unit AddEditData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls,
  DataModule,ProjectManager, DB,ADODB,General,Math,DataObjects, TeeProcs,
  TeEngine, Chart, Series,ReadData,WriteData, DBChart,ImportDataProgress,
  RunInitialisation,ScenarioManager,OKCANCL2, Menus;

type

  TformAddEditData = class(TForm)
    pcDataAddEdit: TPageControl;
    tsSite: TTabSheet;
    tsRegime: TTabSheet;
    tsParams: TTabSheet;
    gbCAMBIUMParams: TGroupBox;
    dbgParams: TDBGrid;
    rgParamsTypes: TRadioGroup;
    PanelSite: TPanel;
    PanelStartStop: TPanel;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    Label4: TLabel;
    Label5: TLabel;
    labelRotationLength: TLabel;
    PanelControls: TPanel;
    lbRegimeNames: TListBox;
    GroupBox1: TGroupBox;
    bbnSaveRegime: TBitBtn;
    lbParamSets: TListBox;
    tsWeather: TTabSheet;
    Panel1: TPanel;
    Panel5: TPanel;
    GroupBox2: TGroupBox;
    bbnSaveSite: TBitBtn;
    lbSiteNames: TListBox;
    bbnDeleteSite: TBitBtn;
    bbnCreateNewSite: TBitBtn;
    Panel2: TPanel;
    Panel3: TPanel;
    GroupBox3: TGroupBox;
    bbnImportCustomWeatherData: TBitBtn;
    bbnImportSILO: TBitBtn;
    bbnDeleteWeatherDS: TBitBtn;
    lbWeatherDatasets: TListBox;
    GroupBox4: TGroupBox;
    bbnCreateNewParams: TBitBtn;
    bbnDeleteParams: TBitBtn;
    bbnSaveParams: TBitBtn;
    leInitialSpacing: TLabeledEdit;
    Label1: TLabel;
    sgRegimeEvents: TStringGrid;
    DBChartSREvap: TDBChart;
    Series4: TLineSeries;
    Series5: TLineSeries;
    dbchartraintemp: TDBChart;
    Series1: TBarSeries;
    Series2: TLineSeries;
    Series3: TLineSeries;
    OpenDialogSILO: TOpenDialog;
    GroupBox5: TGroupBox;
    Label6: TLabel;
    GroupBox6: TGroupBox;
    Label3: TLabel;
    cmbSoilTexture: TComboBox;
    Label7: TLabel;
    cmbSiteFR: TComboBox;
    cmbSiteLat: TComboBox;
    GroupBox7: TGroupBox;
    cmbSoilDepth: TComboBox;
    Label2: TLabel;
    leMaxASW: TLabeledEdit;
    leMinASW: TLabeledEdit;
    leInitialASW: TLabeledEdit;
    GroupBox8: TGroupBox;
    bbnAddRegime: TBitBtn;
    bbnDeleteRegime: TBitBtn;
    GroupBox9: TGroupBox;
    bbnAddEvent: TBitBtn;
    bbnDeleteEvent: TBitBtn;
    dsAddEditParams: TDataSource;
    dsAddEditWeatherData: TDataSource;
    bbnCopyParams: TBitBtn;
    MainMenu1: TMainMenu;
    Import1: TMenuItem;
    DatafromaneCambiumproject1: TMenuItem;
    bbnCopyRegime: TBitBtn;
    procedure bbnCreateNewParamsClick(Sender: TObject);

    procedure AddDatatoDBGrid(CurrentGrid: TDBGrid;
      CurrentDS : TDataSource;
      CurrentTable: TADOTable;
      CurrentCommand : TADOCommand;
      FromTable : string;
      FilterCriteria : string;
      SortCriteria : String);
    Procedure UpdateLists;
    Procedure FillRegimeSG(RegimeName : String);
    Procedure UpDateRegimeSGHeaders;
    procedure FormShow(Sender: TObject);
    procedure bbnSaveParamsClick(Sender: TObject);
    procedure bbnSaveSiteClick(Sender: TObject);
    procedure UpdateRotationLengthLabel;
    procedure DateTimePicker2Change(Sender: TObject);
    procedure DateTimePicker1Change(Sender: TObject);
    procedure bbnAddEventClick(Sender: TObject);
    procedure bbnCreateNewSiteClick(Sender: TObject);
    procedure bbnAddRegimeClick(Sender: TObject);
    procedure lbRegimeNamesClick(Sender: TObject);
    procedure bbnSaveRegimeClick(Sender: TObject);
    procedure lbSiteNamesClick(Sender: TObject);
    procedure bbnImportSILOClick(Sender: TObject);
    Procedure UpdateWeatherGraphs(WeatherDSName: String;
      ADOQuery: TADOQuery);
    procedure lbWeatherDatasetsClick(Sender: TObject);
    procedure sgRegimeEventsDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    //procedure fodSILOWeatherDataFileOkClick(Sender: TObject; var CanClose: Boolean);
    Procedure UpdateDTPickers(RDA : TRegimeDataArray);
    Procedure ScaleFormObjects;
    procedure FormResize(Sender: TObject);
    procedure rgParamsTypesClick(Sender: TObject);
    procedure bbnImportCustomWeatherDataClick(Sender: TObject);
    procedure bbnDeleteParamsClick(Sender: TObject);
    procedure bbnDeleteSiteClick(Sender: TObject);
    procedure bbnDeleteRegimeClick(Sender: TObject);
    procedure bbnDeleteWeatherDSClick(Sender: TObject);
    Procedure UpdateParamDataGrid(ParamsType : Integer;
      SpeciesName: String);
    procedure bbnDeleteEventClick(Sender: TObject);
    Procedure UpdateFormForSelectedSite(ItemIndex: Integer);
    procedure leInitialSpacingChange(Sender: TObject);
    procedure leMaxASWChange(Sender: TObject);
    procedure leMinASWChange(Sender: TObject);
    procedure leInitialASWChange(Sender: TObject);
    procedure bbnCopyParamsClick(Sender: TObject);
    procedure tsWeatherShow(Sender: TObject);
    procedure tsRegimeShow(Sender: TObject);
    procedure tsSiteShow(Sender: TObject);
    procedure tsParamsShow(Sender: TObject);
    procedure DatafromaneCambiumproject1Click(Sender: TObject);


    procedure pcDataAddEditChange(Sender: TObject);
    procedure lbParamSetsClick(Sender: TObject);
    procedure bbnCopyRegimeClick(Sender: TObject);


    { Private declarations }

  public
    { Public declarations }
  end;

  Procedure UpdateMainParamsTable(CurrentADOCommand: TADOCommand;
    MainTableName: string;
    InterrimTableName: string;
    MainTableField : string;
    InterrimTableField : string;
    Criteria : string);

  Procedure CreateNewSite(SiteName : String);

  Procedure DeleteDataSet(DataSet: STring;
    TableName: String;
    FieldName,ScenTableFieldName : String;
    ADOCommand: TADOCommand);

  Procedure CreateNewRegime(RegimeName : String;
    RegimeStart: TDate;
    RegimeEnd : TDate);

  Procedure DeleteRegimeEvent(CurrentRDA : TRegimeDataArray;
    MyEventDate: TDate;
    MyEventType : String;
    MyRegimeName : String);

  Procedure SaveRegimeChanges(MyRegimeName : STring);

  Procedure UpdateRegimeSG(CurrentRegimeDataArray : TRegimeDataArray;
    SG: TStringGrid);

  Procedure SetSiteValues(NewDataSetName : String);

  Procedure WriteSILOWeatherData(DSName: string;
    FileName : String);

  Procedure UpdateSitesInfo(SiteName : String);

  Procedure CopySelectedParams(InParamsName: String);

  Procedure CreateNewParams(NewParamsName: String;
    CambiumParamsTableName: String;
    TPGParamsTableName: String;
    SpeciesNamesTableName: STring;
    SpeciesNameField: String;
    CambiumParamsList: array of TParametersList;
    TPGParamsList: array of TParametersList);

  Procedure DeleteScenarioDataAfterDataChanges(ScenariosTableName: String;
    InputName: String;
    InputType: Integer;
    SegmentDataADOQuery: TADOQuery;
    DeleteADOCommand: TADOCommand;
    ParamsType: Integer);

  Procedure GetSILOData(SILOFileName: String);

  Procedure CopyRegime(OldRegimeName,NewRegimeName: String;
  CurrentQuery: TADOQuery;
  RegimesTable: TADOTable;
  var CurrentRegimeDataArray: TRegimeDataArray);




var
  formAddEditData : TFormAddEditData;




const
  SITELATCMBTEXT = 'Select site latitude';
  DEFAULTLAT = '30';
  DEFAULTDEPTH = '100';
  DEFAULTTEXT = 'Sand';
  DEFAULTFR = 0.5;
  SILOWEATHERDATA = 'SILO';
  CUSTOMWEATHERDATA = 'Custom';


implementation

uses NewDataSetName, Event, New3PGParamSet, ImportWizard, CAMBIUMManager,
  AddEditCAMBIUMParams, ImportCambiumProjectData;

{$R *.dfm}

procedure TformAddEditData.bbnAddEventClick(Sender: TObject);
begin
  if lbRegimeNames.ItemIndex >=0 then begin
    if DateTimePicker2.Date > DateTimePicker1.Date then
      formEvent.showmodal
    else
      Messagedlg('The harvest date must be later than the establishment date',
        mtError,[mbOK],0);
  end else
    MessageDlg('First create a new, or select an existing, regime',mtError,[mbOK],0);

end;

Procedure CreateNewSite(SiteName : String);
begin
  InsertRecord(DataModule.DataModuleBoard.ADOCommandCAMBIUM,
    ProjectManager.SITENAMESTABLE,
    ProjectManager.SITENAMEFIELD,
    '"' + SiteName + '"');

  UpdateSitesInfo(SiteName);

end;

Procedure CopyRegime(OldRegimeName,NewRegimeName: String;
  CurrentQuery: TADOQuery;
  RegimesTable: TADOTable;
  var CurrentRegimeDataArray: TRegimeDataArray);
var
  i : integer;
begin
  SetLength(CurrentRegimeDataArray,0);
  FillRegimeDataArray(CurrentQuery,OldRegimeName,CurrentRegimeDataArray);
  for i := 0 to length(CurrentRegimeDataArray)-1 do begin
    CurrentRegimeDataArray[i].RegimeName :=NewRegimeName;
  end;
  WriteSavedRegimeInformation(CurrentRegimeDataArray,
    ProjectManager.REGIMESTABLE,
    RegimesTable,False);


end;

Procedure CreateNewRegime(RegimeName : String;
  RegimeStart: TDate;
  RegimeEnd : TDate);
begin
  InsertRecord(DataModule.DataModuleBoard.ADOCommandCAMBIUM,
    ProjectManager.REGIMENAMESTABLE,
    ProjectManager.REGIMENAMEFIELD,
    '"' + RegimeName + '"');

  InsertRecord(DataModule.DataModuleBoard.ADOCommandCAMBIUM,
    ProjectManager.REGIMESTABLE,
    ProjectManager.REGIMENAMEFIELD + ',' + ProjectManager.EVENTTYPEFIELD + ',' +
    ProjectManager.EVENTDATEFIELD + ',' + ProjectManager.EVENTVALUEFIELD,
    '"' + RegimeName + '","' + Event.EVENTPLANT + '","' +
    datetostr(RegimeStart) + '","' + formAddEditData.leInitialSpacing.text +  '"');

  InsertRecord(DataModule.DataModuleBoard.ADOCommandCAMBIUM,
    ProjectManager.REGIMESTABLE,
    ProjectManager.REGIMENAMEFIELD + ',' + ProjectManager.EVENTTYPEFIELD + ',' +
    ProjectManager.EVENTDATEFIELD + ',' + ProjectManager.EVENTVALUEFIELD,
    '"' + RegimeName + '","' + Event.EVENTHARVEST + '","' +
    datetostr(RegimeEnd) + '","' + '1"');


  General.GetDistinctValuesinField(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
    ProjectManager.REGIMENAMESTABLE,
    ProjectManager.REGIMENAMEFIELD,
    formAddEditData.lbRegimeNames.Items);
end;

Procedure UpdateRegimeSG(CurrentRegimeDataArray : TRegimeDataArray;
  SG: TStringGrid);
var
 h,i : integer;
 EDate : TDate;
begin
  EDate := EncodeDate(1900,01,01);

  SG.RowCount := 1 + Length(CurrentRegimeDataArray);
  for h := 0 to  Length(CurrentRegimeDataArray)-1 do begin
    if CurrentRegimeDataArray[h].EventType=Event.EVENTPLANT then
      EDate :=CurrentRegimeDataArray[h].EventDate;
  end;

  for i := 0 to Length(CurrentRegimeDataArray) -1 do begin
    if CurrentRegimeDataArray[i].EventType <> '' then begin

      SG.Rows[i+1].Strings[0] := CurrentRegimeDataArray[i].EventType;
      SG.Rows[i+1].Strings[1] := floattostr((CurrentRegimeDataArray[i].EventDate - EDate)/365.25);
      SG.Rows[i+1].Strings[2] := DatetoStr(CurrentRegimeDataArray[i].EventDate);
      if CurrentRegimeDataArray[i].EventType = EVENTPLANT  then
        SG.Rows[i+1].Strings[3] := 'Initial stand density of ' + floattostr(CurrentRegimeDataArray[i].EventValue) + ' stems/Ha';
      if CurrentRegimeDataArray[i].EventType = EVENTTHIN  then
        SG.Rows[i+1].Strings[3] := 'Residual stand density of ' + floattostr(CurrentRegimeDataArray[i].EventValue) + ' stems/Ha'
      else if CurrentRegimeDataArray[i].EventType = EVENTPRUN  then
        SG.Rows[i+1].Strings[3] := 'Pruning with intensity of ' + floattostr(CurrentRegimeDataArray[i].EventValue) + ' m'
      else if CurrentRegimeDataArray[i].EventType = EVENTFERT  then
        SG.Rows[i+1].Strings[3] := 'Fertilization to increase site FR by ' + floattostr(CurrentRegimeDataArray[i].EventValue)
      else if CurrentRegimeDataArray[i].EventType = EVENTHARVEST  then
        SG.Rows[i+1].Strings[3] := 'Clearfell';


      General.GridColAutoSize(formAddEditData.sgRegimeEvents);
    end;
  end;
end;

procedure TformAddEditData.bbnAddRegimeClick(Sender: TObject);
begin
  CurrentTargetTable :=  ProjectManager.REGIMESTABLE;
  CurrentRelevantField := ProjectManager.REGIMENAMEFIELD;

  if DateTimePicker2.Date - DateTimePicker1.Date > 365 then begin
    OKCANCL2.OKRightDlg.ShowModal;

    if OKCANCL2.OKRightDlg.ModalResult = mrOK then begin

      if OKCANCL2.OKRightDlg.leNewDatasetName.Text <> '' then begin
        if General.IsNewValueUnique(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
          OKCANCL2.OKRightDlg.leNewDatasetName.Text,
          CurrentTargetTable,CurrentRelevantField) then begin

          AddEditData.CreateNewRegime(OKCANCL2.OKRightDlg.leNewDatasetName.Text,
            formAddeditdata.DateTimePicker1.Date,
            formAddEditData.DateTimePicker2.date);
        end;
      end else
        MessageDlg('Specify a name for the regime',mtError,[mbOK],0);
    end;

  end else
    MessageDlg('A rotation of greater than 365 days is required. Please ' +
     're-check selected establishment and harvest dates.',mtError,[mbOK],0);

end;

Procedure CopySelectedParams(InParamsName: String);
var
  TempCambiumParams,TempTPGParams: TParametersListArray;

begin
  if OKCANCL2.OKRightDlg.leNewDatasetName.Text <> '' then begin
    if General.IsNewValueUnique(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
      OKCANCL2.OKRightDlg.leNewDatasetName.Text,
      ProjectManager.SPECIESNAMESTABLE,ProjectManager.SPECIESNAMEFIELD) then begin

      TempCambiumParams := ReadParameters(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
        formAddEditData.lbParamSets.Items[formAddEditData.lbParamSets.ItemIndex],
        ProjectManager.CAMBIUMPARAMSTABLE);

      TempTPGParams := ReadParameters(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
        formAddEditData.lbParamSets.Items[formAddEditData.lbParamSets.ItemIndex],
        ProjectManager.TPGPARAMSTABLE);

      CreateNewParams(OKCANCL2.OKRightDlg.leNewDatasetName.Text,
        ProjectManager.CAMBIUMPARAMSTABLE,
        ProjectManager.TPGPARAMSTABLE,
        ProjectManager.SPECIESNAMESTABLE,
        ProjectManager.SPECIESNAMEFIELD,
        TempCambiumParams,
        TempTPGParams);
    end;
  end else
    MessageDlg('Specify a name for the new parameter set',mtError,[mbOK],0);
end;

procedure TformAddEditData.bbnCopyParamsClick(Sender: TObject);
begin
  OKCANCL2.OKRightDlg.ShowModal;

  if OKCANCL2.OKRightDlg.ModalResult = mrOK then begin
    if lbParamSets.ItemIndex > -1 then begin
      CopySelectedParams(lbParamSets.items[lbparamsets.ItemIndex]);
    end else
      Messagedlg('First select a parameter set to copy',mtError,[mbOK],0);

    UpdateParamDataGrid(rgParamsTypes.ItemIndex,
      OKCANCL2.OKRightDlg.leNewDatasetName.Text);
  end;
end;

Procedure TformAddEditData.bbnCopyRegimeClick(Sender: TObject);
begin
  if lbRegimeNames.ItemIndex > -1 then begin
    OKCANCL2.OKRightDlg.ShowModal;

    if OKCANCL2.OKRightDlg.leNewDatasetName.Text <> '' then begin
      if OKCANCL2.OKRightDlg.ModalResult = mrOK then begin
        CopyRegime(lbRegimeNames.Items[lbRegimeNames.ItemIndex],
          OKCANCL2.OKRightDlg.leNewDatasetName.Text,
          DataModule.DataModuleBoard.ADOQueryCAMBIUM,
          DataModule.DataModuleBoard.ADOTableCAMBIUMGeneral,
          CurrentRegimeDataArray);

        General.GetDistinctValuesinField(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
          ProjectManager.REGIMENAMESTABLE,
          ProjectManager.REGIMENAMEFIELD,
          formAddEditData.lbRegimeNames.Items);
      end;
    end else
      Messagedlg('Specify a name for the new regime',mtError,[mbOK],0);
  end else
    messagedlg('First select a regime to copy',mtError,[mbOK],0);

end;

Procedure CreateNewParams(NewParamsName: String;
  CambiumParamsTableName: String;
  TPGParamsTableName: String;
  SpeciesNamesTableName: STring;
  SpeciesNameField: String;
  CambiumParamsList: array of TParametersList;
  TPGParamsList: array of TParametersList);
var
  i : integer;
  ParamsTableName: String;

begin
  for i := 0 to 1 do begin
    case i of
      0:  begin
        NewDataSetName.CurrentTargetTable := CambiumParamsTableName;
        NewDataSetName.CurrentRelevantField := SpeciesNameField;
        ParamsTableName := CambiumParamsTableName;

        AddEditCAMBIUMParams.WriteDefaultParamSet(NewParamsName,
          SpeciesNamesTableName,
          CambiumParamsTableName,
          CambiumParamsList);

      end;
      1:  begin
        NewDataSetName.CurrentTargetTable := TPGParamsTableName;
        NewDataSetName.CurrentRelevantField := SpeciesNameField;
        ParamsTableName := TPGParamsTableName;

        AddEditCAMBIUMParams.WriteDefaultParamSet(NewParamsName,
          SpeciesNamesTableName,
          TPGParamsTableName,
          TPGParamsList);

      end;

        //formNew3PGParamSet.showmodal;
    end;

    NewDataSetName.CurrentRelevantField := ProjectManager.SPECIESNAMEFIELD;

    General.GetDistinctValuesinField(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
      NewDataSetName.CurrentTargetTable,
      ProjectManager.SPECIESNAMEFIELD,
      formAddEditData.lbParamSets.Items);

    if formAddEditData.lbParamSets.Items.Count > 0 then begin
      formAddEditData.lbParamSets.Selected[0] := true;
      formAddEditData.UpdateParamDataGrid(formAddEditData.rgParamsTypes.itemindex,
        formAddEditData.lbParamSets.Items[0]);
    end;
  end;
end;

procedure TformAddEditData.bbnCreateNewParamsClick(Sender: TObject);

begin
  OKCANCL2.OKRightDlg.ShowModal;

  if OKCANCL2.OKRightDlg.ModalResult = mrOK then begin
    if OKCANCL2.OKRightDlg.leNewDatasetName.Text <> '' then begin
      if General.IsNewValueUnique(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
        OKCANCL2.OKRightDlg.leNewDatasetName.Text,
        ProjectManager.SPECIESNAMESTABLE,ProjectManager.SPECIESNAMEFIELD) then begin

        CreateNewParams(OKCANCL2.OKRightDlg.leNewDatasetName.Text,
          ProjectManager.CAMBIUMPARAMSTABLE,
          ProjectManager.TPGPARAMSTABLE,
          ProjectManager.SPECIESNAMESTABLE,
          ProjectManager.SPECIESNAMEFIELD,
          AddEditCAMBIUMParams.DefaultParameterItems_RadiataXylem,
          AddEditCAMBIUMParams.DefaultParameterItems_RadiataStand);

        rgParamsTypes.ItemIndex := 0;
        lbParamSets.ItemIndex := 0;

        UpdateParamDataGrid(rgParamsTypes.ItemIndex,
          lbParamSets.Items[lbParamSets.ItemIndex]);

      end;
    end else
      Messagedlg('Specify a name for the new parameter set',mtError,[mbOK],0);
  end;
end;

procedure TformAddEditData.bbnCreateNewSiteClick(Sender: TObject);
begin
  with formAddEditData do begin
    if cmbSiteLat.Text <> '' then begin
      if cmbSoilTexture.Text <> '' then begin
        if cmbSoilDepth.Text <> '' then begin
          if strtoint(leMinASW.Text) < strtoint(leMaxASW.Text) then begin
            if (strtoint(formAddEditData.leInitialASW.Text) <= strtoint(leMaxASW.Text)) and
              (strtoint(formAddEditData.leInitialASW.Text) >= strtoint(leMinASW.Text)) then begin

              CurrentTargetTable := ProjectManager.SITESTABLE;
              CurrentRelevantField := ProjectManager.SITENAMEFIELD;

              OKCANCL2.OKRightDlg.ShowModal;

              if OKCANCL2.OKRightDlg.ModalResult = mrOK then begin
                if OKCANCL2.OKRightDlg.leNewDatasetName.Text <> '' then begin
                  if General.IsNewValueUnique(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
                    OKCANCL2.OKRightDlg.leNewDatasetName.Text,
                    CurrentTargetTable,CurrentRelevantField) then begin

                    AddEditData.CreateNewSite(OKCANCL2.OKRightDlg.leNewDatasetName.Text);
                  end;
                end else
                  Messagedlg('Specify a name for the site',mtError,[mbOK],0);
              end;
            end else
              Messagedlg('Initial ASW (' + formAddEditData.leInitialASW.Text + ') must be within the range of minimum and maximum ASW for the site',mtError,[mbOK],0);
          end else
            Messagedlg('Minimum site available soil water must be less than maximum available soil water',mtError,[mbOK],0);
        end else
          Messagedlg('Specify soil depth',mtError,[mbOK],0);
      end else
        MessageDlg('Specify soil texture',mtError,[mbOK],0);
    end else
      Messagedlg('Specify site latitude',mtError,[mbOK],0);
  end;


end;

procedure TformAddEditData.bbnDeleteEventClick(Sender: TObject);
var
  EventDate : TDate;
  EventType : String;
  i : integer;
begin

  if sgRegimeEvents.Row > 0 then begin
    EventDate := strtodate(sgRegimeEvents.Cells[2,sgRegimeEvents.Row]);
    EventType := sgRegimeEvents.Cells[0,sgRegimeEvents.Row];

    if (EventType <> Event.EVENTPLANT) and (EventType <> Event.EVENTHARVEST) then begin

      DeleteRegimeEvent(CurrentRegimeDataArray,EventDate,
        EventType,lbRegimeNames.Items[lbRegimeNAmes.ItemIndex]);

      for i := 1 to formAddEditData.sgRegimeEvents.RowCount-1 do
       formAddEditData.sgRegimeEvents.Rows[i].Clear;
      formAddEditData.sgRegimeEvents.RowCount := 1;

      UpdateRegimeSG(CurrentRegimeDataArray,
        formAddEditData.sgRegimeEvents);

    end else
      messagedlg('Establishment and harvest events cannot be deleted.  The entire regime must be deleted',mtError,[mbOK],0);
  end else
    Messagedlg('First select a regime event to delete',mtError,[mbOK],0);
end;

Procedure DeleteRegimeEvent(CurrentRDA : TRegimeDataArray;
  MyEventDate: TDate;
  MyEventType : String;
  MyRegimeName : String);
var
  i : integer;
begin
  for i := 0 to Length(CurrentRDA)-1 do begin
    if (CurrentRDA[i].RegimeName = MyRegimeName) and
     (floor(CurrentRDA[i].EventDate) = floor(MyEventDate)) and
     (CurrentRDA[i].EventType = MyEventType) then begin
     CurrentRDA[i].EventType := '';
     CurrentRDA[i].RegimeName := '';
     CurrentRDA[i].EventDate := EncodeDate(1900,01,01);
     CurrentRDA[i].eventvalue := 0;
    end;
  end;
end;

procedure TformAddEditData.bbnDeleteParamsClick(Sender: TObject);
begin
  if lbParamSets.ItemIndex > -1 then begin
    if rgParamsTypes.ItemIndex = 0 then begin
      if Messagedlg('All scenarios using this parameter set will be deleted.  The' +
        ' associated stand model parameter set will also be deleted. Do you want to proceed?',
        mtWarning,[mbYes,mbNo],0) = mrYes then begin

        Screen.Cursor := crHourglass;
        Application.ProcessMessages;

        try

          DeleteDataSet(lbParamSets.Items[lbParamSets.ItemIndex],
            ProjectManager.SCENARIOSTABLE,
            ProjectManager.SCENARIOCAMBIUMPARAMSFIELD,
            ProjectManager.SCENARIOCAMBIUMPARAMSFIELD,
            DataModule.DataModuleBoard.ADOCommandCAMBIUM);

          DeleteDataSet(lbParamSets.Items[lbParamSets.ItemIndex],
            ProjectManager.CAMBIUMPARAMSTABLE,
            ProjectManager.SPECIESNAMEFIELD,
            ProjectManager.SCENARIOCAMBIUMPARAMSFIELD,
            DataModule.DataModuleBoard.ADOCommandCAMBIUM);

          DeleteDataSet(lbParamSets.Items[lbParamSets.ItemIndex],
            ProjectManager.TPGPARAMSTABLE,
            ProjectManager.SPECIESNAMEFIELD,
            ProjectManager.SCENARIOCAMBIUMPARAMSFIELD,
            DataModule.DataModuleBoard.ADOCommandCAMBIUM);

          DeleteDataSet(lbParamSets.Items[lbParamSets.ItemIndex],
            ProjectManager.SPECIESNAMESTABLE,
            ProjectManager.SPECIESNAMEFIELD,
            ProjectManager.SCENARIOCAMBIUMPARAMSFIELD,
            DataModule.DataModuleBoard.ADOCommandCAMBIUM);


          General.GetDistinctValuesinField(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
            ProjectManager.CAMBIUMPARAMSTABLE,
            ProjectManager.SPECIESNAMEFIELD,
            lbParamSets.Items);

          dbgParams.Columns.Clear;
        finally
          Screen.Cursor := crDefault;
        end;
      end;
    end else
      messagedlg('Delete the associated CAMBIUM parameter set first',mtError,[mbOK],0);
  end else
    Messagedlg('First select a parameter set to delete',mtError,[mbOK],0);
end;

procedure TformAddEditData.bbnDeleteRegimeClick(Sender: TObject);
var
  i : integer;
begin
  if lbRegimeNames.ItemIndex > -1 then begin
    if messagedlg('All scenarios using this regime will be deleted.' +
    ' Do you want to proceed?', mtWarning,[mbYes,mbNo],0) = mrYes then begin
      try
        Screen.Cursor := crHourglass;
        Application.ProcessMessages;

        DeleteDataSet(lbRegimeNames.Items[lbRegimeNames.ItemIndex],
          ProjectManager.REGIMESTABLE,
          ProjectManager.REGIMENAMEFIELD,
          ProjectManager.SCENARIOREGIMEFIELD,
          DataModule.DataModuleBoard.ADOCommandCAMBIUM);

        DeleteDataSet(lbRegimeNames.Items[lbRegimeNames.ItemIndex],
          ProjectManager.REGIMENAMESTABLE,
          ProjectManager.REGIMENAMEFIELD,
          ProjectManager.SCENARIOREGIMEFIELD,
          DataModule.DataModuleBoard.ADOCommandCAMBIUM);

        General.GetDistinctValuesinField(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
          ProjectManager.REGIMESTABLE,
          ProjectManager.REGIMENAMEFIELD,
          lbRegimeNames.Items);

        for i := 0 to sgRegimeEvents.ColCount - 1 do
          sgRegimeEvents.Cols[i].Clear;
        sgRegimeEvents.RowCount := 1;
      finally
        Screen.Cursor := crDefault;
      end;
    end;
  end else
    Messagedlg('First select a regime to delete',mtError,[mbOK],0);
end;

procedure TformAddEditData.bbnDeleteSiteClick(Sender: TObject);
begin
  if lbSiteNames.ItemIndex > -1 then begin

    if messagedlg('All scenarios using this site will be deleted.' +
      ' Do you want to proceed?', mtWarning,[mbYes,mbNo],0) = mrYes then begin

      Screen.Cursor := crHourglass;
      Application.ProcessMessages;

      try
        DeleteDataSet(lbSiteNames.Items[lbSiteNames.ItemIndex],
          ProjectManager.SITESTABLE,
          ProjectManager.SITENAMEFIELD,
          ProjectManager.SCENARIOSITEFIELD,
          DataModule.DataModuleBoard.ADOCommandCAMBIUM);

        DeleteDataSet(lbSiteNames.Items[lbSiteNames.ItemIndex],
          ProjectManager.SITENAMESTABLE,
          ProjectManager.SITENAMEFIELD,
          ProjectManager.SCENARIOSITEFIELD,
          DataModule.DataModuleBoard.ADOCommandCAMBIUM);


        General.GetDistinctValuesinField(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
          ProjectManager.SITESTABLE,
          ProjectManager.SITENAMEFIELD,
          lbSiteNames.Items);


        if lbSIteNames.Items.Count >0 then begin
          lbSiteNames.Selected[0]:= true;
          lbSiteNames.ItemIndex := 0;
        end else
          lbSiteNames.ItemIndex := -1;

        formAddEditData.UpdateFormForSelectedSite(lbSiteNames.ItemIndex);
      finally
        Screen.Cursor := CrDefault;
      end;
    end;
  end else
    Messagedlg('First select a site to delete',mtError,[mbOK],0);
end;

Procedure TformAddEditData.UpdateFormForSelectedSite(ItemIndex: Integer);
begin
  if ItemIndex > -1 then begin

    FillSitedataRecord(DataMOdule.DataModuleBoard.ADOQueryCAMBIUM,
      lbSiteNames.Items[lbSiteNames.ItemIndex],
      CurrentSiteData);

    cmbSiteLat.ItemIndex := cmbSiteLat.Items.IndexOf(inttostr(CurrentSiteData.Latitude));
    cmbSoilDepth.itemindex :=  cmbSoilDepth.Items.IndexOf(floattostr(CurrentSiteData.SoilDepth));
    cmbSoilTexture.itemindex := cmbSoilTexture.items.IndexOf(CurrentSiteData.SoilTexture);
    cmbSiteFR.itemindex := cmbSiteFR.items.IndexOf(Format('%.2f',[CurrentSiteData.FR]));
    leMinASW.text := floattostr(CurrentSiteData.MinASW);
    leMaxASW.Text := floattostr(CurrentSiteData.MaxASW);
    formAddEditData.leInitialASW.Text := floattostr(CurrentSiteData.InitialASW);
  end else begin
    cmbSiteLat.ItemIndex := -1;
    cmbSiteLat.ItemIndex := -1;
    cmbSoilTexture.ItemIndex := -1;
    cmbSiteFR.ItemIndex := -1;
    cmbSoilDepth.ItemIndex := -1;
    leMinASW.Text := '0';
    leMaxASW.Text := '0';
    leInitialASW.Text := '0';
  end;
end;

procedure TformAddEditData.bbnDeleteWeatherDSClick(Sender: TObject);
begin
  if lbWeatherDataSets.ItemIndex > -1 then begin
    if messagedlg('All scenarios using this weather data will be deleted.' +
      ' Do you want to proceed?', mtWarning,[mbYes,mbNo],0) = mrYes then begin
      Screen.Cursor := crHourglass;
      Application.ProcessMessages;

      try
        DeleteDataSet(lbWeatherDataSets.Items[lbWeatherDataSets.ItemIndex],
          ProjectManager.WEATHERDATATABLE,
          ProjectManager.WEATHERDATASETNAMEFIELD,
          ProjectManager.SCENARIOWEATHERDATAFIELD,
          DataModule.DataModuleBoard.ADOCommandCAMBIUM);

        DeleteDataSet(lbWeatherDataSets.Items[lbWeatherDataSets.ItemIndex],
          ProjectManager.WEATHERDATASETNAMESTABLE,
          ProjectManager.WEATHERDATASETNAMEFIELD,
          ProjectManager.SCENARIOWEATHERDATAFIELD,
          DataModule.DataModuleBoard.ADOCommandCAMBIUM);


        General.GetDistinctValuesinField(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
          ProjectManager.WEATHERDATASETNAMESTABLE,
          ProjectManager.WEATHERDATASETNAMEFIELD,
          lbWeatherDataSets.Items);

        formAddEditData.dbchartraintemp.Series[0].Clear;
        formAddEditData.dbchartraintemp.Series[1].Clear;

        formAddEditData.dbChartSREvap.Series[0].Clear;
        formAddEditData.dbChartSREvap.Series[1].Clear;
      finally
        Screen.Cursor := CRDefault;
      end;
    end;
  end else
    Messagedlg('First select a dataset to delete',mtError,[mbOK],0);

end;

Procedure DeleteDataSet(DataSet: STring;
  TableName: String;
  FieldName,ScenTableFieldName : String;
  ADOCommand: TADOCommand);
var
  SNames : TStringList;
  i : integer;
begin

  SNames := TStringList.Create;

  SNames := ScenarioManager.GetScenariosUsingDataSet(ProjectManager.SCENARIOSTABLE,
    ScenTableFieldName,
    DataSet,
    DataModule.DataModuleBoard.ADOQueryCAMBIUM);

  for i := 0 to Snames.Count-1 do begin
    ScenarioManager.DeleteScenarios(SNames,
      ProjectManager.SCENARIOSTABLE,
      ProjectManager.SCENARIONAMEFIELD,
      DataModule.DataModuleBoard.ADOCommandCAMBIUM);

    ScenarioManager.DeleteScenarios(SNames,
      ProjectManager.CABALASCENARIOSTABLE,
      ProjectManager.SCENARIONAMEFIELD,
      DataModule.DataModuleBoard.ADOCommandCAMBIUM);
  end;

  SNames.Free;

  General.DeleteFromTable(DataModule.DataModuleBoard.ADOCommandCAMBIUM,
    TableName,
    FieldName + '="' + DataSet + '"');

  CAMBIUMManager.formMain.UpdateGUI(CurrentOpenProject);
end;

procedure TformAddEditData.bbnImportCustomWeatherDataClick(Sender: TObject);
begin
  formImportWizard.showmodal;
  formImportWizard.cmbDataType.ItemIndex := WEATHERDATAINDICATOR;
  formImportWizard.Refresh;
end;

procedure TformAddEditData.bbnImportSILOClick(Sender: TObject);

begin
  if formaddeditdata.OpenDialogSILO.Execute = True then begin

    GetSILOData(OpenDialogSILO.FileName);
  end;
end;



Procedure WriteSILOWeatherData(DSName: string;
  FileName : String);
var
  //TempSLArray : TStringListArray;
  TempSL : TStringList;
  StartLine : Integer;

const
  //SILO columns of date,rain,mint,maxt,evap,radn,minrh,maxrh
  SILOColsList : array[0..7] of integer = (1,7,3,5,9,11,16,15);
begin
  TempSL := TStringList.Create;
  Startline := 0;

  try
    formImportDataProgress.Show;

    screen.cursor := crHourglass;

    if FileName <> '' then begin
      //TempSLArray := ReadDelimitedFile(CurrentFileName,
        //' ',34);
      try
        TempSL.LoadFromFile(FileName);

        while copy(TempSL[StartLine],1,10) <> '(yyyymmdd)' do
          StartLine := StartLine + 1;

        WriteSILOData(DSName,
          TempSL,' ',StartLine+2,SILOColsList[0],SILOColsList[1],SILOColsList[2],
          SILOColsList[3],SILOColsList[4],SILOColsList[5],SILOColsList[6],
          SILOColsList[7],DataModule.DataModuleBoard.ADOTableCAMBIUMGeneral);
      except
        on E: Exception do
          Messagedlg('There was a problem opening the file',mtError,[mbOK],0);
      end;
    end;
  finally
    formImportDataProgress.close;
    formImportDataProgress.ProgressBar1.Position := 1;
    TempSL.Free;
    screen.cursor := crdefault;
  end;

end;



Procedure SetSiteValues(NewDataSetName : String);
var
  b: Double;
begin
  //See Campbell and Norman 1998 for these coefficients
  b := 1.7;

  case formAddeditData.cmbSoilTexture.ItemIndex of
    0 :  b := 1.7;
    1 :  b := 2.1;
    2 :  b := 3.1;
    3 :  b := 4.5;
    4 :  b := 4.7;
    5 :  b := 4;
    6 :  b := 5.2;
    7 :  b := 6.6;
    8 :  b := 6;
    9 :  b := 7.9;
    10 :  b := 7.6;
  end;

  CurrentSiteData.SiteName := NewDataSetName;
  CurrentSiteData.Latitude := strtoint(formAddeditData.cmbSiteLat.Text);
  CurrentSiteData.SoilDepth :=  strtofloat(formAddeditData.cmbSoilDepth.text);
  CurrentSiteData.SoilTexture :=  formAddeditData.cmbSoilTexture.Text;
  CurrentSiteData.SoilClass := b;
  CurrentSiteData.FR :=  strtofloat(formAddEditData.cmbSiteFR.text);
  CurrentSiteData.MinASW := strtofloat(formAddeditData.leMinASW.Text);
  CurrentSiteData.MaxASW := strtofloat(formAddeditData.leMaxASW.Text);
  CurrentSiteData.InitialASW := strtofloat(formAddEditData.leInitialASW.Text);
end;

Procedure DeleteScenarioDataAfterDataChanges(ScenariosTableName: String;
  InputName: String;
  InputType: Integer;
  SegmentDataADOQuery: TADOQuery;
  DeleteADOCommand: TADOCommand;
  ParamsType: Integer);
var
  SQLString: String;
  OperationalFieldName : String;
  MyScenarioName : String;
  OnlyIGMDeleteString : STring;

begin
  OnlyIGMDeleteString := '';

  case InputType of
    1 : OperationalFieldName := SCENARIOSITEFIELD;
    2 : OperationalFieldName := SCENARIOREGIMEFIELD;
    3 : OperationalFieldName := SCENARIOWEATHERDATAFIELD;
    4 : OperationalFieldName := SCENARIOCAMBIUMPARAMSFIELD;
  end;

  case ParamsType of
    0: OnlyIGMDeleteString := '';
    1: begin
      OnlyIGMDeleteString := ' AND ' + ProjectManager.SCENARIOTYPEFIELD + '="' +
      CAMBIUM_SCENARIO_TYPE + '"';
    end;
  end;

  SQLString := '';
  SQLString := 'SELECT * FROM ' +
    ScenariosTableName + ' WHERE ' +
    ScenariosTableName + '.' + OperationalFieldName + '="' +
    InputName + '"' + OnlyIGMDeleteString;

  SegmentDataADOQuery.SQL.Clear;
  SegmentDataADOQuery.SQL.Add(SQLString);

  try
    SegmentDataADOQuery.Active := true;
    while not SegmentDataADOQuery.Eof do begin
      MyScenarioName := SegmentDataADOQuery.FieldByName(SCENARIONAMEFIELD).AsString;
      DeleteFromTable(DeleteADOCommand,CAMBIUMSEGMENTSDATATABLE,
        SCENARIONAMEFIELD + '="' + MyScenarioName + '"');
      DeleteFromTable(DeleteADOCommand,DAILYOUTPUTDATATABLE,
        SCENARIONAMEFIELD + '="' + MyScenarioName + '"');

      SegmentDataADOQuery.next;
    end;
  except
    on E: Exception do
      Messagedlg('Data from scenarios using the associated input data set were not deleted: ' +
        E.Message,mtError,[mbOK],0);
  end;
end;


procedure TformAddEditData.bbnSaveParamsClick(Sender: TObject);
var
  CurrentTableName : String;
begin
  if Messagedlg('All data for scenarios using this parameter set will be deleted.  Continue?',
    mtWarning,[mbYes,mbNo],0) = MrYes then begin

    try
      Screen.Cursor := CrHourglass;
      Application.processmessages;

      case rgParamsTypes.ItemIndex of
        0: CurrentTableName := projectManager.CAMBIUMPARAMSTABLE;
        1: CurrentTableName := ProjectManager.TPGPARAMSTABLE;
      end;

      UpdateMainParamsTable(DataModule.DataModuleBoard.ADOCommandCAMBIUM,
        CurrentTableName,
        ProjectManager.TEMPDATAEDITTINGTABLE,
        ProjectManager.PARAMVALUEFIELD,
        ProjectManager.PARAMVALUEFIELD,
        (CurrentTableName + '.' +
        ProjectManager.SPECIESNAMEFIELD + '=' +
        ProjectManager.TEMPDATAEDITTINGTABLE + '.' +
        ProjectManager.SPECIESNAMEFIELD + ' AND ' +
        CurrentTableName + '.' +
        ProjectManager.PARAMNAMEFIELD + '=' +
        ProjectManager.TEMPDATAEDITTINGTABLE + '.' +
        ProjectManager.PARAMNAMEFIELD));

      Screen.Cursor := CrHourglass;
      Application.processmessages;

      DeleteScenarioDataAfterDataChanges(SCENARIOSTABLE,
        lbParamSets.items[lbParamSets.ItemIndex],
        PARAMSCODE,DataModule.DataModuleBoard.ADOQueryCAMBIUM,
        DataModule.DataModuleBoard.ADOCommandCAMBIUM,
        rgParamsTypes.ItemIndex);

      CAMBIUMManager.formMain.UpdateGUI(CurrentOpenProject);
    finally
      Screen.Cursor := crDefault;
      application.processmessages;
    end;
  end;
end;

procedure TformAddEditData.bbnSaveRegimeClick(Sender: TObject);
begin
  if lbRegimeNames.ItemIndex > -1 then begin
      SaveRegimeChanges(lbRegimeNames.Items[lbRegimeNames.ItemIndex]);
  end else
    Messagedlg('First select a regime',mtError,[mbOK],0);

end;

Procedure SaveRegimeChanges(MyRegimeName : STring);
begin
    if Messagedlg('All data for scenarios using this regime will be deleted.  Continue?',mtWarning,
      [mbYes,mbNo],0) = mrYes then begin

      try
        Screen.Cursor := crHourglass;

        WriteData.WriteSavedRegimeInformation(CurrentRegimeDataArray,
          ProjectManager.REGIMESTABLE,
          DataModule.DataModuleBoard.ADOTableCAMBIUMGeneral,
          True);

        UpdateRegimeSG(CurrentRegimeDataArray,formAddEditdata.sgRegimeEvents);

        ReadData.FillRegimeDataArray(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
          MyRegimeName,
          CurrentRegimeDataArray);

        DeleteScenarioDataAfterDataChanges(SCENARIOSTABLE,
          MyRegimeName,
          REGIMEDATACODE,DataModule.DataModuleBoard.ADOQueryCAMBIUM,
          DataModule.DataModuleBoard.ADOCommandCAMBIUM,
          0);

        CAMBIUMManager.formMain.UpdateGUI(CurrentOpenProject);

        UpdateRegimeSG(CurrentRegimeDataArray,formAddEditdata.sgRegimeEvents);

      finally
        Screen.Cursor := crDefault;
      end;
    end;

end;

procedure TformAddEditData.bbnSaveSiteClick(Sender: TObject);
var
  MySiteMemo : SmallInt;
  MySiteName : String;
begin
  if lbSiteNames.ItemIndex > -1 then begin
    if Messagedlg('All data for scenarios using this site will be deleted.  Continue?',mtWarning,
      [mbYes,mbNo],0) = mrYes then begin

      try
        Screen.Cursor := crHourglass;
        Application.processmessages;

        MySiteMemo := lbSiteNames.ItemIndex;
        MySiteName := lbSiteNames.items[MySiteMemo];

        UpdateSitesInfo(lbSiteNames.Items[MySiteMemo]);

        DeleteScenarioDataAfterDataChanges(SCENARIOSTABLE,
          MySiteName,
          SITEDATACODE,DataModule.DataModuleBoard.ADOQueryCAMBIUM,
          DataModule.DataModuleBoard.ADOCommandCAMBIUM,0);

        CAMBIUMManager.formMain.UpdateGUI(CurrentOpenProject);

        lbSiteNames.ItemIndex := MySiteMemo;
      finally
        Screen.Cursor := crDefault;
        Application.ProcessMessages;
      end;
    end;
  end else
    Messagedlg('First select a site to edit.  Otherwise, first click on "Create a new site"',
      mtError,[mbOK],0);
end;



Procedure UpdateSitesInfo(SiteName: String);
begin
  with formAddEditData do begin
    if cmbSiteLat.Text <> '' then begin
      if cmbSoilTexture.Text <> '' then begin
        if cmbSoilDepth.Text <> '' then begin
          if strtoint(leMinASW.Text) <= strtoint(leMaxASW.Text) then begin
            if (strtoint(formAddEditData.leInitialASW.Text) <= strtoint(leMaxASW.Text)) and
              (strtoint(formAddEditData.leInitialASW.Text) >= strtoint(leMinASW.Text)) then begin


              SetSiteValues(SiteName);

              WriteData.WriteSiteInformation(CurrentSiteData,
                ProjectManager.SITESTABLE,
                DataModule.DataModuleBoard.ADOTableCAMBIUMGeneral,
                True);

              General.GetDistinctValuesinField(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
                ProjectManager.SITESTABLE,
                ProjectManager.SITENAMEFIELD,
                lbSiteNames.Items);

            end else
              Messagedlg('Initial ASW (' + formAddEditData.leInitialASW.Text + ') must be within the range of minimum and maximum ASW for the site',mtError,[mbOK],0);
          end else
            Messagedlg('Minimum site available soil water must be less than maximum available soil water',mtError,[mbOK],0);
        end else
          Messagedlg('Specify soil depth',mtError,[mbOK],0);
      end else
        MessageDlg('Specify soil texture',mtError,[mbOK],0);
    end else
      Messagedlg('Specify site latitude',mtError,[mbOK],0);
  end;
end;

procedure TformAddEditData.DatafromaneCambiumproject1Click(Sender: TObject);
begin
  formImportCambiumProject.showmodal;
end;

procedure TformAddEditData.DateTimePicker1Change(Sender: TObject);
var
  i : integer;
  EventBeforeNewDate : Boolean;
begin
  EventBeforeNewDate := false;

  UpdateRotationLengthLabel;
  for i := 0 to length(CurrentRegimeDataArray)-1 do begin
    if (CurrentRegimeDataArray[i].EventType <> Event.EVENTPLANT) and
      (CurrentRegimeDataArray[i].EventDate < DateTimePicker1.Date) then
      EventBeforeNewDate := true;
  end;
  for i := 0 to length(CurrentRegimeDataArray)-1 do begin
    if (CurrentRegimeDataArray[i].EventType = Event.EVENTPLANT) and
      (EventBeforeNewDate = False) then
      CurrentRegimeDataArray[i].EventDate := DateTimePicker1.Date;
  end;

  if EventBeforeNewDate then
    Messagedlg('The planting date could not be changed as another event is scheduled for an earlier date.',
      mtError,[mbOK],0);

end;

procedure TformAddEditData.DateTimePicker2Change(Sender: TObject);
var
  i : integer;
  EventAfterNewDate : Boolean;
begin
  UpdateRotationLengthLabel;
  EventAfterNewDate := false;

  for i := length(CurrentRegimeDataArray)-1 downto 0 do begin
    if (CurrentRegimeDataArray[i].EventType <> Event.EVENTHARVEST) and
      (CurrentRegimeDataArray[i].EventDate > DateTimePicker1.Date) then
      EventAfterNewDate := true;
  end;

  for i := length(CurrentRegimeDataArray)-1 downto 0 do begin
    if (CurrentRegimeDataArray[i].EventType = Event.EVENTHARVEST) and
      (EventAfterNewDate = false)  then
      CurrentRegimeDataArray[i].EventDate := DateTimePicker2.Date;
  end;

  if EventAfterNewDate then
    Messagedlg('The harvesting date could not be changed as another event is scheduled for a later date.',
      mtError,[mbOK],0);

end;

Procedure TFormAddEditData.ScaleFormObjects;
begin
  DBChartRainTemp.Height := round(pcDataAddEdit.Height/2);

end;

procedure TformAddEditData.UpdateRotationLengthLabel;
begin
  if DateTimePicker2.Date > DateTimePicker1.Date then begin

    labelRotationLength.Caption := 'Rotation length: ' +
      Format('%.2f', [(DateTimePicker2.Date -
      DateTimePicker1.Date)/365.25]) + ' years';
  end else
    labelRotationLength.Caption := 'Rotation length: ';

end;

Procedure UpdateMainParamsTable(CurrentADOCommand: TADOCommand;
  MainTableName: string;
  InterrimTableName: string;
  MainTableField : string;
  InterrimTableField : string;
  Criteria : string);
var
  SQLString : string;
begin
  SQLString := '';
  SQLString := 'UPDATE ' +
    MainTableName + ',' + InterrimTableName +
    ' SET ' + MainTableName + '.' + MainTableField + '=' +
    InterrimTableName + '.' + InterrimTableField +
    ' WHERE ' +
    Criteria;

  CurrentADOCommand.CommandText := SQLString;
  try
    CurrentADOCommand.Execute;
    messagedlg('Changes to the data were successfully saved',mtInformation,[mbOK],0);
  except
    on E:Exception do begin
      messagedlg('Changes were not saved: ' + E.Message,mtWarning,[mbOK],0);
    end;
  end;
end;





{procedure TformAddEditData.fodSILOWeatherDataFileOkClick(Sender: TObject;
  var CanClose: Boolean);
begin
    WriteSILOWeatherData();
end;}

procedure TformAddEditData.FormResize(Sender: TObject);
begin
  ScaleFormObjects;
end;

procedure TformAddEditData.FormShow(Sender: TObject);
begin
  pcDataAddEdit.TabIndex := 0;
  UpdateLists;
end;

Procedure TformAddEditData.UpdateLists;
begin

    General.GetDistinctValuesinField(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
      ProjectManager.SPECIESNAMESTABLE,
      ProjectManager.SPECIESNAMEFIELD,
      AddEditData.formAddEditData.lbParamSets.Items);

    General.GetDistinctValuesinField(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
      ProjectManager.REGIMENAMESTABLE,
      ProjectManager.REGIMENAMEFIELD,
      AddEditData.formAddEditData.lbRegimeNames.Items);

    General.GetDistinctValuesinField(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
      ProjectManager.SITENAMESTABLE,
      ProjectManager.SITENAMEFIELD,
      AddEditData.formAddEditData.lbSiteNames.Items);

    General.GetDistinctValuesinField(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
      ProjectManager.WEATHERDATATABLE,
      ProjectManager.WEATHERDATASETNAMEFIELD,
      AddEditData.formAddEditData.lbWeatherdatasets.Items);

    UpDateRegimeSGHeaders;

    if lbParamSets.Count > 0 then begin
      lbParamSets.ItemIndex := 0;
      UpdateParamDataGrid(rgParamsTypes.ItemIndex,
        lbParamSets.Items[lbParamSets.ItemIndex]);
    end;

    if lbSiteNames.Count > 0 then begin
      lbSiteNames.ItemIndex := 0;
      formAddEditData.UpdateFormForSelectedSite(lbSiteNames.ItemIndex);
    end;

    if lbRegimeNames.Count > 0 then begin
      lbRegimeNames.ItemIndex := 0;
      formAddEditData.UpDateRegimeSGHeaders;
      FillRegimeSG(lbRegimeNames.Items[lbRegimeNames.ItemIndex]);
    end;

    if lbWeatherDataSets.Count > 0 then begin
      lbWeatherDataSets.ItemIndex := 0;
      UpdateWeatherGraphs(lbWeatherDataSets.items[lbWeatherDataSets.ItemIndex],
        DataModule.DataModuleBoard.ADOQueryWeatherDisplay);
    end;

    General.GridColAutoSize(sgRegimeEvents);

    bbnAddEvent.Font.Color := clBlue;
    bbnDeleteEvent.Font.Color := clBlue;
end;

Procedure TformAddEditData.UpdateParamDataGrid(ParamsType : Integer;
  SpeciesName: String);
var
  ParamsTableName : String;
begin
  ParamsTableName := '';
  if SpeciesName <> '' then begin

    case ParamsType of
      0: ParamsTableName := ProjectManager.CAMBIUMPARAMSTABLE;
      1: ParamsTableName := projectManager.TPGPARAMSTABLE;
    end;

    AddDatatoDBGrid(dbgParams,dsAddEditParams,datamodule.DataModuleBoard.ADOTableInputParam,
      datamodule.DataModuleBoard.ADOCommandCAMBIUM,ParamsTableName,
      ProjectManager.SPECIESNAMEFIELD + '="' + SpeciesName + '"',
      ProjectManager.PARAMDESCRIPTIONFIELD + ' ASC');

    //Define visible and read-only columns specific to the cambial
    //parameters table
    dbgParams.Columns[0].Visible := false;
    dbgParams.Columns[1].Visible := false;
    dbgParams.Columns[2].Visible := false;
    dbgParams.Columns[3].ReadOnly := true;
    dbgParams.Columns[1].ReadOnly := true;

    dbgParams.Columns[3].Width := 300;
  end;
end;

procedure TformAddEditData.lbParamSetsClick(Sender: TObject);
begin
  UpdateParamDataGrid(rgParamsTypes.ItemIndex,
    lbParamSets.Items[lbParamSets.ItemIndex]);
end;

procedure TformAddEditData.lbRegimeNamesClick(Sender: TObject);
begin
  if lbRegimeNames.ItemIndex > -1 then begin
    UpdateRegimeSGHeaders;
    FillRegimeSG(lbRegimeNames.Items[lbRegimeNames.ItemIndex]);
  end;
end;

Procedure TformAddEditData.FillRegimeSG(RegimeName : String);
begin
  ReadData.FillRegimeDataArray(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
    RegimeName,
    CurrentRegimeDataArray);

  UpdateDTPickers(CurrentRegimeDataArray);

  UpdateRegimeSG(CurrentRegimeDataArray,formAddEditdata.sgRegimeEvents);

  UpdateRotationLengthLabel;
end;

Procedure TFormaddeditdata.UpdateDTPickers(RDA : TRegimeDataArray);
var
  i : integer;
begin
  for i := 0 to Length(RDA)-1 do begin
    if RDA[i].EventType = Event.EVENTPLANT then begin
      DateTimePicker1.Date := RDA[i].EventDate;
      leInitialSpacing.Text := floattostr(RDA[i].EventValue);
    end;
    if RDA[i].EventType = Event.EVENTHARVEST then
      DateTimePicker2.Date := RDA[i].EventDate;
  end;
end;



procedure TformAddEditData.lbSiteNamesClick(Sender: TObject);
begin
  if lbSiteNames.ItemIndex > -1 then
    formAddEditData.UpdateFormForSelectedSite(lbSiteNames.ItemIndex);
end;

procedure TformAddEditData.lbWeatherDatasetsClick(Sender: TObject);
begin
  if lbWeatherDataSets.ItemIndex > -1 then
    UpdateWeatherGraphs(lbWeatherDataSets.items[lbWeatherDataSets.ItemIndex],
      DataModule.DataModuleBoard.ADOQueryWeatherDisplay);
end;

procedure TformAddEditData.leInitialASWChange(Sender: TObject);
begin
  if (strtofloat(leInitialASW.Text) > 999) then begin
    Messagedlg('Initial soil water must be less than 1000 mm/m',mtError,[mbOK],0);
    leInitialASW.Text := '0';
  end;
end;

procedure TformAddEditData.leInitialSpacingChange(Sender: TObject);
var
  i : integer;
begin
  for i := 0 to length(CurrentRegimeDataArray)-1 do begin
    if CurrentRegimeDataArray[i].EventType = Event.EVENTPLANT then
      CurrentRegimeDataArray[i].EventValue := strtofloat(leInitialSpacing.Text);
  end;
end;

procedure TformAddEditData.leMaxASWChange(Sender: TObject);
begin
  if (strtofloat(leMaxASW.Text) > 999) then begin
    Messagedlg('Maximum soil water must be less than 1000 mm/m',mtError,[mbOK],0);
    leMaxASW.Text := '0';
  end;


end;

procedure TformAddEditData.leMinASWChange(Sender: TObject);
begin
  if (strtofloat(leMinASW.Text) > 999) then begin
    Messagedlg('Minimum soil water must be less than 1000 mm/m',mtError,[mbOK],0);
    leMinASW.Text := '0';
  end;
end;

procedure TformAddEditData.pcDataAddEditChange(Sender: TObject);
begin
  UpdateLists;
end;

Procedure SILODataConductor;
begin
  formaddeditdata.OpenDialogSILO.Execute;

end;

Procedure GetSILOData(SILOFileName: String);
begin
  if SILOFileName <> '' then begin
    if Messagedlg('For large SILO datasets, the import may take up to five minutes. Continue?',mtConfirmation,
      [mbYes,mbNo],0) = mrYes then begin

      CurrentTargetTable := ProjectManager.WEATHERDATATABLE;
      CurrentRelevantField := ProjectManager.WEATHERDATASETNAMEFIELD;

      OKCANCL2.OKRightDlg.ShowModal;

      if OKCANCL2.OKRightDlg.ModalResult = mrOK then begin
        if OKCANCL2.OKRightDlg.leNewDatasetName.Text <> '' then begin
          if (General.IsNewValueUnique(Datamodule.DataModuleBoard.ADOQueryCAMBIUM,
            OKCANCL2.OKRightDlg.leNewDatasetName.Text,
            ProjectManager.WEATHERDATASETNAMESTABLE,
            ProjectManager.WEATHERDATASETNAMEFIELD) = false) and
            (Messagedlg('A dataset of the same name already exists. Replace?',mtConfirmation,[mbYes,mbNo],0) = mrYes) or
            (General.IsNewValueUnique(Datamodule.DataModuleBoard.ADOQueryCAMBIUM,
            OKCANCL2.OKRightDlg.leNewDatasetName.Text,
            ProjectManager.WEATHERDATASETNAMESTABLE,
            ProjectManager.WEATHERDATASETNAMEFIELD) = true) then begin

            try
              Screen.Cursor := crHourglass;
              WriteSILOWeatherData(OKCANCL2.OKRightDlg.leNewDatasetName.Text,
              SILOFileName);
            finally
              Screen.Cursor := crDefault;
            end;
          end;
        end else
          Messagedlg('Specify a name for the dataset',mtError,[mbOK],0);

        General.GetDistinctValuesinField(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
          ProjectManager.WEATHERDATATABLE,
          ProjectManager.WEATHERDATASETNAMEFIELD,
          formAddEditData.lbWeatherDatasets.Items);
      end;
    end;
  end;
end;

procedure TformAddEditData.rgParamsTypesClick(Sender: TObject);
var
  MyItemIndexMemo : Smallint;
  MyIndexName : String;
begin
  if lbParamSets.ItemIndex > -1 then begin
    MyItemIndexMemo := lbParamSets.ItemIndex;
    MyIndexName := lbParamSets.Items[MyItemIndexMemo];

    if rgParamsTypes.ItemIndex = 1 then begin

        General.GetDistinctValuesinField(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
        ProjectManager.TPGPARAMSTABLE,
        ProjectManager.SPECIESNAMEFIELD,
        lbParamSets.Items);

        UpdateParamDataGrid(rgParamsTypes.ItemIndex,MyIndexName);


    end else begin

        General.GetDistinctValuesinField(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
        ProjectManager.CAMBIUMPARAMSTABLE,
        ProjectManager.SPECIESNAMEFIELD,
        lbParamSets.Items);

        UpdateParamDataGrid(rgParamsTypes.ItemIndex,MyIndexName);

    end;

    lbParamSets.ItemIndex := MyItemIndexMemo;

  end;
end;

procedure TformAddEditData.sgRegimeEventsDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);


begin
  with sgRegimeEvents.Canvas do begin

    if (gdSelected in State) and (aRow > 0) then begin
      Brush.Color := clBlue;
      //Font.Style := [fsBold];
    end else begin
      if aRow=0 then
        Brush.Color:=clGray;

      if sgRegimeEvents.Rows[ARow].Strings[0] = Event.EVENTTHIN then
        Brush.color := clMoneyGreen;
      if sgRegimeEvents.Rows[ARow].Strings[0] = Event.EVENTPRUN then
        Brush.color := clAqua;
      if sgRegimeEvents.Rows[ARow].Strings[0] = Event.EVENTFERT then
        Brush.color := clSkyBlue;
    end;

    fillrect (rect);
    TextRect (Rect, Rect.Left+2, Rect.Top+1, sgRegimeEvents.Cells[aCol, aRow]);

  end;
end;



procedure TformAddEditData.tsParamsShow(Sender: TObject);
begin
  if lbParamSets.Count > 0 then begin
    lbParamSets.ItemIndex := 0;
    UpdateParamDataGrid(rgParamsTypes.ItemIndex,
      lbParamSets.Items[lbParamSets.ItemIndex]);
  end;
end;

Procedure TformAddEditData.UpDateRegimeSGHeaders;
begin
  sgRegimeEvents.Rows[0].Strings[0] := 'Event type';
  sgRegimeEvents.Rows[0].Strings[1] := 'Event age (y)';
  sgRegimeEvents.Rows[0].Strings[2] := 'Event date';
  sgRegimeEvents.Rows[0].Strings[3] := 'Event description';
end;

procedure TformAddEditData.tsRegimeShow(Sender: TObject);
var
  i : integer;
begin
  for i := 0 to sgRegimeEvents.RowCount - 1 do begin
    sgRegimeEvents.Rows[i].Clear;
  end;
  sgRegimeEvents.RowCount := 1;

  UpDateRegimeSGHeaders;

  if lbRegimeNames.Count > 0 then begin
    lbRegimeNames.ItemIndex := 0;
    FillRegimeSG(lbRegimeNames.Items[lbRegimeNames.ItemIndex]);
  end;


end;

procedure TformAddEditData.tsSiteShow(Sender: TObject);
begin
  cmbSiteLat.ItemIndex := -1;
  cmbSoilTexture.ItemIndex := -1;
  cmbSiteFR.ItemIndex := -1;
  cmbSoilDepth.ItemIndex := -1;
  leMinASW.Text := '0';
  leMaxASW.Text := '0';
  leInitialASW.Text := '0';

  lbSiteNames.ItemIndex := -1;

  if lbSiteNames.Count > 0 then begin
    lbSiteNames.ItemIndex := 0;
    formAddEditData.UpdateFormForSelectedSite(lbSiteNames.ItemIndex);
  end;

end;

procedure TformAddEditData.tsWeatherShow(Sender: TObject);
begin
  dbChartRainTemp.Series[0].Clear;
  dbChartRainTemp.Series[1].Clear;
  dbChartRainTemp.Series[2].Clear;

  dbChartSREvap.Series[0].Clear;
  dbChartSREvap.Series[1].Clear;

  if lbWeatherDatasets.Count > 0 then
    lbWeatherDatasets.ItemIndex := -1
end;

Procedure TformAddeditdata.UpdateWeatherGraphs(WeatherDSName: String;
  ADOQuery: TADOQuery);
begin
  ADOQuery.SQL.Clear;
  ADOQuery.SQL.add('SELECT ' +
    '*' + ' FROM ' +
    ProjectManager.WEATHERDATATABLE + ' WHERE ' +
    ProjectManager.WEATHERDATASETNAMEFIELD + '="' +
    WeatherDSName + '";');
  ADOQuery.Active := true;

  DBChartRainTemp.Series[0].DataSource := ADOQuery;
  DBChartRainTemp.Series[0].XValues.valueSource :=
    ProjectManager.WEATHERDATEFIELD;
  DBChartRainTemp.Series[0].YValues.ValueSource :=
    ProjectManager.RAINFIELD;

  DBChartRainTemp.Series[1].DataSource := ADOQuery;
  DBChartRainTemp.Series[1].XValues.valueSource :=
    ProjectManager.WEATHERDATEFIELD;
  DBChartRainTemp.Series[1].YValues.ValueSource :=
    ProjectManager.MINTEMPFIELD;

  DBChartRainTemp.Series[2].DataSource := ADOQuery;
  DBChartRainTemp.Series[2].XValues.valueSource :=
    ProjectManager.WEATHERDATEFIELD;
  DBChartRainTemp.Series[2].YValues.ValueSource :=
    ProjectManager.MAXTEMPFIELD;

  DBChartSREvap.Series[0].DataSource := ADOQuery;
  DBChartSREvap.Series[0].XValues.valueSource :=
    ProjectManager.WEATHERDATEFIELD;
  DBChartSREvap.Series[0].YValues.ValueSource :=
    ProjectManager.QAFIELD;

  DBChartSREvap.Series[1].DataSource := ADOQuery;
  DBChartSREvap.Series[1].XValues.valueSource :=
    ProjectManager.WEATHERDATEFIELD;
  DBChartSREvap.Series[1].YValues.ValueSource :=
    ProjectManager.EVAPFIELD;
end;

procedure TFormAddEditData.AddDatatoDBGrid(CurrentGrid: TDBGrid;
  CurrentDS : TDataSource;
  CurrentTable: TADOTable;
  CurrentCommand : TADOCommand;
  FromTable : string;
  FilterCriteria : string;
  SortCriteria : String);
var
  SQLString : string;

begin
  if General.TableExists(ProjectManager.TEMPDATAEDITTINGTABLE,datamodule.DataModuleBoard.ADOConnectionCAMBIUM) then begin
    SQLString := 'DROP TABLE ' +  ProjectManager.TEMPDATAEDITTINGTABLE;

    CurrentCommand.CommandText := SQLString;
    CurrentCommand.Execute;
  end;


  SQLString := 'SELECT * INTO [' + ProjectManager.TEMPDATAEDITTINGTABLE +
  '] FROM [' +
  FromTable +
  '] WHERE ' +
  FilterCriteria +
  ' ORDER BY ' +
  SortCriteria;

  CurrentCommand.CommandText := SQLString;
  CurrentCommand.Execute;

  CurrentDS.DataSet := CurrentTable;
  CurrentGrid.DataSource := CurrentDS;

  CurrentTable.active := false;
  CurrentTable.TableName := ProjectManager.TEMPDATAEDITTINGTABLE;
  CurrentTable.Active := true;
end;

end.
