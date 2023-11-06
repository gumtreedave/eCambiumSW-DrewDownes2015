unit AddEditCAMBIUMParams2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons,DataObjects,DataModule,ProjectManager;



Procedure WriteDefaultParamSet(NewDataSetName : string);

const

  DefaultParameterItems_RadiataXylem : array[0..29] of DataObjects.TParametersList=
  (
    (ParameterName : 'AuxinLag';
      ParameterDescription : 'Rate of auxin signal conduction (m/day)';
      ParameterValue : 3),
    (ParameterName :'b0Volume';
      ParameterDescription : 'Intercept for Schumacher/Hall stem vol equation (Log(m³))';
      ParameterValue : -4.3),
    (ParameterName :'b1Volume';
      ParameterDescription : 'Partial slope of Diameter for stem vol calculation';
      ParameterValue : 1.85),
    (ParameterName :'b2Volume';
      ParameterDescription : 'Partial slope of Height for stem vol calculation';
      ParameterValue : 1),
    (ParameterName :'kTaper';
      ParameterDescription: 'Exponent in taper function (see Bi et al 1994)';
      ParameterValue : 0),
    (ParameterName : 'b1MFA';
      ParameterDescription: 'The x-displacement of the auxin/MFA relationship';
      ParameterValue : -1.2),
    (ParameterName : 'b2MFA';
      ParameterDescription: 'The rate of change in the auxin/MFA relationship';
      ParameterValue : -3.5),
    (ParameterName :'MaxAuxConc'  ;
      ParameterDescription : 'Peak cambial auxin concentration (ng/cm²)';
      ParameterValue : 2),
    (ParameterName :'MaxMFA'  ;
      ParameterDescription : 'The maximum angle of microfibrils in the S2 wall layer (degrees)';
      ParameterValue : 45),
    (ParameterName :'MaxWallExtensibility'  ;
      ParameterDescription : 'Maximum extensibility of the cell wall (um/MPA/h)';
      ParameterValue : 0.2),
    (ParameterName :'MaxTempXylem'  ;
      ParameterDescription : 'Maximum temperature for xylem development (deg C)';
      ParameterValue : 35),
    (ParameterName :'MaxWallDepRate'  ;
      ParameterDescription : 'Maximum rate of secondary wall deposition (um²/day)';
      ParameterValue : 4),
    (ParameterName :'MinAuxConcChangeRate'  ;
      ParameterDescription : 'The minimum rate of change of auxin conc radially (ng/cm²/um)';
      ParameterValue : 0.00075),
    (ParameterName :'MinAuxConcDivision' ;
      ParameterDescription : 'Minimum auxin concentration required for mitosis (ng/cm²)';
      ParameterValue : 1.6),
    (ParameterName :'MinDDivision'  ;
      ParameterDescription : 'Minimum radial diameter for periclinal division (um)';
      ParameterValue : 12),
    (ParameterName :'MinTimeForMitosis'  ;
      ParameterDescription : 'The minimum time required between successive cell divisions (days)';
      ParameterValue : 3),
    (ParameterName :'MinTempXylem'  ;
      ParameterDescription : 'Minimum temperature for xylem development (deg C)';
      ParameterValue : 5),
    (ParameterName :'OptTempXylem'  ;
      ParameterDescription : 'Optimum temperature for xylem development (deg C)';
      ParameterValue : 20),
    (ParameterName :'MinOsmoticPotential'  ;
      ParameterDescription : 'Minimum osmotic potential achievable by the tree (MPa)';
      ParameterValue : -2.5),
    (ParameterName :'PMCMod'  ;
      ParameterDescription : 'Ratio of xylem:phloem divisions';
      ParameterValue : 3),
    (ParameterName :'PrimaryWallThickness';
      ParameterDescription : 'Thickness of the primary wall (um)';
      ParameterValue : 0.1),
    (ParameterName :'RDLRatio'  ;
      ParameterDescription : 'Ratio of tracheid length/radial growth (um/um)';
      ParameterValue : 0.01),
    (ParameterName :'RunningMeanDurationFoliage'  ;
      ParameterDescription : 'Duration of the running mean to integrate foliage effects (days)';
      ParameterValue : 35),
    (ParameterName :'RunningMeanDurationTemp'  ;
      ParameterDescription : 'Duration of the running mean to integrate foliage effects (days)';
      ParameterValue : 20),
    (ParameterName :'TemperatureAcclimation'  ;
      ParameterDescription : 'Maximum cumulative temperature sensitivity (deg C)';
      ParameterValue : 2),
    (ParameterName :'WallDensity' ;
      ParameterDescription : 'Density of the cell wall (g/cm3)';
      ParameterValue : 1.5),
    (ParameterName :'WallExtSensAux';
      ParameterDescription : 'Sensitivity of wall extensibility to auxin concentration';
      ParameterValue : 0.5),
    (ParameterName :'WallThickDurSensTemp'  ;
      ParameterDescription : 'Sensitivity of wall thickening duration to temperature';
      ParameterValue : 0.5),
    (ParameterName :'WaterPotGradHt';
      ParameterDescription : 'Gradient of water potential along the stem (MPa/m)';
      ParameterValue : 0.1),
    (ParameterName :'YieldThreshold';
      ParameterDescription : 'Turgor yield threshold for growth (MPa)';
      ParameterValue : 0.3)
  );

  DefaultParameterItems_RadiataStand : array[0..29] of DataObjects.TParametersList=
  (
    (ParameterName : 'maxAge';
      ParameterDescription : 'Determines rate of "physiological decline" of forest';
      ParameterValue : 50),
    (ParameterName : 'nAge';
      ParameterDescription : 'Parameters in age-modifier';
      ParameterValue : 4),
    (ParameterName : 'rAge';
      ParameterDescription : 'rAge';
      ParameterValue : 0.95),
    (ParameterName : 'fullCanAge';
      ParameterDescription : 'Age at full canopy cover (Y)';
      ParameterValue : 0),
    (ParameterName : 'k';
      ParameterDescription : 'Radiation extinction coefficient';
      ParameterValue : 0.5),
    (ParameterName : 'gammaR';
      ParameterDescription : 'Root turnover rate per month';
      ParameterValue : 0.015),
    (ParameterName : 'SWconst0';
      ParameterDescription : 'Soil water constant';
      ParameterValue : 0.7),

    (ParameterName : 'SWconst0';
      ParameterDescription : 'Soil water constant';
      ParameterValue : 0.7),
    (ParameterName : 'SWPower0';
      ParameterDescription : 'Power in the eqn for SW modifier';
      ParameterValue : 9),
    (ParameterName : 'MaxIntcptn';
      ParameterDescription : 'Max proportion of rainfall intercepted by canopy';
      ParameterValue : 0.15),
    (ParameterName : 'LAImaxIntcptn';
      ParameterDescription : 'LAI required for maximum canopy conductance';
      ParameterValue : 0),
    (ParameterName : 'MaxCond';
      ParameterDescription : 'Maximum canopy conductance (gc, m/s)';
      ParameterValue : 0.02),
    (ParameterName : 'SWconst0';
      ParameterDescription : 'Soil water constant';
      ParameterValue : 0.7)

  );




  gammaR = 0.015      'Root turnover rate per month
  SWconst0 = 0.7       'SW constants are 0.7 for sand,0.6 for sandy-loam,
                       '  0.5 for clay-loam, 0.4 for clay
  SWpower0 = 9         'Powers in the eqn for SW modifiers are 9 for sand,
                       '  7 for sandy-loam, 5 for clay-loam and 3 for clay
  MaxIntcptn = 0.15    'Max proportion of rainfall intercepted by canopy
  LAImaxIntcptn = 0    'LAI required for maximum rainfall interception
  MaxCond = 0.02       'Maximum canopy conductance (gc, m/s)
  LAIgcx = 3.33        'LAI required for maximum canopy conductance
  BLcond = 0.2         'Canopy boundary layer conductance, assumed constant
  CoeffCond = 0.05     'Determines response of canopy conductance to VPD
  y = 0.47             'Assimilate use efficiency
  Tmax = 40            '"Critical" biological temperatures: max, min
  Tmin = 8.5             '  and optimum. Reset if necessary/appropriate
  Topt = 16
  kF = 1               'Number of days production lost per frost days
  pFS2 = 1             'Foliage:stem partitioning ratios for D = 2cm
  pFS20 = 0.15         '  and D = 20cm
  aWs = 0.095          'Stem allometric parameters
  nWs = 2.4
  pRx = 0.8            'maximum root biomass partitioning
  pRn = 0.25           'minimum root biomass partitioning
  m0 = 0               'Value of m when FR = 0
  fN0 = 1              'Value of fN when FR = 0
  fNn = 0              'Power of (1-FR) in fN
  alphaCx = 0.06       'Canopy quantum efficiency
  poolFractn = 0       'Determines fraction of excess water that remains on site
  'Stem mortality
  gammaN1 = 0          'Coefficients in stem mortality rate
  gammaN0 = 0
  tgammaN = 2
  ngammaN = 1
  wSx1000 = 300        'Max tree stem mass (kg) likely in mature stands of 1000 trees/ha
  thinPower = 3 / 2    'Power in self-thinning law
  mF = 0               'Leaf mortality fraction
  mR = 0.2             'Root mortality fraction
  mS = 0.2             'Stem mortality fraction
  'Litterfall rate
  gammaF1 = 0.027       'Coefficients in monthly litterfall rate
  gammaF0 = 0.001
  tgammaF = 2
  'Specific leaf area
  SLA0 = 11            'specific leaf area at age 0 (m^2/kg)
  SLA1 = 4             'specific leaf area for mature trees (m^2/kg)
  tSLA = 2.5           'stand age (years) for SLA = (SLA0+SLA1)/2
  'Branch & bark fraction
  fracBB0 = 0.75       'branch & bark fraction at age 0 (m^2/kg)
  fracBB1 = 0.15       'branch & bark fraction for mature trees (m^2/kg)
  tBB = 2              'stand age (years) for fracBB = (fracBB0+fracBB1)/2
  'Basic density
  rho0 = 0.45        'basic density for older trees (t/m3)
  rho1 = 0.45        'ratio of basic density of young to old trees
  tRho = 4             'age at which density = average of old and young values
  'Mean stem height allometric relationship
  aH = 0
  nHB = 0
  nHN = 0
  'Stand volume allometric relationship
  aV = 0
  nVB = 0
  nVN = 0
  'Conversion factors
  Qa = -90             'intercept of net v. solar radiation relationship (W/m2)
  Qb = 0.8             'slope of net v. solar radiation relationship
  gDM_mol = 24         'conversion of mol to gDM
  molPAR_MJ = 2.3      'conversion of MJ to PAR


implementation

Procedure WriteDefaultParamSet(NewDataSetName : string);
var
  i,j : integer;
  mytest : string;
begin
  DataModule.DataModuleBoard.ADOTableInputParam.Active := false;

  DataModule.DataModuleBoard.ADOTableInputParam.TableName :=
    ProjectManager.SPECIESNAMESTABLE;
  DataModule.DataModuleBoard.ADOTableInputParam.Active := true;

  DataModule.DataModuleBoard.ADOTableInputParam.Append;
  DataModule.DataModuleBoard.ADOTableInputParam.FieldValues[ProjectManager.SPECIESNAMEFIELD]:=
    NewDataSetName;
  DataModule.DataModuleBoard.ADOTableInputParam.Post;

  DataModule.DataModuleBoard.ADOTableInputParam.Active := false;
  DataModule.DataModuleBoard.ADOTableInputParam.TableName :=
    ProjectManager.CAMBIUMPARAMSTABLE;
  DataModule.DataModuleBoard.ADOTableInputParam.Active := true;

  for i := 0 to length(RadiataDefaultParameterItems)-1 do begin
    DataModule.DataModuleBoard.ADOTableInputParam.Insert;

    j := i;
    DataModule.DataModuleBoard.ADOTableInputParam.FieldValues[ProjectManager.SPECIESNAMEFIELD]:=
      NewDataSetName;
    DataModule.DataModuleBoard.ADOTableInputParam.FieldValues[ProjectManager.PARAMNAMEFIELD]:=
      RadiataDefaultParameterItems[i].ParameterName;
    DataModule.DataModuleBoard.ADOTableInputParam.FieldValues[ProjectManager.PARAMDESCRIPTIONFIELD]:=
      RadiataDefaultParameterItems[i].ParameterDescription;
    DataModule.DataModuleBoard.ADOTableInputParam.FieldValues[ProjectManager.PARAMVALUEFIELD]:=
      RadiataDefaultParameterItems[i].ParameterValue;
    DataModule.DataModuleBoard.ADOTableInputParam.Post;
    //DataModule.
  end;
end;

end.
