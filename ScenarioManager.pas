unit ScenarioManager;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,ADODB,contnrs,DB,DBGRids,General,
  DataModule,ProjectWarnings;

  Procedure GetSelectedScenarioNames(CurrentDBGrid: TDBGrid;
    CurrentDS: TDataSource;
    CurrentTable: TADOTable;
    ScenarioNameFieldName: String;
    ScenariosSL: TStringList);

  Function GetSelectedScenarioRecordCount(CurrentDBGrid: TDBGrid;
    CurrentDS: TDataSource;
    CurrentTable: TADOTable;
    RecordCountFieldName: String): SmallInt;

  Procedure DeleteScenarios(ScenarioNamesList: TStringList;
    ScenariosTableName : string;
    ScenarioNameField : String;
    CommandObject: TADOCommand);

  Function GetScenariosUsingDataSet(ScenariosTableName: String;
    DataFieldName : String;
    DataSet: String;
    CurrentQuery : TADOQuery): TStringList;


  Procedure SetScenarioVariables(ScenarioName: String;
    var ScenarioType : String;
    var SiteName: String;
    var SiteLat: Single;
    var RegimeName: String;
    var WeatherDSName: String;
    var ParamSetName : String;
    var CABALAProject: String;
    var CABALAScenarioName: String;
    var CABALAScenarioID: Integer;
    var CABALAScenarioParentID : Integer;
    var TreeType : String;
    var Position : Single;
    var AllVariablesSetOK : boolean;
    MyCAMBIUMQuery : TADOQuery;
    MyCABALAQuery : TADOQuery);

  Function GetSpecificScenarioName(CurrentDBGrid: TDBGrid;
    CurrentDS: TDataSource;
    CurrentQuery: TADOQuery;
    ScenarioNameFieldName: String;
    SelNumber: Integer): String;

const
  CAMBIUM_SCENARIO_TYPE = 'Cambium';
  CABALA_SCENARIO_TYPE = 'Cabala';
  TREETYPES : array[0..2] of string = ('Suppressed','Average','Dominant');



implementation

uses ProjectManager,LinkCABALAScenario;

Procedure DeleteScenarios(ScenarioNamesList: TStringList;
  ScenariosTableName : string;
  ScenarioNameField : String;
  CommandObject: TADOCommand);
var
  i : integer;
begin

  for i := 0 to ScenarioNamesList.Count-1 do begin
    General.DeleteFromTable(CommandObject,
      ScenariosTableName,
      ScenarioNameField + '="' + ScenarioNamesList[i] + '"');

      //**********************************************************************
      //Clear the output data tables
      DeleteFromTable(DataModule.DataModuleBoard.ADOCommandCAMBIUM,
        CAMBIUMSEGMENTSDATATABLE,
        SCENARIONAMEFIELD + '="' + ScenarioNamesList[i] + '"');

      DeleteFromTable(DataModule.DataModuleBoard.ADOCommandCAMBIUM,
        ProjectManager.DAILYOUTPUTDATATABLE,
        SCENARIONAMEFIELD + '="' + ScenarioNamesList[i] + '"');
      //**********************************************************************

 end;
end;

Procedure SetScenarioVariables(ScenarioName: String;
  var ScenarioType : String;
  var SiteName: String;
  var SiteLat: Single;
  var RegimeName: String;
  var WeatherDSName: String;
  var ParamSetName : String;
  var CABALAProject: String;
  var CABALAScenarioName: String;
  var CABALAScenarioID: Integer;
  var CABALAScenarioParentID : Integer;
  var TreeType : String;
  var Position : Single;
  var AllVariablesSetOK : boolean;
  MyCAMBIUMQuery : TADOQuery;
  MyCABALAQuery : TADOQuery);
var
  SQLQuery: String;
  CABALASiteID: Integer;

begin
  AllVariablesSetOK := true;

  try

    SQLQuery := '';

    SQLQuery := 'SELECT * FROM ' +
    ProjectManager.SCENARIOSTABLE + ' WHERE ' +
    ProjectManager.SCENARIONAMEFIELD + '="' + ScenarioName + '";';

    MyCAMBIUMQuery.SQL.Clear;
    MyCAMBIUMQuery.SQL.Add(SQLQuery);
    MyCAMBIUMQuery.Active := true;

   MyCAMBIUMQuery.First;

    ParamSetName := MyCAMBIUMQuery.FieldByName(ProjectManager.SCENARIOCAMBIUMPARAMSFIELD).AsString;
    TreeType := MyCAMBIUMQuery.FieldByName(ProjectManager.SCENARIOTREETYPEFIELD).AsString;
    Position := MyCAMBIUMQuery.FieldByName(ProjectManager.SCENARIOSTEMPOSFIELD).AsFloat;
    ScenarioType := MyCAMBIUMQuery.FieldByName(ProjectManager.SCENARIOTYPEFIELD).AsString;

    if ScenarioType = CAMBIUM_SCENARIO_TYPE then begin

      SiteName :=  MyCAMBIUMQuery.FieldByName(ProjectManager.SCENARIOSITEFIELD).AsString;
      WeatherDSName :=  MyCAMBIUMQuery.FieldByName(ProjectManager.SCENARIOWEATHERDATAFIELD).AsString;
      RegimeName :=  MyCAMBIUMQuery.FieldByName(ProjectManager.SCENARIOREGIMEFIELD).AsString;

      MyCAMBIUMQuery.Active := false;

      SQLQuery := '';

      SQLQuery := 'SELECT * FROM ' +
      ProjectManager.SITESTABLE + ' WHERE ' +
      ProjectManager.SITENAMEFIELD + '="' + SiteName + '";';

      MyCAMBIUMQuery.SQL.Clear;
      MyCAMBIUMQuery.SQL.Add(SQLQuery);
      MyCAMBIUMQuery.Active := true;

      MyCAMBIUMQuery.First;

      SiteLat := MyCAMBIUMQuery.FieldByName(ProjectManager.SITELATFIELD).AsFloat;

    end else if ScenarioType = CABALA_SCENARIO_TYPE then begin

      SQLQuery := '';

      SQLQuery := 'SELECT * FROM ' +
      ProjectManager.CABALASCENARIOSTABLE + ' WHERE ' +
      ProjectManager.SCENARIONAMEFIELD + '="' + ScenarioName + '";';

      MyCAMBIUMQuery.SQL.Clear;
      MyCAMBIUMQuery.SQL.Add(SQLQuery);
      MyCAMBIUMQuery.Active := true;

      MyCAMBIUMQuery.First;

      CABALAProject := MyCAMBIUMQuery.FieldByName(ProjectManager.CABALAPROJECTFIELD).AsString;
      CABALAScenarioName := MyCAMBIUMQuery.FieldByName(ProjectManager.CABALASCENARIONAMEFIELD).AsString;

      if ProjectManager.ConnectDatabase(CABALAProject,
        DataModule.DataModuleBoard.ADOConnectionCABALA,LinkCabalaScenario.CABALAPW) = true then begin

        SQLQuery := '';
        SQLQUERY := 'SELECT * FROM ' +
        CABALASCENARIOPARENTINFOTABLE + ' WHERE ' +
        CABALASCENARIONAMEFIELD_CABALADB + '="' +
        CABALAScenarioName + '";';

        MyCABALAQuery.sql.Clear;
        MyCABALAQuery.sql.Add(SQLQuery);
        MyCABALAQuery.Active := true;
        MyCABALAQuery.First;

        CABALAScenarioParentID := MyCABALAQuery.FieldByName(CABALASCENARIOPARENTIDFIELD).AsInteger;
        CABALASiteID := MyCABALAQuery.FieldByName(CABALASITEIDFIELD).AsInteger;

        MyCABALAQuery.Active := false;

        SQLQuery := '';
        SQLQUERY := 'SELECT * FROM ' +
        CABALASCENARIOINFOTABLE + ' WHERE ' +
        CABALASCENARIOPARENTIDFIELD + '=' +
        inttostr(CABALAScenarioParentID) + ';';

        MyCABALAQuery.sql.Clear;
        MyCABALAQuery.sql.Add(SQLQuery);
        MyCABALAQuery.Active := true;
        MyCABALAQuery.First;


        CABALAScenarioID := MyCABALAQuery.FieldByName(CABALASCENARIOIDFIELD).AsInteger;

        MyCABALAQuery.Active := false;

        SQLQUERY := 'SELECT * FROM ' +
        CABALASITEINFOTABLE + ' WHERE ' +
        CABALASITEIDFIELD + '=' +
        inttostr(CABALASiteID) + ';';

        MyCABALAQuery.sql.Clear;
        MyCABALAQuery.sql.Add(SQLQuery);
        MyCABALAQuery.Active := true;
        MyCABALAQuery.First;

        SiteLat := MyCABALAQuery.FieldByName(CABALASITELATFIELD).AsInteger;

        MyCABALAQuery.Active := false;
      end else begin
        AllVariablesSetOK := false;
        FormWarnings.MemoWarnings.lines.add('Could not connect to the CaBala data file');
      end;
    end;
  except
    AllVariablesSetOK := false;
  end;
end;

Procedure GetSelectedScenarioNames(CurrentDBGrid: TDBGrid;
  CurrentDS: TDataSource;
  CurrentTable: TADOTable;
  ScenarioNameFieldName: String;
  ScenariosSL: TStringList);
var
  i : integer;


begin
  CurrentTable.First;
  ScenariosSL.Clear;

  if CurrentDBGrid.SelectedRows.Count > 0 then begin

    for i := 0 to CurrentDBGrid.SelectedRows.Count - 1 do begin

      //TempSL.Clear;

      CurrentDS.DataSet.GotoBookmark(Pointer(CurrentDBGrid.SelectedRows.Items[i]));
      ScenariosSL.Add(CurrentTable.FieldByName(ScenarioNameFieldName).AsString);

      CurrentTable.next;
    end;
  end;
end;

Function GetSpecificScenarioName(CurrentDBGrid: TDBGrid;
  CurrentDS: TDataSource;
  CurrentQuery: TADOQuery;
  ScenarioNameFieldName: String;
  SelNumber: Integer): String;
begin
  CurrentQuery.First;

  if CurrentDBGrid.SelectedRows.Count > 0 then begin
    CurrentDS.DataSet.GotoBookmark(Pointer(CurrentDBGrid.SelectedRows.Items[SelNumber]));
    Result := CurrentQuery.FieldByName(ScenarioNameFieldName).AsString;
  end;
end;

Function GetScenariosUsingDataSet(ScenariosTableName: String;
  DataFieldName : String;
  DataSet: String;
  CurrentQuery : TADOQuery): TStringList;
var
  TempSL: TStringList;
  SQLString : String;
  i : integer;
begin
  TempSL := TStringList.Create;

  CurrentQuery.sql.clear;

  SQLString := 'SELECT * FROM [' + ScenariosTableName +
    '] WHERE ' + DataFieldName + '="' + DataSet + '"';
  CurrentQuery.SQL.Add(SQLString);
  CurrentQuery.Active := true;

  for i := 0 to CurrentQuery.RecordCount-1 do
    TempSL.Add(CurrentQuery.FieldByName(ProjectManager.SCENARIONAMEFIELD).AsString);

  Result := TempSL;
end;

Function GetSelectedScenarioRecordCount(CurrentDBGrid: TDBGrid;
  CurrentDS: TDataSource;
  CurrentTable: TADOTable;
  RecordCountFieldName: String): Smallint;
var
  Temp: String;

begin
  CurrentTable.First;
  Result := 0;

  if CurrentDBGrid.SelectedRows.Count =1 then begin

    CurrentDS.DataSet.GotoBookmark(Pointer(CurrentDBGrid.SelectedRows.Items[0]));
    Temp := CurrentTable.FieldByName(RecordCountFieldName).AsString;

    if Temp <> '' then
      Result := round(strtofloat(Temp))
    else
      Result := 0;

  end else
    messagedlg('No/more than one scenarios selected',mtError,[mbOK],0);
end;










end.
