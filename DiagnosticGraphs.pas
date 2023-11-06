unit DiagnosticGraphs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, TeeProcs, TeEngine, Chart, Series, ComCtrls,DataObjects,
  ReadData,General, StdCtrls;

type
  TformDiagnosticGraphs = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet4: TTabSheet;
    ChartZoneCounts: TChart;
    TabSheet5: TTabSheet;
    ChartTemperature: TChart;
    Series17: TLineSeries;
    Series19: TLineSeries;
    Series13: TAreaSeries;
    Series14: TAreaSeries;
    Series15: TAreaSeries;
    TabSheet10: TTabSheet;
    ChartHeight: TChart;
    Series44: TLineSeries;
    Series45: TLineSeries;
    Series49: TPointSeries;
    ChartDBH: TChart;
    Series6: TLineSeries;
    Series7: TLineSeries;
    Series48: TPointSeries;
    ChartCarbohydrate: TChart;
    Series4: TLineSeries;
    ChartDurations: TChart;
    Series2: TLineSeries;
    Series3: TLineSeries;
    Series5: TLineSeries;
    Panel1: TPanel;
    gbMensData: TGroupBox;
    lbMensDatasets: TListBox;
    TabSheet2: TTabSheet;
    ChartLAI: TChart;
    Series1: TLineSeries;
    ChartSPH: TChart;
    Series8: TLineSeries;
    ChartBiomass: TChart;
    Series9: TLineSeries;
    Series10: TLineSeries;
    Series11: TLineSeries;
    Series12: TLineSeries;
    Series16: TLineSeries;
    ChartWaterPotential: TChart;
    Series18: TLineSeries;
    Series20: TLineSeries;
    ChartStandVol: TChart;
    Series21: TLineSeries;
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lbMensDatasetsClick(Sender: TObject);
    procedure lbMensDatasetsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  Procedure MainLoop(ScenarioName : String);
  Procedure AllSeriesClear;
  Procedure DrawMensDataGraphs(MensurationData: TMensDataArray);

var
  formDiagnosticGraphs: TformDiagnosticGraphs;

implementation

uses ProjectManager, DataModule, CAMBIUMManager, ScenarioType, ScenarioManager;

{$R *.dfm}

Procedure AllSeriesClear;
begin
  ClearChart(formDiagnosticGraphs.chartCarbohydrate);
  ClearChart(formDiagnosticGraphs.ChartDBH);
  ClearChart(formDiagnosticGraphs.ChartDurations);
  ClearChart(formDiagnosticGraphs.ChartZoneCounts);
  ClearChart(formDiagnosticGraphs.ChartTemperature);
  ClearChart(formDiagnosticGraphs.ChartWaterPotential);
  ClearChart(formDiagnosticGraphs.ChartSPH);
  ClearChart(formDiagnosticGraphs.ChartBiomass);
  ClearChart(formDiagnosticGraphs.ChartStandVol);
  ClearChart(formDiagnosticGraphs.ChartHeight);
  ClearChart(formDiagnosticGraphs.ChartLAI);
end;

procedure MainLoop(ScenarioName: String);
Var
  CurrentDailyData : TCAMBIUMDailyOutputDataArray;
  CABALARunData : TCambiumInputDataArray;
  MensurationData : TMensDataArray;
  DayCounter: Integer;
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
  StemPos: Single;
  VariablesSet : Boolean;
begin
  FormDiagnosticGraphs.Caption := 'Summary of growth and stand development data from ' +
    ScenarioName;

  ScenarioManager.SetScenarioVariables(ScenarioName,
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
    StemPos,
    VariablesSet,
    datamodule.DataModuleBoard.ADOQueryCAMBIUM,
    datamodule.DataModuleBoard.ADOQueryCABALA);

  if VariablesSet then begin

    try
      AllSeriesClear;

      if ScenarioType = ScenarioManager.CABALA_SCENARIO_TYPE then begin
        FormMain.labelStatus.Caption := 'Reading CaBala data';
        screen.Cursor := crHourGlass;
        formMain.Refresh;

        CABALARunData := ReadData.ReadCABALAData(ScenarioName,
        CABALAScenarioName,
        datamodule.DataModuleBoard.ADOQueryCAMBIUM,
        datamodule.DataModuleBoard.ADOQueryCABALA);
      end;

      FormMain.labelStatus.Caption := 'Reading actual measurements data';
      formMain.Refresh;

      MensurationData := ReadMensurationData(ScenarioName,
        ProjectManager.REALMENSURATIONDATATABLE,
        ProjectManager.MENSDATASETNAMEFIELD,
        dataModule.DataModuleBoard.ADOQueryCAMBIUM);


      formMain.LabelStatus.Caption := 'Reading CAMBIUM output data';
      formMain.Refresh;

      CurrentDailyData := ReadData.ReadDailyData(ScenarioName,
        ProjectManager.DAILYOUTPUTDATATABLE,
        ProjectManager.SCENARIONAMEFIELD,
        DataModule.DataModuleBoard.ADOQueryCAMBIUM);

      formMain.LabelStatus.Caption := 'Drawing graphs';
      formMain.Refresh;

      for DayCOunter := 0 to Length(CurrentDailyData)-1 do begin
        with formDiagnosticGraphs do begin

          ChartCarbohydrate.Series[0].AddXY(CurrentDailyData[DayCounter].LogDate,
            CurrentDailyData[DayCounter].StandNPP);
          ChartCarbohydrate.Series[1].AddXY(CurrentDailyData[DayCounter].LogDate,
            CurrentDailyData[DayCounter].TreeNPP);
          ChartCarbohydrate.Series[2].AddXY(CurrentDailyData[DayCounter].LogDate,
            CurrentDailyData[DayCounter].StemAllocCarb);

          ChartBiomass.Series[0].AddXY(CurrentDailyData[DayCounter].LogDate,
            CurrentDailyData[DayCounter].WFStand);
          ChartBiomass.Series[1].AddXY(CurrentDailyData[DayCounter].LogDate,
            CurrentDailyData[DayCounter].WSStand);
          ChartBiomass.Series[2].AddXY(CurrentDailyData[DayCounter].LogDate,
            CurrentDailyData[DayCounter].WRStand);

          ChartSPH.Series[0].AddXY(CurrentDailyData[DayCounter].LogDate,
            CurrentDailyData[DayCounter].SPH);

          ChartDBH.Series[0].AddXY(CurrentDailyData[DayCounter].LogDate,
            CurrentDailyData[DayCounter].DiamAtModellingPos);
          ChartHeight.Series[0].AddXY(CurrentDailyData[DayCounter].LogDate,
            CurrentDailyData[DayCounter].TreeHeight);
          ChartStandVol.Series[0].AddXY(CurrentDailyData[DayCounter].LogDate,
            CurrentDailyData[DayCounter].StemVol);


          ChartZoneCounts.Series[0].AddXY(CurrentDailyData[DayCounter].LogDate,
            CurrentDailyData[DayCounter].CZCount);
          ChartZoneCounts.Series[1].AddXY(CurrentDailyData[DayCounter].LogDate,
            CurrentDailyData[DayCounter].EZCount);
          ChartZoneCounts.Series[2].AddXY(CurrentDailyData[DayCounter].LogDate,
            CurrentDailyData[DayCounter].TZCount);

          ChartDurations.Series[0].AddXY(CurrentDailyData[DayCounter].LogDate,
            CurrentDailyData[DayCounter].CellCycleDur);
          ChartDurations.Series[1].AddXY(CurrentDailyData[DayCounter].LogDate,
            CurrentDailyData[DayCounter].GrowingDays);
          ChartDurations.Series[2].AddXY(CurrentDailyData[DayCounter].LogDate,
            CurrentDailyData[DayCounter].ThickeningDays);

          ChartTemperature.Series[0].AddXY(CurrentDailyData[DayCounter].LogDate,
            CurrentDailyData[DayCounter].MinTemp);
          ChartTemperature.Series[1].AddXY(CurrentDailyData[DayCounter].LogDate,
            CurrentDailyData[DayCounter].MaxTemp);

          ChartWaterPotential.Series[0].AddXY(CurrentDailyData[DayCounter].LogDate,
            CurrentDailyData[DayCounter].MaxLWP);
          ChartWaterPotential.Series[1].AddXY(CurrentDailyData[DayCounter].LogDate,
            round(CurrentDailyData[DayCounter].ASWRootZone));
          //ChartWaterPotential.Series[2].AddXY(CurrentDailyData[DayCounter].LogDate,
            //CurrentDailyData[DayCounter].ASWRootZone);

          ChartLAI.Series[0].AddXY(CurrentDailyData[DayCounter].LogDate,
            CurrentDailyData[DayCounter].DailyLAI);
          //ChartLAI.Series[1].AddXY(CurrentDailyData[DayCounter].LogDate,
            //CurrentDailyData[DayCounter].LeafModAux);
          //ChartLAI.Series[2].AddXY(CurrentDailyData[DayCounter].LogDate,
            //CurrentDailyData[DayCounter].AuxConChRate);


        end;
      end;

      for DayCOunter := 0 to Length(CABALARunData)-1 do begin
        with formDiagnosticGraphs do begin
          ChartDBH.Series[1].AddXY(CABALARunData[DayCounter].LogDate,
            CABALARunData[DayCounter].IndepDBH_cm);
          ChartHeight.Series[1].AddXY(CABALARunData[DayCounter].LogDate,
            CABALARunData[DayCounter].TreeHt_m);
        end;
      end;
      formDiagnosticGraphs.Show;

    finally
      formMain.LabelStatus.Caption := '';
      screen.Cursor := crDefault;
    end;
  end else
    messagedlg('Some variables could not be set',mtError,[mbOK],0);
end;

procedure TformDiagnosticGraphs.FormResize(Sender: TObject);
begin
  ChartCarbohydrate.Height := round(PageControl1.Height/2);
  ChartDurations.Height := round(PageControl1.Height/2);
  ChartTemperature.Height := round(PageControl1.Height/2);
  ChartDBH.Height := round(PageControl1.Height/3);
  ChartStandVol.Height := round(PageControl1.Height/3);
  ChartSPH.Height := round(PageControl1.Height/2);
  //ChartRates.Height := round(PageControl1.Height/2);
end;


procedure TformDiagnosticGraphs.FormShow(Sender: TObject);
begin
  try
    {General.GetDistinctValuesinField(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
      ProjectManager.DENDROMETERDATATABLE,ProjectManager.DENDRODATASETNAMEFIELD,
      lbDendroDataSets.Items);}
    General.GetDistinctValuesinField(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
      ProjectManager.REALMENSURATIONDATATABLE,ProjectManager.MENSDATASETNAMEFIELD,
      lbMensDataSets.Items)
  except

  end;

end;

procedure TformDiagnosticGraphs.lbMensDatasetsClick(Sender: TObject);
var
  MyMensData: TMensDataArray;
begin
  if lbMensDataSets.ItemIndex > -1 then begin

    MyMensData := ReadData.ReadMensurationData(lbMensDataSets.Items[lbMensDataSets.ItemIndex],
      ProjectManager.REALMENSURATIONDATATABLE,
      ProjectManager.MENSDATASETNAMEFIELD,
      DataModule.DataModuleBoard.ADOQueryCAMBIUM);

    DrawMensDataGraphs(MyMensData);

  end;

end;

procedure TformDiagnosticGraphs.lbMensDatasetsKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
if lbMensDataSets.ItemIndex > -1 then begin
    if Key = VK_DELETE then begin
      if Messagedlg('Are you sure you want to delete this pith-to-bark wood property dataset?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
        ClearFilteredRecords(REALMENSURATIONDATATABLE,
          MENSDATASETNAMEFIELD,
          lbMensDataSets.Items[lbMensDataSets.ItemIndex],
          DataModule.DataModuleBoard.ADOCommandCAMBIUM);

        General.GetDistinctValuesinField(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
          REALMENSURATIONDATATABLE,
          MENSDATASETNAMEFIELD,
          lbMensDataSets.Items);
      end;
    end;
  end;
end;

Procedure DrawMensDataGraphs(MensurationData: TMensDataArray);
var
  I : integer;
begin
  with formDiagnosticGraphs do begin
    CHartDBH.Series[2].Clear;
    ChartHeight.Series[2].Clear;
  end;
  for i := 0 to Length(MensurationData)-1 do begin
    with formDiagnosticGraphs do begin
      ChartDBH.Series[2].AddXY(MensurationData[i].LogDate,
        MensurationData[i].DBH);
      ChartHeight.Series[2].AddXY(MensurationData[i].LogDate,
        MensurationData[i].Height);

    end;
  end;
end;


end.
