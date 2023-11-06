unit ReadData;

interface
  uses General,ProjectManager,CAMBIUMObjects,DataObjects,DataModule,
  LinkCABALAScenario,Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids,ADODB,ProjectWarnings;

  Function ReadParameters(CurrentADOQuery: TADOQuery;
    SpeciesName : string;
    ParametersTableName : String): TParametersListArray;

  Function ReadCABALAData(CurrentScenarioName: string;
    CABALAScenarioName : String;
    CAMQuery : TADOQuery;
    CABQuery: TADOQuery): TCambiumInputDataArray;

  Function ReadSegmentsData(ScenarioName : String;
    SegmentsDataTableName: String;
    ScenarioNameFieldName : String;
    CurrentQuery: TADOQuery): TCambiumSegmentDataArray;
  Function ReadSegmentsData_Inmm(ScenarioName : String;
    SegmentsDataTableName : String;
    ScenarioNameFieldName: String;
    CurrentQuery: TADOQuery): TCambiumSegmentDataArray;
  Function ReadMensurationData(DataSetName : String;
    MensurationDataTableName : String;
    DatasetNameFieldName: String;
    CurrentQuery: TADOQuery): TMensDataArray;
  Function ReadDailyData(ScenarioName : String;
    DailyDataTableName : String;
    ScenarioNameFieldName: String;
    CurrentQuery: TADOQuery): TCAMBIUMDailyOutputDataArray;
  Procedure FillRegimeDataArray(CurrentQuery: TADOQuery;
    RegimeName: String;
    var CurrentRegimeDataArray: TRegimeDataArray);
  Procedure FillSiteDataRecord(CurrentQuery: TADOQuery;
    SiteName: String;
    var CurrentSiteData: TSiteData);
  Procedure FillWeatherDataArray(CurrentQuery: TADOQuery;
    WeatherDSName: String;
    StartDate:TDate;EndDate:TDate;
    var CurrentWeatherDataArray: TWeatherDataArray);
  Procedure GetDataFromCSVFile(FileName: String;
    MyStringList:TStringList);
  Function ReadSSData(DataSetName : String;
    SSDataTableName : String;
    DataSetNameFieldName: String;
    CurrentQuery: TADOQuery): TSSDataArray;

  Function ReadSegmentsData_RingMeans(ScenarioName : String;
    SegmentsDataTableName : String;
    ScenarioNameFieldName: String;
    CurrentQuery: TADOQuery;
    HemCorr : Integer): TRingMeanDataArray;

  Function GetSSDataRingMeans(DataSetName : String;
    SSDataTableName : String;
    SSRingPositionsTableName: STring;
    SSDataSetNameFieldName: String;
    SSPosFieldName: String;
    RingPosFieldName,RingWidthFieldName: String;
    CurrentQuery: TADOQuery): TRingMeanDataArray;

  Function ReadRingMeansData(CurrentLabel : String;
    DataTableName : String;
    CurrentLabelFieldName: String;
    CurrentQuery: TADOQuery): TRingMeanDataArray;

implementation

uses AddEditCAMBIUMParams;

Procedure GetDataFromCSVFile(FileName: String;
  MyStringList:TStringList);
begin
  MyStringList.Clear;
  MyStringList.LoadFromFile(FileName);

end;

Function ReadDailyData(ScenarioName : String;
  DailyDataTableName : String;
  ScenarioNameFieldName: String;
  CurrentQuery: TADOQuery): TCAMBIUMDailyOutputDataArray;
var
  SQLString: String;
  i : integer;

begin
  try
    SetLength(Result,0);
    //SetLength(Result,1);

    SQLString := 'SELECT * FROM ' +
      DailyDataTableName +
      ' WHERE ' +
      ScenarioNameFieldName + '=' +
      '"' + ScenarioName + '"' +
      ' ORDER BY  ' + ProjectManager.DAILYDATADATEFIELD +
      ' ASC';

    CurrentQuery.SQL.Clear;
    CurrentQuery.SQL.add(SQLString);
    CurrentQuery.active := true;
    CurrentQuery.First;

    i := 0;

    while not CurrentQuery.Eof do begin
      SetLength(Result,Length(Result)+1);

      Result[i].LogDate := CurrentQuery.FieldByName(ProjectManager.DAILYDATADATEFIELD).AsDateTime;
      Result[i].DiamAtModellingPos := CurrentQuery.FieldByName(ProjectManager.STEMDIAMFIELD).AsFloat;
      //Result[i].DiamAtBase := CurrentQuery.FieldByName(ProjectManager.BASESTEMDIAMFIELD).AsFloat;
      //Result[i].DBH := CurrentQuery.FieldByName(ProjectManager.DAILYDATADBHFIELD).AsFloat;
      Result[i].TreeHeight := CurrentQuery.FieldByName(ProjectManager.TREEHEIGHTFIELD).AsFloat;
      Result[i].TreeNPP := CurrentQuery.FieldByName(ProjectManager.TREENPPFIELD).AsFloat;
      Result[i].StandNPP := CurrentQuery.FieldByName(ProjectManager.STANDNPPFIELD).AsFloat;
      Result[i].StemAllocCarb := CurrentQuery.FieldByName(ProjectManager.STEMALLOCFIELD).AsFloat;
      Result[i].CZCount := CurrentQuery.FieldByName(ProjectManager.MEANCZCOUNTFIELD).AsInteger;
      Result[i].EZCount := CurrentQuery.FieldByName(ProjectManager.MEANEZCOUNTFIELD).AsInteger;
      Result[i].TZCount := CurrentQuery.FieldByName(ProjectManager.MEANTZCOUNTFIELD).AsInteger;
      Result[i].GrowingDays := CurrentQuery.FieldByName(ProjectManager.MEANDAYSGROWINGFIELD).AsInteger;
      Result[i].ThickeningDays := CurrentQuery.FieldByName(ProjectManager.MEANDAYSSECTHICKFIELD).AsInteger;
      //Result[i].MeanRadGrowthRate := CurrentQuery.FieldByName(ProjectManager.MEANRDGRFIELD).AsFloat;
      //Result[i].MeanWTRate := CurrentQuery.FieldByName(ProjectManager.MEANWTRFIELD).AsFloat;
      Result[i].MinTemp := CurrentQuery.FieldByName(ProjectManager.MINTEMPFIELD).AsFloat;
      Result[i].MaxTemp := CurrentQuery.FieldByName(ProjectManager.MAXTEMPFIELD).AsFloat;
      Result[i].MinLWP := CurrentQuery.FieldByName(ProjectManager.MINLWPFIELD).AsFloat;
      Result[i].MaxLWP := CurrentQuery.FieldByName(ProjectManager.MAXLWPFIELD).AsFloat;
      Result[i].ASWRootZone := CurrentQuery.FieldByName(ProjectManager.ASWRZFIELD).AsFloat;
      //Result[i].MinOP:= CurrentQuery.FieldByName(ProjectManager.MINOPFIELD).AsFloat;
      Result[i].CellCycleDur:= CurrentQuery.FieldByName(ProjectManager.MEANCELLCYCLEDURFIELD).AsFloat;
      Result[i].DailyLAI := CurrentQuery.FieldByName(ProjectManager.LAIFIELD).AsFloat;
      Result[i].WFStand := CurrentQuery.FieldByName(ProjectManager.WFFIELD).AsFloat;
      Result[i].WSStand := CurrentQuery.FieldByName(ProjectManager.WSFIELD).AsFloat;
      Result[i].WRStand := CurrentQuery.FieldByName(ProjectManager.WRFIELD).AsFloat;
      Result[i].SPH := CurrentQuery.FieldByName(ProjectManager.SPHFIELD).Asinteger;
      Result[i].StemVol := CurrentQuery.FieldByName(ProjectManager.TOTSTEMVOLFIELD).Asinteger;

      CurrentQuery.Next;
      i := i + 1;
    end;
  except
    on E:Exception do begin
      Messagedlg('There was a problem reading the segment mean data: ' + E.Message,mtError,[mbOK],0);
    end;
  end;
end;

Function ReadRingMeansData(CurrentLabel : String;
  DataTableName : String;
  CurrentLabelFieldName: String;
  CurrentQuery: TADOQuery): TRingMeanDataArray;
var
  SQLString: String;
  i : integer;

begin
  try
    SetLength(Result,0);
    //SetLength(Result,1);

    SQLString := 'SELECT * FROM ' +
      DataTableName +
      ' WHERE ' +
      CurrentLabelFieldName + '=' +
      '"' + CurrentLabel + '"';

    CurrentQuery.SQL.Clear;
    CurrentQuery.SQL.add(SQLString);
    CurrentQuery.active := true;
    CurrentQuery.First;

    i := 0;

    while not CurrentQuery.Eof do begin
      SetLength(Result,Length(Result)+1);

      Result[i].RingYear := CurrentQuery.FieldByName(ProjectManager.RINGPROPSYEARFIELD).AsInteger;
      Result[i].MeanWD := CurrentQuery.FieldByName(ProjectManager.RINGPROPSMEANWDFIELD).AsFloat;
      Result[i].MeanTRD := CurrentQuery.FieldByName(ProjectManager.RINGPROPSMEANTRDFIELD).AsFloat;
      Result[i].MeanWT := CurrentQuery.FieldByName(ProjectManager.RINGPROPSMEANWTFIELD).AsFloat;
      Result[i].MeanMFA := CurrentQuery.FieldByName(ProjectManager.RINGPROPSMEANMFAFIELD).AsFloat;
      Result[i].MeanMOE := CurrentQuery.FieldByName(ProjectManager.RINGPROPSMEANMOEFIELD).AsFloat;
      Result[i].WDSD := CurrentQuery.FieldByName(ProjectManager.RINGPROPSWDSDFIELD).AsFloat;
      Result[i].TRDSD := CurrentQuery.FieldByName(ProjectManager.RINGPROPSTRDSDFIELD).AsFloat;
      Result[i].WTSD := CurrentQuery.FieldByName(ProjectManager.RINGPROPSWTSDFIELD).AsFloat;
      Result[i].MFASD := CurrentQuery.FieldByName(ProjectManager.RINGPROPSMFASDFIELD).AsFloat;
      Result[i].MOESD := CurrentQuery.FieldByName(ProjectManager.RINGPROPSMOESDFIELD).AsFloat;

      CurrentQuery.Next;
      i := i + 1;
    end;
  except
    on E:Exception do begin
      Messagedlg('There was a problem reading the ring means data: ' + E.Message,mtError,[mbOK],0);
    end;
  end;
end;


Function ReadSegmentsData(ScenarioName : String;
  SegmentsDataTableName : String;
  ScenarioNameFieldName: String;
  CurrentQuery: TADOQuery): TCambiumSegmentDataArray;
var
  SQLString: String;
  i : integer;

begin
  try
    SetLength(Result,0);
    //SetLength(Result,1);

    SQLString := 'SELECT * FROM ' +
      SegmentsDataTableName +
      ' WHERE ' +
      ScenarioNameFieldName + '=' +
      '"' + ScenarioName + '"' +
      ' ORDER BY  ' + ProjectManager.SEGMENTPOSITIONFIELD +
      ' DESC';

    CurrentQuery.SQL.Clear;
    CurrentQuery.SQL.add(SQLString);
    CurrentQuery.active := true;
    CurrentQuery.First;

    i := 0;

    while not CurrentQuery.Eof do begin
      SetLength(Result,Length(Result)+1);

      Result[i].SegmentPosition := CurrentQuery.FieldByName(ProjectManager.SEGMENTPOSITIONFIELD).AsFloat;
      Result[i].StartDate := CurrentQuery.FieldByName(ProjectManager.STARTDATEFIELD).AsDateTime;
      Result[i].WoodDensity := CurrentQuery.FieldByName(ProjectManager.WOODDENSITYFIELD).AsFloat;
      Result[i].MOE := CurrentQuery.FieldByName(ProjectManager.MOEFIELD).AsFloat;
      Result[i].MFA := CurrentQuery.FieldByName(ProjectManager.MFAFIELD).AsFloat;
      Result[i].MeanRD := CurrentQuery.FieldByName(ProjectManager.MEANRDFIELD).AsFloat;
      Result[i].MeanWT := CurrentQuery.FieldByName(ProjectManager.MEANWTFIELD).AsFloat;
      Result[i].RinginSegment := CurrentQuery.FieldByName(ProjectManager.RINGINSEGMENTMARKERFIELD).AsInteger;

      Result[i].SegmentWidth := CurrentQuery.FieldByName(ProjectManager.SEGMENTWIDTHFIELD).AsFloat;

      CurrentQuery.Next;
      i := i + 1;
    end;
  except
    on E:Exception do begin
      Messagedlg('There was a problem reading the segment mean data: ' + E.Message,mtError,[mbOK],0);
    end;
  end;
end;

Function ReadSSData(DataSetName : String;
  SSDataTableName : String;
  DataSetNameFieldName: String;
  CurrentQuery: TADOQuery): TSSDataArray;
var
  SQLString: String;
  i : integer;

begin
  try
    SetLength(Result,0);
    //SetLength(Result,1);

    SQLString := 'SELECT * FROM ' +
      SSDataTableName +
      ' WHERE ' +
      DataSetNameFieldName + '=' +
      '"' + DataSetName + '"' +
      ' ORDER BY  ' + ProjectManager.SSPOSFIELD +
      ' DESC';

    CurrentQuery.SQL.Clear;
    CurrentQuery.SQL.add(SQLString);
    CurrentQuery.active := true;
    CurrentQuery.First;

    i := 0;

    while not CurrentQuery.Eof do begin
      SetLength(Result,Length(Result)+1);

      Result[i].SSPos := CurrentQuery.FieldByName(ProjectManager.SSPOSFIELD).AsFloat;
      Result[i].WD := CurrentQuery.FieldByName(ProjectManager.WOODDENSITYFIELD).AsFloat;
      Result[i].MOE := CurrentQuery.FieldByName(ProjectManager.MOEFIELD).AsFloat;
      Result[i].MFA := CurrentQuery.FieldByName(ProjectManager.MFAFIELD).AsFloat;
      Result[i].TRD := CurrentQuery.FieldByName(ProjectManager.MEANRDFIELD).AsFloat;
      Result[i].TWT := CurrentQuery.FieldByName(ProjectManager.MEANWTFIELD).AsFloat;

      CurrentQuery.Next;
      i := i + 1;
    end;
  except
    on E:Exception do begin
      Messagedlg('There was a problem reading the SilviScan data: ' + E.Message,mtError,[mbOK],0);
    end;
  end;
end;

Function ReadMensurationData(DataSetName : String;
  MensurationDataTableName : String;
  DataSetNameFieldName: String;
  CurrentQuery: TADOQuery): TMensDataArray;
var
  SQLString: String;
  i : integer;

begin
  try
    SetLength(Result,0);
    //SetLength(Result,1);

    SQLString := 'SELECT * FROM ' +
      MensurationDataTableName +
      ' WHERE ' +
      DataSetNameFieldName + '=' +
      '"' + DataSetName + '"' +
      ' ORDER BY  ' + ProjectManager.MENSDATEFIELD +
      ' ASC';

    CurrentQuery.SQL.Clear;
    CurrentQuery.SQL.add(SQLString);
    CurrentQuery.active := true;
    CurrentQuery.First;

    i := 0;

    while not CurrentQuery.Eof do begin
      SetLength(Result,Length(Result)+1);

      Result[i].LogDate := CurrentQuery.FieldByName(ProjectManager.MENSDATEFIELD).AsDateTime;
      Result[i].DBH := CurrentQuery.FieldByName(ProjectManager.DBHFIELD).AsFloat;
      Result[i].Height := CurrentQuery.FieldByName(ProjectManager.MEASTREEHEIGHTFIELD).AsFloat;

      CurrentQuery.Next;
      i := i + 1;
    end;
  except
    on E:Exception do begin
      Messagedlg('There was a problem reading the measured mensuration data: ' + E.Message,mtError,[mbOK],0);
    end;
  end;
end;

Function ReadSegmentsData_Inmm(ScenarioName : String;
  SegmentsDataTableName : String;
  ScenarioNameFieldName: String;
  CurrentQuery: TADOQuery): TCambiumSegmentDataArray;
var
  SQLString: String;
  i : integer;

begin
  try
    SetLength(Result,0);
    //SetLength(Result,1);

    SQLString := 'SELECT ' +
    'round(' + ProjectManager.SEGMENTPOSITIONFIELD + '/1000' + ',0)*1000 as ' +
      ProjectManager.SEGMENTPOSITIONFIELD + ', ' +
    'avg(' + ProjectManager.MOEFIELD + ') as ' + ProjectManager.MOEFIELD + ', ' +
    'avg(' + ProjectManager.WOODDENSITYFIELD + ') as ' + ProjectManager.WOODDENSITYFIELD + ', '+
    'avg(' + ProjectManager.MFAFIELD + ') as ' + ProjectManager.MFAFIELD +

    ' FROM ' +
      SegmentsDataTableName +
      ' WHERE ' +
      ScenarioNameFieldName + '=' +
      '"' + ScenarioName + '"' +
      //' ORDER BY  ' + ProjectManager.SEGMENTPOSITIONFIELD +
      //' DESC' +
      ' GROUP BY ' +
      'round(' + ProjectManager.SEGMENTPOSITIONFIELD + '/1000' + ',0)';

    CurrentQuery.SQL.Clear;
    CurrentQuery.SQL.add(SQLString);
    CurrentQuery.active := true;
    CurrentQuery.First;

    i := 0;

    while not CurrentQuery.Eof do begin
      SetLength(Result,Length(Result)+1);

      Result[i].SegmentPosition := CurrentQuery.FieldByName(ProjectManager.SEGMENTPOSITIONFIELD).AsFloat;
      //Result[i].StartDate := CurrentQuery.FieldByName(ProjectManager.STARTDATEFIELD).AsDateTime;
      Result[i].WoodDensity := CurrentQuery.FieldByName(ProjectManager.WOODDENSITYFIELD).AsFloat;
      Result[i].MOE := CurrentQuery.FieldByName(ProjectManager.MOEFIELD).AsFloat;
      Result[i].MFA := CurrentQuery.FieldByName(ProjectManager.MFAFIELD).AsFloat;
      //Result[i].MeanRD := CurrentQuery.FieldByName(ProjectManager.MEANRDFIELD).AsFloat;
      //Result[i].MeanWT := CurrentQuery.FieldByName(ProjectManager.MEANWTFIELD).AsFloat;

      //Result[i].SegmentWidth := CurrentQuery.FieldByName(ProjectManager.SEGMENTWIDTHFIELD).AsFloat;

      CurrentQuery.Next;
      i := i + 1;
    end;
  except
    on E:Exception do begin
      Messagedlg('There was a problem reading the segment mean data: ' + E.Message,mtError,[mbOK],0);
    end;
  end;
end;

Function ReadSegmentsData_RingMeans(ScenarioName : String;
  SegmentsDataTableName : String;
  ScenarioNameFieldName: String;
  CurrentQuery: TADOQuery;
  HemCorr : Integer): TRingMeanDataArray;
var
  SQLString: String;
  i : integer;

begin
  try
    SetLength(Result,0);
    //SetLength(Result,1);

    SQLString := 'SELECT ' +
    'year(DateAdd("m",' + inttostr(HemCorr) + ',[' + ProjectManager.STARTDATEFIELD + '])) as ' +
    'RingYear' + ', ' +
    'avg(' + ProjectManager.WOODDENSITYFIELD + ') as ' + ProjectManager.WOODDENSITYFIELD + ', '+
    'avg(' + ProjectManager.MEANRDFIELD + ') as ' + ProjectManager.MEANRDFIELD + ', '+
    'avg(' + ProjectManager.MEANTDFIELD + ') as ' + ProjectManager.MEANTDFIELD + ', '+
    'avg(' + ProjectManager.MEANWTFIELD + ') as ' + ProjectManager.MEANWTFIELD + ', '+
    'avg(' + ProjectManager.MFAFIELD + ') as ' + ProjectManager.MFAFIELD + ',' +
    'avg(' + ProjectManager.MOEFIELD + ') as ' + ProjectManager.MOEFIELD +

    ' FROM ' +
      SegmentsDataTableName +
      ' WHERE ' +
      ScenarioNameFieldName + '=' +
      '"' + ScenarioName + '"' +
      //' ORDER BY  ' + ProjectManager.SEGMENTPOSITIONFIELD +
      //' DESC' +
      ' GROUP BY ' +
     'year(DateAdd("m",' + inttostr(HemCorr) + ',[' + ProjectManager.STARTDATEFIELD + ']))';

    CurrentQuery.SQL.Clear;
    CurrentQuery.SQL.add(SQLString);
    CurrentQuery.active := true;
    CurrentQuery.First;

    i := 0;

    while not CurrentQuery.Eof do begin
      SetLength(Result,Length(Result)+1);

      Result[i].RingYear := CurrentQuery.FieldByName('RingYear').AsInteger;
      Result[i].MeanWD := CurrentQuery.FieldByName(ProjectManager.WOODDENSITYFIELD).AsFloat;
      Result[i].meanMOE := CurrentQuery.FieldByName(ProjectManager.MOEFIELD).AsFloat;
      Result[i].MeanMFA := CurrentQuery.FieldByName(ProjectManager.MFAFIELD).AsFloat;
      Result[i].MeanTRD := CurrentQuery.FieldByName(ProjectManager.MEANRDFIELD).AsFloat;
      Result[i].MeanWT := CurrentQuery.FieldByName(ProjectManager.MEANWTFIELD).AsFloat;

      //Result[i].SegmentWidth := CurrentQuery.FieldByName(ProjectManager.SEGMENTWIDTHFIELD).AsFloat;

      CurrentQuery.Next;
      i := i + 1;
    end;
  except
    on E:Exception do begin
      Messagedlg('There was a problem reading the segment mean data: ' + E.Message,mtError,[mbOK],0);
    end;
  end;
end;

Function GetSSDataRingMeans(DataSetName : String;
  SSDataTableName : String;
  SSRingPositionsTableName: STring;
  SSDataSetNameFieldName: String;
  SSPosFieldName: String;
  RingPosFieldName,RingWidthFieldName: String;
  CurrentQuery: TADOQuery): TRingMeanDataArray;
var
  SQLString: String;
  i : integer;

begin
  try
    SetLength(Result,0);
    //SetLength(Result,1);

    SQLString := 'SELECT ' +
    ProjectManager.RingYEARFIELD + ',' +
    'avg(' + ProjectManager.WOODDENSITYFIELD + ') as ' + ProjectManager.WOODDENSITYFIELD + ', '+
    'avg(' + ProjectManager.MEANRDFIELD + ') as ' + ProjectManager.MEANRDFIELD + ', '+
    'avg(' + ProjectManager.MEANTDFIELD + ') as ' + ProjectManager.MEANTDFIELD + ', '+
    'avg(' + ProjectManager.MEANWTFIELD + ') as ' + ProjectManager.MEANWTFIELD + ', '+
    'avg(' + ProjectManager.MFAFIELD + ') as ' + ProjectManager.MFAFIELD + ',' +
    'avg(' + ProjectManager.MOEFIELD + ') as ' + ProjectManager.MOEFIELD +

    ' FROM ' +
      SSDataTableName + ',' + SSRingPositionsTableName +

      ' WHERE ' +
      SSDataTableName + '.' + SSDataSetNameFieldName + '=' +
      SSRingPositionsTableName + '.' + SSDataSetNameFieldName  +
      ' and ' +
      SSDataTableName + '.' + SSPosFieldName + '<=' +
      SSRingPositionsTableName + '.' + RingPosFieldName +
      ' and ' +
      SSDataTableName + '.' + SSPosFieldName + '>' +
      SSRingPositionsTableName + '.' + RingPosFieldName + '-' +
      SSRingPositionsTableName + '.' + RingWidthFieldName +
      ' GROUP BY ' + ProjectManager.RingYEARFIELD + ';';

    CurrentQuery.SQL.Clear;
    CurrentQuery.SQL.add(SQLString);
    CurrentQuery.active := true;
    CurrentQuery.First;

    i := 0;

    while not CurrentQuery.Eof do begin
      SetLength(Result,Length(Result)+1);

      Result[i].RingYear := CurrentQuery.FieldByName('RingYear').AsInteger;
      Result[i].MeanWD := CurrentQuery.FieldByName(ProjectManager.WOODDENSITYFIELD).AsFloat;
      Result[i].meanMOE := CurrentQuery.FieldByName(ProjectManager.MOEFIELD).AsFloat;
      Result[i].MeanMFA := CurrentQuery.FieldByName(ProjectManager.MFAFIELD).AsFloat;
      Result[i].MeanTRD := CurrentQuery.FieldByName(ProjectManager.MEANRDFIELD).AsFloat;
      Result[i].MeanWT := CurrentQuery.FieldByName(ProjectManager.MEANWTFIELD).AsFloat;

      //Result[i].SegmentWidth := CurrentQuery.FieldByName(ProjectManager.SEGMENTWIDTHFIELD).AsFloat;

      CurrentQuery.Next;
      i := i + 1;
    end;
  except
    on E:Exception do begin
      Messagedlg('There was a problem reading the segment mean data: ' + E.Message,mtError,[mbOK],0);
    end;
  end;
end;


Procedure FillRegimeDataArray(CurrentQuery: TADOQuery;
  RegimeName: String;
  var CurrentRegimeDataArray: TRegimeDataArray);
var
  SQLQuery : String;
  i : Integer;
begin
  SetLength(CurrentRegimeDataArray,0);
  SQLQuery := 'SELECT * FROM ' +
    ProjectManager.REGIMESTABLE + ' WHERE ' +
    ProjectManager.REGIMENAMEFIELD + '="' + RegimeName + '"' +
    ' ORDER BY ' + ProjectManager.EVENTDATEFIELD + ';';
  CurrentQuery.SQL.Clear;
  CurrentQuery.SQL.Add(SQLQuery);
  CurrentQuery.Active := true;

  CurrentQuery.First;

  i := 0;

  SetLength(CurrentRegimeDataArray,CurrentQuery.RecordCount);

  while not CurrentQuery.eof do begin
    CurrentRegimeDataArray[i].RegimeName := CurrentQuery.FieldByName(ProjectManager.REGIMENAMEFIELD).AsString;
    CurrentRegimeDataArray[i].EventType := CurrentQuery.FieldByName(ProjectManager.EVENTTYPEFIELD).AsString;
    CurrentRegimeDataArray[i].EventDate := CurrentQuery.FieldByName(ProjectManager.EVENTDATEFIELD).AsDateTime;
    CurrentRegimeDataArray[i].EventValue := CurrentQuery.FieldByName(ProjectManager.EVENTVALUEFIELD).AsFloat;
    CurrentQuery.next;
    i := i + 1;
  end;
end;

Procedure FillSiteDataRecord(CurrentQuery: TADOQuery;
  SiteName: String;
  var CurrentSiteData: TSiteData);
var
  SQLQuery : String;

begin
  SetLength(CurrentRegimeDataArray,0);
  SQLQuery := 'SELECT * FROM ' +
    ProjectManager.SITESTABLE + ' WHERE ' +
    ProjectManager.SITENAMEFIELD + '="' + SiteName + '";';
  CurrentQuery.SQL.Clear;
  CurrentQuery.SQL.Add(SQLQuery);
  CurrentQuery.Active := true;

  CurrentQuery.First;

  SetLength(CurrentRegimeDataArray,CurrentQuery.RecordCount);

  CurrentSiteData.SiteName := CurrentQuery.FieldByName(ProjectManager.SITENAMEFIELD).AsString;
  CurrentSiteData.Latitude := CurrentQuery.FieldByName(ProjectManager.SITELATFIELD).AsInteger;
  CurrentSiteData.SoilDepth := CurrentQuery.FieldByName(ProjectManager.SOILDEPTHFIELD).Asfloat;
  CurrentSiteData.SoilTexture := CurrentQuery.FieldByName(ProjectManager.SOILTEXTUREFIELD).Asstring;
  CurrentSiteData.SoilClass := CurrentQuery.FieldByName(ProjectManager.SOILCLASSFIELD).AsFloat;
  CurrentSiteData.FR := CurrentQuery.FieldByName(ProjectManager.SITEFRFIELD).Asfloat;
  CurrentSiteData.MinASW := CurrentQuery.FieldByName(ProjectManager.MINASWFIELD).Asfloat;
  CurrentSiteData.MaxASW := CurrentQuery.FieldByName(ProjectManager.MAXASWFIELD).Asfloat;
  CurrentSiteData.InitialASW := CurrentQuery.FieldByName(ProjectManager.INITIALASWFIELD).Asfloat;

end;

Procedure FillWeatherDataArray(CurrentQuery: TADOQuery;
  WeatherDSName: String;
  StartDate:TDate;EndDate:TDate;
  var CurrentWeatherDataArray: TWeatherDataArray);
var
  SQLQuery : String;
  i : Integer;
begin
  SetLength(CurrentWeatherDataArray,0);
  SQLQuery := 'SELECT * FROM ' +
    ProjectManager.WEATHERDATATABLE + ' WHERE ' +
    ProjectManager.WEATHERDATASETNAMEFIELD + '="' + WeatherDSName + '"' +
    ' AND ' + ProjectManager.WEATHERDATEFIELD + ' >=#' + datetostr(StartDate) + '# AND ' +
    ProjectManager.WEATHERDATEFIELD + ' <=#' + datetostr(EndDate) + '# ' +
    ' ORDER BY ' + ProjectManager.WEATHERDATEFIELD + ';';
  CurrentQuery.SQL.Clear;
  CurrentQuery.SQL.Add(SQLQuery);
  CurrentQuery.Active := true;

  CurrentQuery.First;

  i := 0;

  SetLength(CurrentWeatherDataArray,CurrentQuery.RecordCount);

  while not CurrentQuery.eof do begin
    CurrentWeatherDataArray[i].LogDate := CurrentQuery.FieldByName(ProjectManager.WEATHERDATEFIELD).AsDateTime;
    CurrentWeatherDataArray[i].Rainfall := CurrentQuery.FieldByName(ProjectManager.RAINFIELD).AsFloat;
    CurrentWeatherDataArray[i].MinTemp := CurrentQuery.FieldByName(ProjectManager.MINTEMPFIELD).AsFloat;
    CurrentWeatherDataArray[i].MaxTemp := CurrentQuery.FieldByName(ProjectManager.MAXTEMPFIELD).AsFloat;
    CurrentWeatherDataArray[i].SolRad := CurrentQuery.FieldByName(ProjectManager.QAFIELD).AsFloat;
    CurrentWeatherDataArray[i].Evap := CurrentQuery.FieldByName(ProjectManager.EVAPFIELD).AsFloat;
    CurrentWeatherDataArray[i].MinRH := CurrentQuery.FieldByName(ProjectManager.MINRHFIELD).AsFloat;
    CurrentWeatherDataArray[i].MaxRH := CurrentQuery.FieldByName(ProjectManager.MAXRHFIELD).AsFloat;

    CurrentQuery.next;
    i := i + 1;
  end;
end;


Function ReadParameters(CurrentADOQuery : TADOQuery;
  SpeciesName : string;
  ParametersTableName : String): TParametersListArray;
var
  SQLString : string;
  i : integer;

begin
  try

    //FormMain.labelStatus.Caption := 'Reading CAMBIUM parameters';
    //formmain.Refresh;
    SetLength(Result,0);

    SQLString := 'SELECT * FROM ' +
      ParametersTableName +
      ' WHERE ' +
      ProjectManager.SPECIESNAMEFIELD + '=' +
      '"' + SpeciesName + '"';

    CurrentADOQuery.SQL.Clear;
    CurrentADOQuery.SQL.add(SQLString);
    CurrentADOQuery.active := true;

    SetLength(Result,CurrentADOQuery.RecordCount);

    CurrentADOQuery.First;

    i := 0;

    while not CurrentADOQuery.Eof do begin

      Result[i].Species :=
          CurrentADOQuery.FieldByName(SPECIESNAMEFIELD).asstring;
      Result[i].ParameterName :=
          CurrentADOQuery.FieldByName(PARAMNAMEFIELD).asstring;
      Result[i].ParameterValue :=
          CurrentADOQuery.FieldByName(PARAMVALUEFIELD).asfloat;
      Result[i].ParameterDescription :=
          CurrentADOQuery.FieldByName(PARAMDESCRIPTIONFIELD).asstring;

      CurrentADOQuery.next;
      i := i + 1;

    end;
  except
    on E: exception do begin
      messagedlg('Problem',mtError,[mbOK],0);
    end;
  end;
end;

Function ReadCABALAData(CurrentScenarioName: string;
  CABALAScenarioName : String;
  CAMQuery : TADOQuery;
  CABQuery: TADOQuery): TCambiumInputDataArray;
var
  SQLString : string;
  CABALAProjectName : string;
  CABALAScenarioParentID, CABALAScenarioID : integer;
  i : integer;
  CurrentCAMBIUMInputData : TCambiumInputDataArray;
  NoMinWP: Boolean;

begin
  NoMinWP := false;

  try

    SQLString := 'SELECT * FROM ' +
      ProjectManager.CABALASCENARIOSTABLE +
      ' WHERE ' +
      ProjectManager.SCENARIONAMEFIELD + '=' +
      '"' + CurrentScenarioName + '"';

    CAMQuery.SQL.Clear;
    CAMQuery.SQL.add(SQLString);
    CAMQuery.active := true;
    CAMQuery.First;

    CABALAProjectName := CAMQuery.FieldByName(
      ProjectManager.CABALAPROJECTFIELD).AsString;


    if DataModule.DataModuleBoard.ADOConnectionCABALA.Connected = true then begin

      SQLString := 'SELECT * FROM ' +
        LinkCABALAScenario.CABALASCENARIOPARENTINFOTABLE +
        ' WHERE ' +
        LinkCABALAScenario.CABALASCENARIONAMEFIELD_CABALADB + '=' +
        '"' + CABALAScenarioName + '"';

      CABQuery.SQL.Clear;
      CABQuery.SQL.add(SQLString);

      CABQuery.active := true;
      CABQuery.First;

      CABALAScenarioParentID :=  CABQuery.FieldByName(
        LinkCABALAScenario.CABALASCENARIOPARENTIDFIELD).Asinteger;

      SQLString := 'SELECT * FROM ' +
        LinkCABALAScenario.CABALASCENARIOINFOTABLE +
        ' WHERE ' +
        LinkCABALAScenario.CABALASCENARIOPARENTIDFIELD + '=' +
        inttostr(CABALAScenarioParentID);

      CABQuery.SQL.Clear;
      CABQuery.SQL.add(SQLString);
      CABQuery.active := true;
      CABQuery.First;

      CABALAScenarioID :=  CABQuery.FieldByName(
        LinkCABALAScenario.CABALASCENARIOIDFIELD).Asinteger;

      SQLString := 'SELECT * FROM ' +
        LinkCABALAScenario.CABALA_OUTPUTALL_TABLE +
        ' WHERE ' +
        LinkCABALAScenario.CABALASCENARIOIDFIELD + '=' +
        inttostr(CABALAScenarioID) + ' AND ' +
        LinkCABALAScenario.CABALADATA_SPHFIELD + '>0' +
        ' ORDER BY [' + CABALADATEFIELD + '];';
      //Takes into account "fallow" periods in CaBala, hence SPH > 0


      CABQuery.Active := false;
      CABQuery.SQL.Clear;
      CABQuery.SQL.add(SQLString);
      CABQuery.active := true;
      CABQuery.First;

      //Reset the array
      SetLength(CurrentCAMBIUMInputData,0);
      //Set the array to the length of the CABALA input data
      SetLength(CurrentCAMBIUMInputData,CABQuery.RecordCount);

      i := 0;
      while not CABQuery.Eof do begin

        CurrentCAMBIUMInputData[i].LogDate :=
          CABQuery.FieldByName(CABALADATA_DATEFIELD).AsDateTime;
        CurrentCAMBIUMInputData[i].LAI
          :=CABQuery.FieldByName(CABALADATA_LAIFIELD).AsFloat;
        CurrentCAMBIUMInputData[i].NPP_tperha
          :=CABQuery.FieldByName(CABALADATA_NPPFIELD).AsFloat;
        CurrentCAMBIUMInputData[i].GPP_tperha
          :=CABQuery.FieldByName(CABALADATA_GPPFIELD).AsFloat;
        CurrentCAMBIUMInputData[i].SPH
          :=CABQuery.FieldByName(CABALADATA_SPHFIELD).AsInteger;
        CurrentCAMBIUMInputData[i].etaf
          :=CABQuery.FieldByName(CABALADATA_ETAFFIELD).AsFloat;
        CurrentCAMBIUMInputData[i].etacr
          :=CABQuery.FieldByName(CABALADATA_ETACRFIELD).AsFloat;
        CurrentCAMBIUMInputData[i].etas
          :=CABQuery.FieldByName(CABALADATA_ETASFIELD).AsFloat;
        CurrentCAMBIUMInputData[i].PDWP_Mpa
          :=CABQuery.FieldByName(CABALADATA_PREDAWNWPFIELD).AsFloat;
        try
          CurrentCAMBIUMInputData[i].MDWP_Mpa
            :=CABQuery.FieldByName(CABALADATA_MIDDAYWPFIELD).AsFloat;
        except
          NoMinWP := True;
          CurrentCAMBIUMInputData[i].MDWP_Mpa := CurrentCAMBIUMInputData[i].PDWP_Mpa * 1.25;
        end;

        //CurrentCAMBIUMInputData[i].SWC
          //:=CABQuery.FieldByName(CABALADATA_SOILWATERFIELD).Asfloat;
        CurrentCAMBIUMInputData[i].SWCRZ
          :=CABQuery.FieldByName(CABALADATA_SOILWATERFIELD).Asfloat;
        CurrentCAMBIUMInputData[i].MinTemp
          :=CABQuery.FieldByName(CABALADATA_MINTEMPFIELD).AsFloat;
        CurrentCAMBIUMInputData[i].MaxTemp
          :=CABQuery.FieldByName(CABALADATA_MAXTEMPFIELD).AsFloat;
        CurrentCAMBIUMInputData[i].IndepDBH_cm
          :=CABQuery.FieldByName(CABALADATA_DBHFIELD).AsFloat;
        CurrentCAMBIUMInputData[i].TreeHt_m
          :=CABQuery.FieldByName(CABALADATA_HEIGHTFIELD).AsFloat;
        CurrentCAMBIUMInputData[i].GreenHt_m
          :=CABQuery.FieldByName(CABALADATA_GREENHTFIELD).AsFloat;
        CurrentCAMBIUMInputData[i].wfr
          :=CABQuery.FieldByName(CABALADATA_WFRFIELD).AsFloat;
        CurrentCAMBIUMInputData[i].wf
          :=CABQuery.FieldByName(CABALADATA_WFFIELD).AsFloat;
        CurrentCAMBIUMInputData[i].wcr
          :=CABQuery.FieldByName(CABALADATA_WCRFIELD).AsFloat;
        CurrentCAMBIUMInputData[i].ws
          :=CABQuery.FieldByName(CABALADATA_WSFIELD).AsFloat;
        CurrentCAMBIUMInputData[i].Transp
          :=CABQuery.FieldByName(CABALADATA_GS1FIELD).Asfloat;
        CurrentCAMBIUMInputData[i].VPD_kpa
          :=CABQuery.FieldByName(CABALADATA_VPDFIELD).AsFloat;
        CurrentCAMBIUMInputData[i].Rain
          :=CABQuery.FieldByName(CABALADATA_RAINFIELD).AsFloat;
        CurrentCAMBIUMInputData[i].FinalStandVol
          :=CABQuery.FieldByName(CABALADATA_FINALVOLFIELD).AsFloat;

        CABQuery.Next;
        i := i + 1;

      end;

      Result := CurrentCAMBIUMInputData;
      //if NoMinWP = true then
        //formWarnings.MemoWarnings.Lines.Add('The CaBala database did not have predictions of minimum daily leaf water potential. ' +
          //'Data was estimated as 25% of pre-dawn leaf water potential.');

    end else
      formWarnings.memoWarnings.Lines.Add('Could not connect to the CaBala data file');
  finally
    //FormMain.labelstatus.Caption := '';
    //formmain.Refresh;
  end;
end;


end.
