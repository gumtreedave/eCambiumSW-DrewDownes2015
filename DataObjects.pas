unit DataObjects;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids,{FileCtrl,}Contnrs,General;

type

  TWeatherData = record
    LogDate : TDate;
    Rainfall : double;
    MinTemp : double;
    MaxTemp : double;
    SolRad : double;
    //VPD : double;
    Evap : double;
    MinRH: Double;
    MaxRH : Double;
  end;

  TWeatherdataArray = Array of TWeatherData;

  TSiteData = record
    SiteName : string[50];
    Latitude : integer;
    SoilDepth : Double;
    SoilTexture : String[50];
    SoilClass : Single;
    FR: Single;
    InitialASW,MinASW,MaxASW: Double;
  end;

  TParametersList = record
    Species : string[50];
    ParameterName: string[50];
    ParameterDescription: string;
    ParameterValue : double;
  end;

  TParametersListArray = array of TParametersList;

  TCAMBIUMInputData = record
    LogDate : TDate;
    LAI : double;
    NPP_tperha : double;     // t/ha
    GPP_tperha : double;     // t/ha
    SPH : integer;    // stems/ha
    etaf : double;    // 0 - 1
    etacr : double;   // 0 - 1
    etas : double;    // 0 - 1
    PDWP_Mpa : double;    //MPa
    MDWP_Mpa : double;    //MPa
    SWC : double;
    SWCRZ : Double;
    MinTemp : double;
    MaxTemp : double;
    Rain : double;
    IndepDBH_cm : double;
    //DBase_cm : double;
    TreeHt_m : Double;
    GreenHt_m : double;
    wfr : double;
    wf : double;
    wcr : double;
    ws: Double;
    Transp : double;
    VPD_kpa: double;
    DayLength: Double;
    FinalStandVol,AllStandVol : Double;
  end;

  TCAMBIUMInputDataArray = array of TCambiumInputData;

  TRegimeData = record
    RegimeName : String;
    EventDate : TDate;
    EventType : string[50];
    EventValue : Double;
  end;

  TRegimeDataArray = array of TRegimeData;

  TMensData = record
    LogDate : TDate;
    DBH : Double;
    Height : Double;
    GreenHt : Double;
    BA : Double;
    StandVol : Double;
  end;

  TMensDataArray = array of TMensData;

  TSSData = record
    SSPos : Double;
    WD: DOuble;
    TRD: Double;
    TTD: Double;
    TWT : Double;
    MFA: Double;
    MOE: Double;
  end;

  TSSDataArray = array of TSSData;

  TCAMBIUMCellData = record
    TreeNumber : Integer;
    StemPosition : Double;
    RadialFileNumber : Integer;
    CellType : string[50];
    RadialPosition : Double;
    TangentialPosition : Double;
    CellNumber : Integer;
    CellRD : Double;
    CellTD : Double;
    CellWT : Double;
    CellLength : Double;
  end;

  TCAMBIUMCellDataArray = array of TCAMBIUMCellData;

  TCAMBIUMSegmentData = record
    StartDate : TDate;
    EndDate : TDate;
    TreeAge : Double;
    SegmentNumber : Integer;
    SegmentPosition : Double;
    SegmentWidth : Double;
    MeanRD : Double;
    MeanTD : Double;
    MeanWT : Double;
    MeanLength : Double;
    WoodDensity : Double;
    MFA : Double;
    CellDensity : Double;
    MOE : Double;
    RinginSegment : Smallint;
  end;

  TCAMBIUMSegmentDataArray = array of TCAMBIUMSegmentData;

  TRingMeanData = record
    RingYear: Integer;
    MeanWD,WDSD: Double;
    MeanTRD,TRDSD: Double;
    MeanTTD,TTDSD: Double;
    MeanWT,WTSD : Double;
    MeanMFA,MFASD: DOuble;
    MeanMOE,MOESD: Double;
  end;

  TRingMeanDataArray = array of TRingMeanData;

  TCAMBIUMDailyOutputData = record
    LogDate: TDate;
    TreeAge : Double;
    MinTemp,MaxTemp: Double;
    Rainfall : Double;
    Transpiration: Double;
    TempAcclimationF: Double;
    MinLWP,MaxLWP,MinOP: Double;
    ASWRootZone : Double;
    DiamAtModellingPos : Double;
    DiamAtBase : Double;
    DBH : Double;
    TreeHeight: Double;
    SPH: Integer;
    ExcessCarb: Double;
    StandNPP,TreeNPP,StemAllocCarb : Double;
    CZCount: Integer;
    EZCount : Integer;
    TZCount: Integer;
    GrowingDays: Double;
    ThickeningDays: Double;
    CellCycleDur : DOuble;
    MeanWTRate : Double;
    MeanRadGrowthRate : Double;
    StemVol: Double;
    LivingStemVol: Double;
    MeanLivingCellVol,MeanCZCellVol : Double;
    MeanTL,MeanWD: Double;
    CellPop: Double;
    CumCarbCZ,CumCarbEZ,CumCarbTZ,CumCarbEZExit : Double;
    CarbConsCZ,CarbConsEZ,CarbConsTZ : Double;
    fTemp : Double;
    DailyLAI : DOuble;
    WFStand,WSStand,WRStand : Double;
  end;

  TCAMBIUMDailyOutputDataArray = array of TCAMBIUMDailyOutputData;

  TCAMBIUMBoardData = record

  end;

  TCAMBIUMParameters = record
    //CAMBIUM parameters
    b0MOE,b1MOE : Double;
    MaxMFA : Double;
    MinTemp: Double;
    MaxTRD : Double;
    MaxTLength : Double;
    MaxDailyWE : Double;
		MinDDivision : Double;
    MinCellCycle : Double;
    //MaxCZWidth : Double;
    //MaxEZWidth : Double;
    EZCZRatio : Double;
    MinOP : Double;
    LengthReductionatDivision : Double;
    RDLRatio : DOuble;
    WallDensity: Double;
    //WaterPotGradHt : Double;
    VacFactor : Double;
    MFAFactor : Double;
    MaxWallRatio: Double;
    MinTurgor : Double;
    MaxWallThickRate : Double;
    YieldThreshold : Double;
    CritConcCellDeath : Double;
    JuvenileCoreFactor : Double;
    //RelDLEW,RelDLLW : Double;
    ExtractionFactor : Double;


    //Procedure SetParameterValues;
  end;

  T3PGParameters = record
    //aH,nHB,nHN: Double;
    maxAge: Double;
    nAge : Double;
    rAge : Double;
    fullCanAge : Double;
    k: Double;
    gammaR: Double;
    //SWconst0 : Double;
    //SWPower0 : Double;
    MaxIntcptn : Double;
    LAImaxIntcptn : Double;
    MaxCond : Double;
    LAIgcx : Double;
    BLCond : Double;
    CoeffCond : Double;
    y : Double;
    TMax : Double;
    Tmin : Double;
    TOpt : Double;
    pFS2 : Double;
    pFS20 : Double;
    pRx : Double;
    pRn : Double;
    m0 : Double;
    fN0 : Double;
    fNn : Double;
    alphaCx : Double;
    //poolFracn : Double;
    //gammaN1 : Double;
    //gammaN0 : Double;
    //tgammaN : Double;
    //ngammaN : Double;
    wSx1000 : Double;
    thinPower : Double;
    //mF : Double;
    //mR : Double;
    mS : Double;
    gammaF1 : Double;
    gammaF0 : Double;
    tgammaF : Double;
    SLA0 : Double;
    SLA1 : Double;
    tSLA : Double;
    //fracBB0 : Double;
    //fracBB1 : DOuble;
    //tBB : Double;
    Qa : Double;
    Qb : Double;
    PSIMin : Double;
    //PreDawnSensRSWC : Double;
    //DeltaPSIMax: Double;
    RootConversion : Double;
    MaxHDRatio,MinHDRatio : Double;
    //TreeHtHyd : Double;
  end;
var
  CurrentRegimeDataArray : TRegimeDataArray;
  CurrentSiteData : TSiteData;
  //CurrentWeatherdata : TWeatherdataArray;

const
  DaysInMonthNY : array[1..12] of integer = (31,28,31,30,31,30,31,31,30,31,30,31);
  DBH_DBASE_FAC = 1.05;
  BASEPOS = 0.05;
  BARKPROP = 0.1;
  MINBASEDIAM_CM = 0.5;
  MINMFA = 1;
  PRIMARYWALLTHICKNESS = 0.2;
  MAXOP = -0.2;
  MINGROWINGDAYS = 2;
  MAXGROWINGDAYS = 999;
  PHLOEMLOADINGDAYS = 25;
  //CRITDISTFORJW = 10;
  MAXSCALLOC = 5;
  MAXCZWIDTH = 25;



implementation



end.
