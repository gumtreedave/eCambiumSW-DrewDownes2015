unit ExportData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,ADODB,DataModule,ReadData,Contnrs,DataObjects;

type
  TformExportData = class(TForm)
    cmbDataType: TComboBox;
    bbnExportData: TBitBtn;
    cmbScenario: TComboBox;
    SaveDialog1: TSaveDialog;
    Label1: TLabel;
    Label2: TLabel;
    procedure bbnExportDataClick(Sender: TObject);
    procedure SaveDialog1CanClose(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  Procedure MainLoop(CurrentQuery: TADOQuery;
    DestinationFilePath: String;
    ScenarioName: String;
    DataType: Integer);

var
  formExportData: TformExportData;

const
  SEGMENTDATA = 0;
  DAILYDATA = 1;
  SCENARIOSUMMARIES = 2;
  BOARDDATA = 3;

implementation

uses ProjectManager, BoardProperties, BoardDimensions;

{$R *.dfm}




Procedure MainLoop(CurrentQuery: TADOQuery;
  DestinationFilePath: String;
  ScenarioName: String;
  DataType: Integer);
var
  TableName,FieldName: String;
  SQLString : String;
  OutputFile : TextFile;
  FieldsString,LineString: String;
  TotFields : SmallInt;
  i: Integer;
  SelectStrings,FilterString,OrderFieldName : String;
  ExportBoardsList : TObjectList;
  SegmentsDataForBoards : TCAMBIUMSegmentDataArray;


begin
  SelectStrings := '';
  OrderFieldName := '';
  FilterString := '';
  AssignFile(OutputFile, DestinationFilePath);

  ReWrite(OutputFile);
  FieldsString := '';
  Screen.cursor := crHourglass;
  Application.ProcessMessages;

  try
    try
      if formExportData.cmbDataType.itemindex < 3 then begin
        case formExportData.cmbDataType.itemindex of
          0: begin
            TableName := ProjectManager.CAMBIUMSEGMENTSDATATABLE;
            FieldName := ProjectManager.SCENARIONAMEFIELD;
            SelectStrings := ProjectManager.SCENARIONAMEFIELD + ',' +
              ProjectManager.STARTDATEFIELD + ' as [Start of segment formation],' +
              ProjectManager.ENDDATEFIELD + ' as [End of segment formation],' +
              ProjectManager.SEGMENTPOSITIONFIELD + '/1000 as [Dist from pith (mm)],' +
              ProjectManager.RINGINSEGMENTMARKERFIELD + ' as [Ring number],' +
              ProjectManager.SEGMENTWIDTHFIELD + ' as [Width of segment (µm)],'+
              ProjectManager.MEANRDFIELD + ' as [Mean tracheid radial diam (µm)],'+
              ProjectManager.MEANWTFIELD + ' as [Mean wall thickness (µm)],'+
              ProjectManager.WOODDENSITYFIELD + ' as [Mean wood density (kg/m³)],'+
              ProjectManager.CELLDENSITYFIELD + ' as [Mean cell densitywood density (cells/mm²)],'+
              ProjectManager.MFAFIELD + ' as [Mean MFA (deg)],'+
              ProjectManager.MOEFIELD + ' as [Mean MOE (GPa)]';
            OrderFieldName := ProjectManager.SEGMENTNUMBERFIELD;
            FilterString := ' WHERE ' +  FieldName + '=' +
              '"' + ScenarioName + '"';
          end;
          1: begin
            TableName := ProjectManager.DAILYOUTPUTDATATABLE;
            FieldName := ProjectManager.SCENARIONAMEFIELD;
            SelectStrings := 'ScenarioName, LogDate as OutputDate, StemDiameter as [Stem diam (cm)], ' +
              'TreeHeight as [Tree height (m)], StandNPP as [Stand NPP (T/Ha)], TreeNPP as [Tree NPP (kg)], ' +
              'MeanCZCount as [Cambial cells], MeanEZCount as [Enlarging cells], MeanTZCount as [Secondary thickening cells], ' +
              'MeanDaysCellGrowth as [Growing days (d)], MeanDaysSecThick as [Thickening days (d)], ' +
              'MinTemp as [Min daily temp (deg C)], MaxTemp as [Max daily temp (deg C)], MaxLWP as [Pre-dawn LWP (MPa)], ' +
              'WFStand as [Foliage mass (T/Ha)], WSStand as [Stem mass (T/Ha)], WRStand as [Root mass (T/Ha)], ' +
              'LAI as LAI, SPH as [Stand density (Stems/ha)], ASWRootZone as [ASW in root zone (mm)], ' +
              'VolSpecStemAllocCarb as [Tree age (y)], WallThickRate as [Transpiration], RadGrowthRate as [Rainfall (mm)]';
              OrderFieldName := ProjectManager.DAILYDATADATEFIELD;
            FilterString := ' WHERE ' + FieldName + '=' +
              '"' + ScenarioName + '"';
          end;
          2: begin
            TableName :=  TEMPSCENARIOSUMMARYTABLE;
            SelectStrings := '*';
            FilterString := '';
            OrderFieldName := '[' + ProjectManager.SCENARIONAMEFIELD_LONG + ']';
          end;
        end;

        SQLString := 'SELECT ' + SelectStrings + ' FROM ' +
          TableName + FilterString +
          ' ORDER BY ' + OrderFieldName;

        CurrentQuery.SQL.Clear;
        CurrentQuery.SQL.add(SQLString);
        CurrentQuery.active := true;
        CurrentQuery.First;

        TotFields := CurrentQuery.FieldCount;
        for i := 0 to TotFields - 1 do
          FieldsString := FieldsString + ',' + CurrentQuery.Fields[i].FieldName;

        FieldsString := copy(FieldsString,2,Length(FieldsString));

        WriteLn(OutputFile,FieldsString);

        while not CurrentQuery.Eof do begin

          LineString := '';

          for i := 0 to TotFields - 1 do
            LineString := LineString + ',' +  vartostr(CurrentQuery.Fields[i].Value);

          LineString := copy(LineString,2,Length(LineString));

          WriteLn(OutputFile,LineString);

          CurrentQuery.Next;
        end;

        // Close the file
      end else begin
        ExportBoardsList := TObjectList.Create;
        try

          SegmentsDataForBoards := ReadSegmentsData_inmm(ScenarioName,
            ProjectManager.CAMBIUMSEGMENTSDATATABLE,
            ProjectManager.SCENARIONAMEFIELD,
            DataModule.DataModuleBoard.ADOQueryCAMBIUM);

          BoardProperties.BoardsMainRoutine(SegmentsDataForBoards,
            strtoint(formBoardDimensions.leCantWidth.Text),
            strtoint(formBoardDimensions.leBoardWidthCant.Text),
            strtoint(formBoardDimensions.leBoardHeightWing.Text),
            strtoint(formBoardDimensions.leBoardWidthWing.Text),
            ExportBoardsList);

          WriteLn(OutputFile,'ScenarioName,Board number,Board X0,Board Y0,' +
            'Board type,Width (mm),' +
            'Thickness (mm),MOE (GPa),Wood density (kg/m³),MFA (deg)');

          for i := 0 to exportBoardsList.count - 1 do begin
            WriteLn(OutputFile,ScenarioName + ',' +
              inttostr(i + 1) + ',' +
              floattostr(TBoard(ExportBoardsList[i]).X0) + ',' +
              floattostr(TBoard(ExportBoardsList[i]).Y0) + ',' +
              TBoard(ExportBoardsList[i]).BType + ',' +
              floattostr(TBoard(ExportBoardsList[i]).Width) + ',' +
              floattostr(TBoard(ExportBoardsList[i]).Thickness) + ',' +
              floattostr(TBoard(ExportBoardsList[i]).MeanMOE) + ',' +
              floattostr(TBoard(ExportBoardsList[i]).MeanWoodDensity) + ',' +
              floattostr(TBoard(ExportBoardsList[i]).MeanMFA));
          end;
        finally
          ExportBoardsList.Free;

        end;
      end;

      MessageDlg(formExportData.cmbDataType.text + ' data successfully exported to file ' +
        DestinationFilePath,mtInformation,[mbOK],0);

    except
      on E: Exception do
        MessageDlg('There was a problem exporting the data: ' + E.Message,mtError,[mbOK],0);
    end;
  finally
    CloseFile(OutputFile);
    Screen.cursor := crDefault;
  end

end;


procedure TformExportData.bbnExportDataClick(Sender: TObject);
begin
  if (cmbScenario.text <> '') or (cmbDataType.ItemIndex = SCENARIOSUMMARIES) then begin
    if cmbDataType.Text <> '' then
      SaveDialog1.Execute
    else
      messagedlg('Select a data type',mtError,[mbOK],0);
  end else
    messagedlg('Select a scenario',mtError,[mbOK],0);
end;


procedure TformExportData.SaveDialog1CanClose(Sender: TObject;
  var CanClose: Boolean);
begin
  if SaveDialog1.FileName <> '' then begin
    MainLoop(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
      SaveDialog1.FileName,
      cmbScenario.Items[cmbScenario.ItemIndex],
      cmbDataType.ItemIndex);
  end else
    messagedlg('Specify a file name and location',mtError,[mbOK],0);

end;

end.
