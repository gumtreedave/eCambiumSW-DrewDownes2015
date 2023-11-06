unit RunManager;

interface
  uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids,DataModule,ProjectManager,
  Menus, DB, DBCtrls,General,ADODB,DataObjects,ProjectWarnings,DevelopingCellsImage,
  CAMBIUMObjects,ModellingHeight,DiagnosticGraphs,contnrs,SetSegmentWidth,Math,
  ScenarioManager,WriteData,RunInitialisation,NumberofCellFiles,ReadData,TreePhysModel,
  TypInfo,Chart,DetailedGraphs;

  Procedure MainLoop(ScenarioNamesList: TStringList);
  Function SetCAMBIUMParameters(CAMBIUMParametersArray: array of TParametersList;
    var CAMBIUMParametersError : Boolean) :
  TCAMBIUMParameters;
  Function Set3PGParameters(ParametersArray: array of TParametersList;
    var TPGParametersError: Boolean) :T3PGParameters;

  Function GetCABALADataforRun(ScenarioName: String;
    CABALAScenarioName: String;
    SiteLat: Single;
    var DataDaily: Boolean;
    CAMQuery,CABQUERY : TADOQuery): TCambiumInputDataArray;


  Function CalculateSegmentData(Params:TCAMBIUMParameters;
    AllCellsList: TObjectList;
    SegmentWidth: Integer;
    StripWidth : Double) : TCAMBIUMSegmentDataArray;

  Procedure CAMBIUMCall(CurrentRunData: TCAMBIUMInputDataArray;
    InputSiteInfo: DataObjects.TSiteData;
    InputRegimeInfo : DataObjects.TRegimeDataArray;
    TPGParameters : T3PGParameters;
    InputWeatherData : DataObjects.TWeatherdataArray;
    CurrentCAMBIUMParameters: TCAMBIUMParameters;
    var SegmentData : TCAMBIUMSegmentDataArray;
    var DailyOutputData : TCAMBIUMDailyOutputDataArray;
    ModellingPosition: single;
    ScenarioType : String;
    SegmentWidth : Integer;
    StripWidth: Double);


  {Procedure UpdateMensurationGraphs(InputData: TMensDataArray;
    DBHChart: TChart;
    DBHSeriesNumber: Integer;
    HtChart: TChart;
    HtSeriesNumber: Integer);  }

var
  ModelStop : Boolean;
  ModelRunning : Boolean;
  GlobalAllCellsImage : TImage;

const
  RUNSOK = 'RunOK';
  RUNSBAD = 'RunBad';
  BASEHT = 0.1;
  CELLFILES = 1;



implementation

uses CAMBIUMManager,LinkCABALAScenario,CAMBIUMModel,AddEditCAMBIUMParams;


Function GetCABALADataforRun(ScenarioName: String;
  CABALAScenarioName: String;
  SiteLat: Single;
  var DataDaily: Boolean;
  CAMQuery,CABQUERY : TADOQuery): TCambiumInputDataArray;
var
  TempCIDA :  TCambiumInputDataArray;
  i : integer;

begin
  DataDaily := true;
  //FormMain.labelStatus.Caption := 'Reading CABALA data';
  //formmain.Refresh;

  TempCIDA := ReadCABALAData(ScenarioName,
    CABALAScenarioName,
    CAMQuery,
    CABQuery);

  for i := 0 to Length(TempCIDA)-1 do begin
    TempCIDA[i].DayLength := GetDayLength(SiteLat,TempCIDA[i].LogDate);
    if i > 0 then begin
      if TempCIDA[i].LogDate > TempCIDA[i-1].LogDate + 1 then
        DataDaily := false;
    end;
  end;

  Result := TempCIDA;
end;






{function SetModellingHeights(ht1: double; ht2:double; ht3: double): ModellingHeightsArray;
var
  i : integer;
begin
  for i := 0 to 2 do begin
    case i of
      0:result[i] := ht1;
      1:result[i] := ht2;
      2:result[i] := ht3;
    end;
  end;
end;    }





Procedure MainLoop(ScenarioNamesList: TStringList);
var
  CAMBIUMInputData : TCambiumInputDataArray;
  CAMBIUMParameters : TCambiumParameters;
  CAMBIUMSegmentData : TCambiumSegmentdataArray;
  CAMBIUMDailyOutputData: TCambiumDailyOutputDataArray;

  ScenarioCounter : integer;
  ModellingPosition : single;
  ScenarioName : string;

  //ScenarioNamesList : TStringList;
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

  InputSiteInfo: DataObjects.TSiteData;
  InputRegimeInfo : DataObjects.TRegimeDataArray;
  TPGParameters : T3PGParameters;
  InputWeatherData : DataObjects.TWeatherdataArray;
  TPGParametersError : Boolean;

  DailyData,CAMBIUMParametersError,VariablesSet : Boolean;


begin
  formMain.pbMain.Min := 0;
  formMain.pbMain.Max := ScenarioNamesList.Count *5;
  FormMain.pbMain.Position := 0;
  formMain.pbMain.StepBy(1);

  //formMain.pbMain.stepit;
  UpDatePB(formMain.pbMain);

  //FormMain.labelStatus.Caption := 'Running the model...';
  FormMain.labelStatus.Caption := 'Preparing model run...';
  formmain.Refresh;
  //formmain.pbmain.Refresh;
  application.processmessages;

  try
    //if Length(CurrentScenarioList) > 0 then begin
    ScenarioCounter := -1;

      While (ScenarioCounter < ScenarioNamesList.Count - 1) and
        (ModelStop <> True) do begin

        TPGParametersError := False;

        ScenarioCounter := ScenarioCounter + 1;

        ScenarioName := ScenarioNamesList.Strings[ScenarioCounter];
        formWarnings.memoWarnings.lines.add('Messages for scenario "' + ScenarioName + '":');

        DeleteFromTable(DataModule.DataModuleBoard.ADOCommandCAMBIUM,
          CAMBIUMSEGMENTSDATATABLE,
          SCENARIONAMEFIELD + '="' + ScenarioName + '"');

        DeleteFromTable(DataModule.DataModuleBoard.ADOCommandCAMBIUM,
          ProjectManager.DAILYOUTPUTDATATABLE,
          SCENARIONAMEFIELD + '="' + ScenarioName + '"');

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
            ModellingPosition,
            VariablesSet,
            datamodule.DataModuleBoard.ADOQueryCAMBIUM,
            datamodule.DataModuleBoard.ADOQueryCABALA);

          if VariablesSet then begin

            DailyData := true;

            if ScenarioType = ScenarioManager.CABALA_SCENARIO_TYPE then begin
              UpDatePB(formMain.pbMain);
              FormMain.labelStatus.Caption := 'Reading CaBala data for ' + ScenarioName;
              screen.Cursor := crHourGlass;
              formMain.Refresh;
              formmain.pbmain.Refresh;

              try
                CAMBIUMInputData := GetCABALADataForRun(ScenarioName,
                  CABALAScenarioName,SiteLat,DailyData,
                  datamodule.DataModuleBoard.ADOQueryCAMBIUM,
                  datamodule.DataModuleBoard.ADOQueryCABALA);
              except
                On E: Exception do
                  FormWarnings.memoWarnings.Lines.Add('Could not open the CaBala database: ' +
                    E.message);

              end;

            end else if ScenarioType  = ScenarioManager.CAMBIUM_SCENARIO_TYPE then begin
              UpDatePB(formMain.pbMain);
              FormMain.labelStatus.Caption := 'Reading data for stand model run for ' + ScenarioName;
              screen.Cursor := crHourGlass;
              formMain.Refresh;
              application.processmessages;


              ReadData.FillSiteDataRecord(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
                SiteName,
                InputSiteInfo);

              ReadData.FillRegimeDataArray(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
                RegimeName,
                InputRegimeInfo);

              //This assumes that the regime info is sorted on ascending date!
              ReadData.FillWeatherDataArray(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
                WeatherDSName,
                InputRegimeInfo[0].EventDate,
                InputRegimeInfo[Length(InputRegimeInfo)-1].EventDate,
                InputWeatherData);

              TPGParameters :=
                Set3PGParameters(ReadParameters(Datamodule.DataModuleBoard.ADOQueryCAMBIUM,
                  ParamSetName,
                  ProjectManager.TPGPARAMSTABLE),TPGParametersError);

              SetLength(CAMBIUMInputData,0);
              SetLength(CAMBIUMInputData,Length(InputWeatherData));

              {for DayStep := 0 to Length(InputWeatherData)-1 do begin
                CAMBIUMInputData[DayStep].LogDate := InputWeatherData[DayStep].LogDate;
                CAMBIUMInputData[DayStep].MinTemp := InputWeatherData[DayStep].MinTemp;
                CAMBIUMInputData[DayStep].MaxTemp := InputWeatherData[DayStep].MaxTemp;
                CAMBIUMInputData[DayStep].Rain := InputWeatherData[DayStep].Rainfall;
              end;   }
            end;

            screen.Cursor := crDefault;

            CAMBIUMParameters :=
              SetCAMBIUMParameters(ReadParameters(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
                ParamSetName,
                ProjectManager.CAMBIUMPARAMSTABLE),CAMBIUMParametersError);

            if (ModelStop <> True) then begin
              if (CAMBIUMParametersError = false) and (TPGParametersError = False) then begin
                if Length(CambiumInputData) > 0 then begin
                  if DailyData = true then begin

                    //**********************************************************************
                    //Clear the output data tables

                    try
                      //if WriteData = True then begin
                        DeleteFromTable(DataModule.DataModuleBoard.ADOCommandCAMBIUM,
                          CAMBIUMSEGMENTSDATATABLE,
                          SCENARIONAMEFIELD + '="' + ScenarioName + '"');

                        DeleteFromTable(DataModule.DataModuleBoard.ADOCommandCAMBIUM,
                          ProjectManager.DAILYOUTPUTDATATABLE,
                          SCENARIONAMEFIELD + '="' + ScenarioName + '"');
                      //end;
                      //**********************************************************************

                      UpDatePB(formMain.pbMain);
                      FormMain.labelStatus.Caption := 'Running the model for ' + ScenarioName;
                      formMain.Refresh;
                      formmain.pbmain.Refresh;
                      application.processmessages;

                      CambiumCall(CambiumInputData,
                        InputSiteInfo,
                        InputRegimeInfo,
                        TPGParameters,
                        InputWeatherData,
                        CambiumParameters,
                        CambiumSegmentData,CambiumDailyOutputData,
                        ModellingPosition,
                        ScenarioType,
                        round(strtofloat(formSegmentWidth.cmbSegmentLength.Items[formSegmentWidth.cmbSegmentLength.Itemindex])*1000),
                        CELLFILES * strtoint(formInitialisation.leTanDiam.Text));

                      //formMain.LabelStatus.Caption := 'Calculating segment means...';
                      //formMain.Refresh;

                      screen.Cursor := crHourGlass;
                      UpDatePB(formMain.pbMain);
                      formMain.LabelStatus.Caption := 'Writing CAMBIUM outputs for ' + ScenarioName;
                      formMain.Refresh;
                      formmain.pbmain.Refresh;
                      application.ProcessMessages;

                      WriteSegmentData(DataModule.DataModuleBoard.ADOTableOutputDataSegments,
                        CAMBIUMSEGMENTSDATATABLE,
                        CambiumSegmentData,
                        ScenarioName,
                        1,
                        ModellingPosition);

                      if formMain.Writedailydatatodisk1.checked then begin

                        WriteDailyData(DataModule.DataModuleBoard.ADOTableOutputDataDaily,
                          DAILYOUTPUTDATATABLE,
                          CAMBIUMDailyOutputData,
                          ScenarioName,
                          ModellingPosition);
                      end;

                      screen.Cursor := crDefault;
                      UpDatePB(formMain.pbMain);
                      formMain.Refresh;
                      application.ProcessMessages;

                      SetLength(CAMBIUMSegmentData,0);
                      SetLength(CAMBIUMDailyOutputData,0);


                      formWarnings.memoWarnings.Lines.Add('The model run was completed without any ' +
                        'reported errors.');

                    except
                      on E: Exception do begin
                        formWarnings.memoWarnings.lines.add('Scenario "' + ScenarioName + '" was not successfully completed: ' +
                          E.message);
                      end;
                    end;
                  end else
                    formWarnings.memoWarnings.lines.add('Scenario "' + ScenarioName + '" was not successfully completed. The input data was not on a daily timestep');
                end else
                  formWarnings.memoWarnings.lines.add('Scenario "' + ScenarioName + '" was not successfully completed. The linked CaBala dataset was empty. ' +
                    'Check that the scenario still exists in the CaBala file');
              end else
                formWarnings.memoWarnings.lines.add('Scenario "' + ScenarioName + '" was not successfully completed. ' +
                  'Some parameters could not be initialised.');
            end;
          end else
            formWarnings.memoWarnings.lines.add('Scenario "' + ScenarioName + '" was not successfully completed. ' +
              'Some scenario variables could not be set.');

        except
          On E: Exception do begin
            formWarnings.memoWarnings.Lines.Add('There was a problem with model run ' +
              '"' + ScenarioName + '": ' +
              E.Message);
          end;
        end;
      end;
  finally
    ModelRunning := false;
    formMain.pbMain.position := 0;
    formMain.labelstatus.caption := '';
    formMain.dbGridScenarios.SelectedRows.Clear;
    screen.Cursor := crDefault;
    formMain.Refresh;
  end;
end;

Procedure CAMBIUMCall(CurrentRunData: TCAMBIUMInputDataArray;
  InputSiteInfo: DataObjects.TSiteData;
  InputRegimeInfo : DataObjects.TRegimeDataArray;
  TPGParameters : T3PGParameters;
  InputWeatherData : DataObjects.TWeatherdataArray;
  CurrentCAMBIUMParameters: TCAMBIUMParameters;
  var SegmentData : TCAMBIUMSegmentDataArray;
  var DailyOutputData : TCAMBIUMDailyOutputDataArray;
  ModellingPosition: single;
  ScenarioType : String;
  SegmentWidth : Integer;
  StripWidth: Double);
var
  MyTree: TTree;
  BasalStemPos,ModStemPos: TStemPosition;

  ModLivingCellsList,ModDeadCellsList: TObjectList;
  BasalLivingCellsList,BasalDeadCellsList: TObjectList;

  OverRideStep : Boolean;

  MyPooledSW,MyStemNo,MyWF,MyWS,MyWR,MyTreeHt,MyRootDepth,MyFertRating: Double;
  MyEstablishmentDate : TDate;
  MyASWLayers : array of double;

  DayStep,i : Integer;
  myyear,mymonth,myday: word;
    AllCellsImage : TImage;

begin
  OverrideStep := false;
  //modelstop := false;

  MyTree := TTree.Create;
  MyTree.TreeNumber := 1;
  MyTree.GrowthDay := -1;

  if formMain.Detailedgraphs1.Checked then begin

    formdetailedgraphs.Show;

    General.ClearChart(formdetailedgraphs.ChartPPTree);
    General.ClearChart(formdetailedgraphs.ChartAllocSL);
    General.ClearChart(formdetailedgraphs.ChartCarbAuxinToday);
    General.ClearChart(formdetailedgraphs.ChartHtD);
    General.ClearChart(formdetailedgraphs.CHartVolSA);
    General.ClearChart(formdetailedgraphs.ChartDistAlpha);
    General.ClearChart(formdetailedgraphs.ChartTotAuxCarbsPerFile);
    General.ClearChart(formdetailedgraphs.ChartTRDWTDead);
    General.ClearChart(formDetailedGraphs.Chart_TRD_WT_TimeAxis);
    General.ClearChart(formdetailedgraphs.ChartTemperature);
    General.ClearChart(formdetailedgraphs.ChartXPP);
    General.ClearChart(formdetailedgraphs.ChartCellCounts);
    General.ClearChart(formdetailedgraphs.ChartDurations);
    General.ClearChart(formdetailedgraphs.ChartAuxConcCZExit);
    General.ClearChart(formdetailedgraphs.ChartLengthVolDead);
    General.ClearChart(formdetailedgraphs.ChartExcessCarbs);
    General.ClearChart(formdetailedgraphs.ChartTurgYTExt);
    General.ClearChart(formdetailedgraphs.ChartWE);
    General.ClearChart(formdetailedgraphs.chartcarbconcincell);
    General.ClearChart(formdetailedgraphs.Chart_WTRD_CellNum);
    General.ClearChart(formdetailedgraphs.Chart_OP_CumCarb_CellNum);
    General.ClearChart(formdetailedgraphs.Chart_Turg_CellNum);
    General.ClearChart(formdetailedgraphs.Chart_ThickDur_CellNum);
    General.ClearChart(formdetailedgraphs.Chart_LAI_SLA);
    General.ClearChart(formdetailedgraphs.CHart_WF_WS_WR);
    General.ClearChart(formdetailedgraphs.CHart_NPPStand_SPH);
    General.ClearChart(formdetailedgraphs.CHart_EvapTrans);
    General.ClearChart(formdetailedgraphs.chartDL);
  end;


  //formMain.UpdateCaptionDuringRun(ScenarioName,
  //inttostr(TreeCounter+1),Format('%.2f', [MyStemPosition.Position_m]));
  //for PositionCounter := 0 to 0 do begin

  SetLength(DailyOutputData,0);
  SetLength(DailyOutputData,Length(CurrentRunData));

  ModStemPos := TStemPosition.Create;
  ModStemPos.Position_m := ModellingPosition;
  ModStemPos.Diameter_cm := 0.1;

  BasalStemPos := TStemPosition.Create;
  BasalStemPos.Position_m := DataObjects.BASEPOS;
  BasalStemPos.Diameter_cm := MINBASEDIAM_CM;

  CAMBIUMModel.InitialiseModel(CurrentRunData,
    InputSiteInfo,
    MyTree,BasalStemPos,CurrentCAMBIUMParameters);

  CAMBIUMModel.InitialiseModel(CurrentRunData,
    InputSiteInfo,
    MyTree,ModStemPos,CurrentCAMBIUMParameters);

  ModLivingCellsList := TObjectList.Create;
  ModDeadCellsList := TObjectList.Create;
  BasalLivingCellsList := TObjectList.Create;
  BasalDeadCellsList := TObjectList.Create;

    //Create the initial list of living cells
  CAMBIUMModel.CreateInitialCellPopulation(ModLivingCellsList,
      strtoint(formInitialisation.leCZWidth.Text),
      MyTree,
      ModStemPos,
      strtoint(formInitialisation.leRadDiam.Text),
      strtoint(formInitialisation.leTanDiam.Text),
      strtoint(formInitialisation.leLength.Text),
      strtoint(forminitialisation.leXprop.Text)/100,
      CurrentRunData[0].LogDate,
      CELLFILES,
      CurrentCAMBIUMParameters);

  CAMBIUMModel.CreateInitialCellPopulation(BasalLivingCellsList,
      strtoint(formInitialisation.leCZWidth.Text),
      MyTree,
      BasalStemPos,
      strtoint(formInitialisation.leRadDiam.Text),
      strtoint(formInitialisation.leTanDiam.Text),
      strtoint(formInitialisation.leLength.Text),
      strtoint(forminitialisation.leXprop.Text)/100,
      CurrentRunData[0].LogDate,
      CELLFILES,
      CurrentCAMBIUMParameters);

  BasalStemPos.DividingCellCount := BasalLivingCellsList.Count;
  BasalStemPos.CurrentMaxCZWidth := 1;

  ModStemPos.DividingCellCount := ModLivingCellsList.Count;
  ModSTemPos.CurrentMaxCZWidth := 1;

  DayStep := -1;

  if ScenarioType = ScenarioManager.CAMBIUM_SCENARIO_TYPE then begin

    SetLength(MYASWLayers,round(InputSiteInfo.SoilDepth*10));
    for i := 0 to length(MyASWLayers)-1 do
      MyASWLayers[i] := InputSiteInfo.InitialASW * 0.1;
    MyPooledSW := 0;
    MyFertRating := InputSiteInfo.FR;
    //This assumes the data has been sorted on ascending date...!!!
    MyEstablishmentDate := InputRegimeInfo[0].EventDate;
    MyStemNo := InputRegimeInfo[0].EventValue;
    MyWF := 0.001;
    MyWS := 0.001;
    MyWR := 0.001;
    MyTreeHt := BASEPOS+0.2;
    MyRootDepth := 0.1;

  end;

  While (DayStep < length(CurrentRunData)-1) and
    (RunManager.ModelStop = False) do begin

    if (formMain.Stepthroughthemodelrundaybyday.checked) and
      (OverRideStep = false) then begin
      if MessageDlg('Go on to the the next day?',mtConfirmation,[mbYes,mbCancel],0) = MrCancel then
        OverrideStep := True;
    end;

    DayStep := DayStep + 1;

    decodedate(CurrentRunData[DayStep].LogDate,myyear,mymonth,myday);

    Application.ProcessMessages;

    if ScenarioType = ScenarioManager.CAMBIUM_SCENARIO_TYPE then
      CurrentRunData[DayStep] := TreePhysModel.MainLoop(InputSiteInfo,
        InputRegimeInfo,
        TPGParameters,
        InputWeatherData,
        DayStep,
        BasalStemPos.Diameter_cm*10,
        (BasalStemPos.MaxLivingCellPosition_um - BasalStemPos.MinLivingCellPosition_um)/ 1000,
        BasalStemPos.MeanWD_kgperm3,
        MyEstablishmentDate,
        MyTreeHt,MyRootDepth,//CurrentRunData[DayStep].TreeHt_m,
        MyFertRating,MyPooledSW,MySTemNo,MyWF,MyWS,MyWR,MyASWLayers);

    if formMain.Detailedgraphs1.Checked then begin

      //General.ClearChart(formdetailedgraphs.ChartAuxCarbConcGrad);
      General.ClearChart(formdetailedgraphs.ChartCellCarbs);
      General.ClearChart(formdetailedgraphs.ChartWPOP);
      General.ClearChart(formdetailedgraphs.ChartWTYT);
      //General.ClearChart(formdetailedgraphs.ChartAuxConcCell);
      General.ClearChart(formdetailedgraphs.ChartRDLength);
      General.ClearChart(formdetailedgraphs.ChartWTVol);
      General.ClearChart(formdetailedgraphs.chartallocCarb);

      formdetailedgraphs.refresh;
    end;

    UpdateTreeLevelData(CurrentRunData,
      MyTree,
      BasalStemPos,
      DayStep,
      CurrentRunData[DayStep].LogDate,
      CurrentCAMBIUMParameters,
      1);

    CAMBIUMModel.MainLoop(CurrentRunData,
      CurrentCambiumParameters,
      MyTree,
      BasalStemPos,
      ModellingPosition,
      BasalLivingCellsList,
      BasalDeadCellsList,
      //formMain.Viewdevelopingxylemduringrun1.Checked,
      false,
      DailyOutputData,
      CELLFILES,
      DayStep);

    MyTree.TreeDBUB_cm := max(BasalStemPos.Diameter_cm,ModStemPos.Diameter_cm);

    if CurrentRunData[DayStep].TreeHt_m > ModellingPosition then begin

      CAMBIUMModel.MainLoop(CurrentRunData,
        CurrentCambiumParameters,
        MyTree,
        ModStemPos,
        ModellingPosition,
        ModLivingCellsList,
        ModDeadCellsList,
        //formMain.Viewdevelopingxylemduringrun1.Checked,
        false,
        DailyOutputData,
        CELLFILES,
        DayStep);
    end;

    if formMain.Viewdevelopingxylemduringrun1.Checked then begin

      DrawCellsDuringRun(formDevelopingCellsImage.imageDevelopingCells,
        General.CombineObjectLists(ModDeadCellsList,ModLivingCellsList),
        round(GetMax(ModStemPos.InitialCellPositions_um)),True);

      //ConvertSaveImage(formDevelopingCellsImage.imageDevelopingCells.Picture,
        //'C:\temp\wood_image.bmp');

    end;
  end;

  {AllCellsImage := TImage.Create(nil);
  AllCellsImage.Picture.Bitmap.PixelFormat := pf24bit;
  AllCellsImage.Height :=  round(ModStemPos.MaxLivingCellPosition_um);
  AllCellsImage.Width := 30*20;

  DrawAllCells(AllCellsImage,
    ModStemPos.MaxLivingCellPosition_um,
    ModDeadCellsList);

  ConvertSaveImage(GlobalAllCellsImage.Picture,
    'C:\Papers\23_CAMBIUM_SW\wood_image.bmp');

  AllCellsImage.Free; }


  SegmentData := CalculateSegmentData(CurrentCAMBIUMParameters,
    ModDeadCellsList,
    SegmentWidth,
    StripWidth);


  MyTree.Free;
  BasalStemPos.free;
  ModStemPos.Free;
  BasalLivingCellsList.Free;
  BasalDeadCellsList.Free;
  ModLivingCellsList.Free;
  ModDeadCellsList.Free;

end;

{Procedure UpdateMensurationGraphs(InputData: TMensDataArray;
  DBHChart: TChart;
  DBHSeriesNumber: Integer;
  HtChart: TChart;
  HtSeriesNumber: Integer);
var
  i : integer;
begin
  for i := 0 to length(InputData)-1 do begin
    DBHChart.Series[DBHSeriesNumber].AddXY(Inputdata[i].LogDate,InputData[i].DBH);
    HtChart.Series[HtSeriesNumber].AddXY(Inputdata[i].LogDate,InputData[i].Height);
  end;
end;    }






Function CalculateDensity(b0: double;
  b1: double;
  b2: double;
  MeanTRD: double;
  MeanTWT: double): Double;Overload;
begin
	if (MeanTRD > 0) and (MeanTWT > 0) then
		Result := b0 + (b1*MeanTRD) +	(b2*MeanTWT)
  else
    Result := 0;
end;




Function CalculateSegmentData(Params:TCAMBIUMParameters;
  AllCellsList: TObjectList;
  SegmentWidth: Integer;
  StripWidth : Double) : TCAMBIUMSegmentDataArray;
var
  i : integer;
  SegmentCounter,CellCounter : Integer;
  MeanRD,MeanTD,MeanWT : Double;
  MeanWD,MeanMFA : Double;
  MeanVol,MeanLumVol : DOuble;
  MinDate,MaxDate : TDate;
  CellDensity : Double;
  MOE : Double;
  RingMarker,RingNumber : smallint;
  MyYear1,MyMonth1,MyDay1,YearMem : Word;
  MinRadPos : DOuble;

begin
  SetLength(Result,0);

  MeanRD := 0;
  MeanTD := 0;
  MeanWT := 0;
  MeanWD := 0;
  CellDensity := 0;
  MeanMFA := 0;
  MOE := 0;
  MeanVol := 0;
  MeanLumVol := 0;
  YearMem := 0;

  CellCounter := 0;
  MinDate := 999999;
  MaxDate := 0;
  RingMarker := 0;
  RingNumber := 0;
  SegmentCounter := 0;

  AllCellsList.Sort(CompareByRadPosition);

  //while SegmentCounter*SegmentWidth < TCell(AllCellsList[0]).RadPosition_um do
    //SegmentCOunter := SegmentCounter + 1;

  if AllCellsList.Count > 0 then begin
    MinRadPos := TCell(AllCellsList[0]).RadPosition_um;

    i := 0;

    while i < AllCellsList.Count-1 do begin
      //if TCell(AllCellsList[i]).StemPosition = ModellingPos then begin
        if TCell(AllCellsList[i]).CellType <> PCELL then begin
          if (TCell(AllCellsList[i]).RadPosition_um - MinRadPos >= SegmentCounter*SegmentWidth) and
            (TCell(AllCellsList[i]).RadPosition_um - MinRadPos < SegmentCounter*SegmentWidth + SegmentWidth)then begin

            MinDate := Min(MinDate,TCell(AllCellsList[i]).GrowthStopDate);
            MaxDate := Max(MaxDate,TCell(AllCellsList[i]).GrowthStopDate);

            DecodeDate(TCell(AllCellsList[i]).GrowthStopDate,MyYear1,MyMonth1,MyDay1);

            if (MyMonth1 >= 7) and (RingMarker = 0) and (MyYear1 <> YearMem) then begin
              YearMem := MyYear1;
              RingMarker := 1;
              RingNumber := RingNumber + 1;
            end;

            MeanRD := MeanRD + TCell(AllCellsList[i]).CellRD_um;
            MeanTD := MeanTD + TCell(AllCellsList[i]).CellTD_um;
            MeanWT := MeanWT + TCell(AllCellsList[i]).CellWT_um;
            MeanVol := MeanVol + TCell(AllCellsList[i]).CellVolume_um3;
            MeanLumVol := MeanLumVol + TCell(AllCellsList[i]).LumenVolume_um3;
            MeanMFA := MeanMFA + TCell(AllCellsList[i]).MFA;

            CellCounter := CellCounter + 1;
            i := i + 1;

          end else begin
            if CellCOunter > 0 then begin

              MeanRD := MeanRD/CellCounter;
              MeanTD := MeanTD/CellCounter;
              MeanWT := MeanWT/CellCounter;
              MeanMFA := MeanMFA/CellCounter;

              //MeanWD := CalculateDensity(Params.b0Density,Params.b1Density,Params.b2Density,
                //(MeanRD + MeanTD)/2,MeanWT);
              MeanWD := CalculateDensity(MeanVol,MeanLumVol,Params.WallDensity);

              MOE := CalculateMOE(Params.b0MOE,
                params.b1MOE,
                //Params.b2MOE,
                MeanWD,
                MeanMFA);

              CellDensity := CellCounter/(SegmentWidth/1000 * StripWidth/1000);
            end else begin
              if Length(Result) > 0 then begin

                MinDate := Result[SegmentCounter-1].startdate;
                MaxDate := Result[SegmentCounter-1].enddate;

                MeanRD := Result[SegmentCounter-1].MeanRD;
                MeanTD := Result[SegmentCounter-1].MeanTD;
                MeanWT := Result[SegmentCounter-1].MeanWT;
                MeanWD := Result[SegmentCounter-1].WoodDensity;
                MeanMFA := Result[SegmentCounter-1].MFA;
                CellDensity := Result[SegmentCounter-1].CellDensity;
                MOE := Result[SegmentCounter-1].MOE;
              end;
            end;

            SetLength(Result,Length(Result) +1);

            Result[SegmentCounter].StartDate := MinDate;
            Result[SegmentCounter].EndDate := MaxDate;
            Result[SegmentCounter].SegmentNumber := SegmentCounter;
            Result[SegmentCounter].SegmentPosition := SegmentCounter * SegmentWidth;
            Result[SegmentCounter].SegmentWidth := SegmentWidth;
            Result[SegmentCounter].MeanRD := MeanRD;
            Result[SegmentCounter].MeanTD := MeanTD;
            Result[SegmentCounter].MeanWT := MeanWT;
            Result[SegmentCounter].WoodDensity := MeanWD;
            Result[SegmentCounter].MFA := MeanMFA;
            Result[SegmentCounter].CellDensity := CellDensity;
            Result[SegmentCounter].MOE := MOE;
            Result[SegmentCounter].RinginSegment := RingNumber;

            RingMarker := 0;

            CellCounter := 0;
            MinDate := MaxDate;
            //MaxDate := 0;

            MeanRD := 0;
            MeanTD := 0;
            MeanWT := 0;
            MeanMFA := 0;
            MeanVol := 0;
            MeanLumVol := 0;

            SegmentCounter := SegmentCounter + 1;

          end;
        end;
      //end;
    end;
  end else
    FormWarnings.MemoWarnings.Lines.Add('No cells were available for segment calculation.');
end;



//Assign parameters values to variables
Function Set3PGParameters(ParametersArray: array of TParametersList;
  var TPGParametersError: Boolean) :T3PGParameters;
var
  i,ParametersCounter : Integer;
  Current3PGParameters : T3PGParameters;
begin
  TPGParametersError := False;
  //Current3PGParameters := T3PGParameters.Create;
  ParametersCounter := 0;

  try
    for i := 0 to length(ParametersArray)-1 do begin

      {1}if ParametersArray[i].ParameterName = 'maxAge'  then begin
        Current3PGParameters.maxAge := ParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
        if Current3PGParameters.MaxAge < 1 then begin
          Current3PGParameters.MaxAge := 1;
          formWarnings.memoWarnings.Lines.Add('Max. age set to 1');
        end;
      end;
      {2}if ParametersArray[i].ParameterName = 'nAge'  then begin
        Current3PGParameters.nAge := ParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
        if Current3PGParameters.nAge < 0 then begin
          Current3PGParameters.nAge := 0;
          formWarnings.memoWarnings.Lines.Add('Parameter nAge set to 0');
        end;
      end;
      {3}if ParametersArray[i].ParameterName = 'rAge'  then begin
        Current3PGParameters.rAge := ParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
        if Current3PGParameters.rAge < 0 then begin
          Current3PGParameters.rAge := 0;
          formWarnings.memoWarnings.Lines.Add('Parameter rAge set to 0');
        end;
      end;
      {4}if ParametersArray[i].ParameterName = 'fullCanAge'  then begin
        Current3PGParameters.fullCanAge := ParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
        if Current3PGParameters.fullCanAge < 1 then begin
          Current3PGParameters.fullCanAge := 1;
          formWarnings.memoWarnings.Lines.Add('Age at full canopy cover set to 1');
        end;
      end;
      {5}if ParametersArray[i].ParameterName = 'k'  then begin
        Current3PGParameters.k := ParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
        if Current3PGParameters.k < 0 then begin
          Current3PGParameters.k := 0;
          formWarnings.memoWarnings.Lines.Add('Radiation extinction coefficient set to 0');
        end;
      end;
      {6}if ParametersArray[i].ParameterName = 'gammaR'  then begin
        Current3PGParameters.gammaR := ParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
        if Current3PGParameters.gammaR < 0 then begin
          Current3PGParameters.gammaR := 0;
          formWarnings.memoWarnings.Lines.Add('Daily root turnover rate set to 0');
        end;
      end;
      {7if ParametersArray[i].ParameterName = 'SWconst0'  then begin
        Current3PGParameters.SWconst0 := ParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
        if Current3PGParameters.SWconst0 < 0 then begin
          Current3PGParameters.SWconst0 := 0;
          formWarnings.memoWarnings.Lines.Add('SW constant set to 0');
        end;

      end;
      8if ParametersArray[i].ParameterName = 'SWPower0'  then begin
        Current3PGParameters.SWPower0 := ParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
        if Current3PGParameters.SWPower0 < 0 then begin
          Current3PGParameters.SWPower0 := 0;
          formWarnings.memoWarnings.Lines.Add('SW power set to 0');
        end;

      end;}
      {9}if ParametersArray[i].ParameterName = 'MaxIntcptn'  then begin
        Current3PGParameters.MaxIntcptn := ParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
        if Current3PGParameters.MaxIntcptn < 0 then begin
          Current3PGParameters.MaxIntcptn := 0;
          formWarnings.memoWarnings.Lines.Add('Max. interception set to 0');
        end;

      end;
      {10}if ParametersArray[i].ParameterName = 'LAImaxIntcptn'  then begin
        Current3PGParameters.LAImaxIntcptn := ParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
        if Current3PGParameters.LAImaxIntcptn < 1 then begin
          Current3PGParameters.LAImaxIntcptn := 1;
          formWarnings.memoWarnings.Lines.Add('LAI for max interception set to 1');
        end;

      end;
      {11}if ParametersArray[i].ParameterName = 'MaxCond'  then begin
        Current3PGParameters.MaxCond := ParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
        if Current3PGParameters.MaxCond < 0 then begin
          Current3PGParameters.MaxCond := 0;
          formWarnings.memoWarnings.Lines.Add('Max. conductance set to 0');
        end;
      end;
      {12}if ParametersArray[i].ParameterName = 'LAIgcx'  then begin
        Current3PGParameters.LAIgcx := ParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
        if Current3PGParameters.LAIgcx < 1 then begin
          Current3PGParameters.LAIgcx := 1;
          formWarnings.memoWarnings.Lines.Add('LAI for max. can. cond. set to 1');
        end;
      end;
      {13}if ParametersArray[i].ParameterName = 'BLCond'  then begin
        Current3PGParameters.BLCond := ParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
      end;
     //{14}if ParametersArray[i].ParameterName = 'aH'  then begin
       // Current3PGParameters.aH := ParametersArray[i].ParameterValue;
       // ParametersCounter := ParametersCounter + 1;
      //end;
      {15}if ParametersArray[i].ParameterName = 'CoeffCond'  then begin
        Current3PGParameters.CoeffCond := ParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
      end;
      {16}if ParametersArray[i].ParameterName = 'y'  then begin
        Current3PGParameters.y := ParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
      end;
      {17}if ParametersArray[i].ParameterName = 'TMax'  then begin
        Current3PGParameters.TMax := ParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
      end;
      {18}if ParametersArray[i].ParameterName = 'Tmin'  then begin
        Current3PGParameters.Tmin := ParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
      end;
      {19}if ParametersArray[i].ParameterName = 'TOpt'  then begin
        Current3PGParameters.TOpt := ParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
      end;
      {20}if ParametersArray[i].ParameterName = 'pFS2'  then begin
        if ParametersArray[i].ParameterValue > 0 then
          Current3PGParameters.pFS2 := ParametersArray[i].ParameterValue
        else begin
         Current3PGParameters.pFS2 := 1;
         formwarnings.memoWarnings.Lines.Add('Lower stem:foliage ratio set to 1');
        end;
        ParametersCounter := ParametersCounter + 1;
      end;
      {21}if ParametersArray[i].ParameterName = 'pFS20'  then begin
        Current3PGParameters.pFS20 := ParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
      end;
      {22}if ParametersArray[i].ParameterName = 'pRx'  then begin
        Current3PGParameters.pRx := ParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
      end;
      {23}if ParametersArray[i].ParameterName = 'pRn'  then begin
        Current3PGParameters.pRn := ParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
      end;
      {24}if ParametersArray[i].ParameterName = 'm0'  then begin
        Current3PGParameters.m0 := ParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
      end;
      {25}if ParametersArray[i].ParameterName = 'fN0'  then begin
        Current3PGParameters.fN0 := ParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
      end;
      {26}if ParametersArray[i].ParameterName = 'fNn'  then begin
        if (ParametersArray[i].ParameterValue > 0) and (ParametersArray[i].ParameterValue <=1) then
          Current3PGParameters.fNn := ParametersArray[i].ParameterValue
        else begin
          Current3PGParameters.fNn := 1;
          formWarnings.memoWarnings.Lines.Add('3PG parameter fNn reset to 1');
        end;
        ParametersCounter := ParametersCounter + 1;
      end;
      {27}if ParametersArray[i].ParameterName = 'alphaCx'  then begin
        Current3PGParameters.alphaCx := ParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
      end;
      {28if ParametersArray[i].ParameterName = 'poolFracn'  then begin
        ParametersCounter := ParametersCounter + 1;
        if (ParametersArray[i].ParameterValue > 0) and (ParametersArray[i].ParameterValue <=1) then
          Current3PGParameters.poolFracn := ParametersArray[i].ParameterValue
        else begin
          Current3PGParameters.poolFracn := 1;
          formWarnings.memoWarnings.Lines.Add('3PG parameter Pool Fraction reset to 1');
        end;
      end;
      29if ParametersArray[i].ParameterName = 'gammaN1'  then begin
        Current3PGParameters.gammaN1 := ParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
      end;
      if ParametersArray[i].ParameterName = 'gammaN0'  then begin
        Current3PGParameters.gammaN0 := ParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
      end;
      if ParametersArray[i].ParameterName = 'tgammaN'  then begin
        Current3PGParameters.tgammaN := ParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
      end;
      if ParametersArray[i].ParameterName = 'ngammaN'  then begin
        Current3PGParameters.ngammaN := ParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
      end; }
      {33}if ParametersArray[i].ParameterName = 'wSx1000'  then begin
        Current3PGParameters.wSx1000 := ParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
      end;
      {34}if ParametersArray[i].ParameterName = 'thinPower'  then begin
        Current3PGParameters.thinPower := ParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
      end;
      {35if ParametersArray[i].ParameterName = 'mF'  then begin
        Current3PGParameters.mF := ParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
      end;
      {36if ParametersArray[i].ParameterName = 'mR'  then begin
        Current3PGParameters.mR := ParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
      end;}
      {37}if ParametersArray[i].ParameterName = 'mS'  then begin
        Current3PGParameters.mS := ParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
      end;
      {38}if ParametersArray[i].ParameterName = 'gammaF1'  then begin
        Current3PGParameters.gammaF1 := ParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
      end;
      {39}if ParametersArray[i].ParameterName = 'gammaF0'  then begin
        Current3PGParameters.gammaF0 := ParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
      end;
      {40}if ParametersArray[i].ParameterName = 'tgammaF'  then begin
        Current3PGParameters.tgammaF := ParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
      end;
      {41}if ParametersArray[i].ParameterName = 'SLA0'  then begin
        Current3PGParameters.SLA0 := ParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
      end;
      {42}if ParametersArray[i].ParameterName = 'SLA1'  then begin
        Current3PGParameters.SLA1 := ParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
      end;
      {43}if ParametersArray[i].ParameterName = 'tSLA'  then begin
        Current3PGParameters.tSLA := ParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
      end;
      {47}if ParametersArray[i].ParameterName = 'Qa'  then begin
        Current3PGParameters.Qa := ParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
      end;
      {48}if ParametersArray[i].ParameterName = 'Qb'  then begin
        Current3PGParameters.Qb := ParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
      end;
      {49}if ParametersArray[i].ParameterName = 'PSIMin'  then begin
        if ParametersArray[i].ParameterValue < 0 then
          Current3PGParameters.PSIMin := ParametersArray[i].ParameterValue
        else begin
          Current3PGParameters.PSIMin := -1;
          formWarnings.memoWarnings.Lines.Add('Minimum leaf water pot. set to -1')
        end;
        ParametersCounter := ParametersCounter + 1;
      end;
      {50if ParametersArray[i].ParameterName = 'DeltaPSIMax'  then begin
        if ParametersArray[i].ParameterValue > 0 then
          Current3PGParameters.DeltaPSIMax := ParametersArray[i].ParameterValue
        else begin
          Current3PGParameters.DeltaPSIMax := 1;
          formWarnings.memoWarnings.Lines.Add('Max water pot. change set to 1');
        end;
        ParametersCounter := ParametersCounter + 1;
      end;  }
     // {51}if ParametersArray[i].ParameterName = 'nHB'  then begin
       // if ParametersArray[i].ParameterValue <> 0 then
        //  Current3PGParameters.nHB := ParametersArray[i].ParameterValue
        //else begin
        //  Current3PGParameters.nHB := 1;
        //  formWarnings.memoWarnings.Lines.Add('Parameter "nHB" cannot be zero. Reset to 1')
        //end;
       // ParametersCounter := ParametersCounter + 1;
      //end;
      //{52}if ParametersArray[i].ParameterName = 'nHN'  then begin
       // Current3PGParameters.nHN := ParametersArray[i].ParameterValue;
       // ParametersCounter := ParametersCounter + 1;
      //end;
      {53}if ParametersArray[i].ParameterName = 'RootConversion'  then begin
        Current3PGParameters.RootConversion := ParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
      end;
      {54}if ParametersArray[i].ParameterName = 'MinHDRatio'  then begin
        Current3PGParameters.MinHDRatio := ParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
      end;
      {55}if ParametersArray[i].ParameterName = 'MaxHDRatio'  then begin
        Current3PGParameters.MaxHDRatio := ParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
      end;
      {57if ParametersArray[i].ParameterName = 'TreeHtHyd'  then begin
        Current3PGParameters.TreeHtHyd := ParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
      end;}

    end;

    if Current3PGParameters.TMax <= Current3PGParameters.Tmin then begin
      Current3PGParameters.Tmin :=  Current3PGParameters.TMax * 0.9;
      formWarnings.memoWarnings.Lines.Add('Min. temp for the stand level model was <= max temp.  Reset to Max temp * 0.9');
    end;
    if (Current3PGParameters.TOpt <=  Current3PGParameters.TMin) or
      (Current3PGParameters.TOpt >=  Current3PGParameters.TMax)
     then begin
      Current3PGParameters.TOpt :=  (Current3PGParameters.TMax + Current3PGParameters.TMin)/2;
      formWarnings.memoWarnings.Lines.Add('Op. temp for the stand level model must be between min. and max. temps.  Reset to (Min + Max)/2');
    end;

    Result := Current3PGParameters;

    if ParametersCounter < Length(AddEditCAMBIUMParams.DefaultParameterItems_RadiataStand) then begin
      FormWarnings.memoWarnings.Lines.Add('CAMBIUM requires ' + inttostr(Length(AddEditCAMBIUMParams.DefaultParameterItems_RadiataStand)) +
        ' parameters for the stand model.  Only ' + inttostr(ParametersCounter) +
        ' could be allocated. The model cannot be successfully run with '+
        ' too few parameters allocated.');
      TPGParametersError := True;
    end;

    //Current3PGParameters.Free;

  except
    on E:Exception do begin
      formWarnings.memoWarnings.Lines.Add('At least one parameter could not be set for the model run. The following error was found: ' + E.Message);

      TPGParametersError := True;
    end;
  end;
end;



//Assign parameters values to variables
Function SetCAMBIUMParameters(CAMBIUMParametersArray: array of TParametersList;
  var CAMBIUMParametersError : Boolean) :
  TCAMBIUMParameters;
var
  i,ParametersCounter : Integer;
  CurrentCAMBIUMParameters : TCambiumParameters;

begin
  ParametersCounter := 0;
  CAMBIUMParametersError := False;

	//Parameters error checking

  try
    for i := 0 to length(CAMBIUMParametersArray)-1 do begin
      {1}if CAMBIUMParametersArray[i].ParameterName = 'MinDDivision'  then begin
        if CAMBIUMParametersArray[i].ParameterValue >= 1 then
          CurrentCAMBIUMParameters.MinDDivision := CAMBIUMParametersArray[i].ParameterValue
        else begin
          CurrentCAMBIUMParameters.MinDDivision := 1;
          formWarnings.memoWarnings.Lines.Add('Min. TD for division was set to 1');
        end;
        ParametersCounter := ParametersCounter + 1;
      end;
      {2}if CAMBIUMParametersArray[i].ParameterName = 'MaxDailyWE'  then begin
        if CAMBIUMParametersArray[i].ParameterValue > 0 then
          CurrentCAMBIUMParameters.MaxDailyWE := CAMBIUMParametersArray[i].ParameterValue
        else begin
          CurrentCAMBIUMParameters.MaxDailyWE := 0.01;
          formWarnings.memoWarnings.Lines.Add('Max. wall ext. was < 0.  Reset to 0.01');
        end;
        ParametersCounter := ParametersCounter + 1;
      end;
      {3}if CAMBIUMParametersArray[i].ParameterName = 'MinCellCycle'  then begin
        if CAMBIUMParametersArray[i].ParameterValue >= 1 then
          CurrentCAMBIUMParameters.MinCellCycle := round(CAMBIUMParametersArray[i].ParameterValue)
        else begin
          CurrentCAMBIUMParameters.MinCellCycle := 1;
          formWarnings.memoWarnings.Lines.Add('Min cell cycle set to 1');
        end;
        ParametersCounter := ParametersCounter + 1;
      end;
      {4}if CAMBIUMParametersArray[i].ParameterName = 'EZCZRatio'  then begin
        if (CAMBIUMParametersArray[i].ParameterValue > 0) and
          (CAMBIUMParametersArray[i].ParameterValue < 10)  then
          CurrentCAMBIUMParameters.EZCZRatio := CAMBIUMParametersArray[i].ParameterValue
        else begin
          CurrentCAMBIUMParameters.EZCZRatio := 0.5;
          formWarnings.memoWarnings.Lines.Add('EZ/CZ ratio was < 0 or > 10 and was set to 0.5');
        end;
        ParametersCounter := ParametersCounter + 1;
      end;
      {5}if CAMBIUMParametersArray[i].ParameterName = 'WallDensity'  then begin
        if CAMBIUMParametersArray[i].ParameterValue > 0 then
          CurrentCAMBIUMParameters.WallDensity := CAMBIUMParametersArray[i].ParameterValue
        else begin
          CurrentCAMBIUMParameters.WallDensity := 0.01;
          formWarnings.memoWarnings.Lines.Add('Wall density was < 0.  Reset to 0.01');
        end;
        ParametersCounter := ParametersCounter + 1;
      end;
      {6}if CAMBIUMParametersArray[i].ParameterName = 'MinTemp'  then begin
        CurrentCAMBIUMParameters.MinTemp := CAMBIUMParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
      end;
      {7}if CAMBIUMParametersArray[i].ParameterName = 'MinTurgor'  then begin
        if CAMBIUMParametersArray[i].ParameterValue > 0 then
          CurrentCAMBIUMParameters.MinTurgor := CAMBIUMParametersArray[i].ParameterValue
        else begin
          CurrentCAMBIUMParameters.MinTurgor := 0.01;
          formWarnings.memoWarnings.Lines.Add('Min. turgor limit was < 0.  Reset to 0.01');
        end;
        ParametersCounter := ParametersCounter + 1;
      end;
      {8}if CAMBIUMParametersArray[i].ParameterName = 'RDLRatio'  then begin
        if CAMBIUMParametersArray[i].ParameterValue > 0 then
          CurrentCAMBIUMParameters.RDLRatio := CAMBIUMParametersArray[i].ParameterValue
        else begin
          CurrentCAMBIUMParameters.RDLRatio := 1;
          formWarnings.memoWarnings.Lines.Add('Radial/lgth growth ratio was < 0.  Reset to 1');
        end;
        ParametersCounter := ParametersCounter + 1;
      end;
      {9}if CAMBIUMParametersArray[i].ParameterName = 'MaxMFA'  then begin
        if CAMBIUMParametersArray[i].ParameterValue > 0 then
          CurrentCAMBIUMParameters.MaxMFA := CAMBIUMParametersArray[i].ParameterValue
        else begin
          CurrentCAMBIUMParameters.MaxMFA := 10;
          formWarnings.memoWarnings.Lines.Add('Max. MFA was < 0.  Reset to 10');
        end;
        ParametersCounter := ParametersCounter + 1;
      end;
      {10}if CAMBIUMParametersArray[i].ParameterName = 'VacFactor'  then begin
        if CAMBIUMParametersArray[i].ParameterValue > 0 then
          CurrentCAMBIUMParameters.VacFactor := CAMBIUMParametersArray[i].ParameterValue
        else begin
          CurrentCAMBIUMParameters.VacFactor := 1;
          formWarnings.memoWarnings.Lines.Add('Osmotic modifier was < 0.  Reset to 1');
        end;
        ParametersCounter := ParametersCounter + 1;
      end;
      {11}if CAMBIUMParametersArray[i].ParameterName = 'MFAFactor'  then begin
        if CAMBIUMParametersArray[i].ParameterValue > 0 then
          CurrentCAMBIUMParameters.MFAFactor := CAMBIUMParametersArray[i].ParameterValue
        else begin
          CurrentCAMBIUMParameters.MFAFactor := 1;
          formWarnings.memoWarnings.Lines.Add('MFA factor was < 0.  Reset to 1');
        end;
        ParametersCounter := ParametersCounter + 1;
      end;
      {12}if CAMBIUMParametersArray[i].ParameterName = 'b0MOE'  then begin
        CurrentCAMBIUMParameters.b0MOE := CAMBIUMParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
      end;
      {13}if CAMBIUMParametersArray[i].ParameterName = 'b1MOE'  then begin
        CurrentCAMBIUMParameters.b1MOE := CAMBIUMParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
      end;
      {14}if CAMBIUMParametersArray[i].ParameterName = 'MinOP'  then begin
        if (CAMBIUMParametersArray[i].ParameterValue < 0) and
           (CAMBIUMParametersArray[i].ParameterValue > -10) then
          CurrentCAMBIUMParameters.MinOP := CAMBIUMParametersArray[i].ParameterValue
        else begin
          CurrentCAMBIUMParameters.MinOP := -1;
          formWarnings.memoWarnings.Lines.Add('Min. OP was reset to -1. The value must be less than 0 and greater than -10 MPa.');
        end;
        ParametersCounter := ParametersCounter + 1;
      end;
      {15}if CAMBIUMParametersArray[i].ParameterName = 'MaxTRD'  then begin
        if CAMBIUMParametersArray[i].ParameterValue >= strtofloat(formInitialisation.leRadDiam.Text) then
          CurrentCAMBIUMParameters.MaxTRD := CAMBIUMParametersArray[i].ParameterValue
        else begin
          CurrentCAMBIUMParameters.MaxTRD := strtofloat(formInitialisation.leRadDiam.Text);
          formWarnings.memoWarnings.Lines.Add('Max. TRD was < ' + formInitialisation.leRadDiam.Text + '.  Reset to ' + formInitialisation.leRadDiam.Text);
        end;
        if CAMBIUMParametersArray[i].ParameterValue <= 120 then
          CurrentCAMBIUMParameters.MaxTRD := CAMBIUMParametersArray[i].ParameterValue
        else begin
          CurrentCAMBIUMParameters.MaxTRD := 120;
          formWarnings.memoWarnings.Lines.Add('Max. TRD was > 120.  Reset to 120');
        end;
        ParametersCounter := ParametersCounter + 1;
      end;
      {16}if CAMBIUMParametersArray[i].ParameterName = 'MaxTLength'  then begin
        if CAMBIUMParametersArray[i].ParameterValue > strtofloat(formInitialisation.leLength.Text) then
          CurrentCAMBIUMParameters.MaxTLength := CAMBIUMParametersArray[i].ParameterValue
        else begin
          CurrentCAMBIUMParameters.MaxTLength := strtofloat(formInitialisation.leLength.Text);
          formWarnings.memoWarnings.Lines.Add('Max. TL was < ' + formInitialisation.leLength.Text + '.  Reset to ' + formInitialisation.leLength.Text);
        end;
        ParametersCounter := ParametersCounter + 1;
      end;
      {17}if CAMBIUMParametersArray[i].ParameterName = 'LengthReductionatDivision'  then begin
        if (CAMBIUMParametersArray[i].ParameterValue > 0) and
          (CAMBIUMParametersArray[i].ParameterValue < 1) then
          CurrentCAMBIUMParameters.LengthReductionatDivision := CAMBIUMParametersArray[i].ParameterValue
        else begin
          CurrentCAMBIUMParameters.LengthReductionatDivision := 0.9;
          formWarnings.memoWarnings.Lines.Add('Lgth reduction at div. must be > 0 & < 1.  Reset to 0.9');
        end;
        ParametersCounter := ParametersCounter + 1;
      end;
      {18}if CAMBIUMParametersArray[i].ParameterName = 'MaxWallRatio'  then begin
        if (CAMBIUMParametersArray[i].ParameterValue > 0) and
          (CAMBIUMParametersArray[i].ParameterValue < 1) then
          CurrentCAMBIUMParameters.MaxWallRatio := CAMBIUMParametersArray[i].ParameterValue
        else begin
          CurrentCAMBIUMParameters.MaxWallRatio := 0.7;
          formWarnings.memoWarnings.Lines.Add('Max. wall ratio must be > 0 & < 1.  Reset to 0.7');
        end;
        ParametersCounter := ParametersCounter + 1;
      end;
      {19}if CAMBIUMParametersArray[i].ParameterName = 'MaxWallThickRate'  then begin
        if (CAMBIUMParametersArray[i].ParameterValue > 0) then
          CurrentCAMBIUMParameters.MaxWallThickRate := CAMBIUMParametersArray[i].ParameterValue
        else begin
          CurrentCAMBIUMParameters.MaxWallThickRate := 1;
          formWarnings.memoWarnings.Lines.Add('Max. wall thick. rate must be > 0.  Reset to 1');
        end;
        ParametersCounter := ParametersCounter + 1;
      end;
      {20}if CAMBIUMParametersArray[i].ParameterName = 'YieldThreshold'  then begin
        if (CAMBIUMParametersArray[i].ParameterValue >= 0) then
          CurrentCAMBIUMParameters.YieldThreshold := CAMBIUMParametersArray[i].ParameterValue
        else begin
          CurrentCAMBIUMParameters.YieldThreshold := 0;
          formWarnings.memoWarnings.Lines.Add('Yield threshold < 0.  Reset to 0');
        end;
        ParametersCounter := ParametersCounter + 1;
      end;
      {21}if CAMBIUMParametersArray[i].ParameterName = 'CritConcCellDeath'  then begin
        if (CAMBIUMParametersArray[i].ParameterValue >= 0) then
          CurrentCAMBIUMParameters.CritConcCellDeath := CAMBIUMParametersArray[i].ParameterValue
        else begin
          CurrentCAMBIUMParameters.CritConcCellDeath := 0;
          formWarnings.memoWarnings.Lines.Add('Crit. conc. for cell death < 0.  Reset to 0');
        end;
        ParametersCounter := ParametersCounter + 1;
      end;
      {22}if CAMBIUMParametersArray[i].ParameterName = 'JuvenileCoreFactor'  then begin
        if (CAMBIUMParametersArray[i].ParameterValue > 0) then
          CurrentCAMBIUMParameters.JuvenileCoreFactor := CAMBIUMParametersArray[i].ParameterValue
        else begin
          CurrentCAMBIUMParameters.JuvenileCoreFactor:= 1;
          formWarnings.memoWarnings.Lines.Add('Juvenile core factor set to 1');
        end;
        ParametersCounter := ParametersCounter + 1;
      end;
      {23}if CAMBIUMParametersArray[i].ParameterName = 'ExtractionFactor'  then begin
        CurrentCAMBIUMParameters.ExtractionFactor := CAMBIUMParametersArray[i].ParameterValue;
        ParametersCounter := ParametersCounter + 1;
      end;
    end;//for

    Result := CurrentCAMBIUMParameters;

    if ParametersCounter < Length(AddEditCAMBIUMParams.DefaultParameterItems_RadiataXylem) then begin
      formWarnings.memoWarnings.Lines.Add('CAMBIUM requires ' + inttostr(Length(AddEditCAMBIUMParams.DefaultParameterItems_RadiataXylem)) +
        ' parameters.  Only ' + inttostr(ParametersCounter) +
        ' could be allocated. The model cannot be successfully run with '+
        ' too few parameters allocated.');
      CAMBIUMParametersError := True;
    end;

    //CurrentCAMBIUMParameters.free;

  except
    on E:Exception do begin
      formWarnings.memoWarnings.Lines.Add('At least one CAMBIUM parameter could not be set for a model run. The following error was found: ' + E.Message);
      CAMBIUMParametersError := True;
    end;
  end;
end;



end.
