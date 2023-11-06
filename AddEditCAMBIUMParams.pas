unit AddEditCAMBIUMParams;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons,DataObjects,DataModule,ProjectManager;



Procedure WriteDefaultParamSet(NewDataSetName : string;
  SpeciesNamesTable : String;
  ParamsTable : String;
  DefaultParamsArray : array of DataObjects.TParametersList);

const

  DefaultParameterItems_RadiataXylem : array[0..22] of DataObjects.TParametersList=
  (
    (ParameterName :'b0MOE'  ;
      ParameterDescription : 'Parameter 1 in the relationship between density/MFA and MOE';
      ParameterValue : 11.03),
    (ParameterName :'b1MOE'  ;
      ParameterDescription : 'Parameter 2 in the relationship between density/MFA and MOE';
      ParameterValue : -24),
    (ParameterName :'MinTemp'  ;
      ParameterDescription : 'Average daily temperature at which cambial activity ceases (deg C) )';
      ParameterValue : 4),
    (ParameterName :'LengthReductionatDivision'  ;
      ParameterDescription : 'Proportion of cell length after division';
      ParameterValue : 0.9),
    (ParameterName :'MaxMFA'  ;
      ParameterDescription : 'Maximum angle of microfibrils in the S2 wall layer (degrees)';
      ParameterValue : 70),
    (ParameterName :'MaxTRD'  ;
      ParameterDescription : 'Maximum diameter of a mature tracheid (µm)';
      ParameterValue : 56),
    (ParameterName :'MaxTLength'  ;
      ParameterDescription : 'Maximum length of a mature tracheid (µm)';
      ParameterValue : 3000),
    (ParameterName :'MaxDailyWE'  ;
      ParameterDescription : 'Maximum wall extensibility (µm/MPa/d)';
      ParameterValue : 16),
    (ParameterName :'MinDDivision'  ;
      ParameterDescription : 'Minimum radial diameter for periclinal division (µm)';
      ParameterValue : 12),
    (ParameterName :'MinCellCycle'  ;
      ParameterDescription : 'Minimum time required between successive cell divisions (cell cycle) (days)';
      ParameterValue : 3),
    (ParameterName :'EZCZRatio'  ;
      ParameterDescription : 'The ratio of enlarging to cambial cells when the cambial zone is 8 cells wide (# EZ cells/# CZ cells)';
      ParameterValue : 0.7),
    (ParameterName :'MinTurgor';
      ParameterDescription : 'Target turgor for growing cells (MPa)';
      ParameterValue : 1),
    (ParameterName :'YieldThreshold';
      ParameterDescription : 'Yield turgor threshold (MPa)';
      ParameterValue : 0.3),
    (ParameterName :'RDLRatio'  ;
      ParameterDescription : 'Ratio of tracheid length/radial growth (µm/µm)';
      ParameterValue : 10),
    (ParameterName :'WallDensity' ;
      ParameterDescription : 'Density of the cell wall (g/cm³)';
      ParameterValue : 1.5),
    (ParameterName :'JuvenileCoreFactor';
      ParameterDescription : 'Distance from crown apex at which mature wood production begins (m)';
      ParameterValue : 8),
    (ParameterName :'MFAFactor';
      ParameterDescription : 'Factor determining MFA responsiveness';
      ParameterValue : 0.4),
    (ParameterName :'VacFactor';
      ParameterDescription : 'Osmotic adjustment factor';
      ParameterValue : 0.05),
    (ParameterName :'MinOP';
      ParameterDescription : 'Minimum osmotic potential achievable by differenting cells in the cambial zone (MPa)';
      ParameterValue : -2.6),
    (ParameterName :'MaxWallRatio';
      ParameterDescription : 'Maximum ratio of wall area to cell cross sectional area';
      ParameterValue : 0.86),
    (ParameterName :'CritConcCellDeath';
      ParameterDescription : 'Critical concentration of carbohydrates for the cessation of secondary thickening (g/ml)';
      ParameterValue : 0.1),
    (ParameterName :'MaxWallThickRate';
      ParameterDescription : 'Maximum rate of wall thickening (µm³/d)';
      ParameterValue : 24000),
    (ParameterName :'ExtractionFactor';
      ParameterDescription : 'The rate of radial development of the latewood zone (µm/d)';
      ParameterValue : 3)
  );

  DefaultParameterItems_RadiataStand : array[0..38] of DataObjects.TParametersList=
  (
    (ParameterName : 'maxAge';
      ParameterDescription : 'Maximum stand age used in age modifier';
      ParameterValue : 250),
    (ParameterName : 'nAge';
      ParameterDescription : 'Power of relative age in function for fAge';
      ParameterValue : 4),
    (ParameterName : 'rAge';
      ParameterDescription : 'Relative age to give fAge = 0.5';
      ParameterValue : 0.5),
    (ParameterName : 'fullCanAge';
      ParameterDescription : 'Age at full canopy cover (Y)';
      ParameterValue : 6),
    (ParameterName : 'k';
      ParameterDescription : 'Radiation extinction coefficient';
      ParameterValue : 0.5),
    (ParameterName : 'gammaR';
      ParameterDescription : 'Root turnover rate per day';
      ParameterValue : 0.0005),
    (ParameterName : 'MaxIntcptn';
      ParameterDescription : 'Rainfall interception in a canopy with LAI for maximum interception (mm)';
      ParameterValue : 0.8),
    (ParameterName : 'LAImaxIntcptn';
      ParameterDescription : 'LAI at maximum canopy rainfall interception';
      ParameterValue : 5),
    (ParameterName : 'MaxCond';
      ParameterDescription : 'Maximum canopy conductance (gc, m/s)';
      ParameterValue : 0.02),
    (ParameterName : 'LAIgcx';
      ParameterDescription : 'LAI required for maximum canopy conductance';
      ParameterValue : 3),
    (ParameterName : 'BLCond';
      ParameterDescription : 'Canopy boundary layer conductance, assumed constant';
      ParameterValue : 0.2),
    (ParameterName : 'CoeffCond';
      ParameterDescription : 'Determines response of canopy conductance to VPD';
      ParameterValue : 0.05),
    (ParameterName : 'y';
      ParameterDescription : 'Assimilate use efficiency (Ratio NPP/GPP)';
      ParameterValue : 0.47),
    (ParameterName : 'TMax';
      ParameterDescription : 'Critical max temp (deg C)';
      ParameterValue : 32),
    (ParameterName : 'Tmin';
      ParameterDescription : 'Critical min temp (deg C)';
      ParameterValue : 0),
    (ParameterName : 'TOpt';
      ParameterDescription : 'Optimum temperature (deg C)';
      ParameterValue : 20),
    (ParameterName : 'pFS2';
      ParameterDescription : 'Foliage:stem partitioning ratios for stems with base diameter 2 cm';
      ParameterValue : 0.8),
    (ParameterName : 'pFS20';
      ParameterDescription : 'Foliage:stem partitioning ratios for stems with base diameter 20 cm';
      ParameterValue : 0.6),
    (ParameterName : 'pRx';
      ParameterDescription : 'Maximum root biomass partitioning';
      ParameterValue : 0.6),
    (ParameterName : 'pRn';
      ParameterDescription : 'Minimum root biomass partitioning';
      ParameterValue : 0.23),
    (ParameterName : 'm0';
      ParameterDescription : 'Value of m when FR = 0';
      ParameterValue : 0),
    (ParameterName : 'fN0';
      ParameterDescription : 'Value of fN when FR = 0';
      ParameterValue : 0.6),
    (ParameterName : 'fNn';
      ParameterDescription : 'Power of (1-FR) in fN';
      ParameterValue : 0),
    (ParameterName : 'alphaCx';
      ParameterDescription : 'Canopy quantum efficiency';
      ParameterValue : 0.055),
    (ParameterName : 'wSx1000';
      ParameterDescription : 'Max tree stem mass (kg) likely in mature stands of 1000 trees/ha';
      ParameterValue : 250),
    (ParameterName : 'thinPower';
      ParameterDescription : 'Power in self-thinning law';
      ParameterValue : 1.5),
    (ParameterName : 'mS';
      ParameterDescription : 'Fraction mean single-tree stem biomass lost per dead tree';
      ParameterValue : 0.2),
    (ParameterName : 'gammaF1';
      ParameterDescription : 'Maximum daily litterfall rate';
      ParameterValue : 0.0035),
    (ParameterName : 'gammaF0';
      ParameterDescription : 'Litterfall rate at t = 0 (1/day)';
      ParameterValue : 0.00003),
    (ParameterName : 'tgammaF';
      ParameterDescription : 'Age at which litterfall rate has median value (days)';
      ParameterValue : 990),
    (ParameterName : 'SLA0';
      ParameterDescription : 'Specific leaf area at age 0 (m^2/kg)';
      ParameterValue : 5),
    (ParameterName : 'SLA1';
      ParameterDescription : 'Specific leaf area for mature leaves (m^2/kg)';
      ParameterValue : 5),
    (ParameterName : 'tSLA';
      ParameterDescription : 'Stand age (years) for SLA = (SLA0 + SLA1)/2';
      ParameterValue : 3),
    (ParameterName : 'Qa';
      ParameterDescription : 'intercept of net v. solar radiation relationship (W/m2)';
      ParameterValue : -90),
    (ParameterName : 'Qb';
      ParameterDescription : 'slope of net v. solar radiation relationship';
      ParameterValue : 0.8),
    (ParameterName : 'PSIMin';
      ParameterDescription : 'Minimum pre-dawn leaf water potential before tree senescence (MPa)';
      ParameterValue : -2.6),
    {(ParameterName : 'DeltaPSIMax';
      ParameterDescription : 'Maximum diurnal leaf water potential decline in young trees (MPa)';
      ParameterValue : 1),}
    (ParameterName : 'RootConversion';
      ParameterDescription : 'The rate of root vertical growth per unit root mass (m/kg)';
      ParameterValue : 1),
    (ParameterName : 'MinHDRatio';
      ParameterDescription : 'The minimum height/base diameter ratio (m/cm)';
      ParameterValue : 0.5),
    (ParameterName : 'MaxHDRatio';
      ParameterDescription : 'The maximum height/base diameter ratio (m/cm)';
      ParameterValue : 1.1)
    {(ParameterName : 'TreeHtHyd';
      ParameterDescription : 'Effect of tree ht on minimum leaf water potential (MPa/m)';
      ParameterValue : 0.01) }
  );



implementation

Procedure WriteDefaultParamSet(NewDataSetName : string;
  SpeciesNamesTable : String;
  ParamsTable : String;
  DefaultParamsArray : array of DataObjects.TParametersList);
var
  i,j : integer;

begin
  DataModule.DataModuleBoard.ADOTableInputParam.Active := false;

  If ParamsTable = ProjectManager.CAMBIUMPARAMSTABLE then begin
    //only the creation of a new xylem parameter set can create a new, unique
    //parameter set name
    DataModule.DataModuleBoard.ADOTableInputParam.TableName :=
      SpeciesNamesTable;
    DataModule.DataModuleBoard.ADOTableInputParam.Active := true;

    DataModule.DataModuleBoard.ADOTableInputParam.Append;
    DataModule.DataModuleBoard.ADOTableInputParam.FieldValues[ProjectManager.SPECIESNAMEFIELD]:=
      NewDataSetName;
    DataModule.DataModuleBoard.ADOTableInputParam.Post;

    DataModule.DataModuleBoard.ADOTableInputParam.Active := false;
  end;

  DataModule.DataModuleBoard.ADOTableInputParam.TableName :=
    ParamsTable;
  DataModule.DataModuleBoard.ADOTableInputParam.Active := true;

  for i := 0 to length(DefaultParamsArray)-1 do begin
    DataModule.DataModuleBoard.ADOTableInputParam.Insert;

    //This was slapped in to try to fix out a wierd variable setting bug
    j := i;
    DataModule.DataModuleBoard.ADOTableInputParam.FieldValues[ProjectManager.SPECIESNAMEFIELD]:=
      NewDataSetName;
    DataModule.DataModuleBoard.ADOTableInputParam.FieldValues[ProjectManager.PARAMNAMEFIELD]:=
      DefaultParamsArray[i].ParameterName;
    DataModule.DataModuleBoard.ADOTableInputParam.FieldValues[ProjectManager.PARAMDESCRIPTIONFIELD]:=
      DefaultParamsArray[i].ParameterDescription;
    DataModule.DataModuleBoard.ADOTableInputParam.FieldValues[ProjectManager.PARAMVALUEFIELD]:=
      DefaultParamsArray[i].ParameterValue;
    DataModule.DataModuleBoard.ADOTableInputParam.Post;
    //DataModule.
  end;
end;

end.
