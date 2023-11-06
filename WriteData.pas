unit WriteData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, Buttons, ExtCtrls, TeeProcs, TeEngine, Chart, Series,
  ComCtrls,DataObjects,ProjectManager,General,dataModule,ImportDataProgress,ADODB,
  ProjectWarnings;

  Procedure WriteSegmentData(SegmentDataTable : TADOTable;
    SegmentDataTableName : string;
    SegmentData: TCambiumSegmentDataArray;
    ScenarioName: string;
    TreeNumber : Integer;
    StemPosition : Single);

  Procedure WriteDataSetName(TheADOTable: TADOTable;
    TheTableName: String;
    DataSetNameFieldName: String;
    DataSetName : String);

  procedure WriteSavedRegimeInformation (CurrentRegimeInfo : TRegimeDataArray;
    RegimeDataTableName : String;
    RegimesDataTable : TADOTable;
    OverWrite: Boolean);

  procedure WriteSiteInformation (CurrentSiteInfo : TSiteData;
    SiteTableName : String;
    SitesTable : TADOTable;
    OverWrite : Boolean);

  procedure WriteWeatherDataFromArray (CurrentWeatherData : TWeatherDataArray;
    WeatherDataSetName : String;
    WeatherDataTableName : String;
    WeatherDataTable : TADOTable;
    OverWrite : Boolean);

  Procedure WriteDailyData(DailyDataTable: TADOTable;
    DailyDataTableName: String;
    DailyData: TCAMBIUMDailyOutputDataArray;
    ScenarioName: STring;
    StemPosition: Single);

  Procedure WriteSLToFile(FilePath: String;
    MyStrings: TStringList);




  {Procedure WriteWeatherData(WeatherDSName : String;
    InputSLArray : TStringListArray;
    DateCOlNum : Integer;
    RainColNum : Integer;
    MaxTCOlNum,MinTColNum : INteger;
    EvapColNum:Integer;
    SRColNum:Integer;
    MaxRHCOlNum,MinRHColNum: Integer;
    WeatherDataTable: TAdoTable);overload;}

  Procedure WriteSILOData(WeatherDSName : String;
    InputSL : TStringList;
    Delimiter : Char;
    StartLine : Integer;
    DateCOlNum : Integer;
    RainColNum : Integer;
    MaxTCOlNum,MinTColNum : INteger;
    EvapColNum:Integer;
    SRColNum:Integer;
    MaxRHCOlNum,MinRHColNum: Integer;
    WeatherDataTable: TAdoTable);

implementation

Procedure WriteSegmentData(SegmentDataTable : TADOTable;
  SegmentDataTableName : string;
  SegmentData: TCambiumSegmentDataArray;
  ScenarioName: string;
  TreeNumber : Integer;
  StemPosition : Single);
var
  i : integer;
begin
  SegmentDataTable.Active := false;
  SegmentDataTable.TableName := SegmentDataTableName;
  SegmentDataTable.Active := true;

  for i := 0 to length(SegmentData)-1 do begin
    SegmentDataTable.Append;
    SegmentDataTable.FieldValues[ProjectManager.SCENARIONAMEFIELD]:=
      ScenarioName;
    SegmentDataTable.FieldValues[ProjectManager.TREENUMBERFIELD]:=
      TreeNumber;
    SegmentDataTable.FieldValues[ProjectManager.STEMPOSITIONFIELD]:=
      StemPosition;
    SegmentDataTable.FieldValues[ProjectManager.STARTDATEFIELD]:=
      Segmentdata[i].StartDate;
    SegmentDataTable.FieldValues[ProjectManager.ENDDATEFIELD]:=
      SegmentData[i].EndDate;
    SegmentDataTable.FieldValues[ProjectManager.SEGMENTNUMBERFIELD]:=
      SegmentData[i].SegmentNumber;
    SegmentDataTable.FieldValues[ProjectManager.SEGMENTPOSITIONFIELD]:=
      SegmentData[i].SegmentPosition;
    SegmentDataTable.FieldValues[ProjectManager.SEGMENTWIDTHFIELD]:=
      SegmentData[i].SegmentWidth;
    SegmentDataTable.FieldValues[ProjectManager.MEANRDFIELD]:=
      SegmentData[i].MeanRD;
    SegmentDataTable.FieldValues[ProjectManager.MEANTDFIELD]:=
      SegmentData[i].MeanTD;
    SegmentDataTable.FieldValues[ProjectManager.MEANLENGTHFIELD]:=
      SegmentData[i].MeanLength;
    SegmentDataTable.FieldValues[ProjectManager.MEANWTFIELD]:=
      SegmentData[i].MeanWT;
    SegmentDataTable.FieldValues[ProjectManager.WOODDENSITYFIELD]:=
      SegmentData[i].WoodDensity;
    SegmentDataTable.FieldValues[ProjectManager.MFAFIELD]:=
      SegmentData[i].MFA;
    SegmentDataTable.FieldValues[ProjectManager.CELLDENSITYFIELD]:=
      SegmentData[i].CellDensity;
    SegmentDataTable.FieldValues[ProjectManager.MOEFIELD]:=
      SegmentData[i].MOE;
    SegmentDataTable.FieldValues[ProjectManager.RINGINSEGMENTMARKERFIELD] :=
      SegmentData[i].RinginSegment;

   SegmentdataTable.Post;
  end;
end;

Procedure WriteSLToFile(FilePath: String;
  MyStrings: TStringList);
var
  OutFile: TextFile;
  i : integer;
begin
  AssignFile(OutFile, FilePath);
  ReWrite(OutFile);

  for i := 0 to MyStrings.Count - 1 do begin
    writeln(MyStrings[i]);
  end;

  closefile(OutFile);
end;




Procedure WriteDailyData(DailyDataTable: TADOTable;
  DailyDataTableName: String;
  DailyData: TCAMBIUMDailyOutputDataArray;
  ScenarioName: STring;
  StemPosition: Single);

var
  i : integer;
  WriteError : Boolean;
begin
  DailyDataTable.Active := false;
  DailyDataTable.TableName := DailyDataTableName;
  DailyDataTable.Active := true;
  WriteError := False;

  for i := 0 to length(DailyData)-1 do begin
    if DailyData[i].LogDate > 0 then begin

      try
        DailyDataTable.Append;

        DailyDataTable.FieldValues[ProjectManager.SCENARIONAMEFIELD]:=
          ScenarioName;
        DailyDataTable.FieldValues[ProjectManager.DAILYDATADATEFIELD]:=
          DailyData[i].LogDate;
        DailyDataTable.FieldValues[ProjectManager.STEMDIAMFIELD]:=
          DailyData[i].DiamAtModellingPos;
        DailyDataTable.FieldValues[ProjectManager.TREEHEIGHTFIELD]:=
          DailyData[i].TreeHeight;
        DailyDataTable.FieldValues[ProjectManager.TREENPPFIELD]:=
          DailyData[i].TreeNPP;
        DailyDataTable.FieldValues[ProjectManager.STANDNPPFIELD]:=
          DailyData[i].StandNPP;
        DailyDataTable.FieldValues[ProjectManager.STEMALLOCFIELD]:=
          DailyData[i].StemAllocCarb;
        DailyDataTable.FieldValues[ProjectManager.MEANCZCOUNTFIELD]:=
          DailyData[i].CZCount;
        DailyDataTable.FieldValues[ProjectManager.MEANEZCOUNTFIELD]:=
          DailyData[i].EZCount;
        DailyDataTable.FieldValues[ProjectManager.MEANTZCOUNTFIELD]:=
          DailyData[i].TZCount;
        DailyDataTable.FieldValues[ProjectManager.MEANDAYSGROWINGFIELD]:=
          DailyData[i].GrowingDays;
        DailyDataTable.FieldValues[ProjectManager.MEANDAYSSECTHICKFIELD]:=
          DailyData[i].ThickeningDays;
        DailyDataTable.FieldValues[ProjectManager.MINTEMPFIELD]:=
          DailyData[i].MinTemp;
        DailyDataTable.FieldValues[ProjectManager.MAXTEMPFIELD]:=
          DailyData[i].MaxTemp;
        DailyDataTable.FieldValues[ProjectManager.MINLWPFIELD] :=
          DailyData[i].MinLWP;
        DailyDataTable.FieldValues[ProjectManager.MAXLWPFIELD]:=
          DailyData[i].MaxLWP;
        DailyDataTable.FieldValues[ProjectManager.ASWRZFIELD]:=
          DailyData[i].ASWRootZone;
        DailyDataTable.FieldValues[ProjectManager.WSFIELD]:=
          DailyData[i].WSStand;
        DailyDataTable.FieldValues[ProjectManager.WFFIELD]:=
          DailyData[i].WFStand;
        DailyDataTable.FieldValues[ProjectManager.WRFIELD]:=
          DailyData[i].WRStand;
        DailyDataTable.FieldValues[ProjectManager.MEANCELLCYCLEDURFIELD] :=
          DailyData[i].CellCycleDur;
        DailyDataTable.FieldValues[ProjectManager.LAIFIELD] :=
          DailyData[i].DailyLAI;
        DailyDataTable.FieldValues[ProjectManager.SPHFIELD] :=
          DailyData[i].SPH;
        DailyDataTable.FieldValues[ProjectManager.TOTSTEMVOLFIELD] :=
          DailyData[i].StemVol;

        //These three variables were added later and just use redundant fields
        //that would exist in older databases
        DailyDataTable.FieldValues[ProjectManager.VOLSPECSTEMALLOCFIELD] :=
          DailyData[i].TreeAge;
        DailyDataTable.FieldValues[ProjectManager.MEANWTRFIELD] :=
          DailyData[i].Transpiration;
        DailyDataTable.FieldValues[ProjectManager.MEANRDGRFIELD] :=
          DailyData[i].Rainfall;


        DailyDataTable.Post;
      except
        WriteError := True;
      end;
    end;
  end;
  if WriteError then
    FormWarnings.MemoWarnings.Lines.add('There was a problem writing the daily data to the data file. ' +
                                        'The version may not be compatible.');
end;

Procedure WriteDataSetName(TheADOTable: TADOTable;
  TheTableName: String;
  DataSetNameFieldName: String;
  DataSetName : String);

begin
  TheADOTable.Active := false;
  TheADOTable.TableName := TheTableName;
  TheADOTable.Active := true;


  TheADOTable.Append;

  TheADOTable.FieldValues[DataSetNameFieldName]:=
        DataSetName;

  TheADOTable.Post;
end;



Procedure WriteSILOData(WeatherDSName : String;
  InputSL : TStringList;
  Delimiter: char;
  StartLine : Integer;
  DateColNum : Integer;
  RainColNum : Integer;
  MaxTColNum,MinTColNum : INteger;
  EvapColNum:Integer;
  SRColNum:Integer;
  MaxRHCOlNum,MinRHColNum: Integer;
  WeatherDataTable: TAdoTable);
var
  i : integer;
  InputDate : TDate;
  slrow : TStringList;
  test3:string;
  test4 : double;
begin

  ClearFilteredRecords(ProjectManager.SCENARIOSTABLE,
    ProjectManager.SCENARIOWEATHERDATAFIELD,
    WeatherDSName,
    dataModule.DataModuleBoard.ADOCommandCAMBIUM);

  ClearFilteredRecords(ProjectManager.WEATHERDATASETNAMESTABLE,
    ProjectManager.WEATHERDATASETNAMEFIELD,
    WeatherDSName,
    dataModule.DataModuleBoard.ADOCommandCAMBIUM);

  ClearFilteredRecords(ProjectManager.WEATHERDATATABLE,
    ProjectManager.WEATHERDATASETNAMEFIELD,
    WeatherDSName,
    dataModule.DataModuleBoard.ADOCommandCAMBIUM);

  WeatherDataTable.Active := false;
  WeatherDataTable.TableName := ProjectManager.WEATHERDATASETNAMESTABLE;
  WeatherDataTable.Active := true;

  WeatherDataTable.Append;

  WeatherDataTable.FieldValues[ProjectManager.WEATHERDATASETNAMEFIELD]:=
    WeatherDSName;

  WeatherDataTable.Post;

  formImportDataProgress.ProgressBar1.min := 0;
  formImportDataProgress.progressbar1.step := 1;
  formImportDataProgress.ProgressBar1.max := InputSL.Count + 1;

  UpDatePB(formImportDataProgress.ProgressBar1);

  WeatherDataTable.Active := false;
  WeatherDataTable.TableName := ProjectManager.WEATHERDATATABLE;
  WeatherDataTable.Active := true;

  try
    for i := StartLine-1 to InputSL.Count-1 do begin

      UpDatePB(formImportDataProgress.ProgressBar1);
      formImportDataProgress.Refresh;
      application.ProcessMessages;


      //test1 := inttostr(inputsl.Count);

      slRow := TStringList.Create;
      General.DecodeDelimitedString(InputSL.Strings[i],
        slrow,
        ' ');

      //test2 := slrow.Strings[1];

      WeatherDataTable.Append;

      WeatherDataTable.FieldValues[ProjectManager.WEATHERDATASETNAMEFIELD]:=
        WeatherDSName;

      InputDate :=  ConvertSILODate(slRow.Strings[DateColNum-1]);

      WeatherDataTable.FieldValues[ProjectManager.WEATHERDATEFIELD]:=
        DateTimetoStr(InputDate);
      WeatherDataTable.FieldValues[ProjectManager.MAXTEMPFIELD]:=
        slrow.Strings[MaxTColNum-1];
      //Test3 and Test4 were created to try to fix a wierd variable settting bug
      test3 := slrow.Strings[MaxTColNum-1];
      WeatherDataTable.FieldValues[ProjectManager.MINTEMPFIELD]:=
        slrow.Strings[MinTColNum-1];
      WeatherDataTable.FieldValues[ProjectManager.EVAPFIELD]:=
        slrow.Strings[EvapColNum-1];
      test3 := slrow.Strings[RainColNum-1];
      test4 := strtofloat(test3);
      WeatherDataTable.FieldValues[ProjectManager.RAINFIELD]:=
        test4;
        //strtofloat(slrow.Strings[i][RainColNum-1]);
      WeatherDataTable.FieldValues[ProjectManager.QAFIELD]:=
        slrow.Strings[SRColNum-1];

      WeatherDataTable.FieldValues[ProjectManager.MINRHFIELD]:=
        slrow.Strings[MinRHColNum-1];
      WeatherDataTable.FieldValues[ProjectManager.MAXRHFIELD]:=
        slrow.Strings[MaxRHColNum-1];

      WeatherDataTable.Post;

      slrow.Free;
    end;
  except
    on E: Exception do begin
      Messagedlg('There was a problem importing the data: ' + E.Message,mtError,[mbOK],0);

      ClearFilteredRecords(ProjectManager.WEATHERDATASETNAMESTABLE,
        ProjectManager.WEATHERDATASETNAMEFIELD,
        WeatherDSName,
        dataModule.DataModuleBoard.ADOCommandCAMBIUM);

      ClearFilteredRecords(ProjectManager.WEATHERDATATABLE,
        ProjectManager.WEATHERDATASETNAMEFIELD,
        WeatherDSName,
        dataModule.DataModuleBoard.ADOCommandCAMBIUM);

    end;
  end;

end;

procedure WriteWeatherDataFromArray (CurrentWeatherData : TWeatherDataArray;
  WeatherDataSetName : String;
  WeatherDataTableName : String;
  WeatherDataTable : TADOTable;
  OverWrite: Boolean);
var
  i,UniqueCOunter : integer;
  UniqueSuffix,ImportName : String;
  Test : Boolean;
begin
  Test := False;
  UniqueSuffix := '';
  UniqueCounter := 0;

  if OverWrite then
    ClearFilteredRecords(ProjectManager.WEATHERDATATABLE,
      ProjectManager.WEATHERDATASETNAMEFIELD,
      WeatherDataSetName,
      dataModule.DataModuleBoard.ADOCommandCAMBIUM);

  WeatherDataTable.Active := false;
  WeatherDataTable.TableName := WeatherDataTableName;
  WeatherDataTable.Active := true;

  While Test = False do begin
    Test := General.IsNewValueUnique(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
      WeatherDataSetName + UniqueSuffix,
      ProjectManager.WEATHERDATATABLE,
      ProjectManager.WEATHERDATASETNAMEFIELD);
    if Test = False then
      UniqueSuffix := UniqueSuffix + inttostr(UniqueCounter + 1);
  end;

  ImportName := WeatherDataSetName + UniqueSuffix;

  InsertRecord(DataModule.DataModuleBoard.ADOCommandCAMBIUM,
    ProjectManager.WEATHERDATASETNAMESTABLE,
    ProjectManager.WEATHERDATASETNAMEFIELD,
    '"' + ImportName + '"');

  for i := 0 to Length(CurrentWeatherData) - 1 do begin

      WeatherDataTable.Append;
      WeatherDataTable.FieldValues[ProjectManager.WEATHERDATASETNAMEFIELD]:=
        ImportName;
      WeatherDataTable.FieldValues[ProjectManager.WEATHERDATEFIELD]:=
        CurrentWeatherData[i].LogDate;
      WeatherDataTable.FieldValues[ProjectManager.MINTEMPFIELD]:=
        CurrentWeatherData[i].MinTemp;
      WeatherDataTable.FieldValues[ProjectManager.MAXTEMPFIELD]:=
        CurrentWeatherData[i].MaxTemp;
      WeatherDataTable.FieldValues[ProjectManager.QAFIELD]:=
        CurrentWeatherData[i].SolRad;
      WeatherDataTable.FieldValues[ProjectManager.RAINFIELD]:=
        CurrentWeatherData[i].Rainfall;
      WeatherDataTable.FieldValues[ProjectManager.EVAPFIELD]:=
        CurrentWeatherData[i].Evap;
      WeatherDataTable.FieldValues[ProjectManager.MINRHFIELD]:=
        CurrentWeatherData[i].MinRH;
      WeatherDataTable.FieldValues[ProjectManager.MAXRHFIELD]:=
        CurrentWeatherData[i].MaxRH;

      WeatherDataTable.Post;
  end;
end;

procedure WriteSavedRegimeInformation (CurrentRegimeInfo : TRegimeDataArray;
  RegimeDataTableName : String;
  RegimesDataTable : TADOTable;
  OverWrite : Boolean);
var
  i,UniqueCOunter : integer;
  UniqueSuffix,ImportName : String;
  Test : Boolean;
begin
  Test := False;
  UniqueSuffix := '';
  UniqueCounter := 0;

  if OverWrite then
    ClearFilteredRecords(ProjectManager.REGIMESTABLE,
      ProjectManager.REGIMENAMEFIELD,
      CurrentRegimeInfo[0].RegimeName,
      dataModule.DataModuleBoard.ADOCommandCAMBIUM);

  RegimesDataTable.Active := false;
  RegimesDataTable.TableName := RegimeDataTableName;
  RegimesDataTable.Active := true;


  While Test = False do begin
    Test := General.IsNewValueUnique(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
      CurrentRegimeInfo[0].RegimeName + UniqueSuffix,
      ProjectManager.REGIMESTABLE,
      ProjectManager.REGIMENAMEFIELD);
    if Test = False then
      UniqueSuffix := UniqueSuffix + inttostr(UniqueCounter + 1);
  end;

  ImportName := CurrentRegimeInfo[0].RegimeName + UniqueSuffix;

  InsertRecord(DataModule.DataModuleBoard.ADOCommandCAMBIUM,
    ProjectManager.REGIMENAMESTABLE,
    ProjectManager.REGIMENAMEFIELD,
    '"' + ImportName + '"');

  for i := 0 to Length(CurrentRegimeInfo) - 1 do begin
    if CurrentRegimeInfo[i].EventType <> '' then begin
      RegimesDataTable.Append;
      RegimesDataTable.FieldValues[ProjectManager.REGIMENAMEFIELD]:=
        ImportName;
      RegimesDataTable.FieldValues[ProjectManager.EVENTTYPEFIELD]:=
        CurrentRegimeInfo[i].EventType;
      RegimesDataTable.FieldValues[ProjectManager.EVENTDATEFIELD]:=
        CurrentRegimeInfo[i].EventDate;
      RegimesDataTable.FieldValues[ProjectManager.EVENTVALUEFIELD]:=
        CurrentRegimeInfo[i].EventValue;
      RegimesdataTable.Post;
    end;
  end;
end;

procedure WriteSiteInformation (CurrentSiteInfo : TSiteData;
  SiteTableName : String;
  SitesTable : TADOTable;
  OverWrite: Boolean);
var
  UniqueCOunter : integer;
  UniqueSuffix,ImportName : String;
  Test : Boolean;
begin
  Test := False;
  UniqueSuffix := '';
  UniqueCounter := 0;

  if OverWrite then
    ClearFilteredRecords(ProjectManager.SITESTABLE,
      ProjectManager.SITENAMEFIELD,
      CurrentSiteInfo.SiteName,
      dataModule.DataModuleBoard.ADOCommandCAMBIUM);

  SitesTable.Active := false;
  SitesTable.TableName := SiteTableName;
  SitesTable.Active := true;

  While Test = False do begin
    Test := General.IsNewValueUnique(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
      CurrentSiteInfo.SiteName + UniqueSuffix,
      ProjectManager.SITESTABLE,
      ProjectManager.SITENAMEFIELD);
    if Test = False then
      UniqueSuffix := UniqueSuffix + inttostr(UniqueCounter + 1);
  end;

  ImportName := CurrentSiteInfo.SiteName + UniqueSuffix;

  InsertRecord(DataModule.DataModuleBoard.ADOCommandCAMBIUM,
    ProjectManager.SITENAMESTABLE,
    ProjectManager.SITENAMEFIELD,
    '"' + ImportName + '"');

  SitesTable.Append;
    SitesTable.FieldValues[ProjectManager.SITENAMEFIELD]:=
    ImportName;
    SitesTable.FieldValues[ProjectManager.SITELATFIELD]:=
    CurrentSiteInfo.Latitude;
    SitesTable.FieldValues[ProjectManager.SOILDEPTHFIELD]:=
    CurrentSiteInfo.SoilDepth;
    SitesTable.FieldValues[ProjectManager.SOILTEXTUREFIELD]:=
    CurrentSiteInfo.SoilTexture;
    SitesTable.FieldValues[ProjectManager.SITEFRFIELD]:=
    CurrentSiteInfo.FR;
    SitesTable.FieldValues[ProjectManager.MINASWFIELD]:=
    CurrentSiteInfo.MinASW;
    SitesTable.FieldValues[ProjectManager.MAXASWFIELD]:=
    CurrentSiteInfo.MaxASW;
    SitesTable.FieldValues[ProjectManager.INITIALASWFIELD]:=
    CurrentSiteInfo.InitialASW;
    SitesTable.FieldValues[ProjectManager.SOILCLASSFIELD]:=
    CurrentSiteInfo.SoilClass;

  SitesTable.Post;

end;




end.
