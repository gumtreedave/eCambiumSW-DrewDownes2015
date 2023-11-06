unit ImportCambiumProjectData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, Buttons, ProjectManager,DataModule,
  General,ReadData,DataObjects,WriteData,AddEditData;

type
  TformImportCambiumProject = class(TForm)
    pcDataTypes: TPageControl;
    tsParams: TTabSheet;
    tsSites: TTabSheet;
    tsRegimes: TTabSheet;
    tsWeather: TTabSheet;
    Panel1: TPanel;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    bbnBrowse: TBitBtn;
    labelFile: TLabel;
    OpenDialog1: TOpenDialog;
    lbParams: TListBox;
    lbSites: TListBox;
    lbRegimes: TListBox;
    lbWeather: TListBox;
    pbCambiumDataImport: TProgressBar;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    cbParamsAll: TCheckBox;
    bbnImportParams: TBitBtn;
    cbSitesAll: TCheckBox;
    cbRegimesAll: TCheckBox;
    cbWeatherAll: TCheckBox;
    bbnImportSites: TBitBtn;
    bbnImportRegimes: TBitBtn;
    bbnImportWeather: TBitBtn;
    procedure bbnBrowseClick(Sender: TObject);
    procedure OpenDialog1CanClose(Sender: TObject; var CanClose: Boolean);
    Procedure UpdateDataLists(MyProject: String);
    procedure bbnImportParamsClick(Sender: TObject);
    procedure bbnImportSitesClick(Sender: TObject);
    procedure bbnImportRegimesClick(Sender: TObject);
    procedure bbnImportWeatherClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  Procedure DoImport(NamesList: TStrings;
  StartIndex,EndIndex : Integer;
  DataType : Integer);

var
  formImportCambiumProject: TformImportCambiumProject;

implementation

{$R *.dfm}

procedure TformImportCambiumProject.bbnBrowseClick(Sender: TObject);
begin
  openDialog1.Execute;
end;

procedure TformImportCambiumProject.bbnImportParamsClick(Sender: TObject);
var
  StartIndex,EndIndex : Integer;

begin
  if (lbParams.ItemIndex > -1) or
    ((lbParams.Count > 0) and (cbParamsall.Checked)) then begin

    if cbParamsall.Checked then begin
      StartIndex := 0;
      EndIndex := lbParams.Items.Count - 1;
    end else begin
      StartIndex := lbParams.ItemIndex;
      EndIndex := lbParams.ItemIndex;
    end;

    DoImport(lbParams.Items,
      Startindex,EndIndex,
      PARAMSCODE);
  end;
end;

procedure TformImportCambiumProject.bbnImportRegimesClick(Sender: TObject);
var
  StartIndex,EndIndex : Integer;

begin
  if (lbRegimes.ItemIndex > -1) or
    ((lbRegimes.Count > 0) and (cbRegimesall.Checked)) then begin

    if cbRegimesall.Checked then begin
      StartIndex := 0;
      EndIndex := lbRegimes.Items.Count - 1;
    end else begin
      StartIndex := lbRegimes.ItemIndex;
      EndIndex := lbRegimes.ItemIndex;
    end;

    DoImport(lbRegimes.Items,
      Startindex,EndIndex,
      REGIMEDATACODE);
  end;
end;

procedure TformImportCambiumProject.bbnImportSitesClick(Sender: TObject);
var
  StartIndex,EndIndex : Integer;

begin
  if (lbSites.ItemIndex > -1) or
    ((lbSites.Count > 0) and (cbSitesall.Checked)) then begin

    if cbSitesall.Checked then begin
      StartIndex := 0;
      EndIndex := lbSites.Items.Count - 1;
    end else begin
      StartIndex := lbSites.ItemIndex;
      EndIndex := lbSites.ItemIndex;
    end;

    DoImport(lbSites.Items,
      Startindex,EndIndex,
      SITEDATACODE);
  end;
end;



procedure TformImportCambiumProject.bbnImportWeatherClick(Sender: TObject);
var
  StartIndex,EndIndex : Integer;
begin
  if (lbWeather.ItemIndex > -1) or
    ((lbWeather.Count > 0) and (cbWeatherall.Checked)) then begin

    if MessageDlg('Weather data can take several minutes to import.  You will not be' +
                  'able to stop the process once it has begun.  Continue?',mtWarning,
                  [mbYes,mbNo],0) = mrYes then begin

      if cbWeatherall.Checked then begin
        StartIndex := 0;
        EndIndex := lbWeather.Items.Count - 1;
      end else begin
        StartIndex := lbWeather.ItemIndex;
        EndIndex := lbWeather.ItemIndex;
      end;

      DoImport(lbWeather.Items,
        Startindex,EndIndex,
        WEATHERDATACODE);
    end;
  end;
end;

procedure TformImportCambiumProject.FormShow(Sender: TObject);
begin
  pcDataTypes.TabIndex := 0;
end;

Procedure DoImport(NamesList: TStrings;
  StartIndex,EndIndex : Integer;
  DataType : Integer);
var
  i : integer;
  CurrentName : String;
  CMBParams,TPGParams : TParametersListArray;
  SitesData : TSiteData;
  RegimesData : TRegimeDataArray;
  WeatherData : TWeatherDataArray;
  UniqueSuffixParams : String;
  ParamsName : String;

begin
  UniqueSuffixParams := '';

  formImportCambiumProject.pbCambiumDataImport.Min := 0;
  formImportCambiumProject.pbCambiumDataImport.Max := 9999;

  try
    try
      formImportCambiumProject.pbCambiumDataImport.Min := Startindex;
      formImportCambiumProject.pbCambiumDataImport.Max := EndIndex;
      screen.cursor := crHourglass;
      Application.ProcessMessages;

      for i := StartIndex to EndIndex do begin
        UpDatePB(formImportCAMBIUMProject.pbCambiumDataImport);

        CurrentName := NamesList[i];
        case DataType of
          PARAMSCODE: begin
            CMBParams := ReadParameters(DataModule.DataModuleBoard.ADOQueryExport,
              CurrentName,
              ProjectManager.CAMBIUMPARAMSTABLE);
            TPGParams := ReadParameters(DataModule.DataModuleBoard.ADOQueryExport,
              CurrentName,
              ProjectManager.TPGPARAMSTABLE);

            while General.IsNewValueUnique(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
              CurrentName + UniqueSuffixParams,
              ProjectManager.SPECIESNAMESTABLE,
              ProjectManager.SPECIESNAMEFIELD) <> True do begin

              UniqueSuffixParams := UniqueSuffixParams + '1';

            end;

            AddEditData.CreateNewParams(CurrentName + UniqueSuffixParams,
              ProjectManager.CAMBIUMPARAMSTABLE,
              ProjectManager.TPGPARAMSTABLE,
              ProjectManager.SPECIESNAMESTABLE,
              ProjectManager.SPECIESNAMEFIELD,
              CMBParams,TPGParams);
          end;
          SITEDATACODE: begin
            FillSiteDataRecord(DataModule.DataModuleBoard.ADOQueryExport,
              CurrentName,
              SitesData);

            WriteSiteInformation(SitesData,
              ProjectManager.SITESTABLE,
              DataModule.DataModuleBoard.ADOTableCAMBIUMGeneral,
              False);
          end;
          REGIMEDATACODE: begin
            FillRegimeDataArray(DataModule.DataModuleBoard.ADOQueryExport,
              CurrentName,
              RegimesData);

            WriteSavedRegimeInformation(RegimesData,
              ProjectManager.REGIMESTABLE,
              DataModule.DataModuleBoard.ADOTableCAMBIUMGeneral,
              False);

          end;
          WEATHERDATACODE: begin

            FillWeatherDataArray(DataModule.DataModuleBoard.ADOQueryExport,
              CurrentName,
              EncodeDate(1850,01,01),EncodeDate(2999,01,01),
              WeatherData);

            WriteWeatherDataFromArray(WeatherData,CurrentName,
              ProjectManager.WEATHERDATATABLE,
              dataModule.DataModuleBoard.ADOTableCAMBIUMGeneral,
              False);

          end;
        end;
      end;
      Messagedlg('Data import complete',mtInformation,[mbOK],0);
    except
      Messagedlg('Data import complete.  There may have been a problem importing one or more ' +
        'datasets.',mtWarning,[mbOK],0);
    end;
  finally
    formImportCambiumProject.pbCambiumDataImport.Position := 0;
    screen.cursor := crDefault;
  end;
end;


procedure TformImportCambiumProject.OpenDialog1CanClose(Sender: TObject;
  var CanClose: Boolean);
begin
  UpdateDataLists(OpenDialog1.FileName);
end;

Procedure TformImportCambiumProject.UpdateDataLists(MyProject: String);
Var
  ExportProjectOpen : Boolean;
begin
  ExportProjectopen := False;

  labelFile.Caption := 'Current file: ';
  lbWeather.Items.Clear;
  lbSites.Items.Clear;
  lbRegimes.Items.Clear;
  lbParams.Items.Clear;

  ExportProjectOpen := ProjectManager.OpenProject(MyProject,
    DataModule.DataModuleBoard.ADOConnection_ForImporting,
    CAMBIUMDBPASSWORD);

  if ExportProjectOpen then begin
    labelFile.Caption := 'Current file: ' + OpenDialog1.FileName;

    General.GetDistinctValuesinField(DataModule.DataModuleBoard.ADOQueryExport,
      ProjectManager.SPECIESNAMESTABLE,
      ProjectManager.SPECIESNAMEFIELD,
      lbParams.Items);

    General.GetDistinctValuesinField(DataModule.DataModuleBoard.ADOQueryExport,
      ProjectManager.REGIMENAMESTABLE,
      ProjectManager.REGIMENAMEFIELD,
      lbRegimes.Items);

    General.GetDistinctValuesinField(DataModule.DataModuleBoard.ADOQueryExport,
      ProjectManager.SITENAMESTABLE,
      ProjectManager.SITENAMEFIELD,
      lbSites.Items);

    General.GetDistinctValuesinField(DataModule.DataModuleBoard.ADOQueryExport,
      ProjectManager.WEATHERDATATABLE,
      ProjectManager.WEATHERDATASETNAMEFIELD,
      lbWeather.Items);

  end else begin
    Messagedlg('The file could not be opened',mtError,[mbOK],0);
    labelFile.Caption := 'Current file: ';
    lbWeather.Items.Clear;
    lbSites.Items.Clear;
    lbRegimes.Items.Clear;
    lbParams.Items.Clear;
  end;
end;

end.
