unit ProjectManager;

interface
  uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DataModule,ADODB,ScenarioManager,DB,DBGRids,General,
  OleAuto,ProjectWarnings;

type
  TSelectedScenariosInfo = array of TStringList;

  Function ConnectDatabase(dbName : String;
    CurrentADOConnection : TADOConnection;
    DBPassword : string): boolean;
  procedure CreateDataBase(dbName: string;
    CambiumDBPassword: String);
  Procedure CreateTables;
  Procedure GetAllScenarios(CurrentADOCommand: TADOCommand;
    CurrentADOTable : TADOTable;
    TableName : string;
    SummaryStat : Integer;
    ZoneWidthType : Integer;
    ZoneWidth: INteger;
    SortField: String);
  Function CompactAndRepair(DB: string): Boolean;

  {Function GetSelectedScenariosInfo(CurrentDBGrid: TDBGrid;
    CurrentDS: TDataSource;
    CurrentQuery: TADOQuery;
    ScenarioTypeFieldName: String;
    ScenarioNameFieldName: String;
    ScenarioCAMBIUMParamsFieldName : String;
    StemPositionFieldName : String;
    TreeTypeFieldName : String;
    SiteNameFieldName: String;
    WeatherDSNameFieldName : String;
    RegimeNameFieldName: String): TSelectedScenariosInfo;  }
  Function OpenProject (dbName : string;
    CurrentADOConnection : TADOConnection;
    CambiumDBPassword: String): boolean;
  Function CreateProject (dbName : string): boolean;


var
  CurrentOpenProject : String;
  ImagesDirectory : String;


const
  //Table names and fields:
  SITESTABLE = 'Sites';
  SITENAMESTABLE = 'SiteNames';
  SITENAMEFIELD = 'SiteName';
  SITELATFIELD = 'SiteLat';
  SOILDEPTHFIELD = 'SoilDepth';
  SOILTEXTUREFIELD = 'SoilTexture';
  SOILCLASSFIELD = 'SoilClass';
  SITEFRFIELD = 'FR';
  MINASWFIELD = 'MinASW';
  MAXASWFIELD = 'MaxASW';
  INITIALASWFIELD = 'InitialASW';

  CAMBIUMPARAMSTABLE = 'CAMBIUMParameters';
  TPGPARAMSTABLE = 'TPGParameters';
  SPECIESNAMESTABLE = 'ParameterSpecies';
  SPECIESNAMEFIELD = 'SpeciesName';
  PARAMNAMEFIELD = 'ParameterName';
  PARAMDESCRIPTIONFIELD = 'ParameterDescription';
  PARAMUNITSFIELD = 'Units';
  PARAMVALUEFIELD = 'ParameterValue';

  REGIMESTABLE = 'Regimes';
  REGIMENAMESTABLE = 'RegimeNames';
  REGIMENAMEFIELD = 'RegimeName';
  EVENTTYPEFIELD = 'EventType';
  EVENTDATEFIELD = 'EventDate';
  EVENTVALUEFIELD = 'EventValue';

  WEATHERDATASETNAMESTABLE = 'WeatherDatasets';
  WEATHERDATATABLE = 'WeatherData';
  WEATHERDATASETNAMEFIELD = 'DataSetName';
  WEATHERDATEFIELD = 'LogDate';
  MINTEMPFIELD =  'MinTemp';
  MAXTEMPFIELD = 'MaxTemp';
  QAFIELD = 'Qa';
  //VPDFIELD = 'VPD';
  RAINFIELD = 'Rainfall';
  EVAPFIELD = 'Evap';
  MINRHFIELD = 'MinRH';
  MAXRHFIELD = 'MaxRH';

  SCENARIOSTABLE = 'Scenarios';
  SCENARIONAMEFIELD = 'Scenarioname';
  SCENARIOTYPEFIELD = 'Scenariotype';
  SCENARIOSITEFIELD = 'Sitename';
  SCENARIOREGIMEFIELD = 'Regimename';
  SCENARIOWEATHERDATAFIELD = 'Weatherdataset';
  SCENARIOCAMBIUMPARAMSFIELD = 'CAMBIUMParameterSet';
  SCENARIOSTEMPOSFIELD = 'StemPosition';
  SCENARIOTREETYPEFIELD = 'TreeType';

  TEMPSCENARIOSUMMARYTABLE = 'TempFinalScenariosTable';
  RECORDCOUNTFIELD_LONG = 'Data records';
  TREEDIAMFIELD_LONG = 'Diameter UB (cm)';
  COREDENSFIELD_LONG = 'Core mean WD (kg/m³)';
  OUTERDENSFIELD_LONG = 'Outer mean WD (kg/m³)';
  INNERDENSFIELD_LONG = 'Inner mean WD (kg/m³)';
  COREMOEFIELD_LONG = 'Core mean MOE (GPa)';
  OUTERMOEFIELD_LONG = 'Outer mean MOE (GPa)';
  INNERMOEFIELD_LONG = 'Inner mean MOE (GPa)';
  SEGSIZE_LONG = 'Segment (µm)';
  SCENARIONAMEFIELD_LONG = 'Scenario name';
  SCENARIOTYPEFIELD_LONG = 'External data source';
  SCENARIOSITEFIELD_LONG = 'Site name';
  SCENARIOREGIMEFIELD_LONG = 'Regime';
  SCENARIOWEATHERDATAFIELD_LONG = 'Weather dataset';
  SCENARIOCAMBIUMPARAMSFIELD_LONG = 'CAMBIUM parameter set';
  SCENARIO3PGPARAMSFIELD_LONG = 'Stand model parameter set';
  SCENARIOSTEMPOSFIELD_LONG = 'Stem position (m)';
  SCENARIOTREETYPEFIELD_LONG = 'Tree type';
  DAILYDATARECORDS_LONG = 'Daily data rec count';

  CABALASCENARIOSTABLE = 'CABALAScenarios';
  CABALASCENARIONAMEFIELD = 'CABALAScenarioName';
  CABALAPROJECTFIELD = 'CaBalaProject';

  TEMPALLSCENARIOSTABLE = 'TempAllScenarios';
  RECORDCOUNTFIELD = 'RecordCount';
  TREEDBHFIELD = 'TreeDBH';
  WMDFIELD = 'WMD';
  WMMOEFIELD = 'WMMOE';
  WMMFAFIELD = 'WMMFA';

  TEMPDATAEDITTINGTABLE = 'temptable';

  CAMBIUMSEGMENTSDATATABLE = 'SegmentsData';
  TREENUMBERFIELD = 'TreeNumber';
  STEMPOSITIONFIELD = 'StemPosition';
  STARTDATEFIELD = 'StartDate';
  ENDDATEFIELD = 'EndDate';
  SEGMENTNUMBERFIELD = 'SegmentNumber';
  SEGMENTPOSITIONFIELD = 'SegmentPosition';
  SEGMENTWIDTHFIELD = 'SegmentWidth';
  MEANRDFIELD = 'MeanTRD';
  MEANTDFIELD = 'MeanTTD';
  MEANLENGTHFIELD = 'MeanTL';
  MEANWTFIELD = 'MeanTWT';
  WOODDENSITYFIELD = 'WoodDensity';
  MFAFIELD = 'MFA';
  MOEFIELD = 'MOE';
  CELLDENSITYFIELD = 'CellDensity';
  RINGINSEGMENTMARKERFIELD = 'RinginSegment';

  DAILYOUTPUTDATATABLE = 'DailyData';
  DAILYDATADATEFIELD = 'LogDate';
  STEMDIAMFIELD = 'StemDiameter';
  BASESTEMDIAMFIELD = 'StemDiameterBase';
  DAILYDATADBHFIELD = 'DBH';
  EXCESSCARBFIELD = 'ExcessCarb';
  TREENPPFIELD = 'TreeNPP';
  STANDNPPFIELD = 'StandNPP';
  STEMALLOCFIELD = 'StemAllocCarb';
  VOLSPECSTEMALLOCFIELD = 'VolSpecStemAllocCarb';  //Using this redundant field for tree age
  TREEHEIGHTFIELD = 'TreeHeight';
  MEANCZCOUNTFIELD = 'MeanCZCount';
  MEANEZCOUNTFIELD = 'MeanEZCount';
  MEANTZCOUNTFIELD = 'MeanTZCount';
  MEANDAYSGROWINGFIELD = 'MeanDaysCellGrowth';
  MEANDAYSSECTHICKFIELD = 'MeanDaysSecThick';
  MEANWTRFIELD = 'WallThickRate';  //Using redundant field for transp
  MEANRDGRFIELD = 'RadGrowthRate';  //Using redundant field for rain
  TOTSTEMVOLFIELD = 'StemVolume';
  WSFIELD = 'WSStand';
  WFFIELD = 'WFStand';
  WRFIELD = 'WRStand';
  CZVOLFIELD = 'CZVolume';
  LIVINGSTEMVOLFIELD = 'LivingStemVolume';
  TOTCELLPOPFIELD = 'LivingCellPop';
  MEANLIVINGCELLVOLFIELD = 'MeanLivingCellVol';
  MEANCZCELLVOLFIELD = 'MeanCZCellVol';
  HOURSOFGROWTHFIELD = 'HoursofGrowth';
  MINLWPFIELD = 'MinLWP';
  MAXLWPFIELD = 'MaxLWP';
  MINOPField = 'MinOP';
  MEANCELLCYCLEDURFIELD = 'CellCycleDur';
  FTEMPFIELD = 'fTemp';
  LAIFIELD = 'LAI';
  SPHFIELD = 'SPH';
  ASWRZFIELD = 'ASWRootZone';


  REALSSDATATABLE  = 'SSData';
  SSDATASETNAMEFIELD = 'SampleName';
  SSPOSFIELD = 'SSPosition';

  SSRINGPOSITIONSTABLE = 'SSRingPositions';
  RINGYEARFIELD = 'RingYear';
  RINGPOSFIELD = 'RingPos';
  RINGWIDTHFIELD = 'RingWidth';

  MEANRINGPROPSTABLE = 'RingData';
  RINGPROPSLABELFIELD = 'Label';
  RINGPROPSYEARFIELD = 'RingYear';
  RINGPROPSMEANWDFIELD = 'MeanWD';
  RINGPROPSMEANTRDFIELD = 'MeanTRD';
  RINGPROPSMEANWTFIELD = 'MeanWT';
  RINGPROPSMEANMFAFIELD = 'MeanMFA';
  RINGPROPSMEANMOEFIELD = 'MeanMOE';
  RINGPROPSWDSDFIELD = 'WDStDev';
  RINGPROPSTRDSDFIELD = 'TRDStDev';
  RINGPROPSWTSDFIELD = 'WTStDev';
  RINGPROPSMFASDFIELD = 'MFAStDev';
  RINGPROPSMOESDFIELD = 'MOEStDev';

  REALMENSURATIONDATATABLE = 'MensurationData';
  MENSDATEFIELD = 'LogDate';
  MENSDATASETNAMEFIELD = 'DataSetName';
  DBHFIELD = 'DBH';
  MEASTREEHEIGHTFIELD = 'TreeHeight';
  CROWNLENGTHFIELD = 'CrownLength';
  STEMVOLFIELD = 'StemVolume';

  DENDROMETERDATATABLE = 'DendrometerData';
  DENDRODATEFIELD = 'LogDate';
  DENDRODATASETNAMEFIELD = 'DataSetName';
  DENDRORADIALPOSFIELD = 'RadialPosition';

  RESCALEDWOODPROPSTABLE = 'RescaledWoodData';
  RESCALEDATASETNAMEFIELD = 'DataSetName';
  RESCALEDATEFIELD = 'LogDate';
  RESCALEDENSITYFIELD = 'WoodDensity';
  RESCALETRDFIELD = 'TracheidRD';
  RESCALETWTFIELD = 'TracheidWT';
  RESCALEMFAFIELD = 'MFA';

  CAMBIALZONEPROPSTABLE = 'CambialZoneData';
  CZPROPSDATEFIELD = 'LogDate';
  CZPROPSCZCOUNTFIELD = 'CZCount';
  CZPROPSEZCOUNTFIELD = 'EZCount';
  CZPROPSTZCOUNTFIELD = 'TZCount';
  CZPROPSMEANCZCELLRD = 'CZCellRD';
  CZPROPSCELLCYCLEFIELD = 'CellCycleDur';
  CZPROPSENLDURFIELD = 'EnlDur';
  CZPROPSTHICKDURFIELD = 'ThickDur';
  CZPROPSENLRATEFIELD = 'EnlRate';
  CZPROPSTHICKRATEFIELD = 'ThickRate';

  SITEDATACODE = 1;
  REGIMEDATACODE = 2;
  WEATHERDATACODE = 3;
  PARAMSCODE = 4;
  //TPGPARAMS = 5;

  CAMBIUMDBPASSWORD = 'WoodIsGood99!';



implementation

Uses SummaryStats;


Function CreateProject (dbName : string): boolean;
begin
  Result := False;

  try
    ProjectManager.CreateDataBase(dbName,
      CAMBIUMDBPASSWORD);
    if ProjectManager.ConnectDatabase(dbName,
      DataModule.DataModuleBoard.ADOConnectionCAMBIUM,
      CAMBIUMDBPASSWORD) then begin
      ProjectManager.CreateTables;
      messagedlg('The project was successfully created',mtInformation,[mbOK],0);
      Result := True;
    end;
  except
    on E: Exception do begin
      messagedlg('The project could not be created: ' + E.Message,
        mtError,[mbOK],0);
      If FileExists (dbName) then
        DeleteFile(dbName);
      Result := False;
    end;
  end;
end;

{Function CheckTablesOK (TablesList : TStringList):boolean;
var
  i,j : integer;

begin
  j := 0;

  for i := 0 to TablesList.Count - 1 do begin
    if TablesList.Strings[i] = CAMBIUMPARAMSTABLE then
      j := j + 1;
    if TablesList.Strings[i] = SITESTABLE then
      j := j + 1;
    if TablesList.Strings[i] = SITENAMESTABLE then
      j := j + 1;
    if TablesList.Strings[i] = REGIMESTABLE then
      j := j + 1;
    if TablesList.Strings[i] = REGIMENAMESTABLE then
      j := j + 1;
    if TablesList.Strings[i] = WEATHERDATATABLE then
      j := j + 1;
    if TablesList.Strings[i] = TPGPARAMSTABLE then
      j := j + 1;
    if TablesList.Strings[i] = SPECIESNAMESTABLE then
      j := j + 1;
    if TablesList.Strings[i] = WEATHERDATASETNAMESTABLE then
      j := j + 1;
    if TablesList.Strings[i] = SCENARIOSTABLE then
      j := j + 1;
    if TablesList.Strings[i] = CABALASCENARIOSTABLE then
      j := j + 1;
    if TablesList.Strings[i] = TEMPALLSCENARIOSTABLE then
      j := j + 1;
    if TablesList.Strings[i] = CAMBIUMSEGMENTSDATATABLE then
      j := j + 1;
    if TablesList.Strings[i] = REALSSDATATABLE then
      j := j + 1;
    if TablesList.Strings[i] = REALMENSURATIONDATATABLE then
      j := j + 1;
    if TablesList.Strings[i] = DAILYOUTPUTDATATABLE then
      j := j + 1;
    if TablesList.Strings[i] = DENDROMETERDATATABLE then
      j := j + 1;
    if TablesList.Strings[i] = RESCALEDWOODPROPSTABLE then
      j := j + 1;

  end;

  Result := true;

  //if j < TablesList.Count - 2 then
    //Result := false
    //Ignore the temp editting table
  //else
    //Result := true;
end;   }

Function GetSelectedScenariosInfo(CurrentDBGrid: TDBGrid;
  CurrentDS: TDataSource;
  CurrentQuery: TADOQuery;
  ScenarioTypeFieldName: String;
  ScenarioNameFieldName: String;
  ScenarioCAMBIUMParamsFieldName : String;
  StemPositionFieldName : String;
  TreeTypeFieldName : String;
  SiteNameFieldName: String;
  WeatherDSNameFieldName : String;
  RegimeNameFieldName: String): TSelectedScenariosInfo;
var
  i : integer;
  ScenarioInfoString : TStringList;
begin
  SetLength(Result,CurrentDBGrid.SelectedRows.Count);

  CurrentQuery.First;

  if CurrentDBGrid.SelectedRows.Count > 0 then begin

    for i := 0 to CurrentDBGrid.SelectedRows.Count - 1 do begin
      ScenarioInfoString := TStringList.Create;
      ScenarioInfoString.Clear;

      CurrentDS.DataSet.GotoBookmark(Pointer(CurrentDBGrid.SelectedRows.Items[i]));
      ScenarioInfoString.Add(CurrentQuery.FieldByName(ScenarioTypeFieldName).AsString);
      ScenarioInfoString.Add(CurrentQuery.FieldByName(ScenarioNameFieldName).AsString);
      ScenarioInfoString.Add(CurrentQuery.FieldByName(ScenarioCAMBIUMParamsFieldName).AsString);
      ScenarioInfoString.Add(CurrentQuery.FieldByName(StemPositionFieldName).AsString);
      ScenarioInfoString.Add(CurrentQuery.FieldByName(TreeTypeFieldName).AsString);
      ScenarioInfoString.Add(CurrentQuery.FieldByName(SiteNameFieldName).AsString);
      ScenarioInfoString.Add(CurrentQuery.FieldByName(WeatherDSNameFieldName).AsString);
      ScenarioInfoString.Add(CurrentQuery.FieldByName(RegimeNameFieldName).AsString);

      CurrentQuery.next;

      Result[i] := ScenarioInfoString;
    end;
  end else
    messagedlg('No scenarios selected',mtError,[mbOK],0);
end;


Function OpenProject (dbName : string; CurrentADOConnection : TADOConnection;
  CambiumDBPassword: String): boolean;
var
  TableNamesList : TStringList;

begin
  Result := false;
  TableNamesList := TStringList.create;

  if ProjectManager.ConnectDatabase(dbName, CurrentADOConnection,CambiumDBPassword) then begin
    CurrentADOConnection.GetTableNames(TableNamesList);
    //if CheckTablesOK(TableNamesList) then begin
      Result := True
    {end else begin
      Result := false;
      messagedlg('The selected file cannot be used by CAMBIUM',mtError,[mbOK],0);
      CurrentADOConnection.Connected := false;
    end;}
  end else
      Result := false;
end;

function CompactAndRepair(DB: string): Boolean; {DB = Path to Access Database}
var
  v: OLEvariant;
begin
  Result := True;

  try
    v := CreateOLEObject('JRO.JetEngine');
    try
      v.CompactDatabase('Provider=Microsoft.Jet.OLEDB.4.0;Jet OLEDB:Database Password="' +
                        CAMBIUMDBPASSWORD + '";Data Source=' + DB,
                        'Provider=Microsoft.Jet.OLEDB.4.0;Jet OLEDB:Database Password="' +
                        CAMBIUMDBPASSWORD + '";Data Source=' + DB +
                        'x;Jet OLEDB:Engine type=5');


      DeleteFile(DB);
      RenameFile(DB+'x',DB);
    finally
      V := Unassigned;
    end;
  except
    Result := False;
  end;
end;

Procedure GetAllScenarios(CurrentADOCommand: TADOCommand;
  CurrentADOTable : TADOTable;
  TableName : string;
  SummaryStat : Integer;
  ZoneWidthType : Integer;
  ZoneWidth : Integer;
  SortField : String);
var
  SQLString : string;
  SummaryString,TableLinkString,SummaryStringOuter,SummaryStringInner : String;
begin
  SQLString := '';
  SummaryString := '';
  TableLinkString := '';
  SummaryStringOuter := '';
  SummaryStringInner := '';

  case ZoneWidthType of
    SummaryStats.DISTSUMMARY: begin
      SummaryStringOuter := 'TempSummaryTable.MaxSegPos-' + CAMBIUMSEGMENTSDATATABLE + '.' + SEGMENTPOSITIONFIELD + '<= ' +  inttostr(ZoneWidth*1000);
      SummaryStringInner := CAMBIUMSEGMENTSDATATABLE + '.' + SEGMENTPOSITIONFIELD + '<= ' + inttostr(ZoneWidth*1000);
    end;
    SummaryStats.RINGSUMMARY: begin
      SummaryStringOuter := 'TempSummaryTable.MaxRingNum-' + CAMBIUMSEGMENTSDATATABLE + '.' + RINGINSEGMENTMARKERFIELD + '<= ' +  inttostr(ZoneWidth);
      SummaryStringInner := CAMBIUMSEGMENTSDATATABLE + '.' + RINGINSEGMENTMARKERFIELD + '<= ' + inttostr(ZoneWidth);
    end;
  end;

  SQLString := 'DELETE * FROM ' + TEMPALLSCENARIOSTABLE;

  CurrentADOCommand.CommandText := SQLString;
  CurrentADOCommand.Execute;

  if General.TableExists('TempDailyDataCountTable',datamodule.DataModuleBoard.ADOConnectionCAMBIUM) then begin
    SQLString := 'DROP TABLE ' +  'TempDailyDataCountTable';

    CurrentADOCommand.CommandText := SQLString;
    CurrentADOCommand.execute;
  end;

  SQLString := 'SELECT ' +  ProjectManager.DAILYOUTPUTDATATABLE + '.' +
    SCENARIONAMEFIELD + ', ' +
    'COUNT(' +
    DAILYOUTPUTDATATABLE + '.' + SCENARIONAMEFIELD + ') AS DDRecordCount ' +
    ' Into TempDailyDataCountTable FROM ' +
    DAILYOUTPUTDATATABLE + ' GROUP BY ' +
    DAILYOUTPUTDATATABLE + '.' + SCENARIONAMEFIELD;

  CurrentADOCommand.CommandText := SQLString;
  CurrentADOCommand.execute;

  if General.TableExists('TempSummaryTable',datamodule.DataModuleBoard.ADOConnectionCAMBIUM) then begin
    SQLString := 'DROP TABLE ' +  'TempSummaryTable';

    CurrentADOCommand.CommandText := SQLString;
    CurrentADOCommand.execute;
  end;


  SQLString := 'SELECT ' +  CAMBIUMSEGMENTSDATATABLE + '.' +
    SCENARIONAMEFIELD + ', ' +
    'COUNT(' +
    CAMBIUMSEGMENTSDATATABLE + '.' + SCENARIONAMEFIELD + ') AS RecordCount, ' +
    'MAX(' + CAMBIUMSEGMENTSDATATABLE + '.' + SEGMENTPOSITIONFIELD + ') AS MaxSegPos, ' +
    'MAX(' + CAMBIUMSEGMENTSDATATABLE + '.' + RINGINSEGMENTMARKERFIELD + ') AS MaxRingNum, ' +
    'MAX(' + CAMBIUMSEGMENTSDATATABLE + '.' + SEGMENTWIDTHFIELD + ') AS MaxSegWidth, ' +
    'AVG(' + CAMBIUMSEGMENTSDATATABLE + '.' + MOEFIELD + ') AS MeanMOE, ' +
    'AVG(' + CAMBIUMSEGMENTSDATATABLE + '.' + WOODDENSITYFIELD + ') AS MeanDens ' +
    ' Into TempSummaryTable FROM ' +
    CAMBIUMSEGMENTSDATATABLE + ' GROUP BY ' +
    CAMBIUMSEGMENTSDATATABLE + '.' + SCENARIONAMEFIELD;

  CurrentADOCommand.CommandText := SQLString;
  CurrentADOCommand.execute;

  if General.TableExists('TempOuterTable',datamodule.DataModuleBoard.ADOConnectionCAMBIUM) then begin
    SQLString := 'DROP TABLE ' +  'TempOuterTable';

    CurrentADOCommand.CommandText := SQLString;
    CurrentADOCommand.execute;
  end;

  SQLString := 'SELECT ' +  CAMBIUMSEGMENTSDATATABLE + '.' +
    SCENARIONAMEFIELD + ', ' +
    'AVG(' + CAMBIUMSEGMENTSDATATABLE + '.' + MOEFIELD + ') AS MeanMOEOuter, ' +
    'AVG(' + CAMBIUMSEGMENTSDATATABLE + '.' + WOODDENSITYFIELD + ') AS MeanDensOuter ' +
    ' Into TempOuterTable FROM ' +
    CAMBIUMSEGMENTSDATATABLE +
    ' INNER JOIN ' +
    'TempSummaryTable ON ' +
    CAMBIUMSEGMENTSDATATABLE + '.' + SCENARIONAMEFIELD + '=' +
    'TempSummaryTable.' + SCENARIONAMEFIELD +
    ' WHERE ' +
    SummaryStringOuter +
    ' GROUP BY ' +
    CAMBIUMSEGMENTSDATATABLE + '.' + SCENARIONAMEFIELD;

  CurrentADOCommand.CommandText := SQLString;
  CurrentADOCommand.execute;

  if General.TableExists('TempInnerTable',datamodule.DataModuleBoard.ADOConnectionCAMBIUM) then begin
    SQLString := 'DROP TABLE ' +  'TempInnerTable';

    CurrentADOCommand.CommandText := SQLString;
    CurrentADOCommand.execute;
  end;

  SQLString := 'SELECT ' +  CAMBIUMSEGMENTSDATATABLE + '.' +
    SCENARIONAMEFIELD + ', ' +
    'AVG(' + CAMBIUMSEGMENTSDATATABLE + '.' + MOEFIELD + ') AS MeanMOEInner, ' +
    'AVG(' + CAMBIUMSEGMENTSDATATABLE + '.' + WOODDENSITYFIELD + ') AS MeanDensInner ' +
    ' Into TempInnerTable FROM ' +
    CAMBIUMSEGMENTSDATATABLE +
    ' INNER JOIN ' +
    'TempSummaryTable ON ' +
    CAMBIUMSEGMENTSDATATABLE + '.' + SCENARIONAMEFIELD + '=' +
    'TempSummaryTable.' + SCENARIONAMEFIELD +
    ' WHERE ' +
    SummaryStringInner +
    ' GROUP BY ' +
    CAMBIUMSEGMENTSDATATABLE + '.' + SCENARIONAMEFIELD;

  CurrentADOCommand.CommandText := SQLString;
  CurrentADOCommand.execute;

  case SummaryStat of
    WHOLECOREMEAN : begin
      SummaryString := 'ROUND(TempSummaryTable.MeanDens,0)' + ' as [' + COREDENSFIELD_LONG + '],' +
      'ROUND(TempSummaryTable.MeanMOE,1)' + ' as [' + COREMOEFIELD_LONG + '],';

      TableLinkString := ')';
    end;
    OUTERCOREMEAN : begin
      SummaryString := 'ROUND(TempOuterTable.MeanDensOuter,0)' + ' as [' + OUTERDENSFIELD_LONG + '],' +
      'ROUND(TempOuterTable.MeanMOEOuter,1)' + ' as [' + OUTERMOEFIELD_LONG + '],';

      TableLinkString := 'LEFT JOIN TempOuterTable ' +
      'ON ' + SCENARIOSTABLE + '.' + SCENARIONAMEFIELD + '=' +
      'TempOuterTable.' + SCENARIONAMEFIELD + ')';
    end;
    INNERCOREMEAN : begin
      SummaryString := 'ROUND(TempInnerTable.MeanDensInner,0)' + ' as [' + INNERDENSFIELD_LONG + '],' +
      'ROUND(TempInnerTable.MeanMOEInner,1)' + ' as [' + INNERMOEFIELD_LONG + '],';

      TableLinkString := ' LEFT JOIN TempInnerTable ' +
      'ON ' + SCENARIOSTABLE + '.' + SCENARIONAMEFIELD + '=' +
      'TempInnerTable.' + SCENARIONAMEFIELD + ')';
    end;
  end;

  CurrentADOTable.Active := false;

  if General.TableExists( TEMPSCENARIOSUMMARYTABLE,datamodule.DataModuleBoard.ADOConnectionCAMBIUM) then begin
    SQLString := 'DROP TABLE ' +   TEMPSCENARIOSUMMARYTABLE;

    CurrentADOCommand.CommandText := SQLString;
    CurrentADOCommand.execute;
  end;

  SQLString := '';
  SQLString := 'SELECT ' +
    //'TempRecordCountTable.RecordCount' + ' as [' + RECORDCOUNTFIELD_LONG + '],' +
    SCENARIOSTABLE + '.' + SCENARIONAMEFIELD + ' as [' + SCENARIONAMEFIELD_LONG + '],' +
    'ROUND(TempSummaryTable.MaxSegPos/10000*2,1)' + ' as [' + TREEDIAMFIELD_LONG + '],' +
    SummaryString +
    'TempSummaryTable.MaxSegWidth' + ' as [' + SEGSIZE_LONG + '],' +
    SCENARIOTYPEFIELD + '+ " (" +' + CABALASCENARIOSTABLE + '.' +  CABALASCENARIONAMEFIELD  + '+")" as [' + SCENARIOTYPEFIELD_LONG + '],' +
    SCENARIOCAMBIUMPARAMSFIELD  + ' as [' + SCENARIOCAMBIUMPARAMSFIELD_LONG + '],' +
    //SCENARIOSTABLE + '.' + SCENARIOTREETYPEFIELD + ' as [' + SCENARIOTREETYPEFIELD_LONG + '],' +
    SCENARIOSTABLE + '.' + SCENARIOSTEMPOSFIELD  + ' as [' + SCENARIOSTEMPOSFIELD_LONG + '],' +
    SCENARIOSITEFIELD + ' as [' + SCENARIOSITEFIELD_LONG + '],' +
    SCENARIOREGIMEFIELD + ' as [' + SCENARIOREGIMEFIELD_LONG + '],' +
    SCENARIOWEATHERDATAFIELD + ' as [' + SCENARIOWEATHERDATAFIELD_LONG + '],' +
    'TempDailyDataCountTable.DDRecordCount' + ' as [' + DAILYDATARECORDS_LONG + ']' +
    ' Into ' +  TEMPSCENARIOSUMMARYTABLE +
    ' FROM ((((' +
    SCENARIOSTABLE + ')' +
    ' LEFT JOIN ' +
    'TempSummaryTable ' +
    'ON ' + SCENARIOSTABLE + '.' + SCENARIONAMEFIELD + '=' +
    'TempSummaryTable.' + SCENARIONAMEFIELD + ')' +
    TableLinkString +
    ' LEFT JOIN ' +
    CABALASCENARIOSTABLE +
    ' ON ' + SCENARIOSTABLE + '.' + SCENARIONAMEFIELD + '=' +
    CABALASCENARIOSTABLE + '.' + SCENARIONAMEFIELD + ')' +
    ' LEFT JOIN ' +
    'TempDailyDataCountTable' +
    ' ON ' + SCENARIOSTABLE + '.' + SCENARIONAMEFIELD + '=' +
    'TempDailyDataCountTable' + '.' + SCENARIONAMEFIELD;
    //' ORDER BY [' +
    //SortField + '] ASC';
    {'[' + SCENARIOSTABLE + '.' + SCENARIOTYPEFIELD + '] ASC' + ',' +
    '[' + SCENARIOSTABLE + '.' + SCENARIONAMEFIELD + '] ASC' + ',' +
    '[TempSummaryTable.MeanDens] ASC';}

    CurrentADOCommand.CommandText := SQLString;
    CurrentADOCommand.execute;

    CurrentADOTable.TableName :=  TEMPSCENARIOSUMMARYTABLE;
    CurrentADOTable.Active := true;
end;


procedure CreateDataBase(dbName: string;
  CambiumDBPassword: String);
var
 DataSource : string;


begin
 DataSource :=
    'Provider=Microsoft.Jet.OLEDB.4.0' +
    ';Jet OLEDB:Database Password=' + CambiumDBPassword +
    ';User ID = Admin' +
    ';Data Source=' + dbName +
    ';Jet OLEDB:Engine Type=4';

  DataModule.DataModuleBoard.Catalog1.Create1(DataSource);
end;

Function ConnectDatabase(dbName: string;
  CurrentADOConnection : TADOConnection;
  DBPassword:string): boolean;
var
  DataSource : string;
begin
  Result := False;
  CurrentADOConnection.Connected := false;
  DataSource :=
     'Provider=Microsoft.Jet.OLEDB.4.0'+
     ';Data Source=' + dbName +
     ';Jet OLEDB:Database Password=' + DBPassword + ';' +
     ';Persist Security Info=False';

  try
    CurrentADOConnection.ConnectionString := DataSource;
    CurrentADOConnection.LoginPrompt := False;
    CurrentADOConnection.Connected := True;
    Result := True
  except
    Result := false;
  end;
end;

procedure CreateTables;
var
  cs : string;
begin
  cs:='CREATE TABLE ' + SITENAMESTABLE + ' (' +
       SITENAMEFIELD + ' TEXT(50))';
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.CommandText := cs;
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.Execute;

  cs:='CREATE INDEX idxPrimary ON ' +  SITENAMESTABLE +
    ' (' + SITENAMEFIELD + ') WITH PRIMARY';
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.CommandText := cs;
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.Execute;


  cs:='CREATE TABLE ' + SITESTABLE + ' (' +
       SITENAMEFIELD + ' TEXT(50) CONSTRAINT idxsite REFERENCES ' +
        SITENAMESTABLE + ' (' + SITENAMEFIELD + '), ' +
       SITELATFIELD + ' Double,' +
       SOILDEPTHFIELD + ' Double,' +
       SITEFRFIELD + ' Single,' +
       MINASWFIELD + ' Double,' +
       MAXASWFIELD + ' Double,' +
       INITIALASWFIELD + ' Double,' +
       SOILCLASSFIELD + ' DOUBLE,' +
       SOILTEXTUREFIELD + ' TEXT(50))';
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.CommandText := cs;
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.Execute;

  cs:='CREATE INDEX idxPrimary ON ' +  SITESTABLE +
    ' (' + SITENAMEFIELD + ') WITH PRIMARY';
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.CommandText := cs;
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.Execute;

  cs:='CREATE TABLE ' + SPECIESNAMESTABLE + ' (' +
       SPECIESNAMEFIELD + ' TEXT(50))';
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.CommandText := cs;
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.Execute;

  cs:='CREATE INDEX idxPrimary ON ' +  SPECIESNAMESTABLE +
    ' (' + SPECIESNAMEFIELD + ') WITH PRIMARY';
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.CommandText := cs;
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.Execute;

  cs:='CREATE TABLE ' + CAMBIUMPARAMSTABLE + ' (' +
       SPECIESNAMEFIELD + ' TEXT(50) CONSTRAINT idxcambiumparams REFERENCES ' +
       SPECIESNAMESTABLE + ' (' + SPECIESNAMEFIELD + '), ' +
       PARAMNAMEFIELD + ' TEXT(50),' +
       PARAMUNITSFIELD + ' TEXT(50),' +
       PARAMDESCRIPTIONFIELD + ' TEXT(250),' +
       PARAMVALUEFIELD + ' Double)';
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.CommandText := cs;
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.Execute;

  cs:='CREATE INDEX idxPrimary ON ' +  CAMBIUMPARAMSTABLE +
    ' (' + SPECIESNAMEFIELD + ',' + PARAMNAMEFIELD + ') WITH PRIMARY';
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.CommandText := cs;
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.Execute;

  cs:='CREATE TABLE ' + TPGPARAMSTABLE + ' (' +
       SPECIESNAMEFIELD + ' TEXT(50) CONSTRAINT idxcambiumparams2 REFERENCES ' +
       SPECIESNAMESTABLE + ' (' + SPECIESNAMEFIELD + '), ' +
       PARAMNAMEFIELD + ' TEXT(50),' +
       PARAMUNITSFIELD + ' TEXT(50),' +
       PARAMDESCRIPTIONFIELD + ' TEXT(250),' +
       PARAMVALUEFIELD + ' Double)';
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.CommandText := cs;
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.Execute;

  cs:='CREATE INDEX idxPrimary ON ' +  TPGPARAMSTABLE +
    ' (' + SPECIESNAMEFIELD + ',' + PARAMNAMEFIELD + ') WITH PRIMARY';
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.CommandText := cs;
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.Execute;

  cs:='CREATE TABLE ' + REGIMENAMESTABLE + ' (' +
       REGIMENAMEFIELD + ' TEXT(50))';
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.CommandText := cs;
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.Execute;

  cs:='CREATE INDEX idxPrimary ON ' +  REGIMENAMESTABLE +
    ' (' + REGIMENAMEFIELD + ') WITH PRIMARY';
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.CommandText := cs;
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.Execute;


  cs:='CREATE TABLE ' + REGIMESTABLE + ' (' +
       REGIMENAMEFIELD + ' TEXT(50) CONSTRAINT idxregime REFERENCES ' +
        REGIMENAMESTABLE + ' (' + REGIMENAMEFIELD + '), ' +
       EVENTTYPEFIELD + ' TEXT(50),' +
       EVENTDATEFIELD + ' DATE,' +
       EVENTVALUEFIELD + ' Double)';
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.CommandText := cs;
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.Execute;

  cs:='CREATE INDEX idxPrimary ON ' +  REGIMESTABLE +
    ' (' + REGIMENAMEFIELD + ',' + EVENTTYPEFIELD + ',' + EVENTDATEFIELD + ') WITH PRIMARY';
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.CommandText := cs;
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.Execute;

  cs:='CREATE TABLE ' + WEATHERDATASETNAMESTABLE + ' (' +
       WEATHERDATASETNAMEFIELD + ' TEXT(50))';
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.CommandText := cs;
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.Execute;

  cs:='CREATE INDEX idxPrimary ON ' +  WEATHERDATASETNAMESTABLE +
    ' (' + WEATHERDATASETNAMEFIELD + ') WITH PRIMARY';
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.CommandText := cs;
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.Execute;

  cs:='CREATE TABLE ' + WEATHERDATATABLE + ' (' +
       WEATHERDATASETNAMEFIELD + ' TEXT(50) CONSTRAINT idxweather REFERENCES ' +
       WEATHERDATASETNAMESTABLE + ' (' + WEATHERDATASETNAMEFIELD + '), ' +
       WEATHERDATEFIELD + ' Date,' +
       MINTEMPFIELD + ' Double,' +
       MAXTEMPFIELD + ' Double,' +
       QAFIELD + ' Double,' +
       EVAPFIELD + ' Double,' +
       MINRHFIELD + ' Double,' +
       MAXRHFIELD + ' Double,' +
       RAINFIELD + ' Double)';
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.CommandText := cs;
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.Execute;

  cs:='CREATE INDEX idxPrimary ON ' + WEATHERDATATABLE +
    ' (' + WEATHERDATASETNAMEFIELD + ',' + WEATHERDATEFIELD + ') WITH PRIMARY';
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.CommandText := cs;
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.Execute;

  cs:='CREATE TABLE ' + CABALASCENARIOSTABLE + ' (' +
    SCENARIONAMEFIELD + ' TEXT(50),' +
    CABALASCENARIONAMEFIELD + ' TEXT(50),' +
    CABALAPROJECTFIELD + ' TEXT(250))';
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.CommandText := cs;
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.Execute;

  cs:='CREATE INDEX idxPrimary ON ' +  CABALASCENARIOSTABLE +
    ' (' + SCENARIONAMEFIELD + ') WITH PRIMARY';
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.CommandText := cs;
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.Execute;

  cs:='CREATE TABLE ' + REALMENSURATIONDATATABLE + ' (' +
    MENSDATASETNAMEFIELD + ' TEXT(50),' +
    MENSDATEFIELD + ' DATE,' +
    DBHFIELD + ' DOUBLE,' +
    MEASTREEHEIGHTFIELD + ' DOUBLE,' +
    STEMVOLFIELD + ' DOUBLE,' +
    CROWNLENGTHFIELD + ' DOUBLE)';
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.CommandText := cs;
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.Execute;

  cs:='CREATE INDEX idxPrimary ON ' +  REALMENSURATIONDATATABLE +
    ' (' + MENSDATASETNAMEFIELD + ',' + MENSDATEFIELD + ') WITH PRIMARY';
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.CommandText := cs;
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.Execute;

  cs:='CREATE TABLE ' + SCENARIOSTABLE + ' (' +
    SCENARIONAMEFIELD + ' TEXT(50),' +
    SCENARIOTYPEFIELD + ' TEXT(50),' +
    SCENARIOTREETYPEFIELD + ' TEXT(50),' +
    SCENARIOSTEMPOSFIELD + ' DOUBLE,' +
    SCENARIOSITEFIELD + ' TEXT(50) CONSTRAINT idxsite2 REFERENCES ' +
    SITENAMESTABLE + ' (' + SITENAMEFIELD + '), ' +
    SCENARIOREGIMEFIELD + ' TEXT(50) CONSTRAINT idxregime2 REFERENCES ' +
    REGIMENAMESTABLE + ' (' + REGIMENAMEFIELD + '), ' +
    SCENARIOWEATHERDATAFIELD + ' TEXT(50) CONSTRAINT idxweather2 REFERENCES ' +
    WEATHERDATASETNAMESTABLE + ' (' + WEATHERDATASETNAMEFIELD + '), ' +
    SCENARIOCAMBIUMPARAMSFIELD + ' TEXT(50) CONSTRAINT idxcambiumparams3 REFERENCES ' +
    SPECIESNAMESTABLE + ' (' + SPECIESNAMEFIELD + '))';

  DataModule.DataModuleBoard.ADOCommandCAMBIUM.CommandText := cs;
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.Execute;

  cs:='CREATE INDEX idxPrimary ON ' +  SCENARIOSTABLE +
    ' (' + SCENARIONAMEFIELD + ') WITH PRIMARY';
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.CommandText := cs;
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.Execute;

  cs:='CREATE TABLE ' + TEMPALLSCENARIOSTABLE + ' (' +
    RECORDCOUNTFIELD + ' INTEGER,' +
    TREEDBHFIELD + ' DOUBLE,' +
    WMDFIELD + ' DOUBLE,' +
    WMMOEFIELD + ' DOUBLE,' +
    WMMFAFIELD + ' DOUBLE,' +
    SCENARIONAMEFIELD + ' TEXT(50),' +
    SCENARIOTYPEFIELD + ' TEXT(50),' +
    SCENARIOCAMBIUMPARAMSFIELD + ' TEXT(50),' +
    SCENARIOTREETYPEFIELD + ' TEXT(50),' +
    SCENARIOSTEMPOSFIELD + ' TEXT(50),' +
    SCENARIOSITEFIELD + ' TEXT(50),' +
    SCENARIOREGIMEFIELD + ' TEXT(50),' +
    SCENARIOWEATHERDATAFIELD + ' TEXT(50))';

  DataModule.DataModuleBoard.ADOCommandCAMBIUM.CommandText := cs;
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.Execute;

  cs:='CREATE INDEX idxPrimary ON ' +  TEMPALLSCENARIOSTABLE +
    ' (' + SCENARIONAMEFIELD + ') WITH PRIMARY';
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.CommandText := cs;
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.Execute;

  cs:='CREATE TABLE ' + CAMBIUMSEGMENTSDATATABLE +' (' +
    SCENARIONAMEFIELD + ' TEXT(50),' +
    TREENUMBERFIELD + ' INTEGER,' +
    STEMPOSITIONFIELD + ' DOUBLE,' +
    STARTDATEFIELD + ' DATE,' +
    ENDDATEFIELD + ' DATE,' +
    SEGMENTNUMBERFIELD + ' INTEGER,' +
    RINGINSEGMENTMARKERFIELD + ' INTEGER,' +
    SEGMENTPOSITIONFIELD + ' DOUBLE,' +
    SEGMENTWIDTHFIELD + ' DOUBLE,' +
    MEANRDFIELD + ' DOUBLE,' +
    MEANTDFIELD + ' DOUBLE,' +
    MEANLENGTHFIELD + ' DOUBLE,' +
    MEANWTFIELD + ' DOUBLE,' +
    CELLDENSITYFIELD + ' DOUBLE,' +
    MOEFIELD + ' DOUBLE,' +
    WOODDENSITYFIELD + ' DOUBLE,' +
    MFAFIELD + ' DOUBLE)';

  DataModule.DataModuleBoard.ADOCommandCAMBIUM.CommandText := cs;
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.Execute;

  cs:='CREATE INDEX idxPrimary ON ' +  CAMBIUMSEGMENTSDATATABLE +
    ' (' + SCENARIONAMEFIELD + ',' + TREENUMBERFIELD + ',' + STEMPOSITIONFIELD + ',' +
      SEGMENTNUMBERFIELD + ') WITH PRIMARY';
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.CommandText := cs;
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.Execute;

  cs:='CREATE TABLE ' + REALSSDATATABLE +' (' +
    SSDATASETNAMEFIELD + ' TEXT(50),' +
    SSPOSFIELD + ' DOUBLE,' +
    MEANRDFIELD + ' DOUBLE,' +
    MEANTDFIELD + ' DOUBLE,' +
    MEANWTFIELD + ' DOUBLE,' +
    CELLDENSITYFIELD + ' DOUBLE,' +
    MOEFIELD + ' DOUBLE,' +
    WOODDENSITYFIELD + ' DOUBLE,' +
    MFAFIELD + ' DOUBLE)';

  DataModule.DataModuleBoard.ADOCommandCAMBIUM.CommandText := cs;
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.Execute;

  cs:='CREATE INDEX idxPrimary ON ' +  REALSSDATATABLE +
    ' (' + SSDATASETNAMEFIELD + ',' + SSPOSFIELD + ') WITH PRIMARY';
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.CommandText := cs;
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.Execute;

  cs:='CREATE TABLE ' + SSRINGPOSITIONSTABLE +' (' +
    SSDATASETNAMEFIELD + ' TEXT(50),' +
    RINGYEARFIELD + ' INTEGER,' +
    RINGPOSFIELD + ' DOUBLE,' +
    RINGWIDTHFIELD + ' DOUBLE)';

  DataModule.DataModuleBoard.ADOCommandCAMBIUM.CommandText := cs;
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.Execute;

  cs:='CREATE INDEX idxPrimary ON ' +  SSRINGPOSITIONSTABLE +
    ' (' + SSDATASETNAMEFIELD + ',' + RINGYEARFIELD + ') WITH PRIMARY';
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.CommandText := cs;
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.Execute;

  cs:='CREATE TABLE ' + DENDROMETERDATATABLE +' (' +
    DENDRODATASETNAMEFIELD + ' TEXT(50),' +
    DENDRODATEFIELD + ' DATE,' +
    DENDRORADIALPOSFIELD+ ' DOUBLE)';

  DataModule.DataModuleBoard.ADOCommandCAMBIUM.CommandText := cs;
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.Execute;

  cs:='CREATE INDEX idxPrimary ON ' +  DENDROMETERDATATABLE +
    ' (' + DENDRODATASETNAMEFIELD + ',' + DENDRODATEFIELD + ') WITH PRIMARY';
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.CommandText := cs;
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.Execute;

  cs:='CREATE TABLE ' + RESCALEDWOODPROPSTABLE +' (' +
    RESCALEDATASETNAMEFIELD + ' TEXT(50),' +
    RESCALEDATEFIELD + ' DATE,' +
    RESCALEDENSITYFIELD + ' DOUBLE,' +
    RESCALETRDFIELD + ' DOUBLE,' +
    RESCALETWTFIELD + ' DOUBLE,' +
    RESCALEMFAFIELD + ' DOUBLE)';


  DataModule.DataModuleBoard.ADOCommandCAMBIUM.CommandText := cs;
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.Execute;

  cs:='CREATE INDEX idxPrimary ON ' +  RESCALEDWOODPROPSTABLE +
    ' (' + RESCALEDATASETNAMEFIELD + ',' + RESCALEDATEFIELD + ') WITH PRIMARY';
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.CommandText := cs;
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.Execute;

  cs:='CREATE TABLE ' + MEANRINGPROPSTABLE +' (' +
    RINGPROPSLABELFIELD + ' TEXT(50),' +
    RINGPROPSYEARFIELD + ' INTEGER,' +
    RINGPROPSMEANWDFIELD + ' DOUBLE,' +
    RINGPROPSWDSDFIELD + ' DOUBLE,' +
    RINGPROPSMEANTRDFIELD + ' DOUBLE,' +
    RINGPROPSTRDSDFIELD + ' DOUBLE,' +
    RINGPROPSMEANWTFIELD + ' DOUBLE,' +
    RINGPROPSWTSDFIELD + ' DOUBLE,' +
    RINGPROPSMEANMFAFIELD + ' DOUBLE,' +
    RINGPROPSMFASDFIELD + ' DOUBLE,' +
    RINGPROPSMEANMOEFIELD + ' DOUBLE,' +
    RINGPROPSMOESDFIELD + ' DOUBLE)';

  DataModule.DataModuleBoard.ADOCommandCAMBIUM.CommandText := cs;
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.Execute;

  cs:='CREATE INDEX idxPrimary ON ' + MEANRINGPROPSTABLE +
    ' (' + RINGPROPSLABELFIELD + ',' + RINGPROPSYEARFIELD + ') WITH PRIMARY';
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.CommandText := cs;
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.Execute;

  cs:='CREATE TABLE ' + DAILYOUTPUTDATATABLE +' (' +
    SCENARIONAMEFIELD + ' TEXT(50),' +
    DAILYDATADATEFIELD + ' DATE,' +
    STEMDIAMFIELD + ' DOUBLE,'+
    BASESTEMDIAMFIELD+ ' DOUBLE,'+
    DAILYDATADBHFIELD+ ' DOUBLE,'+
    TREEHEIGHTFIELD+ ' DOUBLE,'+
    EXCESSCARBFIELD+ ' DOUBLE,'+
    TREENPPFIELD + ' DOUBLE,'+
    STANDNPPFIELD + ' DOUBLE,' +
    STEMALLOCFIELD + ' DOUBLE,'+
    MEANCZCOUNTFIELD + ' DOUBLE,'+
    MEANEZCOUNTFIELD + ' DOUBLE,'+
    MEANTZCOUNTFIELD + ' DOUBLE,'+
    MEANDAYSGROWINGFIELD + ' DOUBLE,'+
    MEANDAYSSECTHICKFIELD + ' DOUBLE,' +
    MEANWTRFIELD + ' DOUBLE,' +
    MEANRDGRFIELD + ' DOUBLE,' +
    //TLTODAYFIELD + ' DOUBLE,' +
    TOTSTEMVOLFIELD + ' DOUBLE,' +
    LIVINGSTEMVOLFIELD + ' DOUBLE,' +
    TOTCELLPOPFIELD + ' DOUBLE,' +
    MEANLIVINGCELLVOLFIELD + ' DOUBLE,' +
    MEANCZCELLVOLFIELD + ' DOUBLE,' +
    HOURSOFGROWTHFIELD + ' DOUBLE,' +
    MINTEMPFIELD + ' DOUBLE,' +
    MAXTEMPFIELD + ' DOUBLE,' +
    MINLWPFIELD + ' DOUBLE,' +
    MAXLWPFIELD + ' DOUBLE,' +
    MINOPFIELD + ' DOUBLE,' +
    WFFIELD + ' DOUBLE,' +
    WSFIELD + ' DOUBLE,' +
    WRFIELD + ' DOUBLE,' +
    VOLSPECSTEMALLOCFIELD + ' DOUBLE,' +
    CZVOLFIELD + ' DOUBLE,' +
    MEANLENGTHFIELD + ' DOUBLE,' +
    MEANRDFIELD + ' DOUBLE,' +
    MEANTDFIELD + ' DOUBLE,' +
    MEANWTFIELD + ' DOUBLE,' +
    MEANCELLCYCLEDURFIELD + ' DOUBLE,' +
    FTEMPFIELD + ' DOUBLE,' +
    LAIFIELD + ' DOUBLE,' +
    SPHFIELD + ' DOUBLE,' +
    ASWRZFIELD + ' DOUBLE)';


  DataModule.DataModuleBoard.ADOCommandCAMBIUM.CommandText := cs;
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.Execute;

  cs:='CREATE INDEX idxPrimary ON ' +  DAILYOUTPUTDATATABLE +
    ' (' + SCENARIONAMEFIELD + ',' + DAILYDATADATEFIELD + ') WITH PRIMARY';
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.CommandText := cs;
  DataModule.DataModuleBoard.ADOCommandCAMBIUM.Execute;




end;



end.
