
unit CAMBIUMModel;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, Buttons, ExtCtrls, TeeProcs, TeEngine, Chart, Series,
  ComCtrls, jpeg,{ FileCtrl,}Math,ProjectWarnings,Contnrs,RunInitialisation,ModellingHeight,
  CAMBIUMManager,General,NumberofCellFiles,DevelopingCellsImage,CambiumObjects,DiagnosticGraphs,DataObjects,
  ProjectManager,TestGraphs,DetailedGraphs,DateUtils;

  Procedure MainLoop(CurrentRunData : TCambiumInputDataArray;
    CurrentCambiumParameters : TCambiumParameters;
    CurrentTree : TTree;
    CurrentPosition : TStemPosition;
    MainModellingPosition: Double;
    LivingCellList : TObjectList;
    DeadCellList : TObjectList;
    ViewDevXylem : Boolean;
    var DailyDataArray : TCAMBIUMDailyOutputDataArray;
    CellFileCount: Integer;
    LogDay: Integer);

  Function CalculateDensity(MeanCellVolume: Double;
    MeanLumenVolume: Double;
    WallDensity_gcm3: Double): Double;Overload;

  Function CalculateMOE(b0: double;
    b1: double;
    WoodDensity : double;
    MFA : double): double;

  Procedure InitialiseModel(InputData: TCAMBIUMInputDataArray;
    InputSite : TSiteData;
    CurrentTree : TTree;
    CurrentPosition : TStemPosition;
    Params: TCambiumParameters);

  Procedure DetermineCells(CurrentCell : TCell;
    CurrLivingCellList: TObjectList;
    CurrentTree:TTree;
    CurrentStemPosition:TStemPosition;
    Params:TCAMBIUMParameters;
    Currentdate: TDate;
    CurrentDay : Integer);

  Procedure DivideCells(CurrentCell : TCell;
    CurrentCellList : TObjectList;
    CurrentTree : TTree;
    CurrentStemPosition : TStemPosition;
    TotalModelledCells : Integer;
    CurrentDate : TDate;
    CurrentDay : Integer;
    Params : TCAMBIUMParameters);

  procedure GrowCells(CurrentCell : TCell;
    CurrentCellList:TObjectList;
    CurrentTree : TTree;
    CurrentDay: Integer;
    CurrentDate : TDate;
    CurrentStemPosition : TStemPosition;
    Params : TCAMBIUMParameters;
    CarbLimittoOP : Boolean);

  Procedure UpdateCellPositions(CurrentCell:TCell;
    CurrentCellList:TObjectList;
    CurrentStemPosition:TStemPosition);

  Procedure GrowCellWalls(CurrentCell : TCell;
    MinTemp: DOuble;
    Params: TCAMBIUMParameters);

  Procedure KillCells(CurrentCell : TCell;
    LivingCellList: TObjectList;
    DeadCellList : TObjectList;
    CurrentTree : TTree;
    CurrentStemPosition : TStemPosition;
    CurrentDate: TDate);

  Procedure UpdateTreeLevelData(InputData: TCAMBIUMInputDataArray;
    InputTree: TTree;
    InputStemPosition : TStemPosition;
    CurrentDay: Integer;
    CurrentDate: TDate;
    Params:TCAMBIUMParameters;
    MaxCRAlloc : Double);

  Procedure UpdateStemPositionLevelData(InputTree : TTree;
    InputStemPosition : TStemPosition;
    CurrentDay : INteger;
    CurrentDate : TDate;
    Params:TCAMBIUMParameters;
    TotalModelledCellCount : Integer);

  Procedure UpdateDailyDataArray(CurrentDay: Integer;
    CurrentDate: TDate;
    InputData: TCAMBIUMInputDataArray;
    var OutputDataArray:TCAMBIUMDailyOutputDataArray;
    InputTree:TTree;
    InputStemPosition:TStemPosition);

  Procedure CreateInitialCellPopulation(LCL : TObjectList;
    RadialNumber : Integer;
    CurrentTree : TTree;
    CurrentStemPosition : TStemPosition;
    InitialMeanRD: DOuble;
    InitialMeanTD: Double;
    InitialMeanLength: Double;
    InitialXProp:Double;
    CurrentDate : Double;
    CellFiles:Integer;
    Params : TCAMBIUMParameters);

  Function CambiumSurfaceArea(DatPos_m: Double;
    Pos_m: Double;
    TreeHt_m: Double): Double;

  Function GetAreaSpecificCarbAllocation_gperum2(TotalAllocToday_g: Double;
    TotalCambialSAToday_m2: Double): Double;

  Function GetCurveParameter(CellCount : Integer;
    TotalValue : Double;
    MinParam : Double;
    var MaxParam : Double): Double;

  Procedure AllocateResources(MyLivingCellList: TObjectList;
    CurrStemPos: TStemPosition;
    CurrTree : TTree;
    CurrDay : Integer;
    CurrMonth : Integer;
    MyParams: TCambiumParameters;
    TotalCellFiles : Integer;
    RecycleStoredCarbs : Boolean);

  Function GetRelevantDay(CurrentDay : Integer;
    StemPos_m: Double;
    TreeHeight_m : Double;
    TravelRate_mperday : Double): Integer;

  Function GetCarbMassPerCellFile(CarbMass_gperum2: Double;
    MeanTracheidTD_um: Double;
    MeanTracheidLength_um : Double): Double;

  Function BodyVolume(TypeofCell:string;
    RDV:double;
    TDV:double;
    LengthV:double):double;Overload;

  Function BodyVolume(TypeofCell:string;
    CSArea:double;
    LengthV:double):double;Overload;

  Function BodyCSArea(TypeofCell:string;
    Volume:double;
    FullLength:double):double;

  Function VolumetoMass(InputVolume_CubicMicrons:double;
    MaterialDensity_gpercc:double):double;

  Function MasstoVolume(InputMass_g:double;
    MaterialDensity_gpercc:double):double;

  Function StemVolumePara(DiamAtBase_m:double;
    Ht_m:double):double;overload;

  Function LivingStemVol(DiamBase_m: Double;
    CurrentTreeHt_m: Double;
    LivingXylemWidth_m : Double ):Double;overload;

  Function MeanCZCellVolume(CurrentLivingCellList : TObjectList): double;

  Function WPOutsideCell(XylemWP:Double;
    CondXylemPosition: Double;
    CurrentCellPosition : Double;
    DecayCoef: DOuble):DOuble;

  Function OPCell(CumulCarb_ug: Double;
    LumVol_um3: Double;
    VacFactor : Double;
    T_Centigrade: Double;
    MinOP,MaxOP : Double):Double;

  Function CarbohydrateRequired_g(CurrentCell:TCell;
    PotRadGrowthRate : Double;
    WallThick1 : Double;
    WallThick2 : Double;
    RDLRat : Double;
    WallDensity_gpercc : Double):Double;

  Procedure GetLivingMeans(MyLivingCellList: TObjectList;
    MyStemPos: TStemPosition);

  Function RandomCellSize(InputValue: Double;
    MinBoundary: Integer;
    MaxBoundary: Integer):Double;

  Function GetMinWallThick(CellCSArea,LumenArea: Double;
    CellTD,CellRD : Double): Double;

  Function CalculateMFA(MyMinMFA,MyMaxMFA: Double;
    MFAAdjustmentFactor: Double;
    CarbsDistAlpha : Double): Double;

  Function CalculateMFA_CZW(MyMinMFA,MyMaxMFA: Double;
    MaxWidth,CurrWidth: DOuble; MFAAdjustmentFactor: Double): Double;

  Function GetJuvenileEffect(TreeHt_m: Double;
    ModPos_m: Double;
    JuvFactor_m: Double;
    MyMin,MyMax: Double): Double;

const

  RANDCELLSIZEMIN = 90;
  RANDCELLSIZEMAX = 110;
  RANDDIVISIONMIN = 40;
  RANDDIVISIONMAX = 60;

implementation

uses RunManager;

Procedure MainLoop(CurrentRunData : TCambiumInputDataArray;
  CurrentCambiumParameters : TCambiumParameters;
  CurrentTree : TTree;
  CurrentPosition : TStemPosition;
  MainModellingPosition: Double;
  LivingCellList : TObjectList;
  DeadCellList : TObjectList;
  ViewDevXylem : Boolean;
  var DailyDataArray : TCAMBIUMDailyOutputDataArray;
  CellFileCount: Integer;
  LogDay: Integer);
  //Main model loop

var
  MyCell : TCell;
  CellCounter : integer;
  PrevMLCP : Double;
  MyYear,MyMonth,MyDay : Word;
begin

  DecodeDate(CurrentRunData[LogDay].LogDate,MyYear,MyMonth,MyDay);

  AllocateResources(LivingCellList,
    CurrentPosition,
    CurrentTree,
    logDay,
    MyMonth,
    CurrentCAMBIUMParameters,
    1,
    true);

  //Re-initialise zone counts and other
  //monitoring variables for the next day's accounting
  CurrentPosition.CumCarbEZExit_ug := 0;
  CurrentPosition.CarbConsumptionCZ_ug := 0;
  CurrentPosition.CarbConsumptionEZ_ug := 0;
  CurrentPosition.CarbConsumptionTZ_ug := 0;
  CurrentPosition.MeanGrowingDays := 0;
  CurrentPosition.MeanThickDays := 0;
  CurrentPosition.MeanCellCycleDur_days := 0;
  CurrentPosition.SumGrowingDays := 0;
  CurrentPosition.SumThickDays := 0;
  CurrentPosition.SumCellCycleDur_days := 0;
  CurrentPosition.MaxOP_MPa := -9999;
  CurrentPosition.MeanTurgor_MPa := 0;
  CurrentPosition.MeanYT_Mpa := 0;
  CurrentPosition.MeanExt_umPerMPaPerhour := 0;
  CurrentPosition.StoppedGrowingTodayCount := 0;
  CurrentPosition.StoppedThickTodayCount := 0;
  CurrentPosition.MeanLumVolLivingCells_um3 := 0;
  CurrentPosition.CZReduced := 0;
  CurrentPosition.EZReduced := 0;
  CurrentPosition.TZReduced := 0;

  //Calculate daily means for key variables
  GetLivingMeans(LivingCellList,
    CurrentPosition);

  //Update variables relevant for the modelled position
  UpDateStemPositionLevelData(CurrentTree,
    CurrentPosition,
    LogDay,
    CurrentRunData[LogDay].LogDate,
    CurrentCAMBIUMParameters,
    DeadCellList.Count);

  CurrentPosition.SmallCellWarning := False;

  LivingCellList.Sort(CompareByRadPosition);


  for  CellCounter := 0 to LivingCellList.Count-1 do begin
    MyCell := TCell(LivingCellList[CellCounter]);

    //Determine the fate of each cell in the current living population
    DetermineCells(MyCell,
      LivingCellList,
      CurrentTree,
      CurrentPosition,
      CurrentCAMBIUMParameters,
      CurrentRunData[LogDay].LogDate,
      LogDay);

  end;

  CurrentPosition.DividedTodayCount := 0;


  if CurrentPosition.StoppedGrowingTodayCount > 0 then
    CurrentPosition.MeanGrowingDays := CurrentPosition.SumGrowingDays/CurrentPosition.StoppedGrowingTodayCount;
  if CurrentPosition.StoppedThickTodayCount > 0 then
    CurrentPosition.MeanThickDays := CurrentPosition.SumThickDays/CurrentPosition.StoppedThickTodayCount;

  for CellCounter := 0 to LivingCellList.Count-1 do begin
    if CellCounter <= LivingCellList.Count-1 then begin

      MyCell := TCell(LivingCellList[CellCounter]);

      if MyCell.Status = DEAD then begin
        //Remove cells that have "died" from the
        //living list and add them the dead list
        KillCells(TCell(LivingCellList[CellCounter]),
        LivingCellList,
        DeadCellList,
        CurrentTree,
        CurrentPosition,
        CurrentRunData[LogDay].LogDate);

      end;
    end;
  end;

  LivingCellList.Sort(CompareByRadPosition);

  for CellCounter := LivingCellList.Count-1 downto 0 do begin
    MyCell := TCell(LivingCellList[CellCounter]);

    if (MyCell.Status = MERI) then begin
      //Divide meristematic cells that meet criteria
      DivideCells(MyCell,
        LivingCellList,
        CurrentTree,
        CurrentPosition,
        DeadCellList.Count + LivingCellList.Count,
        CurrentRunData[LogDay].LogDate,
        LogDay,
        CurrentCAMBIUMParameters);


      if MyCell.Process = DIVI then
        CurrentPosition.CarbConsumptionCZ_ug := CurrentPosition.CarbConsumptionCZ_ug + MyCell.LastCarbConsumption_ug;

    end;
  end;

  if CurrentPosition.DividedTodayCount > 0 then
    CurrentPosition.MeanCellCycleDur_days := CurrentPosition.SumCellCycleDur_days/
      CurrentPosition.DividedTodayCount;

  if (formMain.Detailedgraphs1.Checked) and (CurrentPosition.Position_m > 0.1) then begin

    formdetailedgraphs.ChartDurations.series[0].addxy(CurrentRunData[LogDay].LogDate,
      CurrentPosition.MeanCellCycleDur_days);
    formdetailedgraphs.ChartDurations.series[1].addxy(CurrentRunData[LogDay].LogDate,
      CurrentPosition.MeanGrowingDays);
    formdetailedgraphs.ChartDurations.series[2].addxy(CurrentRunData[LogDay].LogDate,
      CurrentPosition.MeanThickDays);
  end;

  CurrentPosition.LowTurgorFlag := false;

  PrevMLCP := CurrentPosition.MaxLivingCellPosition_um;

  for CellCounter := 0 to LivingCellList.Count-1 do begin
    MyCell := TCell(LivingCellList[CellCounter]);

    GrowCells(MyCell,
      LivingCellList,
      CurrentTree,
      LogDay,
      CurrentRunData[LogDay].LogDate,
      CurrentPosition,
      CurrentCAMBIUMParameters,
      false);

    UpdateCellPositions(MyCell,
      LivingCellList,
      CurrentPosition);

    if MyCell.Process = GROW then
      CurrentPosition.CarbConsumptionEZ_ug := CurrentPosition.CarbConsumptionEZ_ug + MyCell.LastCarbConsumption_ug;

    if (MyCell.Process = GROW) or (MyCell.Process = DIVI) then begin

      CurrentPosition.MeanTurgor_MPa := CurrentPosition.MeanTurgor_MPa +
        MyCell.MeanTurgor_MPa;
      CurrentPosition.MeanYT_Mpa := CurrentPosition.MeanYT_Mpa +
        MyCell.MeanYT_Mpa;
      CurrentPosition.MeanExt_umPerMPaPerhour := CurrentPosition.MeanExt_umPerMPaPerhour +
        MyCell.WallExtensibility_umperMPAh;
    end;

    if (formMain.Detailedgraphs1.Checked) and (CurrentPosition.Position_m > 0.1)  then begin
      formdetailedgraphs.ChartRDLength.Series[0].addxy(MyCell.RadPosition_um,
        MyCell.CellRD_um);
      formdetailedgraphs.ChartRDLength.Series[1].addxy(MyCell.RadPosition_um,
        MyCell.CellLength_um);
      formdetailedgraphs.ChartWTVol.Series[0].addxy(MyCell.RadPosition_um,
        MyCell.CellWT_um);
      formdetailedgraphs.ChartWTVol.Series[1].addxy(MyCell.RadPosition_um,
        MyCell.CellVolume_um3);
      formdetailedgraphs.ChartWTVol.Series[2].addxy(MyCell.RadPosition_um,
        MyCell.LumenVolume_um3);
    end;
  end;

  CurrentPosition.ThinWallCumul := 1;

  //Initialise the min CZ position to ensure it is updated properly in this run.
  CurrentPosition.MinCZCellPosition_um := CurrentPosition.MaxLivingCellPosition_um;
  CurrentPosition.MinGrowingCellPosition_um := CurrentPosition.MaxLivingCellPosition_um;
  CurrentPosition.MinLivingCellPosition_um := CurrentPosition.MaxLivingCellPosition_um;

  for CellCounter := 0 to LivingCellList.Count-1 do begin
    MyCell := TCell(LivingCellList[CellCounter]);

      if MyCell.CellType = CINITIAL then
        CurrentPosition.InitialCellPositions_um[MyCell.CellFileNumber-1] :=
          MyCell.RadPosition_um;

      if MyCell.Status = MERI then begin
        if MyCell.RadPosition_um >= CurrentPosition.MaxCZCellPosition_um then
          CurrentPosition.MaxCZCellPosition_um := MyCell.RadPosition_um;
        if MyCell.RadPosition_um <= CurrentPosition.MinCZCellPosition_um then
          CurrentPosition.MinCZCellPosition_um := MyCell.RadPosition_um;
      end;

      if MyCell.RadPosition_um >= CurrentPosition.MaxLivingCellPosition_um then
        CurrentPosition.MaxLivingCellPosition_um := MyCell.RadPosition_um;

      if MyCell.RadPosition_um <= CurrentPosition.MinLivingCellPosition_um then
        CurrentPosition.MinLivingCellPosition_um := MyCell.RadPosition_um;

      if (MyCell.Process = STHICK) and
        (MyCell.RadPosition_um >= CurrentPosition.maxthickeningcellposition_um) then
        CurrentPosition.maxthickeningcellposition_um := MyCell.RadPosition_um;

      if (MyCell.Process = GROW) then begin
        if (MyCell.RadPosition_um <= CurrentPosition.minGrowingCellPosition_um) then
          CurrentPosition.MinGrowingcellposition_um := MyCell.RadPosition_um;
        if (MyCell.RadPosition_um >= CurrentPosition.MaxGrowingCellPosition_um) then
          CurrentPosition.MaxGrowingCellPosition_um := MyCell.RadPosition_um;
      end;
  end;


  CurrentPosition.MeanTurgor_MPa := CurrentPosition.MeanTurgor_MPa/
    (CurrentPosition.DividingCellCount + CurrentPosition.GrowingCellCount);
  CurrentPosition.MeanYT_Mpa := CurrentPosition.MeanYT_Mpa/
    (CurrentPosition.DividingCellCount + CurrentPosition.GrowingCellCount);
  CurrentPosition.MeanExt_umPerMPaPerhour := CurrentPosition.MeanExt_umPerMPaPerhour/
    (CurrentPosition.DividingCellCount + CurrentPosition.GrowingCellCount);

  if (formMain.Detailedgraphs1.Checked) and (CurrentPosition.Position_m > 0.1) then begin
     formdetailedgraphs.ChartTurgYTExt.Series[0].addxy(CurrentRunData[LogDay].LogDate,
           CurrentPosition.MeanTurgor_MPa);
     formdetailedgraphs.ChartTurgYTExt.Series[1].addxy(CurrentRunData[LogDay].LogDate,
           CurrentPosition.MeanYT_Mpa);
     formdetailedgraphs.ChartTurgYTExt.Series[2].addxy(CurrentRunData[LogDay].LogDate,
           CurrentPosition.MeanExt_umPerMPaPerhour);
     formdetailedgraphs.ChartTurgYTExt.Series[3].addxy(CurrentRunData[LogDay].LogDate,
           CurrentPosition.MeanMinOP_MPa);
     formdetailedgraphs.ChartTurgYTExt.Series[4].addxy(CurrentRunData[LogDay].LogDate,
           CurrentPosition.CritOP);

  end;

  CurrentPosition.DividingCellCount :=  round(CurrentPosition.DividingCellCount/CellFileCount);
  CurrentPosition.GrowingCellCount :=  round(CurrentPosition.GrowingCellCount/CellFileCount);
  CurrentPosition.ThickeningCellCount :=  round(CurrentPosition.ThickeningCellCount/CellFileCount);
  CurrentPosition.CarbConsumptionCZ_ug := CurrentPosition.CarbConsumptionCZ_ug/CellFileCount;

  if (formMain.Detailedgraphs1.Checked) and (CurrentPosition.Position_m > 0.1) then begin
    formdetailedgraphs.ChartCellCounts.Series[0].AddXY(CurrentRunData[LogDay].LogDate,
      CurrentPosition.DividingCellCount);
    formdetailedgraphs.CHartCellCounts.Series[1].AddXY(CurrentRunData[LogDay].LogDate,
      CurrentPosition.GrowingCellCount);
    formdetailedgraphs.ChartCellCounts.Series[2].AddXY(CurrentRunData[LogDay].LogDate,
      CurrentPosition.ThickeningCellCount);
  end;


  CurrentPosition.CarbConsumptionEZ_ug := CurrentPosition.CarbConsumptionEZ_ug/CellFileCount;
  CurrentPosition.LastRadGrowth_umperday := CurrentPosition.MaxLivingCellPosition_um - PrevMLCP;

  if CurrentPosition.ThickeningCellCount > 0 then begin
    for CellCounter := 0 to LivingCellList.Count-1 do begin

      MyCell := TCell(LivingCellList[CellCounter]);

      if MyCell.Status <> DEAD then begin

        GrowCellWalls(MyCell,
          CurrentTree.MinTemp_degC[LogDay],
          CurrentCAMBIUMParameters);

        if MyCell.Process = STHICK then
          CurrentPosition.CarbConsumptionTZ_ug := CurrentPosition.CarbConsumptionTZ_ug + MyCell.LastCarbConsumption_ug;
      end;
    end;
  end;

  CurrentPosition.CarbConsumptionTZ_ug := CurrentPosition.CarbConsumptionTZ_ug/CellFileCount;

  if CurrentPosition.position_m = MainModellingPosition then
    UpdateDailyDataArray(LogDay,
      CurrentRunData[LogDay].LogDate,
      CurrentRunData,
      DailyDataArray,
      CurrentTree,CurrentPosition);


end;



//******************************************************************************
//Initialisation functions

Procedure CreateInitialCellPopulation(LCL : TObjectList;
  RadialNumber : Integer;
  CurrentTree : TTree;
  CurrentStemPosition : TStemPosition;
  InitialMeanRD: DOuble;
  InitialMeanTD: Double;
  InitialMeanLength: Double;
  InitialXProp:Double;
  CurrentDate : Double;
  CellFiles:Integer;
  Params : TCAMBIUMParameters);
var
  h,i,CurrentCellNumber : Integer;
  NewCell : TCell;
  XylemCells : Integer;
  CumulDist : Double;


begin
  //TempOL := TObjectList.Create;

  SetLength(CurrentStemPosition.InitialCellPositions_um,CellFiles);
  SetLength(CurrentStemPosition.InitialCellNumbers,CellFiles);

  if RadialNumber < 1 then
    RadialNumber := 1;
  if InitialXProp > 0.8 then
    InitialXProp := 0.8;

  XylemCells := Round(RadialNumber * InitialXProp);

  //Only 1 initial

  CurrentCellNumber := 0;

  for h := 0 to CellFiles -1  do begin

    CumulDist := CurrentStemPosition.Diameter_cm*10000/2;

    for i := 0 to RadialNumber - 1 do begin

      NewCell := TCell.Create;
      CurrentCellNumber := CurrentCellNumber + 1;

      NewCell.CellNumber := CurrentCellNumber;
      NewCell.CellFileNumber := h + 1;
      NewCell.FormationDate := CurrentDate;
      //NewCell.CellRD := RandomCellSize(InitialMeanRD,RANDCELLSIZEMIN,RANDCELLSIZEMAX);
      NewCell.CellRD_um := InitialMeanRD;
      NewCell.CellTD_um := InitialMeanTD;
      NewCell.CellLength_um := InitialMeanLength;
      NewCell.CellWT_um := PRIMARYWALLTHICKNESS;
      NewCell.MinLumenSizeReached := false;
      NewCell.DaysSinceCreation := 0;

      NewCell.MeanGR_umperday := 0;
      NewCell.ConsecSlowGrowthDays := 0;

      NewCell.StemPosition := CurrentStemPosition.Position_m;

      NewCell.CellVolume_um3 := BodyVolume(NewCell.CellType,
        NewCell.CellRD_um,NewCell.CellTD_um,NewCell.CellLength_um);
      NewCell.LumenVolume_um3 := BodyVolume(NewCell.CellType,
        NewCell.CellRD_um - NewCell.CellWT_um*2,
        NewCell.CellTD_um - NewCell.CellWT_um*2,
        NewCell.CellLength_um);
      NewCell.CellCSArea_um2 := BodyCSArea(NewCell.CellType,
        NewCell.CellVolume_um3,
        NewCell.CellLength_um);
      NewCell.CellCSLumArea_um2 := BodyCSArea(NewCell.CellType,
        NewCell.LumenVolume_um3,
        NewCell.CellLength_um);

      NewCell.LastCarbAlloc := 1;

      NewCell.CellCycleDur_days := Params.MinCellCycle;

      NewCell.RadPosition_um := CumulDist;
      NewCell.TanPosition_um := h * InitialMeanTD;
      NewCell.Status := MERI;
      NewCell.Process := DIVI;
      NewCell.DaysSinceCZExit := 0;
      NewCell.SumGR_um := 0;
      NewCell.MFA := Params.MaxMFA;

      CumulDist := CumulDist + NewCell.CellRD_um;

      if i < XylemCells then
        NewCell.CellType := XMC;
      if i = XylemCells  then begin
        NewCell.CellType := CINITIAL;

        CurrentStemPosition.InitialCellPositions_um[h] := NewCell.RadPosition_um;
        CurrentStemPosition.InitialCellNumbers[h] := NewCell.CellNumber;

      end;

      if i > XylemCells  then
        NewCell.CellType := PMC;

      if CurrentStemPosition.MaxLivingCellPosition_um <= NewCell.RadPosition_um then
        CurrentStemPosition.MaxLivingCellPosition_um := NewCell.RadPosition_um;

      LCL.Add(NewCell);
    end;
  end;

  CurrentStemPosition.MaxCZCellPosition_um :=  CurrentStemPosition.MaxLivingCellPosition_um;
  CurrentStemPosition.MinCZCellPosition_um :=  0;
  CurrentStemPosition.ConductingXylemPosition_um := 0;

end;


procedure InitialiseModel(InputData: TCAMBIUMInputDataArray;
  InputSite : TSiteData;
  CurrentTree : TTree;
  CurrentPosition : TStemPosition;
  Params: TCambiumParameters);
var
  i : integer;
  WinterSolstice,SummerSolstice : TDate;

begin
  //Reset all variables for the new run

  //initialise position-level variables
  CurrentPosition.ExcessCarbPerFile_g := 0;
  Currentposition.MeanRDCZExit_um := 0;
  CurrentPosition.MeanCellCycleDur_days := 0;
  CurrentPosition.MeanGrowingDays := 0;
  CurrentPosition.MeanThickDays := 0;
  CurrentPosition.MeanCellRD_um := 0;
  CurrentPosition.MeanCellWT_um := 0;
  CurrentPosition.MeanLumVolLivingCells_um3 := 0;
  CurrentPosition.MeanCellLength_um := 0;
  CurrentPosition.CumCarbEZExit_ug := 0;
  CurrentPosition.MeanGrowingDays := 0;
  CurrentPosition.MeanThickDays := 0;
  CurrentPosition.MeanCellCycleDur_days := 0;
  CurrentPosition.MeanMinOP_MPa := 0;
  CurrentPosition.MeanTurgor_MPa := 0;
  CurrentPosition.MeanYT_Mpa := 0;
  CurrentPosition.MeanExt_umPerMPaPerhour := 0;
  CurrentPosition.TotCarbs_gpercellfile := 0;
  CurrentPosition.CumulCarbs_gpercellfile := 0;
  CurrentPosition.TotAux_gpercellfile := 0;
  CurrentPosition.ThinWallCumul := 1;
  CurrentPosition.CurrentMaxCZWidth := 1;
  CurrentPosition.WDSum := 0;
  CurrentPosition.MFASum := 0;
  CurrentPosition.MeanWD_kgperm3 := 500;
  CurrentPosition.MeanMFA_deg := 10;
  CurrentPosition.CurrentMaxTurgorLimit := 0;
  CurrentPosition.RingCount := 0;
  CurrentPosition.MeanCellTD_um := strtofloat(formInitialisation.leTanDiam.Text);
  CurrentPosition.MeanCellRD_um := strtofloat(formInitialisation.leRadDiam.Text);
  CurrentPosition.MeanCellLength_um := strtofloat(formInitialisation.leLength.Text);
  CurrentPosition.EWBuild := True;
  CurrentPosition.LWBuild := false;
  CurrentPosition.MinDLPassed := False;
  CurrentPosition.MaxDLPassed := True;
  CurrentPosition.LWCellCOunter := 0;

  SetLength(CurrentPosition.CarbsDistributionAlpha_MFA,Length(inputdata));

  //Initialis tree-level variables
  CurrentTree.ColdDayCounter := 0;
  CurrentTree.TreeDBUB_cm := Max(MINBASEDIAM_CM,CurrentTree.TreeDBUB_cm);
  CurrentTree.TempAcclimation := 0;
  CurrentTree.MaxSPH := 0;
  CurrentTree.MaxDayLength_h := 0;
  CurrentTree.MinDayLength_h := 9999;
  CurrentTree.DormancyStatus := 1;

  SetLength(CurrentPosition.CellDivisions,0);
  SetLength(CurrentPosition.CellDivisions,length(inputdata));
  setlength(CurrentTree.NPP_kgpertree,length(inputdata));
  setlength(CurrentTree.GPP_kgpertree,length(inputdata));
  setlength(CurrentTree.AllocStem,length(inputdata));
  setlength(CurrentTree.AllocStem_kg,length(inputdata));
  setlength(CurrentTree.AllocLeaves,length(inputdata));
  setlength(CurrentTree.AllocLeaves_kg,length(inputdata));
  setlength(CurrentTree.PDLWP1_MPa,length(inputdata));
  setlength(CurrentTree.PDLWP2_MPa,length(inputdata));
  setlength(CurrentTree.MiddayLWP_MPa,length(inputdata));
  setlength(CurrentTree.DayLength_hours,length(inputdata));
  setlength(CurrentTree.MinTemp_degC,length(inputdata));
  setlength(CurrentTree.MaxTemp_degC,length(inputdata));
  setlength(CurrentTree.MaxTempTomorrow_degC,length(inputdata));
  setlength(CurrentTree.TreeHeight_m,length(inputdata));
  setlength(CurrentTree.TreeDBHOB_cm,length(inputdata));
  setlength(CurrentTree.CrownLength_m,length(inputdata));
  setlength(CurrentTree.FormFactor,length(inputdata));
  setlength(CurrentTree.AllocAreaSpecificCarb_gperum2,length(inputdata));
  setlength(CurrentTree.AllocLengthSpecificCarb_gperum,length(inputdata));
  setlength(CurrentTree.FoliageMass_kg,length(inputdata));
  setlength(CurrentTree.CarbsInPhloem_kg,length(inputdata));

  for i := 0 to length(inputData)-1 do begin
    if inputdata[i].DayLength < CurrentTree.MinDayLength_h then
      CurrentTree.MinDayLength_h := inputdata[i].DayLength;
    if inputdata[i].DayLength > CurrentTree.MaxDayLength_h then
      CurrentTree.MaxDayLength_h := inputdata[i].DayLength;
  end;

  if CurrentTree.MinDayLength_h = CurrentTree.MaxDayLength_h  then begin
    //this code works for CAMBIUM IGM runs, where a full array of day lengths
    //doesn't yet exist
    WinterSolstice := EncodeDate(1950, 12, 21);
    SummerSolstice := EncodeDate(1950, 6, 21);

    //The absolute value of latitude is taken so that it doesn't matter in what
    //hemisphere the site is located.
    CurrentTree.MinDayLength_h := General.GetDayLength(abs(InputSite.Latitude),WinterSolstice);
    CurrentTree.MaxDayLength_h := General.GetDayLength(abs(InputSite.Latitude),SummerSolstice);
    if CurrentTree.MaxDayLength_h <= CurrentTree.MinDayLength_h then begin
      CurrentTree.MaxDayLength_h := CurrentTree.MinDayLength_h + 0.1;
      formWarnings.memowarnings.lines.add('The maximum day length for the site ' +
        'was set to the minimum day length + 0.1');
    end;
  end;
end;

//******************************************************************************


//******************************************************************************
//Main procedures

Procedure UpdateTreeLevelData(InputData: TCAMBIUMInputDataArray;
  InputTree: TTree;
  InputStemPosition : TStemPosition;
  CurrentDay: Integer;
  CurrentDate: TDate;
  Params:TCAMBIUMParameters;
  MaxCRAlloc : Double);

begin

  InputTree.GrowthDay := CurrentDay;

  InputTree.MaxSPH := max(InputData[CurrentDay].SPH,
    InputTree.MaxSPH);

  InputTree.TreeAge := (CurrentDay/365.25);

  //Set the NPP & GPP for the "average tree" today in kg,
  //and subsequently the mass allocated to stem.
  InputTree.NPP_kgpertree[CurrentDay] :=
    (InputData[CurrentDay].NPP_tperha/InputData[CurrentDay].SPH)*1000;
  InputTree.GPP_kgpertree[CurrentDay] :=
    (InputData[CurrentDay].GPP_tperha/InputData[CurrentDay].SPH)*1000;
  InputTree.AllocStem[CurrentDay] :=
    InputData[CurrentDay].etas;
  InputTree.AllocStem_kg[CurrentDay] :=
    InputTree.NPP_kgpertree[CurrentDay] * InputTree.AllocStem[CurrentDay];
  InputTree.AllocLeaves[CurrentDay] :=
    InputData[CurrentDay].etaf;
  InputTree.AllocLeaves_kg[CurrentDay] :=
    InputTree.NPP_kgpertree[CurrentDay] * InputTree.AllocLeaves[CurrentDay];
  InputTree.FoliageMass_kg[CurrentDay] := InputData[CurrentDay].wf/
    InputData[CurrentDay].SPH*1000;

  //Smooth the allocated data assuming a constant phloem loading
  InputTree.CarbsInPhloem_kg[CurrentDay] := GetLagMean(InputTree.AllocStem_kg,
    CurrentDay,PHLOEMLOADINGDAYS);

  //Set pre-dawn and midday leaf water potential (MPa) for the tree today
  InputTree.PDLWP1_Mpa[CurrentDay] := InputData[CurrentDay].PDWP_Mpa;

  if CurrentDay < Length(Inputdata)-1 then
    InputTree.PDLWP2_MPa[CurrentDay] := InputData[CurrentDay + 1].PDWP_Mpa
  else
    InputTree.PDLWP2_Mpa[CurrentDay] := InputData[CurrentDay].PDWP_Mpa;

  InputTree.MiddayLWP_Mpa[CurrentDay] := InputData[CurrentDay].MDWP_Mpa;

  //Set the day length (h) the tree is experiencing
  InputTree.DayLength_Hours[CurrentDay] := InputData[CurrentDay].DayLength;

  //Calculate the day length as a number relative to the shortest day (0) and the longest day (1)
  InputTree.RelDL := min(1,max(0,(InputTree.DayLength_hours[CurrentDay] - InputTree.MinDayLength_h)/
    (InputTree.MaxDayLength_h - InputTree.MinDayLength_h)));

  InputTree.MinTemp_degC[CurrentDay] := InputData[CurrentDay].MinTemp;
  InputTree.MaxTemp_degC[CurrentDay] := InputData[CurrentDay].MaxTemp;

  InputTree.TreeHeight_m[CurrentDay] := InputData[CurrentDay].TreeHt_m;

  if (formMain.Detailedgraphs1.Checked) and (InputStemPosition.Position_m < 0.1) then begin
    formdetailedgraphs.ChartPPTree.Series[0].AddXY(CurrentDate,InputTree.NPP_kgpertree[CurrentDay]);
    formdetailedgraphs.ChartPPTree.Series[1].AddXY(CurrentDate,InputTree.GPP_kgpertree[CurrentDay]);

    //formdetailedgraphs.ChartAllocSL.Series[0].AddXY(CurrentDate,InputTree.AllocStem_kg[CurrentDay]);
    formdetailedgraphs.ChartAllocSL.Series[0].AddXY(CurrentDate,InputTree.CarbsInPhloem_kg[CurrentDay]);
    formdetailedgraphs.ChartAllocSL.Series[1].AddXY(CurrentDate,InputTree.AllocLeaves_kg[CurrentDay]);

    formdetailedgraphs.ChartTemperature.Series[1].AddXY(CurrentDate,
      InputTree.MinTemp_degC[CurrentDay]);
    formdetailedgraphs.ChartTemperature.Series[2].AddXY(CurrentDate,
      InputTree.MaxTemp_degC[CurrentDay]);

  end;

  //Calculate the cambial surface area over which to "smear" the daily allocated NPP
  InputTree.CambialSurfaceArea_m2 := CambiumSurfaceArea(InputTree.TreeDBUB_cm/100,
    BASEPOS,
    power(InputTree.TreeHeight_m[CurrentDay],1));

  InputTree.AllocAreaSpecificCarb_gperum2[CurrentDay] := GetAreaSpecificCarbAllocation_gperum2(InputTree.CarbsInPhloem_kg[CurrentDay]*1000,
      InputTree.CambialSurfaceArea_m2);

  InputTree.AllocLengthSpecificCarb_gperum[CurrentDay] :=
    (InputTree.CarbsInPhloem_kg[CurrentDay] * 1000)/
      (InputTree.TreeHeight_m[CurrentDay] * 1000000);

  if (formMain.Detailedgraphs1.Checked) and (InputStemPosition.Position_m < 0.1) then begin
    formdetailedgraphs.ChartHtD.Series[0].AddXY(CurrentDate,InputTree.TreeHeight_m[CurrentDay]);
    //formdetailedgraphs.ChartHtD.Series[1].AddXY(CurrentDate,
      //InputTree.TreeHeight_m[CurrentDay]-InputTree.CrownLength_m[CurrentDay]);

    formdetailedgraphs.ChartHtD.Series[2].AddXY(CurrentDate,InputTree.TreeDBUB_cm);

    formdetailedgraphs.CHartVolSA.Series[0].AddXY(CurrentDate,InputTree.TreeVolume_m3);
    formdetailedgraphs.ChartVolSA.Series[1].AddXY(CurrentDate,InputTree.CambialSurfaceArea_m2*1000000);
    formdetailedgraphs.ChartCarbAuxinToday.Series[1].AddXY(CurrentDate,
      InputTree.AllocAreaSpecificCarb_gperum2[CurrentDay]*1000000);

  end;
end;

//******************************************************************************
//Functions to update stem position-level variables, including means

Procedure UpdateStemPositionLevelData(InputTree : TTree;
  InputStemPosition : TStemPosition;
  CurrentDay : INteger;
  CurrentDate : TDate;
  Params:TCAMBIUMParameters;
  TotalModelledCellCount : Integer);
Var

  PressureDiff_MPa : Double;

begin

  {$R- Turn on range checking}

  //these are status variables which record if the tree has most recently
  //experienced the longest or the shortest day, which will impact on its
  //readiness to enter a period of EW or LW production
  if (InputStemPosition.MaxDLPassed=False) and
    (InputTree.DayLength_hours[CurrentDay] >= InputTree.MaxDayLength_h*0.95) then
    InputStemPosition.MaxDLPassed := true;
  if (InputStemPosition.MinDLPassed=False) and
    (InputTree.DayLength_hours[CurrentDay] <= InputTree.MinDayLength_h*1.05) then
    InputStemPosition.MinDLPassed := true;

  if (InputStemPosition.EWBuild = True) and
    (InputTree.RelDL < 0.95) and//Params.RelDLLW) and
    (InputStemPosition.MaxDLPassed = True)  then begin
    //Only if the tree has most recently experienced the longest day, and the day length
    //on day d is less than the critical level will it enter the phase of LW production
    InputStemPosition.LWBuild := true;
    InputStemPosition.EWBuild := false;
    InputStemPosition.RingCount := InputStemPosition.RingCount + 1;
    InputStemPosition.MinDLPassed := false;
  end;

  if (InputStemPosition.LWBuild = True) and
    (InputTree.RelDL > 0.05) and //Params.RelDLEW) and
    (InputStemPosition.MinDLPassed = True) then begin
    //Only if the tree has most recently experienced the shortest day, and the day length
    //on day d is greater than the critical level will it enter the phase of EW production
    InputStemPosition.EWBuild := true;
    InputStemPosition.LWBuild := false;
    //if InputStemPosition.RingCount > 5 then
      //InputStemPosition.CurrentMaxEZWidth := Params.MaxEZWidth;
    InputStemPosition.MaxDLPassed := false;
    InputStemPosition.LWCellCounter := 0;
    //InputStemPosition.MinEZWAchieved := false;
  end;

  if InputStemPosition.LWBuild = True then
    InputStemPosition.LWCellCounter := InputStemPosition.LWCellCounter + Params.ExtractionFactor;


  //Calculate stem underbark diameter and circumference at the modeled point.
  InputStemPosition.Diameter_cm :=  max(InputStemPosition.Diameter_cm,
    2 * InputStemPosition.MaxLivingCellPosition_um/10000);

  InputStemPosition.Circumference_um :=  2 * pi * InputStemPosition.Diameter_cm/2*10000;


  //The amount of carbohydrate available to each modeled cell file is calculated
  //based on the known "area-specific" amont of carbs (calculated previously in this day step)
  //and a calculated "face area" based on the average length/tan width of the dividing and growing cells
  InputStemPosition.TotCarbs_gpercellfile := GetCarbMassPerCellFile(InputTree.AllocAreaSpecificCarb_gperum2[CurrentDay],
    InputStemPosition.MeanCellTD_um,
    InputStemPosition.MeanCellLength_um);
    //((((1.2 - 0.8)*(InputStemPosition.Position_m))/(INputTree.TreeHeight_m[CurrentDay])) + 0.8);

  {InputStemPosition.TotCarbs_gpercellfile := InputTree.AllocLengthSpecificCarb_gperum[CurrentDay] *
   InputStemPosition.MeanCellLength_um /
   (InputStemPosition.Circumference_um/(InputStemPosition.MeanCellTD_um));}

  InputStemPosition.CumulCarbs_gpercellfile := InputStemPosition.CumulCarbs_gpercellfile +
    InputStemPosition.TotCarbs_gpercellfile;

  //Calculate the effect of a height-related effect on xylem water potential at the modeled position.
  //This assumes that leaf water potential fed into the model has already taken ht into account.
  //PressureDiff_Mpa := max(0,(InputTree.TreeHeight_m[CurrentDay] - InputStemPosition.Position_m)) * 0.01;

  PressureDiff_MPa := 0;

  //Calculated the pre-dawn and midday xylem WP at the modeled position, taking into
  //account any height effect
  InputStemPosition.PDXWP1_Mpa := min(-0.1,
    InputTree.PDLWP1_Mpa[CurrentDay] + PressureDiff_Mpa);
  InputStemPosition.PDXWP2_Mpa := min(-0.1,
    InputTree.PDLWP2_Mpa[CurrentDay]);
  InputStemPosition.MXWP_MPa := min(InputTree.PDLWP1_Mpa[CurrentDay],
    InputTree.MiddayLWP_Mpa[CurrentDay] + PressureDiff_Mpa);

  //modify target turgor slightly under the assumption that cells in the youngest part of the
  //canopy will have a lower target turgor.
  //This idea comes mostly from a need to match small cells with thinner walls at
  //the pith
  InputStemPosition.CurrentMaxTurgorLimit := Params.MinTurgor;

  //A frost effect is calculated assuming that on very cold mornings,
  //protection for cells is required
  InputStemPosition.fFrostDanger := General.LowTempFunction(-5,
    Max(-1,Params.MinTemp),
    InputTree.MinTemp_degC[CurrentDay]);

  InputStemPosition.FrostProtectionOP := InputStemPosition.fFrostDanger*Params.MinOP;
  //InputStemPosition.FrostProtectionOP := 0;
  //InputStemPosition.CritOP := Max(Params.MinOP,Min((InputStemPosition.PDXWP1_MPa + InputStemPosition.PDXWP1_MPa)/2  -
  InputStemPosition.CritOP := Max(Params.MinOP,Min(InputStemPosition.PDXWP1_MPa  -
    InputStemPosition.CurrentMaxTurgorLimit,
    InputStemPosition.FrostProtectionOP)) ;

  if TotalModelledCellCount > 0 then begin

    InputStemPosition.MeanWD_kgperm3 := InputStemPosition.WDSum/
      TotalModelledCellCount;

    InputStemPosition.MeanMFA_deg := InputStemPosition.MFASum/
      TotalModelledCellCount;
  end;

  if InputStemPosition.MeanWD_kgperm3 <=0 then
    InputStemPosition.MeanWD_kgperm3 := 100;

  InputStemPosition.MeanMOE_GPa := CalculateMOE(Params.b0MOE,
    Params.b1MOE,
    InputStemPosition.MeanWD_kgperm3,
    InputStemPosition.MeanMFA_deg);

  if (formMain.Detailedgraphs1.Checked) and (InputStemPosition.Position_m > 0.1) then begin


    formdetailedgraphs.ChartDistAlpha.Series[1].AddXY(CurrentDate,
      InputStemPosition.CarbsDistributionAlpha);

    formdetailedgraphs.ChartTotAuxCarbsPerFile.Series[0].AddXY(CurrentDate,
      InputStemPosition.TotCarbs_gpercellfile*1000000000);
    formdetailedgraphs.ChartTotAuxCarbsPerFile.Series[1].AddXY(CurrentDate,
      InputStemPosition.CumulCarbs_gpercellfile*1000000);


    formdetailedgraphs.ChartXPP.Series[0].AddXY(CurrentDate,
      InputStemPosition.PDXWP1_Mpa);
    formdetailedgraphs.ChartXPP.Series[1].AddXY(CurrentDate,
      InputStemPosition.MXWP_Mpa);

    formdetailedgraphs.ChartDL.Series[0].AddXY(CurrentDate,
      InputTree.DayLength_hours[CurrentDay]);

  end;

  if (formMain.Detailedgraphs1.Checked) and (InputStemPosition.Position_m > 0.1) then begin
    formdetailedgraphs.ChartHtD.Series[3].AddXY(CurrentDate,InputStemPosition.Diameter_cm);

  end;

end;

Function GetMaxCumulCarb(MinOP,CritOP,
  LumVol,VacFac,MinT,MaxT: Double): Double;
var
  test,input: double;
begin
  test := 0;
  input := 0.01;

  while (test >= CritOP) and
    (test >= MinOP) do begin

    input := input + 0.01;

    test := OPCell(Input,
            LumVol,
            VacFac,
            (MinT + MaxT)/2,
            -999,-0.1);
  end;
  Result := Input;
end;

Procedure AllocateResources(MyLivingCellList: TObjectList;
  CurrStemPos: TStemPosition;
  CurrTree : TTree;
  CurrDay : Integer;
  CurrMonth: Integer;
  MyParams: TCambiumParameters;
  TotalCellFiles : Integer;
  RecycleStoredCarbs : Boolean);
var
  i,j : integer;
  MyCell : TCell;
  RemCarb_ug : Double;
  MaxParam,MaxParamMFA : DOuble;
  MyMaxCC,ActualAlloc : double;
  WallThickMod: Double;
  CellCounter : integer;

begin
  if RecycleStoredCarbs then
    RemCarb_ug := (CurrStemPos.TotCarbs_gpercellfile +
      CurrStemPos.ExcessCarbPerFile_g)
      * 1000000
  else
    RemCarb_ug := (CurrStemPos.TotCarbs_gpercellfile) * 1000000;

  MaxParam := 0.5;
  MaxParamMFA := 1;

  if CurrStemPos.EWBuild then
    CellCounter := CurrStemPos.DividingCellCount +
      CurrStemPos.GrowingCellCOunt
  else
    CellCounter := CurrStemPos.DividingCellCount +
      CurrStemPos.GrowingCellCOunt +
      //min(round(CurrTree.TreeHeight_m[CurrDay]-CurrStemPos.Position_m),
        //min(CurrStemPos.ThickeningCellCount,CurrStemPos.LWCellCounter));
      min(CurrStemPos.ThickeningCellCount,round(CurrStemPos.LWCellCounter/MyParams.MaxTRD));


  //A parameter is calculated here which relates to the rate of carbohydrate allocation
  //to cells progressively further from the phloem: for a given quantity of available
  //carbs, this rate will differ for a large zone compared to a small zone of cells

  CurrStemPos.CarbsDistributionAlpha :=
    GetCurveParameter(CellCOunter,
    RemCarb_ug,
    //MyParams.ExtractionFactor,
    0,
    MaxParam);

  //A slightly different calculation is used for the parameter which is later used for
  //the calculation of MFA.
  {CurrStemPos.CarbsDistributionAlpha_MFA[CurrDay] :=
    GetCurveParameter(max(3,CurrStemPos.DividingCellCount +
      CurrStemPos.GrowingCellCOunt),
    RemCarb_ug,
    0,
    MaxParamMFA);    }

  CurrStemPos.CarbsDistributionAlpha_MFA[CurrDay] :=
    CurrStemPos.CarbsDistributionAlpha;

  MyLivingCellList.Sort(CompareByRadPosition);

  for i := 1 to TotalCellFiles do begin

    for j := MyLivingCellList.Count - 1 downto 0  do begin

      MyCell :=  TCell(MyLivingCellList[j]);

      {WallThickMod := 1 - min(1,max(0,((MyCell.CellCSArea_um2 - MyCell.CEllCSLumArea_um2)/MyCell.CellCSArea_um2)/
        MyParams.MaxWallRatio));}

      WallThickMod := 1;

      if MyCell.CellFileNumber = i then begin

        MyMaxCC := GetMaxCumulCarb(MyParams.MinOP,MyParams.MinOP,
          MyCell.LumenVolume_um3,
          MyParams.VacFactor,
          CurrTree.MinTemp_degC[CurrDay],
          CurrTree.MaxTemp_degC[CurrDay]);

        MyCell.LastCarbAlloc := 0;

        if (MyCell.Process = DIVI) or (MyCell.Process = GROW) or (MyCell.Process = STHICK) then begin

          ActualAlloc := WallThickMod *
            Min(max(0,MyMaxCC - MyCell.CumulCarb_ug),(RemCarb_ug * CurrStempos.CarbsDistributionAlpha));

          MyCell.CumulCarb_ug := MyCell.CumulCarb_ug +
            ActualAlloc;

          MyCell.LastCarbAlloc := ActualAlloc;

          if (formMain.Detailedgraphs1.Checked) and (CurrStemPos.Position_m > 0.1) then
            formdetailedgraphs.chartalloccarb.series[0].addxy(MyCell.RadPosition_um,
            RemCarb_ug*CurrStempos.CarbsDistributionAlpha);

          RemCarb_ug := RemCarb_ug - ActualAlloc;

          MyCell.OsmoticPotential := OPCell(MyCell.CumulCarb_ug,
            MyCell.LumenVolume_um3,
            MyParams.VacFactor,
            (CurrTree.MinTemp_degC[CurrDay] + CurrTree.MaxTemp_degC[CurrDay])/2,
            -999,-0.1);

        end;
      end;
    end;

    CurrStemPos.ExcessCarbPerFile_g := RemCarb_ug / 1000000;

  end;
end;

Procedure GetLivingMeans(MyLivingCellList: TObjectList;
  MyStemPos: TStemPosition);
var
  j,AllCellCounter,GrowingCellCOunter: Integer;
  MyCell: TCell;
  MyOPSum,MyRDSum,MyTDSum,MyLSum,MyLVSum: Double;
begin
  MyOPSum := 0;
  AllCellCounter := 0;
  GrowingCellCounter := 0;
  MyRDSum := 0;
  MyTDSum := 0;
  MyLSum := 0;
  MyLVSum := 0;

  for j := MyLivingCellList.Count - 1 downto 0  do begin

    MyCell :=  TCell(MyLivingCellList[j]);

    if mycell.process <> STHICK then begin
      AllCellCounter := AllCellCounter + 1;

      MyOPSum := MyOPSum +
        MyCell.OsmoticPotential;
      MyTDSum := MyTDSum + MyCell.CellTD_um;
      MyLSum := MyLSum + MyCell.CellLength_um;
      MyLVSum := MyLVSum + MyCell.LumenVolume_um3;


      if MyCell.Process = GROW then begin
        GrowingCellCOunter := GrowingCellCOunter + 1;
        MyRDSum := myRDSum + MyCell.CellRD_um;
      end;
    end;
  end;

  if AllCellCounter > 0 then begin
    MyStemPos.MeanMinOP_MPa := MyOPSum/AllCellCounter;
    MyStemPos.MeanCellTD_um := MyTDSum/AllCellCounter;
    MyStemPos.MeanCellLength_um := MyLSum/AllCellCounter;
    MyStemPos.MeanLumVolLivingCells_um3 := MyLVSum/AllCellCOunter;

  end else begin
    MyStemPos.MeanMinOP_MPa := 0;
    formWarnings.memoWarnings.Lines.Add('Zero cell count found for means calculations')
  end;

  if GrowingCellCounter > 0 then
    MyStemPos.MeanRDGrowingCells_um := MyRDSum/GrowingCellCounter
  else
    MyStemPos.MeanRDGrowingCells_um := 0;

end;


Procedure DetermineCells(CurrentCell : TCell;
  CurrLivingCellList: TObjectList;
  CurrentTree:TTree;
  CurrentStemPosition:TStemPosition;
  Params:TCAMBIUMParameters;
  Currentdate: TDate;
  CurrentDay : Integer);
var

  SizeEffectMFA : Double;
  mystartday,i : integer;
  MyJE,MyEZCZRatio : DOuble;
  SR: Double;


begin
  CurrentCell.DistFromInitial := max(0,Round(CurrentStemPosition.InitialCellPositions_um[CurrentCell.CellFileNumber-1] -
      CurrentCell.RadPosition_um));
  CurrentCell.DistFromCambiumEdge :=  max(0,Round(CurrentStemPosition.MinCZCellPosition_um -
      CurrentCell.RadPosition_um));
  MyJE := GetJuvenileEffect(CurrentTree.TreeHeight_m[CurrentDay],
      CurrentStemPosition.Position_m,
      Params.JuvenileCoreFactor,
      0.5,1);
  //MyEZCZRatio := min(1.25,max(0.75,CurrentSTemPosition.DividingCellCount/8)) *
    //Params.EZCZRatio  * MyJE;
  MyEZCZRatio := Params.EZCZRatio  * MyJE;

  //MyEZCZRatio := Params.EZCZRatio  * MyJE;

  if CurrentCell.Status <> DEAD then begin

    CurrentCell.DaysSinceCreation := CurrentCell.DaysSinceCreation + 1;

    if (formMain.Detailedgraphs1.Checked) and (CurrentStemPosition.Position_m > 0.1) then begin

      if CurrentCell.Status = MERI then
        formdetailedgraphs.ChartCellCarbs.Series[0].AddXY(CurrentCell.RadPosition_um,
          CurrentCell.CumulCarb_ug);
      if currentcell.Process = GROW then
        formdetailedgraphs.ChartCellCarbs.Series[1].AddXY(CurrentCell.RadPosition_um,
          CurrentCell.CumulCarb_ug);
      if currentcell.Process = STHICK then
        formdetailedgraphs.ChartCellCarbs.Series[2].AddXY(CurrentCell.RadPosition_um,
          CurrentCell.CumulCarb_ug);

      if CurrentCell.CellVolume_um3 > 0 then
        formdetailedgraphs.ChartCellCarbs.Series[3].AddXY(CurrentCell.RadPosition_um,
          CurrentCell.CumulCarb_ug/CurrentCell.CellVolume_um3)
      else
        formdetailedgraphs.ChartCellCarbs.Series[3].AddXY(CurrentCell.RadPosition_um,
          CurrentCell.CumulCarb_ug);
    end;

    if (CurrentCell.CellType <> CINITIAL) and
      (CurrentStemPosition.CZReduced <= 99) and
      (Currentcell.Status = MERI) and
      ((round(CurrentCell.RadPosition_um) <= round(CurrentStemPosition.MinCZCellPosition_um)) and
      //(CurrentStemPosition.DividingCellCount > CurrentStemPosition.CurrentMaxCZWidth)) or
      (CurrentStemPosition.GrowingCellCount/CurrentStemPosition.DividingCellCount <
        MyEZCZRatio)) or
      //(CurrentStemPosition.DividingCellCount > MAXCZWIDTH) or
      //(CurrentStemPosition.GrowingCellCount < 3)) or
      //(CurrentCell.Status = DIFF) or
      (CurrentCell.CellType = PMC) then begin

      CurrentStemPosition.DividingCellCount := CurrentStemPosition.DividingCellCount - 1;
      CurrentStemPosition.CZReduced := CurrentStemPosition.CZReduced + 1;

      if CurrentCell.CellType=PMC then begin
        CurrentCell.CellType :=PCELL;
        CurrentCell.Status := DEAD;
        CurrentCell.Process := NONE;
      end else if CurrentCell.CellType=XMC then begin

        if round(CurrentCell.RadPosition_um) = round(CurrentStemPosition.MinCZCellPosition_um) then
          CurrentStemPosition.MinCZCellPosition_um := CurrentCell.RadPosition_um +
            CurrentCell.CellRD_um;

        CurrentCell.CellType := XCELL;
        CurrentCell.Status:= DIFF;
        CurrentCell.Process := GROW;
        CurrentStemPosition.GrowingCellCount := CurrentStemPosition.GrowingCellCount + 1;

        if (formMain.Detailedgraphs1.Checked) and (CurrentStemPosition.Position_m > 0.1) then begin
          formdetailedgraphs.ChartAuxConcCZExit.series[1].addxy(CurrentDate,
            CurrentCell.CellRD_um);
          formdetailedgraphs.chartcarbconcincell.series[1].addxy(CurrentDate,
            CurrentCell.CumulCarb_ug*1000/CurrentCell.LumenVolume_um3);
          formdetailedgraphs.Chart_Turg_CellNum.series[0].addxy(CurrentCell.CellNumber,
            CurrentCell.MeanTurgor_MPa);
        end;
      end;
    end;


    if (round(CurrentCell.RadPosition_um) <= round(CurrentStemPosition.MinGrowingCellPosition_um))
      and (CurrentStemPosition.EZReduced <= 99)
      and (CurrentCell.Process=GROW)
      //and ((CurrentCell.CellRD_um > Params.MaxTRD*0.5) or
        //  (Currenttree.RelDl <= 0.75))
      and ((CurrentStemPosition.MeanMinOP_MPa > CurrentStemPosition.CritOP)
      and (CurrentCell.GrowingDays >= MINGROWINGDAYS)
      or (CurrentCell.GrowingDays > MAXGROWINGDAYS)) then begin

      if round(CurrentCell.RadPosition_um) = round(CurrentStemPosition.MinGrowingCellPosition_um) then
        CurrentStemPosition.MinGrowingCellPosition_um := CurrentCell.RadPosition_um +
          CurrentCell.cellrd_um;

      CurrentStemPosition.GrowingCellCount := CurrentStemPosition.GrowingCellCount - 1;
      CurrentStemPosition.EZReduced := CurrentStemPosition.EZReduced + 1;
      CurrentStemPosition.ThickeningCellCount := CurrentStemPosition.ThickeningCellCount + 1;
      CurrentStemPosition.StoppedGrowingTodayCount := CurrentStemPosition.StoppedGrowingTodayCount + 1;
      CurrentStemPosition.SumGrowingDays := CurrentStemPosition.SumGrowingDays +
        CurrentCell.GrowingDays;

      CurrentCell.GrowthStopDate := CurrentDate;

      CurrentCell.Process := STHICK;

      SizeEffectMFA := 0;

      if CurrentStemPosition.CumulCDAlpha < 0.00001 then
        CurrentStemPosition.CumulCDAlpha := CurrentStemPosition.CarbsDistributionAlpha_MFA[CurrentDay]
      else
        CurrentStemPosition.CumulCDAlpha := CurrentStemPosition.CumulCDAlpha*0.85 +
          0.15 * CurrentStemPosition.CarbsDistributionAlpha_MFA[CurrentDay];

      SR:=max(1,CurrentStemPosition.Diameter_cm/
        max(1,(CurrentTree.TreeHeight_m[CurrentDay] - CurrentStemPosition.Position_m)));
      //SR := 1;
      //SR := (CurrentTree.TreeHeight_m[CurrentDay]/60)/(CurrentTree.TreeDBUB_cm/100);


      //CurrentStemPosition.MeanMFA_deg
      CurrentCell.MFA := min(1,max(0.5,1-(CurrentStemPosition.RingCount/40))) *
        CalculateMFA(CurrentStemPosition.MeanMFA_deg * 0.5,Params.MaxMFA,
        Params.MFAFactor*SR,max(SizeEffectMFA,
        CurrentStemPosition.CumulCDAlpha));

      if (formMain.Detailedgraphs1.Checked) and (CurrentStemPosition.Position_m > 0.1) then begin
        formdetailedgraphs.chartcarbconcincell.series[0].addxy(CurrentDate,
          CurrentCell.CumulCarb_ug*1000/CurrentCell.LumenVolume_um3);
        formDetailedGraphs.Chart_OP_CumCarb_CellNum.Series[0].AddXY(CurrentCell.CellNumber,
          CurrentCell.OsmoticPotential);
        formDetailedGraphs.Chart_OP_CumCarb_CellNum.Series[1].AddXY(CurrentCell.CellNumber,
          CurrentCell.CumulCarb_ug);
        formdetailedgraphs.Chart_Turg_CellNum.series[1].addxy(CurrentCell.CellNumber,
          CurrentCell.MeanTurgor_MPa);
        formdetailedgraphs.Chart_ThickDur_CellNum.series[1].addxy(CurrentCell.CellNumber,
          CurrentCell.CumulCarb_ug/CurrentCell.LumenVolume_um3);
      end;
    end;

    if (round(CurrentCell.RadPosition_um) <= round(CurrentStemPosition.MinLivingCellPosition_um)) and
      (CurrentStemPosition.TZReduced <= 99) and
      (CurrentCell.Process = STHICK) and
      ((CurrentCell.MinLumenSizeReached = true) or
      //(CurrentStemPosition.ThickeningCellCount > 100) or
      (CurrentCell.DaysSinceSecThick >= 60) or
      //(CurrentCell.DaysSinceSecThick >= max(20,(1 - max(0,min(1,CurrentCell.DistFromInitial/2500))) * 60))) then begin
      ((CurrentCell.CumulCarb_ug/1000000)/(CurrentCell.LumenVolume_um3*power(10,-12))
        < Params.CritConcCellDeath)) then begin
      //(CurrentCell.TotalProtease > Params.CritConcCellDeath)) then begin
      //(CurrentCell.DaysSinceCreation > Params.CritConcCellDeath)) then begin

      if round(CurrentCell.RadPosition_um) = round(CurrentStemPosition.MinLivingCellPosition_um) then
        CurrentStemPosition.MinLivingCellPosition_um := CurrentCell.RadPosition_um +
          CurrentCell.cellrd_um;

      if CurrentCell.CellWT_um < 1.2 then
        CurrentCell.CellWT_um := 1.2;

      CurrentStemPosition.ThickeningCellCount := CurrentStemPosition.ThickeningCellCount - 1;
      CurrentStemPosition.TZReduced := CurrentStemPosition.TZReduced + 1;
      CurrentStemPosition.StoppedThickTodayCount := CurrentStemPosition.StoppedThickTodayCount + 1;
      CurrentStemPosition.SumThickDays := CurrentStemPosition.SumThickDays +
        CurrentCell.DaysSinceSecThick;

      CurrentCell.Status := DEAD;
      CurrentCell.Process := NONE;

      CurrentStemPosition.WDSum := CurrentStemPosition.WDSum +
        CalculateDensity(CurrentCell.CellVolume_um3,
          CurrentCell.LumenVolume_um3,
          Params.WallDensity);

      CurrentStemPosition.MFASum := CurrentStemPosition.MFASum +
        CurrentCell.MFA;

      //We assume that all remaining carbohydrates are lost into the sap stream
      //CurrentStemPosition.ExcessCarbPerFile_g := CurrentStemPosition.ExcessCarbPerFile_g +
        //CurrentCell.CumulCarb_ug/1000000;
      CurrentCell.CumulCarb_ug := 0;

      CurrentCell.Apoptosisdate := CurrentDate;

      if (formMain.Detailedgraphs1.Checked) and (CurrentStemPosition.Position_m > 0.1) then begin

        formdetailedgraphs.Chart_ThickDur_CellNum.series[0].addxy(CurrentCell.CellNumber,
          CurrentCell.DaysSinceSecThick);
        formdetailedgraphs.ChartTRDWTDead.Series[0].AddXY(CurrentCell.RadPosition_um,
          CurrentCell.CellRD_um);
        formdetailedgraphs.ChartTRDWTDead.Series[1].AddXY(CurrentCell.RadPosition_um,
          CurrentCell.CellWT_um);
        formdetailedgraphs.ChartLengthVolDead.Series[0].AddXY(CurrentCell.RadPosition_um,
          CurrentCell.CellLength_um);
        formdetailedgraphs.ChartLengthVolDead.Series[1].AddXY(CurrentCell.RadPosition_um,
          CurrentCell.CellVolume_um3);
        formdetailedgraphs.chartExcessCarbs.series[0].addxy(CurrentDate,
          CurrentStemPosition.ExcessCarbPerFile_g*1000000);
        formdetailedgraphs.Chart_WTRD_CellNum.Series[0].AddXY(CurrentCell.CellNumber,
          CurrentCell.CellWT_um);
        formdetailedgraphs.Chart_WTRD_CellNum.Series[1].AddXY(CurrentCell.CellNumber,
          CurrentCell.CellRD_um);

        formDetailedGraphs.Chart_TRD_WT_TimeAxis.Series[0].AddXY(CurrentCell.Apoptosisdate,
          CurrentCell.CellRD_um);
        formDetailedGraphs.Chart_TRD_WT_TimeAxis.Series[1].AddXY(CurrentCell.Apoptosisdate,
          CurrentCell.CellWT_um);
      end;
    end;
    if CurrentCell.Status = DIFF then begin
      CurrentCell.DaysSinceCZExit := CurrentCell.DaysSinceCZExit + 1;
      if CurrentCell.Process = GROW then
        CurrentCell.GrowingDays := CurrentCell.GrowingDays + 1;
      if CurrentCell.Process = STHICK then begin
        CurrentCell.DaysSinceSecThick := CurrentCell.DaysSinceSecThick + 1;
        //CurrentCell.TotalProtease := CurrentCell.TotalProtease + 1;
      end;
    end;
  end;
end;

Function CalculateMFA(MyMinMFA,MyMaxMFA: Double;
  MFAAdjustmentFactor: Double;
  CarbsDistAlpha : Double): Double;

begin
  Result := max(MyMinMFA,(1-power(CarbsDistAlpha,MFAAdjustmentFactor))*
            MyMaxMFA);
end;

Function CalculateMFA_CZW(MyMinMFA,MyMaxMFA: Double;
  MaxWidth,CurrWidth: DOuble;
  MFAAdjustmentFactor: Double): Double;
var
  fWidth : DOuble;
begin
  fWidth := power(max(0,min(1,CurrWidth/MaxWidth)),MFAAdjustmentFactor);
  Result := Max(MyMinMFA,MyMaxMFA * fWidth);

end;

procedure KillCells(CurrentCell : TCell;
      LivingCellList: TObjectList;
      DeadCellList : TObjectList;
      CurrentTree : TTree;
      CurrentStemPosition: TStemPosition;
      CurrentDate : TDate);
begin
  if (CurrentCell.CellType <> PCELL) and (CurrentCell.CellType <> PMC) then begin
    CurrentStemPosition.ConductingXylemPosition_um := Max(CurrentStemPosition.ConductingXylemPosition_um,
      CurrentCell.RadPosition_um);

    DeadCellList.ownsobjects := false;
    DeadCellList.Add(CurrentCell);
    DeadCellList.ownsobjects := true;
    LivingCellList.OwnsObjects := false;
    LivingCellList.Remove(CurrentCell);
    LivingCellList.OwnsObjects := true;
  end else begin
    LivingCellList.OwnsObjects := false;
    LivingCellList.Remove(CurrentCell);
    LivingCellList.OwnsObjects := true;
  end;
end;

Function GetJuvenileEffect(TreeHt_m: Double;
  ModPos_m: Double;
  JuvFactor_m: Double;
  MyMin,MyMax: Double): Double;
begin
  Result := max(MyMin,min(MyMax,max(0,(TreeHt_m -
        ModPos_m))/JuvFactor_m));
end;

Procedure DivideCells(CurrentCell : TCell;
  CurrentCellList : TObjectList;
  CurrentTree : TTree;
  CurrentStemPosition : TStemPosition;
  TotalModelledCells : Integer;
  CurrentDate : TDate;
  CurrentDay : Integer;
  Params : TCAMBIUMParameters);
var
  NewCell : TCell;
  PotentialCPV : DOuble;
  MinDD : Double;
  MyJE: Double;
const
  CPW = 0.05;

begin
  CurrentCell.LastCarbConsumption_ug := 0;

    MyJE := GetJuvenileEffect(CurrentTree.TreeHeight_m[CurrentDay],
      CurrentStemPosition.Position_m,
      Params.JuvenileCoreFactor,
      0.7,1);


  if (CurrentTree.DormancyStatus = 1) and
    ((CurrentTree.MinTemp_degC[CurrentDay] + CurrentTree.MaxTemp_degC[CurrentDay])/2> Params.MinTemp) then begin
    //((CurrentStemPosition.GrowingCellCount/CurrentStemPosition.DividingCellCount >=
      //  Params.EZCZRatio * MyJE) or (CurrentStemPosition.GrowingCellCount=0)) then begin

    if (CurrentCell.Status = MERI) then begin

      {CurrentCell.CellCycleDur_days := (Params.MinCellCycle +
        20 *
        //(max(0,min(1,(CurrentCell.DistFromInitial/CurrentStemPosition.MaxCZCellPosition_um))))*
        GetJuvenileEffect(CurrentTree.TreeHeight_m[CurrentDay],
          CurrentStemPosition.Position_m,
          Params.JuvenileCoreFactor,
          0,1));  }

      MinDD := Params.MinDDivision +
        (2 * GetJuvenileEffect(CurrentTree.TreeHeight_m[CurrentDay],
          CurrentStemPosition.Position_m,
          Params.JuvenileCoreFactor,
          0,1));

      CurrentCell.CellCycleDur_days := Params.MinCellCycle;
      //MinDD := Params.MinDDivision;

      PotentialCPV := CurrentCell.CellLength_um * CurrentCell.CellTD_um * CPW;

      if (CurrentCell.CellRD_um >= MinDD) and
        (CurrentCell.TimeSinceMitosis_days > CurrentCell.CellCycleDur_days) and
        (CurrentCell.CumulCarb_ug  > VolumetoMass(PotentialCPV,Params.WallDensity)*1000000*2) then begin
        //((CurrentStemPosition.GrowingCellCount/CurrentStemPosition.DividingCellCount >=
          //Params.EZCZRatio * MyJE)
         //or (CurrentStemPosition.GrowingCellCount <=0)) then begin

        CurrentStemPosition.DividingCellCount := CurrentStemPosition.DividingCellCount + 1;
        CurrentStemPosition.DividedTodayCount := CurrentStemPosition.DividedTodayCount + 1;
        CurrentStemPosition.SumCellCycleDur_days := CurrentStemPosition.SumCellCycleDur_days +
          CurrentCell.TimeSinceMitosis_days;

        CurrentCell.CumulCarb_ug  := max(0,CurrentCell.CumulCarb_ug -
          VolumetoMass(PotentialCPV,Params.WallDensity)*1000000*2);

        CurrentCell.LastCarbConsumption_ug :=  VolumetoMass(PotentialCPV,Params.WallDensity)*1000000;

        NewCell := TCell.Create;
        NewCell.FormationDate := CurrentDate;
        NewCell.SumGR_um := 0;

        NewCell.CellNumber := TotalModelledCells + 1;
        NewCell.MotherCell := CurrentCell.CellNumber;
        NewCell.Status := MERI;
        NewCell.Process := DIVI;
        NewCell.MinLumenSizeReached := false;
        NewCell.TotalProtease := 0;
        NewCell.DaysSinceCreation := 0;
        NewCell.DaysSinceCZExit := 0;
        NewCell.DaysSinceSecThick := 0;
        NewCell.GrowingDays := 0;

        NewCell.CellTD_um := CurrentCell.CellTD_um;
        if formMain.Cellplatepositionrandomised1.Checked = true then
          NewCell.CellRD_um := CurrentCell.CellRD_um - RandomCellSize(CurrentCell.CellRD_um,RANDDIVISIONMIN,RANDDIVISIONMAX)
        else
          NewCell.CellRD_um := CurrentCell.CellRD_um/2;
        CurrentCell.CellRD_um := CurrentCell.CellRD_um - NewCell.CellRD_um;
        NewCell.CellWT_um := CurrentCell.CellWT_um;

        NewCell.TanPosition_um := CurrentCell.TanPosition_um;
        NewCell.CellFileNumber := CurrentCell.CellFileNumber;
        NewCell.MinLumenSizeReached := false;

        NewCell.CEllCSArea_um2 := (NewCell.CellRD_um) *
          (NewCell.CellTD_um);

        CurrentCell.TimeSinceMitosis_days := 0;
        NewCell.TimeSinceMitosis_days := 0;

        NewCell.GrowingDays := 0;
        NewCell.DaysSinceSecThick := 0;
        NewCell.DaysSinceCZExit := 0;
        NewCell.COnsecSlowGrowthDays := 0;
        NewCell.MFA := 0;

        NewCell.LastCarbConsumption_ug := 0;

        CurrentCell.CumulCarb_ug := CurrentCell.CumulCarb_ug/2;
        NewCell.CumulCarb_ug := CurrentCell.CumulCarb_ug;

        NewCell.MeanGR_umperday := 0;
        NewCell.StemPosition := CurrentStemPosition.Position_m;
        NewCell.LastCarbAlloc := 1;

        //**********************************************************************
        //This procedure incorporates a "custom" determination part:

        if ((CurrentCell.CellType = CINITIAL) {and (Random < 0.5)}) or
          (CurrentCell.CellType = XMC)then begin
          //If the cell is an initial cell, and divides, it is assumed it keeps its id
          //The daughter becomes phloem or xylem mc
          //initial daughter types are random

          NewCell.CellType:=XMC;

          //The daughter cell is positioned "xylem-ward" of the mother cell
          NewCell.RadPosition_um := CurrentCell.RadPosition_um;
          CurrentCell.RadPosition_um := CurrentCell.RadPosition_um + NewCell.CellRD_um;

          if CurrentCell.CellType = CINITIAL then
            CurrentStemPosition.InitialCellPositions_um[CurrentCell.CellFileNumber-1]:=
              CurrentCell.RadPosition_um;

        end else begin

          NewCell.CellType:=PMC;
          //The daughter cell is positioned "bark-ward" of the mother cell

          NewCell.RadPosition_um := CurrentCell.RadPosition_um + CurrentCell.CellRD_um;

        end;

        NewCell.CellCycleDur_days := CurrentCell.CellCycleDur_days;

        CurrentCell.CellLength_um := CurrentCell.CellLength_um*Params.LengthReductionatDivision;

        NewCell.CellLength_um := CurrentCell.CellLength_um;

        NewCell.CellVolume_um3 := BodyVolume(NewCell.CellType,
          NewCell.CellRD_um,NewCell.CellTD_um,NewCell.CellLength_um);
        CurrentCell.CellVolume_um3 := BodyVolume(CurrentCell.CellType,
          CurrentCell.CellRD_um,CurrentCell.CellTD_um,CurrentCell.CellLength_um);

        NewCell.LumenVolume_um3 := BodyVolume(NewCell.CellType,
          NewCell.CellRD_um - NewCell.CellWT_um*2,
          NewCell.CellTD_um - NewCell.CellWT_um*2,
          NewCell.CellLength_um);
        CurrentCell.LumenVolume_um3 := BodyVolume(CurrentCell.CellType,
          CurrentCell.CellRD_um - CurrentCell.CellWT_um*2,
          CurrentCell.CellTD_um - CurrentCell.CellWT_um*2,
          CurrentCell.CellLength_um);

        CurrentCellList.Add(NewCell);

      end;
    end;
  end;

  CurrentCell.TimeSinceMitosis_days := CurrentCell.TimeSinceMitosis_days + 1;

end;

procedure GrowCells(CurrentCell : TCell;
  CurrentCellList:TObjectList;
  CurrentTree : TTree;
  CurrentDay: Integer;
  CurrentDate: TDate;
  CurrentStemPosition : TStemPosition;
  Params : TCAMBIUMParameters;
  CarbLimittoOP : Boolean);

var
  CurrentXylemWaterPotential_MPa : Double;
  TotalDailyGrowth_um : Double;
  CarbsRequired_g : Double;
  WaterPotAtCell : DOuble;

begin
  TotalDailyGrowth_um := 0;

  CurrentCell.LastCarbConsumption_ug := 0;
  CurrentCell.HoursofGrowth := 0;
  CurrentCell.WallExtensibility_umperMPAh := 0;
  CurrentCell.MeanOP_MPa := 0;
  CurrentCell.MeanTurgor_MPa := 0;
  CurrentCell.MeanYT_Mpa := 0;

  if ((CurrentCell.Process = DIVI) or (CurrentCell.Process = GROW))
    and ((CurrentTree.MinTemp_degC[CurrentDay] + CurrentTree.MaxTemp_degC[CurrentDay])/2 > Params.MinTemp) then begin

    {CurrentXylemWaterPotential_Mpa :=
        (CurrentStemPosition.MXWP_MPa +
        CurrentStemPosition.PDXWP1_MPa)/2;}

    CurrentXylemWaterPotential_Mpa := CurrentStemPosition.PDXWP1_MPa;

    WaterPotAtCell := WPOutsideCell(CurrentXylemWaterPotential_MPA,
      CurrentStemPosition.ConductingXylemPosition_um,
      CurrentCell.RadPosition_um,0);

    //Calculate the OP achievable by the current cell, with a given amount of NSC
    CurrentCell.OsmoticPotential := OPCell(CurrentCell.CumulCarb_ug,
      CurrentCell.LumenVolume_um3,
      Params.VacFactor,
      (CurrentTree.MaxTemp_degC[CurrentDay] + CurrentTree.MinTemp_degC[CurrentDay])/2,
      -999,-0.1);

    CurrentCell.WallExtensibility_umperMPAh :=  Params.MaxDailyWE *
      CurrentTree.DormancyStatus *
      power(max(0,(1 - CurrentCell.CellRD_um/Params.MaxTRD)),1) *
      (1 - (CurrentStemPosition.CritOP/Params.MinOP));

    CurrentCell.MeanYT_Mpa := Params.YieldThreshold;

    CurrentCell.MeanTurgor_MPa := max(0,min(CurrentStemPosition.CurrentMaxTurgorLimit,
      WaterPotAtCell -
      CurrentStemPosition.MeanMinOP_MPa));
      //CurrentCell.OsmoticPotential));

    //CurrentCell.MeanTurgor_MPa := CurrentStemPosition.CurrentMaxTurgorLimit;

    TotalDailyGrowth_um := max(0,CurrentCell.WallExtensibility_umperMPAh *
      (CurrentCell.MeanTurgor_MPa - CurrentCell.MeanYT_Mpa));

    if (formMain.Detailedgraphs1.Checked) and (CurrentStemPosition.Position_m > 0.1) then begin
      formdetailedgraphs.ChartWPOP.Series[0].Color := clBlue;
      formdetailedgraphs.ChartWPOP.Series[0].AddXY(CurrentCell.RadPosition_um,
        WaterPotAtCell);
      formdetailedgraphs.ChartWPOP.Series[1].AddXY(CurrentCell.RadPosition_um,
        CurrentCell.OsmoticPotential);
      formdetailedgraphs.ChartWTYT.Series[0].AddXY(CurrentCell.RadPosition_um,
        CurrentCell.WallExtensibility_umperMPAh);
      formdetailedgraphs.ChartWTYT.Series[1].AddXY(CurrentCell.RadPosition_um,
        CurrentCell.MeanYT_Mpa);
      formdetailedgraphs.ChartWTYT.Series[2].AddXY(CurrentCell.RadPosition_um,
        CurrentCell.MeanTurgor_MPa);
    end;

    if CurrentCell.CellRD_um + TotalDailyGrowth_um > Params.MaxTRD then
      TotalDailyGrowth_um := Params.MaxTRD - CurrentCell.CellRD_um;

    CarbsRequired_g := CarbohydrateRequired_g(CurrentCell,
      TotalDailyGrowth_um,
      PRIMARYWALLTHICKNESS,PRIMARYWALLTHICKNESS,
      Params.RDLRatio,
      Params.WallDensity);

    if (CarbsRequired_g  >
      CurrentCell.CumulCarb_ug/1000000) then begin

      TotalDailyGrowth_um := 0;
      CurrentCell.LastCarbConsumption_ug := 0;
      //Assumes that if carbon is starting to become limiting,
      //growth is abandoned.
    end else begin
      CurrentCell.LastCarbConsumption_ug := CarbsRequired_g*1000000;
      CurrentCell.CumulCarb_ug :=  max(0,CurrentCell.CumulCarb_ug - CarbsRequired_g*1000000);
    end;

    if CurrentCell.Status <> MERI then begin
      CurrentCell.SumGR_um := CurrentCell.SumGR_um + TotalDailyGrowth_um;
      if CurrentCell.GrowingDays > 0 then begin
        CurrentCell.MeanGR_umperday := CurrentCell.SumGR_um/CurrentCell.GrowingDays;
      end else
        CurrentCell.MeanGR_umperday := TotalDailyGrowth_um;
    end;

    CurrentCell.CellRD_um := CurrentCell.CellRD_um + TotalDailyGrowth_um;

    CurrentCell.CellLength_um := Min(Params.MaxTLength,CurrentCell.CellLength_um + (TotalDailyGrowth_um *
      Params.RDLRatio * max(0,(1 - CurrentCell.CellLength_um/Params.MaxTLength))));

    CurrentCell.CellWT_um := PRIMARYWALLTHICKNESS;

    CurrentCell.CellVolume_um3 := BodyVolume(CurrentCell.CellType,
      CurrentCell.CellRD_um,CurrentCell.CellTD_um,CurrentCell.CellLength_um);

    CurrentCell.LumenVolume_um3 := BodyVolume(CurrentCell.CellType,
      CurrentCell.CellRD_um - CurrentCell.CellWT_um*2,
      CurrentCell.CellTD_um - CurrentCell.CellWT_um*2,
      CurrentCell.CellLength_um);

    CurrentCell.CEllCSArea_um2 := (CurrentCell.CellRD_um) *
      (CurrentCell.CellTD_um);

    CurrentCell.CEllCSLumArea_um2 := (CurrentCell.CellRD_um - CurrentCell.CellWT_um*2) *
      (CurrentCell.CellTD_um - CurrentCell.CellWT_um*2);


  end else
    TotalDailyGrowth_um := 0;

  CurrentCell.LastGrowthRate_umperday := TotalDailyGrowth_um;

  CurrentCell.OsmoticPotential := OPCell(CurrentCell.CumulCarb_ug,
    CurrentCell.LumenVolume_um3,
    Params.VacFactor,
    (CurrentTree.MinTemp_degC[CurrentDay] + CurrentTree.MaxTemp_degC[CurrentDay])/2,
    -999,-0.1);
end;

Procedure UpdateCellPositions(CurrentCell: TCell;
  CurrentCellList: TObjectList;
  CurrentStemPosition:TStemPosition);
var
  i : integer;
  CellUnderConsideration : TCell;

begin
  for i := 0 to CurrentCellList.Count-1 do begin
    CellUnderConsideration := TCell(CurrentCellList[i]);

    if (CellUnderConsideration.TanPosition_um = CurrentCell.TanPosition_um) and
      (CellUnderConsideration.RadPosition_um > CurrentCell.RadPosition_um) then
      CellUnderConsideration.RadPosition_um := CellUnderConsideration.RadPosition_um +
        CurrentCell.LastGrowthRate_umperday;
  end;
end;

procedure GrowCellWalls(CurrentCell : TCell;
  MinTemp: Double;
  Params: TCAMBIUMParameters);
var
  CarbsRequired_ug : Double;
  PotNewWallVol_um3,PotNewLumVol_um3 : DOuble;
  PotNewLumCSArea_Um2 : Double;
  tempeffect : double;

begin
  Tempeffect := max(0,min(1,(MinTemp - Params.MinTemp)/(18 - Params.MinTemp)));

  CurrentCell.LastCarbConsumption_ug := 0;

  if CurrentCell.Process = STHICK then begin

    PotNewWallVol_um3 := min(Params.MaxWallThickRate,MasstoVolume(CurrentCell.CumulCarb_ug/1000000,
      Params.WallDensity));

    //PotLumVol_um3 := CurrentCell.CellVolume_um3 - PotWallVol_um3;
    PotNewLumVol_um3 := max(CurrentCell.LumenVolume_um3 - PotNewWallVol_um3,
      (1-Params.MaxWallRatio)*CurrentCell.cellvolume_um3);

    CarbsRequired_ug := VolumetoMass(max(0,CurrentCell.LumenVolume_um3 -
      PotNewLumVol_um3),Params.WallDensity)*1000000;

    CurrentCell.LumenVolume_um3 := PotNewLumVol_um3;

    if (CurrentCell.CellVolume_um3 - CurrentCell.LumenVolume_um3)/CurrentCell.CellVolume_um3 >=
      Params.MaxWallRatio * 0.99 then //*sqrt((1-(CurrentCell.CellRD_um/Params.MaxTRD)))  then
      CurrentCell.MinLumenSizeReached := True;

    PotNewLumCSArea_um2  := BodyCSArea(CurrentCell.CellType,
      CurrentCell.LumenVolume_um3,CurrentCell.CellLength_um);

    CurrentCell.CellWT_um := max(CurrentCell.CellWT_um,
      GetMinWallThick(CurrentCell.CellCSLumArea_um2,
      PotNewLumCSArea_um2,
      CurrentCell.CellTD_um,CurrentCell.CellRD_um));

    CurrentCell.CellCSLumArea_um2 := PotNewLumCSArea_um2;

    CurrentCell.LastCarbConsumption_ug := CarbsRequired_ug;

    CurrentCell.CumulCarb_ug := max(0,CurrentCell.CumulCarb_ug -  CarbsRequired_ug);

    CurrentCell.TotalProtease := CurrentCell.TotalProtease + CarbsRequired_ug;

  end;
end;

//******************************************************************************
//Distributions and curves

Function SigmoidalGrowthDecayCurve(X:double; b0:double; b1:double; b2:double):double;
begin
  Result := (b0/(1+exp(-(X-b1)/b2)))
end;

Function LogNormalPDF(Pos : Double;
  variance : double): Double;
begin
  Result := 1/(Pos*variance*SQRT(2*PI))*
    EXP(-(power((LN(pos)),2))/(2*power(variance,2)));
end;

Function LogisticFunction_CDF(x: Double;
  Alpha: Double): Double;
begin
  Result := 1/(1+power(Alpha,-x));
end;

Function LogisticFunction_PDF(x: Double;
  Alpha: Double): Double;
begin
  Result := power(Alpha,-x)/power((1+power(Alpha,-x)),2);
end;

Function AsymptoticExponential(x: Double;
  Shape: Double): Double;
begin
  Result := 1 - power(exp(-x),Shape);
end;

//******************************************************************************



//******************************************************************************
//Volume and form functions relating to the stem

Function StemVolumeSH(b0Vol : Double; b1Vol : Double; b2Vol : Double; DiamBH:double;Ht:double):double;
begin
  Result := power(10,b0Vol+b1Vol*log10(DiamBH)+b2Vol*log10(Ht));
  //Schumacher and Hall stem vol equ.
end;

Function StemVolumePara(DiamAtBase_m:double; Ht_m:double):double;overload;
  begin
    Result := ParaboloidVolume(DiamAtBase_m,DiamAtBase_m,Ht_m);
  //Volume of a paraboloid
end;

Function LivingStemVol(DiamBase_m: Double;
  CurrentTreeHt_m: Double;
  LivingXylemWidth_m : Double ):Double;overload;
Var
  TotStemVol : Double;
  DeadStemVol : Double;
const
  MAXHDR = 70;

begin

  TotStemVol := StemVolumePara(DiamBase_m,CurrentTreeHt_m);

  DeadStemVol := StemVolumePara(DiamBase_m - LivingXylemWidth_m*2,CurrentTreeHt_m);

	Result := (TotStemVol - DeadStemVol);
	//We calculate the volume of living xylem tissue: in m3

end;

//******************************************************************************
//Volume, mass and form functions relating mainly to tracheids

Function BodyVolume(TypeofCell:string;RDV:double;TDV:double;LengthV:double):double;Overload;
begin
	if (TypeofCell=PCELL) then
		//We calculate phloem volume as a cylinder
		Result := CylinderVolumeFromDiam(RDV,TDV,LengthV)
  else
    Result := RectangularPrismVolumeFromDiam(RDV,TDV,LengthV);
		//Result := CylinderVolumeFromDiam(RDV,TDV,LengthV);
    //Result := (2 * ConeVolume(RDV,TDV,LengthV/2));
end;

Function BodyVolume(TypeofCell:string;CSArea:double;LengthV:double):double;Overload;
begin
	if (TypeofCell=PCELL) then
		//We calculate phloem volume as a cylinder
		Result := CylinderVolumeFromArea(CSArea,LengthV)
  else
    Result := RectangularPrismVolumeFromArea(CSArea,LengthV);
		//Result := CylinderVolume(CSArea,LengthV);
    //Result := (2 * ConeVolume(CSArea,LengthV/2));
end;

Function BodyCSArea(TypeofCell:string;Volume:double;FullLength:double):double;
begin
	if (TypeofCell=PCELL) then
		Result := CylinderCSArea(Volume,FullLength)
  else begin
		//Result := CylinderCSArea(Volume,FullLength)
    //Result := ConeCSArea(Volume/2,FullLength/2);
    Result := RectangularPrismCSAreaFromVol(Volume,FullLength);
  end;
end;

Function VolumetoMass(InputVolume_CubicMicrons:double;
  MaterialDensity_gpercc:double):double;
//Converts an input volume in cubic microns to an output mass in g
var
  InputVolumeCC : double;
begin
  InputVolumeCC := InputVolume_CubicMicrons/power(10,12);
  Result := InputVolumeCC * MaterialDensity_gpercc;
end;

Function MasstoVolume(InputMass_g:double; MaterialDensity_gpercc:double):double;
//Converts an input mass in g to an output volume in cubic microns
var
  OutputVolumeCC : double;
begin
  OutputVolumeCC := InputMass_g * (1/MaterialDensity_gpercc);
  Result := OutputVolumeCC * power(10,12);
end;

Function MeanCZCellVolume(CurrentLivingCellList : TObjectList): double;
//Get the mean volume of cambial cells
var
  i : integer;
  VolSum: Double;
  VolCount : Integer;
begin
  VolSum := 0;
  VolCount := 0;

  for i := 0 to CurrentLivingCellList.Count-1 do begin
    if TCell(CurrentLivingCellList[i]).Status = MERI then begin
      VolSum := TCell(CurrentLivingCellList[i]).CellVolume_um3 + VolSum;
      VolCount := VolCount + 1;
    end;
  end;

  if VolCount > 0 then
    Result := VolSum/VolCount
  else
    Result := 0;
end;

//******************************************************************************
//Functions to update daily, tree level variables, including tree-level means

Function TempAcclimation(PriorAF : DOuble; LagMeanT : Double; MinTCG : Double; TempAcc : Double): Double;
var
  AF : Double;
begin
  AF := PriorAF;

  //We assume there was some data with which to do the calculation

  if LagMeanT > MinTCG then
    AF := AF + 0.1
  else
    AF := AF - 0.1;

  if AF < 0 then AF := 0;

  if AF >= TempAcc then AF := TempAcc;

  Result := AF;
end;

Function GetAreaSpecificCarbAllocation_gperum2(TotalAllocToday_g: Double;
  TotalCambialSAToday_m2: Double): Double;
var
  CSA_um2 : Double;
begin
  CSA_um2 := TotalCambialSAToday_m2 * 1000000000000;
  if CSA_um2 > 0 then
    Result := TotalAllocToday_g/CSA_um2
  else
    Result := 0;
end;

Function CambiumSurfaceArea(DatPos_m: Double;
  Pos_m: Double;
  TreeHt_m : Double): Double;
begin
  //Result := ParaboloidSurfaceArea(Pos_m,DatPos_m);
  Result := ConeLateralSurfaceArea(DatPos_m,TreeHt_m);

end;

//******************************************************************************
//Functions to deal with position level info

Function GetCurveParameter(CellCount : Integer;
  TotalValue : Double;
  MinParam: Double;
  var MaxParam : Double): Double;
  //This function calculates the proportion of the cascading (decreasing)
  //amount of an allocated substance (auxin or carbs) that is allocated to each
  //subsequent cell with increasing distance from the cambial initial.
var
  i,j : integer;
  MyParam,FinalParam : Double;
  Crit : Double;
  MySum,MaxSum : Integer;
  TotalSum,TestValue : Double;
begin
  FinalParam := 1;

  //Crit is the value above which the algorithm aims
  //to allocate to the maximum number of cells
  if CellCount > 0 then
    Crit := TotalValue/CellCount
  else
    Crit := TotalValue;

  MaxSum := 0;

  if MaxParam > 1 then
    MaxParam := 1;

  for i  := round(MinParam*100) to round (MaxParam*100) do begin
    MyParam := i/100;

    MySum := 0;
    TotalSum := 0;

    TestValue := TotalValue;

    for j := 0 to CellCount do begin
      TotalSum := TotalSum + MyParam*TestValue;

      if MyParam*TestValue > Crit then
        MySum := MySum + 1;

      TestValue := TestValue - (MyParam*TestValue);
    end;

    //At least 99% of the substance must be allocated
    //within the zone
    if TotalSum >= TotalValue*0.99  then begin
      if MySum > MaxSum then begin
        MaxSum := MySum;
        FinalParam := MyParam;
      end;
    end;
  end;
  Result := FinalParam;
end;

Function GetCarbMassPerCellFile(CarbMass_gperum2: Double;
  MeanTracheidTD_um: Double;
  MeanTracheidLength_um : Double): Double;
var
  RelevantTSA_um2 : Double;
begin
  RelevantTSA_um2 := MeanTracheidTD_um * MeanTracheidLength_um;
  Result := CarbMass_gperum2 *  RelevantTSA_um2;
end;

Function GetRelevantDay(CurrentDay : Integer;
  StemPos_m: Double;
  TreeHeight_m : Double;
  TravelRate_mperday : Double): Integer;
var
  HtDiff : Double;
  DaysForTravel : Integer;
  ProdDay : Integer;
begin

  HtDiff := TreeHeight_m - StemPos_m;
  if HtDiff > 0 then
    DaysForTravel := Round(HtDiff/TravelRate_mperday)
  else
    DaysForTravel := 0;

  ProdDay := round(CurrentDay - DaysForTravel);
  if ProdDay < 0 then
    ProdDay := 0;

  Result :=  ProdDay;
end;

Function GetCumulMass(InputDataArray : array of Double;
  EndPos: Integer;
  Lag : Integer):Double;
var
  FilterStart,FilterEnd: Integer;
  i : Integer;
  CumulValue : Double;
  Correction : Double;

begin
  CumulValue := 0;

  if EndPos - Lag >= 0 then
    FilterStart := EndPos - Lag
  else
    FilterStart := 0;

  if EndPos <= Length(InputDataArray)-1 then
    FilterEnd := EndPos
  else
    FilterEnd := Length(InputDataArray)-1;

  for i:= FilterStart to FilterEnd do begin
    Correction := (i - FilterStart)/Lag;
    CumulValue := InputDataArray[i] * Correction + CumulValue;
  end;

  Result := CumulValue;
end;


//******************************************************************************
//Functions associated with cell division

Function RandomCellSize(InputValue: Double;MinBoundary: Integer;MaxBoundary: Integer):Double;
var
  RandomProp : Double;

begin
  RandomProp := RandomRange(MinBoundary,MaxBoundary)/100;
  Result := InputValue * RandomProp;
end;


//******************************************************************************
//Functions associated with cell growth, osmotic maintenance and carbs balance

Function WPOutsideCell(XylemWP:Double;
  CondXylemPosition: Double;
  CurrentCellPosition : Double;
  DecayCoef: DOuble):DOuble;
var
  MyMaxWP : DOuble;
  PositionDiff_mm : Double;
begin
  if XylemWP < 0 then
    MyMaxWP := XylemWP * -1
  else
    MyMaxWP := XylemWP;

  if DecayCoef > 0 then
    DecayCoef := DecayCoef* -1;

  PositionDiff_mm :=  CurrentCellPosition/1000 - CondXylemPosition/1000;

  Result := MyMaxWP*exp(DecayCoef*PositionDiff_mm) - (MyMaxWP*2);

end;

Function CarbohydrateRequired_g(CurrentCell:TCell;
  PotRadGrowthRate : Double;
  WallThick1 : Double;
  WallThick2 : Double;
  RDLRat : Double;
  WallDensity_gpercc : Double):Double;

Var
  CurrentCellVolume : Double;
  CurrentLumenVolume : Double;
  PotentialCellVolume : Double;
  PotentialLumenVolume : Double;
  OldWallVolume: DOuble;
  NewWallVolume: DOuble;

begin
  CurrentCellVolume := round(BodyVolume(CurrentCell.CellType,
    CurrentCell.CellRD_um,
    CurrentCell.CellTD_um,
    CurrentCell.CellLength_um));
  //Cell volume in um3
  CurrentLumenVolume := round(BodyVolume(CurrentCell.CellType,
    CurrentCell.CellRD_um - WallThick1*2,
    CurrentCell.CellTD_um - WallThick1*2,
    CurrentCell.CellLength_um- WallThick1*2));
  //Lumen volume in um3

  OldWallVolume := CurrentCellVolume - CurrentLumenVolume;
  //Wall volume in um3

  PotentialCellVolume := round(BodyVolume(CurrentCell.CellType,
    CurrentCell.CellRD_um + PotRadGrowthRate,
    CurrentCell.CellTD_um,
    CurrentCell.CellLength_um  + (PotRadGrowthRate*RDLRat)));
  //Cell volume in um3
  PotentialLumenVolume := round(BodyVolume(CurrentCell.CellType,
    CurrentCell.CellRD_um + PotRadGrowthRate - WallTHick2*2,
    CurrentCell.CellTD_um - WallThick2*2,
     CurrentCell.CellLength_um  + (PotRadGrowthRate*RDLRat)- WallThick2*2));
  //Cell volume in um3

  NewWallVolume := PotentialCellVolume - PotentialLumenVolume;
  //Wall volume in um3

  Result := VolumetoMass(NewWallVolume - OldWallVolume,WallDensity_gpercc)

end;


Function OPCell(CumulCarb_ug: Double;
  LumVol_um3: Double;
  VacFactor: Double;
  T_Centigrade: Double;
  MinOP,MaxOP : Double):Double;
var
  CellVol_L : double;
  CumulCarb_g : double;
  Sucrose_mol : Double;
  SucrosePressure : Double;
const
  R = 0.0821;
  MOLARMASSSUCROSE = 342.3;
  OSMOTICCOEFFSUCROSE = 1.4;

begin
  //this assumes that most of the carbs are in the form of sucrose.
  //See Uggla et al 2001

   CumulCarb_g := CumulCarb_ug/1000000;

  Sucrose_mol := CumulCarb_g/MOLARMASSSUCROSE;

  //Modified to take into account an "active" volume
  CellVol_L := (LumVol_um3 *VacFactor/power(10,15));

  if CellVol_L > 0 then
    SucrosePressure := OSMOTICCOEFFSUCROSE *
      -1*(1 * Sucrose_mol/CellVol_L * R * (T_Centigrade + 273))/1000
  else
    SucrosePressure := -0.1;

  Result := Min(MaxOP,Max(MinOP,SucrosePressure));
end;




//******************************************************************************
//Functions associated with secondary wall thickening

Function GetMinWallThick(CellCSArea,LumenArea: Double;
  CellTD,CellRD : Double): Double;
var
  TempLumArea,mywt: Double;
begin
  TempLumArea := CellCSArea;
  mywt := 0.1;
  while (TempLumArea > LumenArea) and (CellRD > mywt*2) and (CellTD > mywt*2) do begin
    TempLumArea := (CellTD - 2*mywt)*(CellRD - 2*mywt);
    mywt := mywt + 0.1;
  end;

  Result := mywt;
end;

//******************************************************************************
//Wood density and MOE functions
Function CalculateDensity(MeanCellVolume: Double;
  MeanLumenVolume: Double;
  WallDensity_gcm3: Double): Double;Overload;
var
  WallRatio : Double;
  Densitykgm3 : DOuble;
begin
  WallRatio := 1 - MeanLumenVolume/MeanCellVolume;
  Densitykgm3 := WallDensity_gcm3 * 1000000 / 1000;

  Result := Densitykgm3 * WallRatio;
end;

Function CalculateMOE(b0: double;
  b1: double;
  WoodDensity : double;
  MFA : double): double;
var
  DenMFARatio : Double;
begin
  DenMFARatio := WoodDensity/MFA;
  Result := max(1,b0 * LN(DenMFARatio) + b1);

end;

//******************************************************************************
//Data management procedures

Procedure UpdateDailyDataArray(CurrentDay: Integer;
  CurrentDate: TDate;
  InputData: TCAMBIUMINputDataArray;
  var OutputDataArray:TCAMBIUMDailyOutputDataArray;
  InputTree:TTree;
  InputStemPosition:TStemPosition);

begin
  //Write the data into the daily array for potential write
  //to disk at the end of the run
  With OutputDataArray[CurrentDay] do begin
    LogDate:=CurrentDate;
    TreeAge := InputTree.TreeAge;
    DiamAtModellingPos := InputStemPosition.Diameter_cm;
    DiamAtBase := InputTree.TreeDBUB_cm;
    DBH := InputData[CurrentDay].IndepDBH_cm;
    TreeHeight := InputTree.TreeHeight_m[CurrentDay];
    TreeNPP := InputTree.NPP_kgpertree[currentday];
      StemAllocCarb := InputTree.NPP_kgpertree[currentday] *
    InputTree.AllocStem[currentday];
    CZCount := InputStemPosition.DividingCellCount;
    EZCount := InputStemPosition.GrowingCellCount;
    TZCount := InputStemPosition.ThickeningCellCount;
    CellCycleDur := InputStemPosition.MeanCellCycleDur_days;
    GrowingDays := InputStemPosition.MeanGrowingDays;
    ThickeningDays := InputStemPosition.MeanThickDays;
    MeanWTRate := InputStemPosition.MeanWTRate_umperday;
    MeanRadGrowthRate := InputStemPosition.MeanGrowthRate_umperday;
    StemVol := InputTree.TreeVolume_m3;
    LivingStemVol := InputTree.LivingVolume_m3;
    MinTemp := InputTree.MinTemp_degC[currentday];
    MaxTemp := InputTree.MaxTemp_degC[currentday];
    MinLWP := InputTree.MiddayLWP_Mpa[currentday];
    MaxLWP := inputTree.PDLWP1_Mpa[currentday];
    DailyLAI := InputData[CurrentDay].LAI;
    WSStand := InputData[CurrentDay].ws;
    WFStand := InputData[CurrentDay].wf;
    WRStand := InputData[CurrentDay].wcr + InputData[CurrentDay].wfr;
    StandNPP := InputData[CurrentDay].NPP_tperha;
    ASWRootZone := InputData[CurrentDay].SWCRZ;
    SPH := INputData[CurrentDay].SPH;
    StemVol := InputData[CurrentDay].FinalStandVol;
    Rainfall := InputData[CurrentDay].Rain;
    Transpiration := InputData[CurrentDay].Transp;
  end;
end;








end.
