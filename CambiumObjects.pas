unit CambiumObjects;

interface

type
  TCell = class
    StemPosition : Single;
    RadPosition_um : Double; //The position of the phloem-ward wall
    PositionNumber : Integer; //Position from cambial initial
    TanPosition_um : Double;
    CellNumber : Integer;
    CellRD_um : double;
    CellTD_um  : double;
    CellLength_um : double;
    CellWT_um : double;
    CellVolume_um3 : double;
    LumenVolume_um3 : double;
    CellCSArea_um2 : Double;
    CEllCSLumArea_um2 : Double;
    MFA : Double;
    CellType : string;
    Status : string;
    Process : string;
    MotherCell : Integer;
    LastGrowthRate_umperday : Double;
    LastCarbConsumption_ug : Double;
    DaysSinceCreation : Integer;
    DaysSinceCZExit : Integer;
    GrowingDays : Integer;
    DaysSinceSecThick : Integer;
    TimeSinceMitosis_days : Integer;
    FormationDate : TDate;
    CellCycleDur_days : Double;
    CellFileNumber : Integer;
    Apoptosisdate,GrowthStopDate : TDate;
    CumulCarb_ug : Double;
    HoursofGrowth : Integer;
    MeanGR_umperday,SumGR_um : Double;
    WallThickRate_um,WallThickRate_um2 : Double;
    MinLumenVolume_um3 : Double;
    MaxWallProp : Double;
    OsmoticPotential : DOuble;
    WallExtensibility_umperMPAh,MeanOP_MPa,MeanTurgor_MPa,MeanYT_Mpa : Double;
    ConsecSlowGrowthDays : Integer;
    LastCarbAlloc : Double;
    MinLumenSizeReached : Boolean;
    WPAC : Double;
    DistFromInitial,DistFromCambiumEdge : Double;
    TotalProtease : Double;


    private
    public

  end;

  TSegment = class
    SegmentNumber : Integer;
  end;

  TCellFile = class
    CellFileNumber : Integer;
    CambialCellNumber : Integer;
    CambialCellPosition : Double;
  end;

  TStemPosition = class
    Position_m : Double;
    DFT_m : Double;
    TotAux_g,TotAux_gpercellfile : Double;
    TotCarbs_gpercellfile, CumulCarbs_gpercellfile: Double;
    CarbsDistributionAlpha : Double;
    CarbsDistributionAlpha_MFA : array of Double;
    CumulCDAlpha: Double;
    CDAlphaCount : Integer;
    MaxLivingCellPosition_um,MinLivingCellPosition_um : Double;
    MaxThickeningCellPosition_um : Double;
    MaxGrowingCellPosition_um,MinGrowingCellPosition_um : Double;
    MaxCZCellPosition_um,MinCZCellPosition_um: Double;
    MeanRDCZExit_um,MeanRDGrowingCells_um,MeanRDLivingCells_um : DOuble;
    MeanCellRD_um,MeanCellTD_um,MeanCellWT_um,MeanCellLength_um,MeanMFA_deg,MeanWD_kgperm3 : Double;
    MeanCellVolLivingCells_um3,MeanLumVolLivingCells_um3 : Double;
    MeanMOE_GPa,WDSum,MFASum : Double;
    ConductingXylemPosition_um : Double;
    InitialCellPositions_um : array of Double;
    InitialCellNumbers : array of Integer;
    CellDivisions : array of integer;
    DividingCellCount,GrowingCellCount,ThickeningCellCount: Integer;
    MeanGrowingDays,MeanThickDays,MeanCellCycleDur_days : Double;
    SumGrowingDays,SumThickDays,SumCellCycleDur_days : Double;
    DividedTodayCount,StoppedGrowingTodayCount,StoppedThickTodayCount: Integer;
    MeanGrowthRate_umperday,MeanWTRate_umperday : double;
    MeanMinOP_MPa,MeanTurgor_MPa,MeanYT_Mpa,MaxOP_MPa,MinOP_MPa : double;
    MeanExt_umPerMPaPerhour : Double;
    MeanHoursofGrowth : Double;
    Diameter_cm: Double;
    LastRadGrowth_umperday : Double;
    CumCarbEZExit_ug : Double;
    CarbConsumptionCZ_ug,CarbConsumptionEZ_ug,CarbConsumptionTZ_ug : Double;
    ExcessCarbPerFile_g : Double;
    Excess_Carb_g : Double;
    PDXWP1_MPa,PDXWP2_MPa,MXWP_MPa: Double;
    ThinWallCumul : DOuble;
    Circumference_um : Double;
    LowTurgorFlag: Boolean;
    CurrentMaxCZWidth : Double;
    CurrentMaxEZWidth : Double;
    CurrentMaxTZWidth : Double;
    MaxGrowingDays: Integer;
    CurrentMaxTurgorLimit: Double;
    CritOP : Double;
    fFrostDanger,FrostProtectionOP : Double;
    StartWP,EndWP,EWWPChangeRate : Double;
    EWDays : Integer;
    RingCount : Integer;
    SmallCellWarning : Boolean;
    EWBuild,LWBuild,MaxDLPassed,MinDLPassed : Boolean;
    MinEZWAchieved : Boolean;
    LWCellCounter : Double;
    CZReduced,EZReduced,TZReduced: Integer;
  end;


  TTree = class
    TreeNumber : Integer;
    TreeAge : DOuble;
    TreeDBHOB_cm : array of Double;
    TreeDBUB_cm : Double;
    TreeHeight_m : array of Double;
    TreeVolume_m3 : Double;
    MinTemp_degC,MaxTemp_degC,MaxTempTomorrow_degC : array of Double;
    MaxSPH : Double;
    FormFactor : array of Double;
    AllocVolSpecificCarb_gperum3 : Double;
    AllocAreaSpecificCarb_gperum2,AllocLengthSpecificCarb_gperum : array of Double;
    CambialSurfaceArea_m2 : Double;
    CrownLength_m : array of Double;
    NPP_kgpertree, GPP_kgpertree: array of Double;
    AllocStem : array of Double;
    AllocLeaves : array of Double;
    FoliageMass_kg : array of Double;
    AllocRoots : array of Double;
    AllocStem_kg : array of Double;
    CarbsInPhloem_kg : array of Double;
    AllocLeaves_kg : array of DOuble;
    Transpiration : array of Double;
    PDLWP1_Mpa : array of Double;
    PDLWP2_Mpa : array of Double;
    MiddayLWP_Mpa : array of Double;
    LivingVolume_m3 : double;
    GrowthDay : Integer;
    ShortDayCounter : Integer;
    ColdDayCounter : Integer;
    ChillUnits : Double;
    DormancyStatus : Integer;
    DayLength_hours : array of Double;
    WallExtShape_Aux,WallExtShape_Temp : Double;
    CellCycleShape_Aux,CellCycleShape_Temp : Double;
    MFAShape_Aux : Double;
    MaxWallRatioFactor,MinWallRatioFactor: Double;
    TempAcclimation : Double;
    MaxDayLength_h,MinDayLength_h : Double;
    RelDl : Double;



  end;

const

  CINITIAL = 'Initial';
  XMC = 'XMC';
  PMC = 'PMC';
  XCELL = 'Xylem';
  PCELL = 'Phloem';

  MERI = 'Meristematic';
  DIFF = 'Differentiating';
  DEAD = 'Dead';

  DIVI = 'Dividing';
  GROW = 'Growing';
  STHICK = 'SecondaryThickening';
  NONE = 'None';


implementation

end.
