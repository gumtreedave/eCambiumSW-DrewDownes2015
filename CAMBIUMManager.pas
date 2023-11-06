//CAMBIUM To do list
//as at 26 Jan 2012


unit CAMBIUMManager;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids,DataModule,ProjectManager,
  Menus, DB, DBCtrls,General,ADODB,RunManager, ComCtrls,DevelopingCellsImage,
  ExtDlgs,BoardProperties,ScenarioManager,FileCtrl,OleAuto;

type THackDBGrid = class(TDBGrid);

type
  TformMain = class(TForm)
    gbControlPanel: TGroupBox;
    gbScenarioList: TGroupBox;
    Splitter1: TSplitter;
    gbProject: TGroupBox;
    gbData: TGroupBox;
    gbScenarios: TGroupBox;
    bbnCreateProject: TBitBtn;
    bbnOpenProject: TBitBtn;
    bbnCreateDataset: TBitBtn;
    panelStatus: TPanel;
    bbnRun: TBitBtn;
    dbGridScenarios: TDBGrid;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    DataSource1: TDataSource;
    pbMain: TProgressBar;
    LabelStatus: TLabel;
    Setsegmentlength1: TMenuItem;
    Run1: TMenuItem;
    Viewwarnings1: TMenuItem;
    Initialisemodelrun1: TMenuItem;
    Stepthroughthemodelrundaybyday: TMenuItem;
    SavePictureDialog1: TSavePictureDialog;
    Boards1: TMenuItem;
    Setboarddimensions1: TMenuItem;
    Setboardgradethresholds1: TMenuItem;
    gbOutputs: TGroupBox;
    bbnSummaryGraphs: TBitBtn;
    bbnExport: TBitBtn;
    ProjectOpenDialog: TOpenDialog;
    ProjectSaveDialog: TSaveDialog;
    About1: TMenuItem;
    Exit1: TMenuItem;
    Createanewproject1: TMenuItem;
    Openanexistingproject1: TMenuItem;
    View1: TMenuItem;
    Viewdevelopingxylemduringrun1: TMenuItem;
    bbnCreateScenario: TBitBtn;
    Optimiseparameters1: TMenuItem;
    Detailedgraphs1: TMenuItem;
    Writedailydatatodisk1: TMenuItem;
    Importdata1: TMenuItem;
    Cellplatepositionrandomised1: TMenuItem;
    Storeandrecycleexcesscarbohydrate1: TMenuItem;
    AdjustParams: TMenuItem;
    Specifylocationsoffilesforparameteroptimisation1: TMenuItem;
    CompactrepairCambiumdatafile1: TMenuItem;
    Summarystatistic1: TMenuItem;
    ImportdatafromanotherCambiumproject1: TMenuItem;
    AbouteCambium1: TMenuItem;
    eCambiumUserGuide1: TMenuItem;
    procedure bbnCreateProjectClick(Sender: TObject);
    procedure bbnOpenProjectClick(Sender: TObject);
    procedure ScenarioListLabel(FullFileName : String);
    procedure bbnLinkCabalaScenarioClick(Sender: TObject);
    procedure bbnCreateDatasetClick(Sender: TObject);
    procedure UpdateGUI(OpenProject : string);
    procedure dbGridScenariosCellClick(Column: TColumn);
    procedure bbnRunClick(Sender: TObject);
    procedure Setthenumberofcellfiles1Click(Sender: TObject);
    procedure Viewwarnings1Click(Sender: TObject);
    procedure Initialisemodelrun1Click(Sender: TObject);
    procedure StepthroughthemodelrundaybydayClick(Sender: TObject);
    Procedure UpdateCaptionDuringRun(ScenarioName: String;
      TreeNumber: string;
      StemPosition: string);
    procedure Saveradialxylemimage1Click(Sender: TObject);
    procedure SavePictureDialog1CanClose(Sender: TObject;
      var CanClose: Boolean);
    procedure Setsegmentlength1Click(Sender: TObject);
    procedure bbnSummaryGraphsClick(Sender: TObject);
    procedure Setboarddimensions1Click(Sender: TObject);
    procedure Setboardgradethresholds1Click(Sender: TObject);
    procedure bbnCreateScenarioClick(Sender: TObject);
    procedure dbGridScenariosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure bbnExportClick(Sender: TObject);
    //procedure SaveSeqImagesClick(Sender: TObject);
    procedure Specifywoodcolour1Click(Sender: TObject);
    procedure ProjectOpenDialogCanClose(Sender: TObject; var CanClose: Boolean);
    procedure ProjectSaveDialogCanClose(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure bbnEditScenarioClick(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure gbScenarioListClick(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Createanewproject1Click(Sender: TObject);
    procedure Openanexistingproject1Click(Sender: TObject);
    procedure Viewdevelopingxylemduringrun1Click(Sender: TObject);
    procedure panelScenariosListLabelClick(Sender: TObject);
    procedure gbProjectClick(Sender: TObject);
    procedure gbDataClick(Sender: TObject);
    procedure gbScenariosClick(Sender: TObject);
    procedure gbOutputsClick(Sender: TObject);
    procedure panelStatusClick(Sender: TObject);
    procedure dbGridScenariosDblClick(Sender: TObject);
    procedure Optimiseparameters1Click(Sender: TObject);
    procedure Detailedgraphs1Click(Sender: TObject);
    procedure FileOpenDialog1FileOkClick(Sender: TObject;
      var CanClose: Boolean);
    procedure Writedailydatatodisk1Click(Sender: TObject);
    procedure Importdata1Click(Sender: TObject);
    procedure Cellplatepositionrandomised1Click(Sender: TObject);
    procedure Storeandrecycleexcesscarbohydrate1Click(Sender: TObject);
    procedure AdjustParamsClick(Sender: TObject);
    procedure CompactrepairCambiumdatafile1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Summarystatistic1Click(Sender: TObject);
    procedure ImportdatafromanotherCambiumproject1Click(Sender: TObject);
    procedure eCambiumUserGuide1Click(Sender: TObject);
    procedure AbouteCambium1Click(Sender: TObject);
    procedure dbGridScenariosTitleClick(Column: TColumn);



  private
    { Private declarations }
  public
    { Public declarations }

  end;

  Procedure MainRoutine;
  Procedure EditScenario(ScenarioName: String);
  Procedure ViewSummaryGraphs;


var
  formMain: TformMain;

implementation

uses SelectDataType, LinkCABALAScenario, AddEditData, NumberofCellFiles,
  ProjectWarnings, RunInitialisation, SetSegmentWidth, SummaryGraphs,
  BoardDimensions, BoardGrades, ScenarioType, SummaryGraphsType, ExportData,
  ColourChoice, CreateCAMBIUMScenario, AboutCambium,
  ImportWizard, SummaryStats, ImportCambiumProjectData;
  //UserGuide;
{$R *.dfm}

procedure TformMain.bbnSummaryGraphsClick(Sender: TObject);
begin
  ViewSummaryGraphs;
end;


Procedure ViewSummaryGraphs;

var
  ScenarioNamesList : TStringList;
  TestDiam : Double;

begin
  if formMain.dbGridScenarios.SelectedRows.Count > 0 then begin

    ScenarioNamesList := TStringList.Create;

    try
      GetSelectedScenarioNames(formMain.dbGridScenarios,
        formMain.DataSource1,
        DataModule.DataModuleBoard.ADOTableAllScenarios,
        ProjectManager.SCENARIONAMEFIELD_LONG,
        ScenarioNamesList);

      //if formMain.dbGridScenarios.SelectedRows.Count > 0 then begin

       { RecCount := ScenarioManager.GetSelectedScenarioRecordCount(formMain.dbGridScenarios,
          formMain.DataSource1,
          DataModule.DataModuleBoard.ADOQueryAllScenarios,
          ProjectManager.RECORDCOUNTFIELD_LONG);                                             }

       TestDiam := ScenarioManager.GetSelectedScenarioRecordCount(formMain.dbGridScenarios,
          formMain.DataSource1,
          DataModule.DataModuleBoard.ADOTableAllScenarios,
          ProjectManager.TREEDIAMFIELD_LONG);


       if ScenarioNamesList.Count = 1 then begin
          if TestDiam > 0 then
            formSummaryGraphsType.showmodal
          else
            Messagedlg('The scenario must have been run to view graphs',mtError,[mbOK],0);
       end else
          Messagedlg('Only select one scenario',mtError,[mbOK],0);

    finally
      ScenarioNamesList.Free;
    end;
  end else
    Messagedlg('Select at least 1 scenario',mtError,[mbOK],0);
end;

procedure TformMain.Cellplatepositionrandomised1Click(Sender: TObject);
begin
  if Cellplatepositionrandomised1.Checked then
    Cellplatepositionrandomised1.Checked := false
  else
    Cellplatepositionrandomised1.Checked := true;
end;



procedure TformMain.CompactrepairCambiumdatafile1Click(Sender: TObject);
begin
  if Messagedlg('This process can take several minutes, and it is necessary to leave the ' +
    'program running until the process completes to avoid corrupting the file. Continue?',
    mtWarning,[mbYes,mbNo],0) = mrYes then begin
    try
      Screen.Cursor := crHourglass;
      Application.ProcessMessages;

      DataModule.DataModuleBoard.ADOConnectionCAMBIUM.Connected := false;

      If CompactandRepair(CurrentOpenProject) then begin
        DataModule.DataModuleBoard.ADOConnectionCAMBIUM.Connected := true;
        UpdateGUI(CurrentOpenProject);
        Messagedlg('Data file compacted/repaired successfully',mtInformation,[mbOK],0);
      end else
        Messagedlg('There was a problem compacting/repairing the data file',
          mtWarning,[mbOK],0);
    finally
      Screen.Cursor := crDefault;
      Application.ProcessMessages;

    end;
  end;
end;



procedure TformMain.Createanewproject1Click(Sender: TObject);
begin
  ProjectSaveDialog.Execute;

end;

procedure TformMain.AbouteCambium1Click(Sender: TObject);
begin
  formAbout.showmodal;
end;

procedure TformMain.AdjustParamsClick(Sender: TObject);
begin
  if AdjustParams.Checked = true then
    AdjustParams.Checked := false
  else
    AdjustParams.Checked := true;

end;

procedure TformMain.bbnCreateDatasetClick(Sender: TObject);
begin
  formAddEditData.showmodal;
end;

procedure TformMain.bbnCreateProjectClick(Sender: TObject);
begin
  ProjectSaveDialog.Execute;
end;

procedure TformMain.bbnCreateScenarioClick(Sender: TObject);
var
  ScenarioNamesList : TStringList;
  ScenarioName : String;


begin
  if dbGridScenarios.SelectedRows.Count > 0 then begin
    ScenarioNamesList := TStringList.Create;

    try
      GetSelectedScenarioNames(formMain.dbGridScenarios,
          formMain.DataSource1,
          DataModule.DataModuleBoard.ADOTableAllScenarios,
          ProjectManager.SCENARIONAMEFIELD_LONG,
          ScenarioNamesList);

      ScenarioName := ScenarioNamesList.Strings[0];

      EditScenario(ScenarioName);

      General.GridColAutoSize(dbGridScenarios);

    finally
      ScenarioNamesList.Free;
    end;
  end else begin
    formScenarioType.showmodal;
    General.GridColAutoSize(dbGridScenarios);
  end;
end;

Procedure EditScenario(ScenarioName: String);
var

  ScenarioType: String;
  SiteName: String;
  SiteLat: Single;
  RegimeName: String;
  WeatherDSName: String;
  ParamSetName : String;
  CABALAProject: String;
  CABALAScenarioName: String;
  CABALAScenarioID: Integer;
  CABALAScenarioParentID : Integer;
  TreeType : String;
  MyStemPositions : array [0..1] of single;
  VariablesSet : Boolean;
  StemPos : String;


begin
  try

    SetScenarioVariables(ScenarioName,
      ScenarioType,
      SiteName,
      SiteLat,
      RegimeName,
      WeatherDSName,
      ParamSetName,
      CABALAProject,
      CABALAScenarioName,
      CABALAScenarioID,
      CABALAScenarioParentID,
      TreeType,
      MyStemPositions[1],
      VariablesSet,
      datamodule.DataModuleBoard.ADOQueryCAMBIUM,
      datamodule.DataModuleBoard.ADOQueryCABALA);

    if VariablesSet then begin


    if ScenarioType = ScenarioManager.CABALA_SCENARIO_TYPE then begin

        LinkCABALAScenario.UpdateListsonForm;
        LinkCABALAScenario.formLinkCABALAScenario.visible := true;

        formLinkCABALAScenario.leScenarioName.Text := ScenarioName;
        formLinkCABALAScenario.cmbStemPosition.Text := floattostr(MyStemPositions[1]);
        formLinkCABALAScenario.cmbStemPosition.ItemIndex := formlinkCABALAScenario.cmbStemPosition.Items.IndexOf(Format('%.1f',[MyStemPositions[1]]));

        formLinkCABALAScenario.cmbTreeType.Text := TreeType;
        formLinkCABALAScenario.cmbTreeType.ItemIndex := formlinkCABALAScenario.cmbTreeType.Items.IndexOf(TreeType);

        formLinkCABALAScenario.cmbCAMBIUMParamSpecies.Text := ParamSetName;
        formLinkCABALAScenario.cmbCAMBIUMParamSpecies.ItemIndex := formlinkCABALAScenario.cmbCAMBIUMParamSpecies.Items.IndexOf(ParamSetName);

        formLinkCABALAScenario.OpenDialog1.FileName := CABALAProject;

        If ProjectManager.ConnectDatabase(CABALAProject,
          DataModule.DataModuleBoard.ADOConnectionCABALA,
          CABALAPW) = True then begin

          UpdateCABALAScenariosList;

          formLinkCABALAScenario.cmbCABALAScenarios.Text := CABALAScenarioName;
          formLinkCABALAScenario.cmbCABALAScenarios.ItemIndex := formlinkCABALAScenario.cmbCABALAScenarios.Items.IndexOf(CABALAScenarioName);

          formLinkCABALAScenario.ShowModal;
          formLinkCABALAScenario.Refresh;
        end else
          MessageDlg('There was a problem connecting to the CaBala data file associated with this ' +
            'scenario',mtError,[mbOK],0);

      end else if ScenarioType  = ScenarioManager.CAMBIUM_SCENARIO_TYPE then begin

        CreateCAMBIUMScenario.UpdateListsonForm;
        formCreateCAMBIUMScenario.Visible := true;

        formCreateCAMBIUMScenario.leScenarioName.Text := ScenarioName;
        formCreateCAMBIUMScenario.cmbSite.ItemIndex := formCreateCAMBIUMScenario.cmbSite.Items.IndexOf(SiteName);

        //formCreateCAMBIUMScenario.cmbWeather.Text := WeatherDSName;
        formCreateCAMBIUMScenario.cmbWeather.itemindex := formCreateCAMBIUMScenario.cmbWeather.Items.IndexOf(WeatherDSName);
        formCreateCAMBIUMScenario.cmbWeather.Text :=
          formCreateCAMBIUMScenario.cmbWeather.items[formCreateCAMBIUMScenario.cmbWeather.ItemIndex];

        formCreateCAMBIUMScenario.cmbRegime.Text := RegimeName;
        formCreateCAMBIUMScenario.cmbRegime.ItemIndex := formCreateCAMBIUMScenario.cmbRegime.Items.IndexOf(RegimeName);

        formCreateCAMBIUMScenario.cmbSpecies.Text := ParamSetName;
        formCreateCAMBIUMScenario.cmbSpecies.ItemIndex := formCreateCAMBIUMScenario.cmbSpecies.Items.IndexOf(ParamSetName);

        formCreateCAMBIUMScenario.cmbTreeType.Text := TreeType;
        formCreateCAMBIUMScenario.cmbTreeType.ItemIndex := formCreateCAMBIUMScenario.cmbTreeType.Items.IndexOf(TreeType);

        StemPos := Format('%.1f',[MyStemPositions[1]]);

        formCreateCAMBIUMScenario.cmbStemPosition.Text := floattostr(MyStemPositions[1]);
        formCreateCAMBIUMScenario.cmbStemPosition.ItemIndex := formCreateCAMBIUMScenario.cmbStemPosition.Items.IndexOf(STemPos);

        formCreateCAMBIUMScenario.ShowModal;
        formCreateCAMBIUMScenario.Refresh;

      end;
    end;
  except

  end;
end;

procedure TformMain.bbnEditScenarioClick(Sender: TObject);
var
  ScenarioNamesList : TStringList;
  ScenarioName : String;
begin
  ScenarioNamesList := TStringList.Create;
  try
    GetSelectedScenarioNames(formMain.dbGridScenarios,
        formMain.DataSource1,
        DataModule.DataModuleBoard.ADOTableAllScenarios,
        ProjectManager.SCENARIONAMEFIELD_LONG,
        ScenarioNamesList);

    ScenarioName := ScenarioNamesList.Strings[0];

    EditScenario(ScenarioName);

  finally
    ScenarioNamesList.Free;
  end;
end;

procedure TformMain.bbnExportClick(Sender: TObject);
var
  SNL : TStringList;
  SN : String;
begin

  SNL := TStringList.Create;

  try
    GetSelectedScenarioNames(formMain.dbGridScenarios,
      formMain.DataSource1,
      DataModule.DataModuleBoard.ADOTableAllScenarios,
      ProjectManager.SCENARIONAMEFIELD_LONG,
      SNL);

    if SNL.Count > 0 then
      SN := SNL.Strings[0];
  finally
    SNL.Free;
  end;

  General.GetDistinctValuesinField(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
    ProjectManager.SCENARIOSTABLE,ProjectManager.SCENARIONAMEFIELD,
    formExportData.cmbScenario.Items);

  formExportData.Visible := True;

  formExportData.cmbScenario.ItemIndex :=
    formExportData.cmbScenario.Items.IndexOf(SN);
  formExportData.cmbScenario.Text :=
    formExportData.cmbScenario.Items[formExportData.cmbScenario.ItemIndex];

  try
    formExportData.showmodal;
  except
  end;



end;

procedure TformMain.bbnLinkCabalaScenarioClick(Sender: TObject);
begin
  formLinkCABALAScenario.showmodal;
end;

procedure TformMain.bbnOpenProjectClick(Sender: TObject);
begin

  ProjectOpenDialog.Execute;


  //FileOpenDialog1.Execute;
end;



procedure TformMain.bbnRunClick(Sender: TObject);
begin
    //form1.show;

  If ModelRunning = False then begin
    ModelStop := False;
    ModelRunning := True;
    formWarnings.memoWarnings.Lines.Clear;
    MainRoutine;
    ModelRunning := false;
  end else begin
    ModelStop := True;
    ModelRunning := False;
  end;

  UpdateGui(CurrentOpenProject);
end;

Procedure MainRoutine;
var
  ScenarioNamesList : TStringList;
begin
  screen.Cursor := crDefault;

  if formMain.dbGridScenarios.SelectedRows.Count > 0 then begin

    ScenarioNamesList := TStringList.Create;

    try

      GetSelectedScenarioNames(formMain.dbGridScenarios,
        formMain.DataSource1,
        DataModule.DataModuleBoard.ADOTableAllScenarios,
        ProjectManager.SCENARIONAMEFIELD_LONG,
        ScenarioNamesList);

      if formMain.Viewdevelopingxylemduringrun1.Checked = true then
        formDevelopingCellsImage.show;

      with formMain do begin

        bbnRun.Caption := 'Stop model runs';
        bbnCreateProject.Enabled := false;
        bbnOpenProject.Enabled := false;
        bbnCreateDataSet.Enabled := false;
        bbnCreateScenario.Enabled := false;
        bbnSummaryGraphs.Enabled := false;
        bbnExport.Enabled := false;
        File1.Enabled := false;
        Run1.Enabled := false;
        Boards1.Enabled := false;
        View1.Enabled := false;
        About1.Enabled := false;
        dbGridScenarios.enabled := false;
        OptimiseParameters1.Enabled := false;
      end;

      RunManager.Mainloop(ScenarioNamesList)

    finally

      with formMain do begin
        pbMain.position := 0;
        labelStatus.caption := '';
        bbnRun.Caption := 'Run selected scenario(s)';
        bbnCreateProject.Enabled := true;
        bbnOpenProject.Enabled := true;
        bbnCreateDataSet.Enabled := true;
        bbnCreateScenario.Enabled := true;
        bbnSummaryGraphs.Enabled := true;
        bbnExport.Enabled := true;
        File1.Enabled := true;
        Run1.Enabled := true;
        Boards1.Enabled := true;
        View1.Enabled := true;
        About1.Enabled := true;
        dbGridScenarios.enabled := true;
        OptimiseParameters1.Enabled := true;

      end;

      ScenarioNamesList.Free;

    end;
  end else
      messagedlg('Select at least 1 scenario',mtError,[mbOK],0);

end;



procedure TformMain.dbGridScenariosCellClick(Column: TColumn);
begin
  //GetSelectedScenarios(formMain.dbGridScenarios);
end;

procedure TformMain.dbGridScenariosDblClick(Sender: TObject);
begin
  ViewSummaryGraphs;
end;

procedure TformMain.dbGridScenariosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  Selected : Boolean;
begin

  dbGridScenarios.canvas.font.color := clBlack;

  if DataSource1.DataSet.FieldByName(ProjectManager.SCENARIOTYPEFIELD_LONG).AsString='' then
    dbGridScenarios.Canvas.Brush.Color:=clSkyBlue
  else
    dbGridScenarios.Canvas.Brush.Color:=clMoneyGreen;

  Selected := dbGridScenarios.SelectedRows.CurrentRowSelected;
  if Selected then begin
    dbGridScenarios.Canvas.Brush.Color := clBlue;
    dbGridScenarios.canvas.font.color := clWhite
  end;

  if DataSource1.DataSet.FieldByName(ProjectManager.DAILYDATARECORDS_LONG).AsInteger>5 then
    dbGridScenarios.canvas.font.Style := [fsBold]
  else
    dbGridScenarios.canvas.font.Style := [];



  DBGridScenarios.DefaultDrawColumnCell
    (Rect, DataCol, Column, State);
end;

procedure TformMain.dbGridScenariosTitleClick(Column: TColumn);
begin
  DataModule.DataModuleBoard.ADOTableAllScenarios.Sort :=
    '[' + Column.Field.FieldName + ']';
end;

procedure TformMain.Detailedgraphs1Click(Sender: TObject);
begin
  if detailedgraphs1.Checked = true then
    detailedgraphs1.Checked := false
  else
    detailedgraphs1.Checked := true;
end;

procedure TformMain.eCambiumUserGuide1Click(Sender: TObject);
var
  UGFilePath: String;
begin
  UGFilePath := ExtractFilePath(Application.ExeName) + 'eCamUserGuide.pdf';
  if FileExists(UGFilePath) then begin
    //formUserManual.AcroPDF1.src := UGFilePath;
    //formUserManual.show;
  end else
    Messagedlg('The e-Cambium user guide could not be found',mtError,[mbOK],0);
end;

procedure TformMain.Exit1Click(Sender: TObject);
begin
  close;
end;

procedure TformMain.FileOpenDialog1FileOkClick(Sender: TObject;
  var CanClose: Boolean);
begin
  UpdateGUI(ProjectOpenDialog.FileName);
end;

procedure TformMain.FormClick(Sender: TObject);
begin
  dbGridScenarios.SelectedRows.Clear;
end;

procedure TformMain.FormCreate(Sender: TObject);
begin
  KeyPreview := true;
end;

procedure TformMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  DeleteList: TStringList;
begin

  if ProjectManager.CurrentOpenProject <> '' then begin

    if Key = VK_DELETE then begin

      try
        screen.Cursor := crHourglass;

        if formMain.dbGridScenarios.SelectedRows.Count > 0 then begin

          DeleteList := TStringList.Create;

          try
            GetSelectedScenarioNames(formMain.dbGridScenarios,
              formMain.DataSource1,
              DataModule.DataModuleBoard.ADOTableAllScenarios,
              ProjectManager.SCENARIONAMEFIELD_LONG,
              DeleteList);

            if MessageDlg('Are you sure you want to delete the selected scenario/s?',
              mtConfirmation,[mbYes,mbNo],0) = mrYes then begin

              Screen.Cursor := CrHourglass;

              ScenarioManager.DeleteScenarios(DeleteList,
                ProjectManager.SCENARIOSTABLE,
                ProjectManager.SCENARIONAMEFIELD,
                DataModule.DataModuleBoard.ADOCommandCAMBIUM);

              ScenarioManager.DeleteScenarios(DeleteList,
                ProjectManager.CABALASCENARIOSTABLE,
                ProjectManager.SCENARIONAMEFIELD,
                DataModule.DataModuleBoard.ADOCommandCAMBIUM);

              UpdateGui(CurrentOpenProject);
            end;
          finally
            DeleteList.Free;
          end;
        end;
      finally
        screen.Cursor := crDefault;

      end;
    end;
  end;
end;

procedure TformMain.FormShow(Sender: TObject);
begin
  BoardDimensions.formBoardDimensions.ReadbdINIFileIntoForm(ExtractFilePath(Application.EXEName) + BoardDimensions.BDINIFILE);
  RunInitialisation.formInitialisation.ReadivINIFileIntoForm(ExtractFilePath(Application.EXEName) + RunInitialisation.IVINIFILE);
end;

procedure TformMain.gbDataClick(Sender: TObject);
begin
  dbGridScenarios.SelectedRows.Clear;
end;

procedure TformMain.gbOutputsClick(Sender: TObject);
begin
  dbGridScenarios.SelectedRows.Clear;
end;

procedure TformMain.gbProjectClick(Sender: TObject);
begin
  dbGridScenarios.SelectedRows.Clear;
end;

procedure TformMain.gbScenarioListClick(Sender: TObject);
begin
  dbGridScenarios.SelectedRows.Clear;
end;

procedure TformMain.gbScenariosClick(Sender: TObject);
begin
  dbGridScenarios.SelectedRows.Clear;
end;

procedure TformMain.Importdata1Click(Sender: TObject);
begin
  formImportWizard.showmodal;
end;

procedure TformMain.ImportdatafromanotherCambiumproject1Click(Sender: TObject);
begin
  formImportCambiumProject.showmodal;
end;

procedure TformMain.Initialisemodelrun1Click(Sender: TObject);
begin
  formInitialisation.showmodal;
end;



procedure TformMain.Openanexistingproject1Click(Sender: TObject);
begin
  ProjectOpenDialog.Execute;
end;

procedure TformMain.Optimiseparameters1Click(Sender: TObject);
begin
  //formParamOptParallel.showmodal;
end;



procedure TformMain.panelScenariosListLabelClick(Sender: TObject);
begin
  dbGridScenarios.SelectedRows.Clear;
end;

procedure TformMain.panelStatusClick(Sender: TObject);
begin
  dbGridScenarios.SelectedRows.Clear;
end;

procedure TformMain.SavePictureDialog1CanClose(Sender: TObject;
  var CanClose: Boolean);
begin
  DevelopingCellsImage.ConvertSaveImage(RunManager.GlobalAllCellsImage.Picture,
    SavePictureDialog1.FileName);
end;

procedure TformMain.Saveradialxylemimage1Click(Sender: TObject);
begin
  SavePictureDialog1.execute;
end;

{procedure TformMain.SaveSeqImagesClick(Sender: TObject);

begin
  if SaveSeqImages.Checked = true then
    SaveSeqImages.Checked := false
  else begin
    SaveSeqImages.Checked := true;

    ImagesDirectory := '';

    if SelectDirectory('Select a directory in which to save the daily images',
     'C:\',ImagesDirectory) then
      MessageDlg('Images will be saved in ' + ImagesDirectory,mtInformation,[mbOK],0)
    else
      MessageDlg('Images will not be saved',mtWarning,[mbOK],0);
  end;
end;   }

Procedure TFormMain.ScenarioListLabel(FullFileName : String);
var
  ProjectName : string;
  FileExt : string;

begin
  FileExt := ExtractFileExt(FullFileName);
  ProjectName := copy(ExtractFileName(FullFileName),
    1,length(ExtractFileName(FullFileName)) - length(FileExt));

  if ProjectName <> '' then begin
    //formMain.PanelScenariosListLabel.caption := 'Scenarios in project "' + ProjectName + '"';
    formMain.Caption := 'e-Cambium: ' + ProjectName;
  end else begin
    //formMain.PanelScenariosListLabel.caption := 'No project selected';
    formMain.Caption := 'e-Cambium'
  end;
end;

procedure TformMain.Setboarddimensions1Click(Sender: TObject);
begin
  formBoardDimensions.showmodal;
end;

procedure TformMain.Setboardgradethresholds1Click(Sender: TObject);
begin
  formBoardGrades.showmodal;
end;

procedure TformMain.Setsegmentlength1Click(Sender: TObject);
begin
  formSegmentWidth.showmodal;
end;

procedure TformMain.Setthenumberofcellfiles1Click(Sender: TObject);
begin
  formNumberofCellFiles.showmodal;
end;




procedure TformMain.Specifywoodcolour1Click(Sender: TObject);
begin
  formColourChoice.showmodal;
end;

procedure TformMain.StepthroughthemodelrundaybydayClick(Sender: TObject);
begin
  If Stepthroughthemodelrundaybyday.checked = true
    then Stepthroughthemodelrundaybyday.checked := false
  else
    Stepthroughthemodelrundaybyday.checked := true;
end;

procedure TformMain.Storeandrecycleexcesscarbohydrate1Click(Sender: TObject);
begin
  if Storeandrecycleexcesscarbohydrate1.checked then
    Storeandrecycleexcesscarbohydrate1.checked := false
  else
    Storeandrecycleexcesscarbohydrate1.checked := true;
end;

procedure TformMain.Summarystatistic1Click(Sender: TObject);
begin
  formSummaryStats.showmodal;
end;

procedure TformMain.ProjectOpenDialogCanClose(Sender: TObject;
  var CanClose: Boolean);
begin
  UpdateGUI(ProjectOpenDialog.FileName);
end;


Procedure TFormMain.UpdateGUI(OpenProject : string);
var
  ProjectOpen : boolean;
  DBError : Boolean;

begin
  ProjectOpen := false;
  DBError := false;
 try
  ProjectOpen := ProjectManager.OpenProject(OpenProject,
    DataModule.DataModuleBoard.ADOConnectionCAMBIUM,
    CAMBIUMDBPASSWORD);

   ProjectManager.CurrentOpenProject := '';

   If ProjectOpen = true then begin

      ProjectManager.GetAllScenarios(DataModule.DataModuleBoard.ADOCommandCAMBIUM,
        DataModule.DataModuleBoard.ADOTableAllScenarios,
        ProjectManager.SCENARIOSTABLE,
        formSummaryStats.rgSummaryStats.ItemIndex,
        formSummaryStats.rgSummaryType.ItemIndex,
        strtoint(formSummaryStats.leSummaryWidth.Text),
        '');
        //CurrentSortField);

      ProjectManager.CurrentOpenProject := OpenProject;

      gridColAutoSize(dbGridScenarios);

      dbGridScenarios.Columns[dbGridScenarios.Columns.Count - 1].Visible := false;

      DataModule.DataModuleBoard.ADOTableAllScenarios.Sort :=
        '[' + ProjectManager.SCENARIONAMEFIELD_LONG + ']';


   end;
 except
    on E: Exception do begin
      DBError := True;
      ProjectOpen := False;
    end;
 end;

 if (ProjectOpen = False) then
  Messagedlg('There was a problem opening the Cambium file',
        mtError,[mbOK],0);

 ScenarioListLabel(ProjectManager.CurrentOpenProject);
 bbnCreateDataset.Enabled := ProjectOpen;
 bbnCreateScenario.Enabled := ProjectOpen;
 bbnRun.Enabled := ProjectOpen;
 bbnSummaryGraphs.Enabled := ProjectOpen;
 bbnExport.Enabled := ProjectOpen;
 OptimiseParameters1.Enabled := ProjectOpen;
 ImportData1.Enabled := ProjectOpen;
 CompactrepairCambiumdatafile1.Enabled := ProjectOpen;
 SummaryStatistic1.Enabled := ProjectOpen;
 ImportDataFromAnotherCambiumProject1.Enabled := ProjectOpen;

 //dbGridScenarios.Enabled := ProjectOpen;

end;



procedure TformMain.Viewdevelopingxylemduringrun1Click(Sender: TObject);
begin
  if Viewdevelopingxylemduringrun1.checked then
    Viewdevelopingxylemduringrun1.Checked := false
  else begin
    if MessageDlg('This setting will significantly slow down the model run speed. Continue?',
      mtConfirmation,[mbYes,mbNo],0) = mrYes then
      Viewdevelopingxylemduringrun1.Checked := true;
  end;


end;

procedure TformMain.Viewwarnings1Click(Sender: TObject);
begin
  formWarnings.showmodal;
end;




procedure TformMain.Writedailydatatodisk1Click(Sender: TObject);
begin
  if Writedailydatatodisk1.Checked then
    Writedailydatatodisk1.Checked := false
  else begin
    if messagedlg('Writing daily data to disk can significantly extend total run time. Continue?',mtWarning,[mbYes,mbNo],0)=mrYes then
      Writedailydatatodisk1.Checked := true;
  end;
end;

procedure TformMain.ProjectSaveDialogCanClose(Sender: TObject;
  var CanClose: Boolean);
var
  OWF: Boolean;
  FName : String;
  pName : char;
begin
  OWF := True;
  if FileExists(ProjectSaveDialog.FileName) then begin
    if MessageDlg('A Cambium file by the same name already exists. Overwrite?',mtWarning,
      [mbYes,mbNo],0) = mrYes then begin
      DeleteFile(ProjectSaveDialog.FileName);
      OWF := True;
    end else
      OWF := False
  end;

  if OWF = True then begin
    with ProjectSaveDialog do begin
      FileName := ChangeFileExt(FileName, '.cambium');
    end;

    If ProjectManager.CreateProject(ProjectSaveDialog.FileName) = True then begin

      ProjectManager.OpenProject(ProjectSaveDialog.FileName,
      DataModule.DataModuleBoard.ADOConnectionCAMBIUM,
      CAMBIUMDBPASSWORD);
      UpdateGUI(ProjectSaveDialog.FileName);
    end;
  end;
end;



Procedure TformMain.UpdateCaptionDuringRun(ScenarioName: String;
  TreeNumber: string;
  StemPosition: string);
begin
  formMain.labelStatus.Caption :=
    ('Calculating xylem development for scenario "' +
    ScenarioName + //'" on tree ' + TreeNumber +
        '" at ' + StemPosition + ' m...');
        formMain.Refresh;
end;



end.
