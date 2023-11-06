unit ImportWizard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids,FileCtrl,Contnrs,General,ProjectManager,
  ADODB,ImportDataProgress,WriteData;

type

  TformImportWizard = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    odDataFile: TOpenDialog;
    labelCurrentFile: TLabel;
    Panel2: TPanel;
    cmbDataType: TComboBox;
    PanelLowerMain: TPanel;
    sgFieldstoColumns: TStringGrid;
    bbnImportData: TBitBtn;
    sgData: TStringGrid;
    Panel1: TPanel;
    bbnBrowse: TBitBtn;
    LabelCurrentImportFile: TLabel;
    leRowstoSkip: TLabeledEdit;
    Label1: TLabel;
    procedure bbnImportDataClick(Sender: TObject);
    procedure bbnBrowseClick(Sender: TObject);
    procedure odDataFileCanClose(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure cmbDataTypeChange(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure sgFieldstoColumnsSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);


    //procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
      CurrentDataType : Integer;
  end;

  Procedure PopulateStringGrid(FileType:Integer);
  Procedure ImportData(ADOCommand: TADOCommand;
    TableName: String;
    DataSetNameFieldName : String;
    DSName : String;
    UseDataFile : Boolean;
    RowstoSkip : INteger;
    FieldsNames: TStrings;
    ColNumbers: TStrings;
    Constants: TStrings;
    InputSG: TStringGrid);


var
  formImportWizard: TformImportWizard;
  //DaysInMonthLY : array[1..12] of integer = (31,29,31,30,31,30,31,31,30,31,30,31);

const
  DaysInMonthNY : array[1..12] of integer = (31,28,31,30,31,30,31,31,30,31,30,31);

  MENSDATAINDICATOR = 0;
  WEATHERDATAINDICATOR = 1;
  SSDATAINDICATOR = 2;
  //RINGPOSINDICATOR = 5;
  RINGMEANSDATAINDICATOR = 3;
  //CAMBIALDATAINDICATOR = 6;



implementation

uses DataModule;



{$R *.dfm}

//******************************************************************************
//Various functions



Function ReadCSVData(FileName:string):TStringList;
Var
  tsplain : tstringlist;
  S : string;
  Tf : Textfile;
Begin
  try
    Tsplain := Tstringlist.create;
    Assignfile(tf,FileName);
    Reset(tf);
    While not eof(tf) do Begin
           Readln(tf,S);
           Tsplain.Add(S);
           //Tsdelim.CommaText := S;
           //ProcessLine;
    end;

    Result := TSplain;

  finally
    closefile(tf);
    //tsplain.free;
  end;
end;

Function AllColumnsSpecified(CurrentSG : TStringGrid):Boolean;
var
  i : integer;
  ColumnsCounter : Integer;

begin
  ColumnsCounter := 0;
  Result := True;

  for i := 0 to CurrentSG.RowCount-1 do begin
    if (CurrentSG.Cells[1,i] <> '') or (CurrentSG.Cells[2,i]<>'') then
      ColumnsCounter := ColumnsCounter + 1;
  end;

  if ColumnsCounter < CurrentSG.RowCount then
    Result := False;

end;


//******************************************************************************
//Functions and procedures for the import wizard

Function CreateDataFields(FileType:Integer) : TStringList;
//This function returns the fields which are required for each cambium data
//type against which the user must match a column number.
var
  MyStringList : TStringList;

begin
  MyStringList := TStringList.Create;
  MyStringList.Add('Data field');

  if FileType = MENSDATAINDICATOR then begin
    //Mensuration data file
    MyStringList.Add(ProjectManager.MENSDATEFIELD);
    MyStringList.Add(ProjectManager.DBHFIELD);
    MyStringList.Add(ProjectManager.MENSDATASETNAMEFIELD);
    MyStringList.Add(ProjectManager.MEASTREEHEIGHTFIELD);
    MyStringList.Add(ProjectManager.CROWNLENGTHFIELD);
    MyStringList.Add(ProjectManager.STEMVOLFIELD);
  end else if FileType = WEATHERDATAINDICATOR then begin
    //Weather data file
    MyStringList.Add(ProjectManager.WEATHERDATASETNAMEFIELD);
    MyStringList.Add(ProjectManager.WEATHERDATEFIELD);
    MyStringList.add(ProjectManager.MINTEMPFIELD);
    MyStringList.Add(ProjectManager.MAXTEMPFIELD);
    MyStringList.Add(ProjectManager.QAFIELD);
    MyStringList.Add(ProjectManager.EVAPFIELD);
    MyStringList.Add(ProjectManager.MINRHFIELD);
    MyStringList.Add(ProjectManager.MAXRHFIELD);
    MyStringList.Add(ProjectManager.RAINFIELD);
  end else if FileType = SSDATAINDICATOR then begin
    MyStringList.Add(ProjectManager.SSDATASETNAMEFIELD);
    MyStringList.add(ProjectManager.SSPOSFIELD);
    MyStringList.Add(ProjectManager.MEANRDFIELD);
    MyStringList.Add(ProjectManager.MEANTDFIELD);
    MyStringList.Add(ProjectManager.MEANWTFIELD);
    MyStringList.Add(ProjectManager.CELLDENSITYFIELD);
    MyStringList.Add(ProjectManager.MOEFIELD);
    MyStringList.Add(ProjectManager.WOODDENSITYFIELD);
    MyStringList.Add(ProjectManager.MFAFIELD);
  {end else if FileType = RINGPOSINDICATOR then begin;
    MyStringList.Add(ProjectManager.SSDATASETNAMEFIELD);
    MyStringList.add(ProjectManager.RINGYEARFIELD);
    MyStringList.Add(ProjectManager.RINGPOSFIELD);
    MyStringList.Add(ProjectManager.RINGWIDTHFIELD);      }
  end else if FileType = RINGMEANSDATAINDICATOR then begin;
    MyStringList.Add(ProjectManager.RINGPROPSLABELFIELD);
    MyStringList.add(ProjectManager.RINGPROPSYEARFIELD);
    MyStringList.Add(ProjectManager.RINGPROPSMEANWDFIELD);
    MyStringList.Add(ProjectManager.RINGPROPSMEANTRDFIELD);
    MyStringList.Add(ProjectManager.RINGPROPSMEANWTFIELD);
    MyStringList.Add(ProjectManager.RINGPROPSMEANMFAFIELD);
    MyStringList.Add(ProjectManager.RINGPROPSMEANMOEFIELD);
    MyStringList.Add(ProjectManager.RINGPROPSWDSDFIELD);
    MyStringList.Add(ProjectManager.RINGPROPSTRDSDFIELD);
    MyStringList.Add(ProjectManager.RINGPROPSWTSDFIELD);
    MyStringList.Add(ProjectManager.RINGPROPSMFASDFIELD);
    MyStringList.Add(ProjectManager.RINGPROPSMOESDFIELD);
  end;

  Result := MyStringList;
end;

Function GetDataSetValueForImport(FtoCSG: TStringGrid;
  InputDataSG: TStringGrid;
  FtoC_FieldNamesColNum: Integer;
  FtoC_InputDataColNum: Integer;
  FtoC_ConstantColNum: Integer;
  DataSetNameFieldName: String;
  RowsToSkip : Integer):String;
var
  i : integer;
  RelevantColNum: Integer;
begin
  for i := 0 to FtoCSG.RowCount-1 do begin
    if FtoCSG.Cells[FtoC_FieldNamesColNum,i]=DataSetNameFieldName then begin
      if FtoCSG.Cells[FtoC_InputDataColNum,i]<>'' then begin
        RelevantColNum :=strtoint(FtoCSG.Cells[FtoC_InputDataColNum,i]);
        Result := InputDataSG.Cells[RelevantColNum,RowsToSkip + 1];
      end else begin
        Result := FtoCSG.Cells[FtoC_ConstantColNum,i]
      end;
    end;
  end;
end;


procedure TformImportWizard.bbnImportDataClick(Sender: TObject);
var
  CurrentTable : String;
  LinkedTable : String;
  MyDSNameField : String;
  MyDataSetName : String;

begin
  if (Messagedlg('Importing large datasets can take several minutes. Continue?',mtWarning,[mbYes,mbNo],0)= mrYes) or
    (sgData.RowCount < 250) then begin

    if AllColumnsSpecified(sgFieldstoColumns) then begin
      //if cmbScenarios.ItemIndex > -1 then begin
      if sgData.RowCount > strtoint(leRowstoSkip.Text) + 1 then begin
        try

          formImportDataProgress.ProgressBar1.Min := 0;
          formImportDataProgress.ProgressBar1.Max := sgData.RowCount-1;
          formImportDataProgress.ProgressBar1.position := 0;
          formImportDataProgress.ProgressBar1.Step := 1;
          screen.cursor := crhourglass;

          LinkedTable := '';
          CurrentTable := '';
          MyDataSetName := '';

          case cmbDataType.ItemIndex of
            MENSDATAINDICATOR :  begin
              CurrentTable := ProjectManager.REALMENSURATIONDATATABLE;
              LinkedTable := '';
              MyDSNameField := ProjectManager.MENSDATASETNAMEFIELD;
            end;
            WEATHERDATAINDICATOR : begin
              CurrentTable := ProjectManager.WEATHERDATATABLE;
              LinkedTable := ProjectManager.WEATHERDATASETNAMESTABLE;
              MyDSNameField := ProjectManager.WEATHERDATASETNAMEFIELD;
              MyDataSetName := GetDatasetValueForImport(formImportWizard.sgFieldstoColumns,
                      formImportWizard.sgData,
                      0,1,2,
                      ProjectManager.WEATHERDATASETNAMEFIELD,
                      strtoint(formImportWizard.leRowstoSkip.Text));
            end;
            SSDATAINDICATOR : begin
              CurrentTable := ProjectManager.REALSSDATATABLE;
              LinkedTable := '';
              MyDSNameField := ProjectManager.SSDATASETNAMEFIELD;
            end;
            //RINGPOSINDICATOR : CurrentTable := ProjectManager.SSRINGPOSITIONSTABLE;
            RINGMEANSDATAINDICATOR : begin
              CurrentTable := ProjectManager.MEANRINGPROPSTABLE;
              LinkedTable := '';
              MyDSNameField := ProjectManager.RINGPROPSLABELFIELD
            end;
          end;

          formImportDataProgress.Show;

          if LinkedTable <> '' then
            WriteData.WriteDataSetName(DataModule.DataModuleBoard.ADOTableCAMBIUMGeneral,
              LinkedTable,
              MyDSNameField,
              MyDataSetName);

          ImportData(DataModule.DataModuleBoard.ADOCommandCAMBIUM,
            CurrentTable,
            MyDSNameField,
            '',
            False,
            strtoint(leRowsToSkip.Text),
            formImportWizard.sgFieldstoColumns.Cols[0],
            formImportWizard.sgFieldstoColumns.Cols[1],
            formImportWizard.sgFieldstoColumns.Cols[2],
            sgData)

      finally
        formImportDataProgress.Close;
        screen.cursor := crDefault;
      end;
      end else
        messagedlg('Select data to import',mtError,[mbOK],0);
    end else
      messagedlg('A column number needs to be specified corresponding to every field',mtError,[mbOK],0);
  end;
end;

Procedure ImportData(ADOCommand: TADOCommand;
  TableName: String;
  DataSetNameFieldName : String;
  DSName : String;
  UseDataFile : Boolean;
  RowsToSkip : Integer;
  FieldsNames: TStrings;
  ColNumbers: TStrings;
  Constants: TStrings;
  InputSG: TStringGrid);
var
  i,j,k : integer;
  SQLString : String;
  FieldsString: String;
  ValuesString:String;
  AProblem : Boolean;
begin
  FieldsString := '';
  AProblem :=False;
  for i := 1 to FieldsNames.Count-1 do
    FieldsString := FieldsString + ',' + FieldsNames.Strings[i];

  FieldsString := copy(FieldsString,2,Length(FieldsString));

  try
    for j := 1 + RowsToSkip to InputSG.RowCount -1 do begin

      UpDatePB(formImportDataProgress.ProgressBar1);

      ValuesString := '';

      for k := 1 to ColNumbers.Count-1 do begin
        if ColNumbers.Strings[k] <> '' then begin
          ValuesString := ValuesString + ',' + '"' + InputSG.Cells[strtoint(ColNumbers.Strings[k]),j] + '"';
        end else
          ValuesString := ValuesString + ',' + '"' + Constants[k] + '"';
      end;

      ValuesString := copy(ValuesString,2,Length(ValuesString));

      ADOCommand.CommandText := '';
      SQLString := '';
      SQLString := 'INSERT INTO ' +
      TableName + '(' + FieldsString + ') ' +
      ' SELECT ' + ValuesString;

      ADOCommand.CommandText := SQLString;

      try
        ADOCommand.Execute;
      except
        AProblem := true;

      end;
    end;

    if AProblem = False then
      MessageDlg('Data successfully imported',mtInformation,[mbOK],0)
    else
      MessageDlg('All/some data may not have been successfully imported',mtWarning,[mbOK],0);

  except
    on E: Exception do begin
      MessageDlg('Data was not imported: ' + E.message,mtError,[mbOK],0);
    end;

  end;
end;


procedure TformImportWizard.cmbDataTypeChange(Sender: TObject);
begin
  PopulateStringGrid(cmbDataType.ItemIndex);

end;

procedure TformImportWizard.FormResize(Sender: TObject);
begin
  sgFieldstoColumns.DefaultColWidth := round(PanelLowerMain.Width/3);
end;

procedure TformImportWizard.FormShow(Sender: TObject);
begin
  General.ClearTheGrid(sgData.ColCount,sgData);
  labelCurrentImportFile.Caption := 'Current file:';

  {cmbScenarios.Items := General.GetDistinctValuesinField(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
    ProjectManager.SCENARIOSTABLE,
    ProjectManager.SCENARIONAMEFIELD);  }
end;

procedure TformImportWizard.bbnBrowseClick(Sender: TObject);
begin
  odDataFile.Execute;
end;

procedure TformImportWizard.odDataFileCanClose(Sender: TObject;
  var CanClose: Boolean);
begin
  general.ClearTheGrid(sgData.ColCount,sgData);
    try
      General.AddDataToSGrid(ReadCSVData(odDataFile.FileName),sgData,General.IMPORTGRID);
      if (sgData.ColCount > 0) and (sgData.RowCount > 0) then begin
        sgData.FixedCols := 1;
        LabelCurrentImportFile.Caption := 'Current file: ' +
          odDataFile.FileName;
      end;
    except
      //on E: Exception do begin
        //Messagedlg('There was a problem opening the file: ' + E.Message,mtError,[mbOK],0);
      //end;
    end;
end;


procedure TformImportWizard.sgFieldstoColumnsSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if (ACol = 0) or
    (ARow = 0) then begin
    sgFieldstoColumns.Options := sgFieldstoColumns.Options-[goEditing]
  end else
    sgFieldstoColumns.Options := sgFieldstoColumns.Options+[goEditing];
end;

//******************************************************************************
//Build data tables from imported data

procedure PopulateStringGrid(FileType:Integer);
//Add the field names to the grid that allows users to specify which columns
//correspond to which fields
begin
  formImportWizard.sgFieldstoColumns.RowCount := CreateDataFields(FileType).Count;
  formImportWizard.sgFieldstoColumns.Cols[0] := CreateDataFields(FileType);

  formImportWizard.sgFieldstoColumns.Cells[1,0] := 'Associated column in data file';
  formImportWizard.sgFieldstoColumns.Cells[2,0] := 'Constant value';
end;


end.
