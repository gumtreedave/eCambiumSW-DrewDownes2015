unit General;

interface
uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids,{FileCtrl,}Contnrs, ComCtrls,ADODB,
  DBGrids,CAmbiumObjects,DB,Chart,Math,TypInfo,jpeg;

type
  TDoubleArray = array of Double;
  TStringListArray =Array of TStringList;


  Procedure ClearTheGrid(GridColumns:integer;CurrentGrid:TStringGrid);
  Procedure AddDataToSGrid(CurrentStringList:TStringList;CurrentGrid:TStringGrid;SpecialCaseIndicator:Integer);
  Procedure GridColAutoSize( Grid:TStringGrid );overload;
  procedure GridColAutoSize(Grid:TDbGrid);overload;
  Procedure UpdateStatusBar(CurrentCaption: TCaption; CurrentMessage: string);
  Function LowTempFunction(MinTemp,MaxTemp,MinTToday: Double):Double;
  Procedure UpDatePB(CurrentPB: TProgressBar);

  Procedure GetDistinctValuesinField(CurrentADOQuery: TADOQuery;
    TableName : string;
    FieldName : string;
    OutputStrings : TStrings);
  Procedure GetFilteredValuesinField(CurrentADOQuery: TADOQuery;
    TableName : string;
    TargetFieldName : String;
    FilterFieldName : string;
    Criterion : String;
    OutputStrings : TStrings);
  Procedure GetMinMaxDatesFromTable(CurrentADOQuery: TADOQuery;
    TableName : string;
    DateFieldName : String;
    FilterFieldName : string;
    FilterCriterion : String;
    Var MinDate : TDate;
    Var MaxDate : TDate);
  Function IsNewValueUnique(CurrentADOQuery:TADOQuery;
    ProposedValue : string;
    IntendedTable:string;
    IntendedField:string):Boolean;
  Function TableExists(TableName : String; DataConnection : TADOConnection):Boolean;
  Function FirstDelimiter(const Delimiters, S: string): Integer;
  Function GetMax(AnArray: array of Double): Double;Overload;
  Function GetMax(AnArray: TDoubleArray): Double;Overload;
  Function GetMin(AnArray: TDoubleArray): Double;Overload;
  Function GetMin(AnArray: array of Double): Double;Overload;
  Procedure Shuffle(list : TObjectList) ;
  Function CompareByRadPosition(Item1 : Pointer; Item2 : Pointer) : Integer;
  Function CompareByOP(Item1 : Pointer; Item2 : Pointer) : Integer;
  Function CombineObjectLists(InputList1: TObjectList;
    InputList2: TObjectList): TObjectList;Overload;
  Function CombineObjectLists(InputList1: TObjectList;
    InputList2: TObjectList; InputList3: TObjectList): TObjectList;Overload;
  Function CombineObjectLists(InputList1: TObjectList;
    InputList2: TObjectList; InputList3: TObjectList;
    InputList4:TObjectList): TObjectList;Overload;
  Procedure ClearChart(InputGraph: TChart);
  Procedure InsertRecord(ADOCommand: TADOCommand;
    TableName: String;
    FieldNamesList: String;
    ValuesList: String);
  Procedure UpdateRecord(ADOCommand: TAdoCommand;
    TableName : String;
    UpdateFieldNamesList : TStringList;
    UpdateFieldValuesList : TStringList;
    Criteria : String);
  Procedure BuildStringList(CommaDelimitedString: String;
    var InputSL : TStringList);

  Procedure ClearFilteredRecords(TableName: String;
    FilterField: String;
    FilterCriterion : String;
    ADOCommand : TAdoCommand);
  Function ReadDelimitedFile(FileName : String;
    Delimiter: char;
    StartLine : Integer): TStringListArray;
  Function ConvertSILODate(SILODateObject: String): TDate;
  Procedure DecodeDelimitedString(InputStr : String;
    var myslrow: TStringList;
    Delimiter: char);
  function TemperatureFunction(TMinD:Real;TMaxD:Real;TMin:Real;Topt:real;TMax:real):Real;
  Function GetDayLength(Lat:Real;CurrentDate:TDate):Real;
  Function expF(x : Double;
    g0 : Double;
    gx : Double;
    tg : Double;
    ng : Double): Double;

  Procedure DeleteFromTable(ADOCommand: TADOCommand;
  TableName: String);Overload;

  Procedure DeleteFromTable(ADOCommand: TADOCommand;
    TableName: String;
    DeleteCriteria: String);Overload;

  Function RandomBetween(InputValue: Double;
    MinBoundary: Integer;
    MaxBoundary: Integer):Double;

  Function GetLagMean(InputDataArray : array of Double;
    EndPos: Integer;
    Lag : Integer):Double;
  function CompareByCarbConc(Item1 : Pointer; Item2 : Pointer) : Integer;
  {Function ConvertSaveImage(InputImage : TPicture;
    ImageFileName:string;
    FileType:integer):boolean;}


  //******************************************************************************
  //Volumes and surface areas for various shapes
  function CylinderVolumeFromDiam (RD:Real; TD:Real; Length:Real): Real;Overload;
  function CylinderVolumeFromArea (CSArea:Real; Length:Real): Real;Overload;
  function CylinderCSArea (Volume:Real; Length:Real): Real;
  function CylinderArea (RD:Real; TD:Real; Length:Real): Real;
  function ConeVolume (RD:Real; TD:Real; Length:Real): Real; Overload;
  function ConeVolume (CSArea:Real; Length:Real): Real; Overload;
  Function ConeCSArea (Volume:Real; Length:Real): Real;
  function ConeLateralSurfaceArea (D:Real; Height:Real):Real;
  Function ParaboloidSurfaceArea(Height: Real; DatHeight: Real): Real;
  function RectangularPrismVolumeFromDiam (RD:Real; TD: Real; L:real):Real;
  function RectangularPrismVolumeFromArea (CSArea: Real; L:real):Real;
  function RectangularPrismCSArea (RD:Real; TD:Real):Real;
  function RectangularPrismCSAreaFromVol (Vol:Real; Ht:Real):Real;
  function RectangularPrismArea (RD:Real; TD:Real):Real;
  function PyramidVolume (RD:Real;TD:Real;H:Real):Real;
  Function ParaboloidVolume(RD: Real; TD: Real; H: Real): Real;




  //Procedure UpDateProgressBar(CurrentPB: TProgressBar; CurrentPosition: Integer);
  //Procedure InitialiseProgressBar(CurrentPB: TProgressBar; PBMax: Integer; PBSteps: Integer);

const
  NORMALGRID = 0;
  IMPORTGRID = 1;


  //MyColours : array[0..13] of TColor = (clWhite,clMaroon,clGreen,clOlive,clNavy,clPurple,clTeal,
  MyColours : array[0..4] of TColor = (clRed,clYellow,clGreen,clBlue,clBlack);




implementation

uses DataObjects;

{Function ConvertSaveImage(InputImage : TPicture; ImageFileName:string; FileType:integer):boolean;
var
  JPGImage : TJPegImage;
  BMPImage : TBitmap;
begin

  Result:=False;
  BMPImage := TBitmap.Create;
  try

    BMPImage.assign(InputImage);
    JPGImage := TJpegImage.Create;

    if FileType = 1 then begin
      try
        JPGImage.Assign(BMPImage) ;
        JPGImage.SaveToFile(ImageFileName + '.jpg') ;
        Result:=True;
      finally
        JPGImage.Free
      end;
    end else if filetype = 2 then begin
      BMPImage.SaveToFile(ImageFileName + '.bmp');
    end;
  finally
   BMPImage.Free
  end;
end; }

Procedure UpDatePB(CurrentPB: TProgressBar);
Var
  Pos : Integer;
Begin
  Pos := CurrentPB.Position;
  CurrentPB.Position := pos + 2;
  CurrentPB.Position := pos + 1;
end;

Function GetLagMean(InputDataArray : array of Double;
  EndPos: Integer;
  Lag : Integer):Double;
var
  FilterStart,FilterEnd: Integer;
  i, MeanDayCounter : Integer;
  MeanValue : Double;

begin
  MeanDayCounter := 0;
  MeanValue := 0;

  if EndPos - Lag >= 0 then
    FilterStart := EndPos - Lag
  else
    FilterStart := 0;

  if EndPos <= Length(InputDataArray)-1 then
    FilterEnd := EndPos
  else
    FilterEnd := Length(InputDataArray)-1;

  for i:= FilterStart to FilterEnd do begin
    MeanValue := InputDataArray[i] + MeanValue;
    MeanDayCounter := MeanDayCounter + 1;
  end;

  if MeanDayCounter > 0 then
    MeanValue := MeanValue/MeanDayCounter
  else
    MeanValue := 0;

  Result := MeanValue;
end;


Function RandomBetween(InputValue: Double;MinBoundary: Integer;MaxBoundary: Integer):Double;
var
  RandomProp : Double;

begin
  Randomize;
  RandomProp := RandomRange(MinBoundary,MaxBoundary)/100;
  Result := InputValue * RandomProp;
end;

Procedure DeleteFromTable(ADOCommand: TADOCommand;
  TableName: String);Overload;
begin
  ADOCommand.CommandText := 'DELETE * FROM ' +
      TableName;
  ADOCommand.Execute;
end;

Procedure DeleteFromTable(ADOCommand: TADOCommand;
  TableName: String;
  DeleteCriteria:String);Overload;
var
  SQLString : string;
begin
  SQLString := 'DELETE * FROM [' +
    TableName + '] WHERE ' + DeleteCriteria;

  ADOCommand.CommandText := SQLString;
  ADOCommand.Execute;
end;

procedure ListComponentProperties(Component: TComponent; Strings: TStringList);
var
  Count, Size, I: Integer;
  List: PPropList;
  PropInfo: PPropInfo;
  PropOrEvent, PropValue: string;
begin
  Count := GetPropList(Component.ClassInfo, tkAny, nil);
  Size  := Count * SizeOf(Pointer);
  GetMem(List, Size);
  try
    Count := GetPropList(Component.ClassInfo, tkAny, List);
    for I := 0 to Count - 1 do
    begin
      PropInfo := List^[I];
      if PropInfo^.PropType^.Kind in tkMethods then
        PropOrEvent := 'Event'
      else
        PropOrEvent := 'Property';
      PropValue := VarToStr(GetPropValue(Component, PropInfo^.Name));
      Strings.Add(Format('[%s] %s: %s = %s', [PropOrEvent, PropInfo^.Name,
        PropInfo^.PropType^.Name, PropValue]));
    end;
  finally
    FreeMem(List);
  end;
end;

//Functions to calculate the length of the day
Function GetDayofYear(inputdate:TDate):integer;
Var
	MyYear,MyMonth,MyDay : Word;
	i,DaysBeforeNow : integer;

begin
	DaysBeforeNow := 0;

	DecodeDate(inputdate,MyYear,MyMonth,MyDay);

	for i := 1 to MyMonth do
		DaysBeforeNow := DaysBeforeNow + DataObjects.DaysInMonthNY[MyMonth];

	Result := MyDay + DaysBeforeNow;
end;

Function GetDayLength(Lat:Real;CurrentDate:TDate):Real;
	//gets fraction of day of daylight
Var
	SLAt:Double;
	cLat:Double;
	sinDec:Double;
	CosH0:Double;
  DOY : integer;
begin
  DOY := GetDayofYear(CurrentDate);

	SLAt := Sin(Pi * Lat / 180);
	cLat := Cos(Pi * Lat / 180);
	sinDec := 0.4 * Sin(0.0172 * (DOY - 80));
	cosH0 := -sinDec * SLAt / (cLat * Sqr(1 - power(sinDec,2)));
	If cosH0 > 1 Then
		Result := 0
	Else if cosH0 < -1 Then
		Result := 24
	Else
		Result := 24*(ArCcos(cosH0) / Pi);
End;

Function LowTempFunction(MinTemp,MaxTemp,MinTToday: Double):Double;
var
  MyValue: Double;
begin
  MyValue := (MinTToday - MinTemp)/(MaxTemp - MinTemp);
  Result := power(1 - Max(0,Min(1,MyValue)),2);
end;

Function GetNightHours(InputDate:TDate; InputLat:real):Real;
var
	DayNumber : Integer;
	RelativeDayLength : Double;

Begin

  DayNumber := 1;

	if InputDate <> strtodate('') then
		DayNumber := GetDayOfYear(InputDate);

	RelativeDayLength := GetDayLength(InputLat,DayNumber);

  Result := ((1 - RelativeDayLength)*24);

end;

Function expF(x : Double;
  g0 : Double;
  gx : Double;
  tg : Double;
  ng : Double): Double;
begin
  If tg <> 0 Then
    Result := gx + (g0 - gx) * Exp(-ln(2) * power((x / tg),ng))
  Else
    Result := gx;
End;

function TemperatureFunction(TMinD:Real;TMaxD:Real;TMin:Real;Topt:real;TMax:real):Real;
var
	TMeanD:real;
begin
	TMeanD := (TMinD + TMaxD)/2;

  if (TMeanD <= TMax) and (TMeanD >=TMin) then
	  Result := ((TMeanD - TMin)/(Topt - TMin)) * power(((TMax - TMeanD)/(TMax - TOpt)),((TMax - TOpt)/(TOpt - TMin)))
  else
    Result := 0;

  if (Result < 0) then
    Result := 0;
end;

Function ConvertSILODate(SILODateObject: String): TDate;
var
  MyYear,MyMonth,MyDay: word;
begin
  MyYear := strtoint(copy(SILODateObject,1,4));
  MyMonth := strtoint(copy(SILODateObject,5,2));
  MyDay := strtoint(Copy(SILODateObject,7,2));

  Result := EncodeDate(MyYear,MyMonth,MyDay);

end;

Function ReadDelimitedFile(FileName : String;
  Delimiter: char;
  StartLine : Integer): TStringListArray;
var
  slfile, slRow: TStringList;
  TempArray : TSTringListArray;
  line : Integer;
begin
  try
    slFile := TStringList.Create;

    try
      slFile.LoadFromFile(FileName);

      SetLength(TempArray,slFile.Count);

      for line := StartLine to length(TempArray)-1 do begin
        slRow := TStringList.Create;
        slRow.StrictDelimiter := false;
        slRow.Delimiter := Delimiter;

        slRow.DelimitedText := slFile[line];

        TempArray[line - StartLine] := slRow;
      end;
      Result := TempArray;
    except

    end;
  finally
    slFile.free;
  end;
end;

Procedure DecodeDelimitedString(InputStr : String;
  var myslrow: TStringList;
  Delimiter: char);

begin
  try
    myslRow.StrictDelimiter := false;
    myslRow.Delimiter := Delimiter;

    myslRow.DelimitedText := InputStr;

  finally

  end;
end;

Procedure BuildStringList(CommaDelimitedString: String;
  var InputSL : TStringList);
begin
  InputSL.Delimiter := ',';
  InputSL.DelimitedText := CommaDelimitedString;
end;

Procedure InsertRecord(ADOCommand: TADOCommand;
  TableName: String;
  FieldNamesList: String;
  ValuesList: String);
var
  SQLString : String;

begin

  SQLString := 'Insert into ' +
    TableName + ' (' +
    FieldNamesList + ') ' +
    'SELECT ' +
    ValuesList + ';';

  with ADOCommand do begin

    CommandText := SQLString;

    try
      Execute;
      //Messagedlg('The new record was created successfully.',mtConfirmation,[mbOK],0);
    except
      //on E: Exception do
        //Messagedlg('There was a problem creating the new record: ' + E.message,mtWarning,[mbOK],0);
    end;
  end;
end;

Procedure UpdateRecord(ADOCommand: TAdoCommand;
  TableName : String;
  UpdateFieldNamesList : TStringList;
  UpdateFieldValuesList : TStringList;
  Criteria : String);
var
  SQLString: String;
  i : Integer;
  SetStr : String;
begin
  SetStr := '';

  for i := 0 to UpdateFieldNamesList.Count-1 do begin
    SetStr := SetStr + ',' + UpdateFieldNamesList.Strings[i] + '="' +
      UpdateFieldValuesList.Strings[i] + '"';
  end;

  SetStr := copy(setstr,2,length(setstr));

  SQLString := 'UPDATE [' +
    TableName + '] SET ' +
    SetStr +
    ' WHERE ' +
    Criteria + ';';


  with ADOCommand do begin

    CommandText := SQLString;

    try
      Execute;
      //Messagedlg('The record was updated successfully.',mtConfirmation,[mbOK],0);

    except
      //on E: Exception do
        //Messagedlg('There was a problem updating the record: '+ E.message,mtWarning,[mbOK],0);

    end;
  end;

end;



procedure ClearTheGrid(GridColumns:Integer;CurrentGrid:TStringGrid);
var
  nCol:integer;
begin
  for nCol := 0 to GridColumns - 1 do
    CurrentGrid.Cols[nCol].Clear;

  CurrentGrid.RowCount := 2;
  CurrentGrid.ColCount := 1;
end;

Function CombineObjectLists(InputList1: TObjectList;
  InputList2: TObjectList): TObjectList;Overload;
var
  i : integer;
  OverallOL : TObjectList;
begin
  OverallOL := TObjectList.create;

  for i := 0 to InputList1.Count-1 do
    OverallOL.Add(InputList1[i]);

  for i := 0 to InputList2.Count-1 do
    OverallOL.Add(InputList2[i]);

  Result := OverallOL;

end;

procedure ClearChart(InputGraph: TChart);
var
  i : integer;
begin
  for i := 0 to InputGraph.SeriesCount-1 do
    InputGraph.Series[i].Clear;

end;

Function CombineObjectLists(InputList1: TObjectList;
  InputList2: TObjectList; InputList3 :TobjectList): TObjectList;Overload;
var
  i : integer;
  OverallOL : TObjectList;
begin
  OverallOL := TObjectList.create;

  for i := 0 to InputList1.Count-1 do
    OverallOL.Add(InputList1[i]);

  for i := 0 to InputList2.Count-1 do
    OverallOL.Add(InputList2[i]);

  for i := 0 to InputList3.Count-1 do
    OverallOL.Add(InputList3[i]);

  Result := OverallOL;
    //OverallOL.destroy;
end;

Function CombineObjectLists(InputList1: TObjectList;
  InputList2: TObjectList; InputList3 :TobjectList;
  InputList4: TObjectList): TObjectList;Overload;
var
  i : integer;
  OverallOL : TObjectList;
begin
  OverallOL := TObjectList.create;

  for i := 0 to InputList1.Count-1 do
    OverallOL.Add(InputList1[i]);

  for i := 0 to InputList2.Count-1 do
    OverallOL.Add(InputList2[i]);

  for i := 0 to InputList3.Count-1 do
    OverallOL.Add(InputList3[i]);

  for i := 0 to InputList4.Count-1 do
    OverallOL.Add(InputList4[i]);

  Result := OverallOL;
    //OverallOL.destroy;
end;



Function TableExists(TableName : String; DataConnection : TADOConnection):Boolean;
var
  MyTableList : TStringList;
  i : integer;

begin
  Result := false;
  MyTableList := TStringList.Create;
  DataConnection.GetTableNames(MyTableList);
  for i := 0 to MyTableList.Count - 1 do begin
    if MyTableList.Strings[i] = TableName then
      Result := true

  end;
end;

Procedure ClearFilteredRecords(TableName: String;
  FilterField: String;
  FilterCriterion : String;
  ADOCommand : TAdoCommand);
var
  SQLString : String;
begin
  SQLString := 'DELETE * FROM ' +
    TableName + ' WHERE ' +
    FilterField + '="' +
    FilterCriterion + '";';

  ADOCommand.CommandText := SQLString;
  ADOCommand.Execute;
end;

Procedure AddColumnNumbers(ColumnCount: Integer; sg: TStringGrid);
Var
  I : Integer;

begin
  sg.ColCount := ColumnCount;
  for i := 0 to columncount do
    sg.Cells[i,0] := inttostr(i);
end;

procedure AddDataToSGrid(CurrentStringList:TStringList; CurrentGrid :TStringGrid; SpecialCaseIndicator : Integer);
//Generic procedure to add csv data to a string grid
var
  oRowStrings:TStringList;
  i:integer;
  TestSL : TStringList;
  Shifter : Integer;
begin
  //CurrentGrid.ColCount := 1;

  if CurrentStringList.Count > 0 then begin

    oRowStrings := TStringList.Create;
    Shifter := 0;

    try
      CurrentGrid.RowCount := CurrentStringList.Count+Shifter+1;

        if SpecialCaseIndicator = IMPORTGRID then begin
          TestSL := TStringList.Create;
          TestSL.Delimiter := ',';
          TestSL.strictdelimiter := true;
          TestSL.DelimitedText := CurrentStringList[0];
          AddColumnNumbers(TestSL.Count,CurrentGrid);
          Shifter := 1;
          CurrentGrid.FixedRows := 1;
        end;

        for i := 0 to CurrentStringList.Count-1 do
        begin
          oRowStrings.Clear;
          oRowStrings.Delimiter := ',';
          oRowStrings.strictdelimiter := true;
          oRowStrings.DelimitedText := CurrentStringList[i];
          //oRowStrings.CommaText := CurrentStringList[i];
          oRowStrings.Insert(0,IntToStr(i));
          if oRowStrings.Count > CurrentGrid.ColCount then
            CurrentGrid.ColCount := oRowStrings.Count;
          CurrentGrid.Rows[i+shifter].Assign(oRowStrings);
        end;
        CurrentGrid.Cells[0,0] := 'Row number';
        GridColAutoSize(CurrentGrid );
    finally
      CurrentStringList.Free;
      oRowStrings.Free;
    end;
  end;
end;

procedure GridColAutoSize(Grid:TSTringGrid);overload;
var
  nCol, nRow, nWidth, nMaxWidth: integer;
begin
  with Grid as TStringGrid do
  begin
    for nCol := 0 to colcount - 1 do
    begin
      nMaxWidth := 0;
      for nRow := 0 to rowcount - 1 do
      begin
        nWidth := Canvas.TextWidth( Cells[nCol,nRow] );
        if nWidth > nMaxWidth then nMaxWidth := nWidth;
      end; {for nRow}
      ColWidths[nCol] := nMaxWidth + 7;
    end; {for nCol}
  end; {with Grid}
end;

procedure GridColAutoSize(Grid: Tdbgrid);overload;
const
  DEFBORDER = 10;
var
  temp, n: Integer;
  lmax: array [0..30] of Integer;
begin
  with Grid do
  begin
    Canvas.Font := Font;
    for n := 0 to Columns.Count - 1 do
      lmax[n] := Canvas.TextWidth(Fields[n].FieldName) + DEFBORDER;
    grid.DataSource.DataSet.First;
    while not grid.DataSource.DataSet.EOF do
    begin
      for n := 0 to Columns.Count - 1 do
      begin
        temp := Canvas.TextWidth(trim(Columns[n].Field.DisplayText)) + DEFBORDER;
        if temp > lmax[n] then lmax[n] := temp;
      end; {for}
      grid.DataSource.DataSet.Next;
    end;
    grid.DataSource.DataSet.First;
    for n := 0 to Columns.Count - 1 do
      if lmax[n] > 0 then
        Columns[n].Width := lmax[n];
  end;
end; {SetGridColumnWidths  }

function FirstDelimiter(const Delimiters, S: string): Integer;

var
  P, Q: PChar;
  Len : Integer;

begin

  Result := 0;
  P := Pointer(Delimiters) ;
  Q := Pointer(s) ;
  Len := StrLen(Q) ;
  while Result < Len do
    if (Q[Result] <> #0) and (StrScan(P, Q[Result]) <> nil) then
      Exit
    else
      Inc(Result) ;
end;

Procedure UpdateStatusBar(CurrentCaption: TCaption; CurrentMessage: string);
begin
  CurrentCaption := CurrentMessage;
end;

Procedure GetDistinctValuesinField(CurrentADOQuery: TADOQuery;
  TableName : string;
  FieldName : string;
  OutputStrings : TStrings);

var
  SQLString : string;


begin
    OutputStrings.Clear;

    CurrentADOQuery.SQL.Clear;

    SQLString := '';
    SQLString := 'SELECT DISTINCT [' +
    FieldName +
    '] FROM ' + TableName + ' ORDER BY ' +
    FieldName;
    CurrentADOQuery.SQL.Add(SQLString);
    CurrentADOQuery.Active := true;
    CurrentADOQuery.First;

    while not CurrentADOQuery.Eof do begin
      OutputStrings.Add(CurrentADOQuery.FieldByName(FieldName).AsString);
      CurrentADOQuery.Next;
    end;
end;

Procedure GetMinMaxDatesFromTable(CurrentADOQuery: TADOQuery;
  TableName : string;
  DateFieldName : String;
  FilterFieldName : string;
  FilterCriterion : String;
  Var MinDate : TDate;
  Var MaxDate : TDate);
var
  SQLString : string;

begin

    CurrentADOQuery.SQL.Clear;

    SQLString := '';
    SQLString := 'SELECT MIN(' +
    DateFieldName +
    ') as MyDate FROM ' + TableName + ' WHERE ' + FilterFieldName + '="' + FilterCriterion + '"' +
    ' GROUP BY ' + FilterFieldName;

    CurrentADOQuery.SQL.Add(SQLString);
    CurrentADOQuery.Active := true;
    CurrentADOQuery.First;
    MinDate := strtodate(CurrentADOQuery.FieldByName('MyDate').Asstring);

    CurrentADOQuery.SQL.Clear;

    SQLString := '';
    SQLString := 'SELECT MAX(' +
    DateFieldName +
    ') as MyDate FROM ' + TableName + ' WHERE ' + FilterFieldName + '="' + FilterCriterion + '"' +
    ' GROUP BY ' + FilterFieldName;

    CurrentADOQuery.SQL.Add(SQLString);
    CurrentADOQuery.Active := true;
    CurrentADOQuery.First;
    MaxDate := strtodate(CurrentADOQuery.FieldByName('MyDate').Asstring);

end;

Procedure GetFilteredValuesinField(CurrentADOQuery: TADOQuery;
  TableName : string;
  TargetFieldName : String;
  FilterFieldName : string;
  Criterion : String;
  OutputStrings : TStrings);

var
  SQLString : string;

begin
    OutputStrings.Clear;

    CurrentADOQuery.SQL.Clear;

    SQLString := '';
    SQLString := 'SELECT [' +
    TargetFieldName +
    '] FROM ' + TableName + ' WHERE ' + FilterFieldName + '="' + Criterion + '"';
    CurrentADOQuery.SQL.Add(SQLString);
    CurrentADOQuery.Active := true;
    CurrentADOQuery.First;

    while not CurrentADOQuery.Eof do begin
      OutputStrings.Add(CurrentADOQuery.FieldByName(TargetFieldName).AsString);
      CurrentADOQuery.Next;
    end;
end;


Function IsNewValueUnique(CurrentADOQuery:TADOQuery;
  ProposedValue : string;
  IntendedTable:string;
  IntendedField:string):Boolean;
var
  ExistingNames : TStringList;
  i : integer;
begin
  Result := True;

  ExistingNames := TStringList.Create;

  General.GetDistinctValuesinField(CurrentADOQuery,
    IntendedTable,IntendedField,ExistingNames);

  for i := 0 to ExistingNames.Count- 1 do begin
    if ProposedValue = ExistingNames.strings[i] then
      Result := false;
  end;

  ExistingNames.free;
end;

function GetMax(AnArray: array of Double): Double;Overload;
var
I: Integer;
begin
Result := AnArray[Low(AnArray)];
for I := Low(AnArray) + 1 to High(AnArray) do
if AnArray[I] > Result then Result := AnArray[I];
end;

function GetMin(AnArray: array of Double): Double;Overload;
var
I: Integer;
begin
Result := AnArray[High(AnArray)];
for I := 0 to length(AnArray)-1 do begin
  if AnArray[I] < Result then
    Result := AnArray[I];
end;
end;

function GetMax(AnArray: TDoubleArray): Double;Overload;
var
I: Integer;
begin
Result := AnArray[Low(AnArray)];
for I := Low(AnArray) + 1 to High(AnArray) do
if AnArray[I] > Result then Result := AnArray[I];
end;

function GetMin(AnArray: TDoubleArray): Double;Overload;
var
I: Integer;
begin
Result := AnArray[High(AnArray)];
for I := Low(AnArray) + 1 to High(AnArray) do
if AnArray[I] < Result then Result := AnArray[I];
end;





 //randomize position of list elements
procedure Shuffle(list : TObjectList) ;
 var
   randomIndex: integer;
   cnt: integer;
 begin
   Randomize;
   for cnt := 0 to -1 + list.Count do
   begin
     randomIndex := Random(-cnt + list.Count) ;
     list.Exchange(cnt, cnt + randomIndex) ;
   end;
end;

function CompareByRadPosition(Item1 : Pointer; Item2 : Pointer) : Integer;
var
  customer1, customer2 : TCell;
begin
  // We start by viewing the object pointers as TCustomer objects
  customer1 := TCell(Item1);
  customer2 := TCell(Item2);

  // Now compare by string
  if customer1.RadPosition_um > customer2.radposition_um
  then Result := 1
  else if customer1.RadPosition_um = customer2.RadPosition_um
  then Result := 0
  else Result := -1;
end;

function CompareByCarbConc(Item1 : Pointer; Item2 : Pointer) : Integer;
var
  customer1, customer2 : TCell;
begin
  // We start by viewing the object pointers as TCustomer objects
  customer1 := TCell(Item1);
  customer2 := TCell(Item2);
  // Now compare by string
  if customer1.CumulCarb_ug/customer1.lumenVolume_um3 > customer2.CumulCarb_ug/customer2.lumenVolume_um3
  then Result := 1
  else if customer1.RadPosition_um = customer2.RadPosition_um
  then Result := 0
  else Result := -1;
end;

function CompareByOP(Item1 : Pointer; Item2 : Pointer) : Integer;
var
  customer1, customer2 : TCell;
begin
  // We start by viewing the object pointers as TCustomer objects
  customer1 := TCell(Item1);
  customer2 := TCell(Item2);
  // Now compare by string
  if customer1.OsmoticPotential > customer2.OsmoticPotential
  then Result := 1
  else if customer1.OsmoticPotential = customer2.OsmoticPotential
  then Result := 0
  else Result := -1;
end;

//******************************************************************************
//Volumes and surface areas for various shapes
function CylinderVolumeFromDiam (RD:Real; TD:Real; Length:Real): Real;Overload;

begin
	Result := pi * power((RD + TD)/4,2) * Length;
end;

function CylinderVolumeFromArea (CSArea:Real; Length:Real): Real;Overload;

begin
	Result := CSArea * Length;
end;

function CylinderCSArea (Volume:Real; Length:Real): Real;

begin
	Result := Volume/Length;
end;

function CylinderArea (RD:Real; TD:Real; Length:Real): Real;
begin
	Result := (2 * pi * (RD + TD)/4 * Length) +
		(2 * pi * power((RD + TD)/4,2));
end;

function ConeVolume (RD:Real; TD:Real; Length:Real): Real; Overload;
begin
	Result := 1/3 * (pi * power((RD + TD)/4,2) * Length);
end;

function ConeVolume (CSArea:Real; Length:Real): Real; Overload;
begin
	Result := 1/3 * (CSArea * Length);
end;

Function ConeCSArea (Volume:Real; Length:Real): Real;

begin
	Result := 3 * (Volume/Length);
end;

function ConeLateralSurfaceArea (D:Real; Height:Real):Real;
var
  l : double;
begin
  l := sqrt(power(D/2,2) + power(Height,2));
	//Result := pi * (power(D/2,2)) * l;
  Result := pi * (D/2) * l;

end;

Function ParaboloidSurfaceArea(Height: Real; DatHeight: Real): Real;
var
  Rad : Real;
begin
  Rad := DatHeight/2;
  Result := ((pi*Rad)/(6*power(Height,2))) *
    (power(power(rad,2) + 4*power(Height,2),3/2)-power(Rad,3));
end;

function RectangularPrismVolumeFromDiam (RD:Real; TD: Real; L:real):Real;

begin
	Result := TD * RD * L;
end;

function RectangularPrismVolumeFromArea (CSArea: Real; L:real):Real;

begin
	Result := CSArea * L;
end;


function RectangularPrismCSArea (RD:Real; TD:Real):Real;
begin
	Result := RD * TD;
end;

function RectangularPrismCSAreaFromVol (Vol:Real; Ht:Real):Real;
begin
	Result := Vol/Ht;
end;

function RectangularPrismArea (RD:Real; TD:Real):Real;
begin
	Result := 2 * (RD*TD + RD*RD + RD*TD);
end;

function PyramidVolume (RD:Real;TD:Real;H:Real):Real;
begin
  //Result := 1;
  {$J-}
  {$Q-}
  Result := (RD*TD*H)/3;
end;

Function ParaboloidVolume(RD: Real; TD: Real; H: Real): Real;
var
  Area : Real;
begin
  Area := pi*power((RD/2 + TD/2)/2,2);
  Result := 0.33 * area * H;
end;





end.
