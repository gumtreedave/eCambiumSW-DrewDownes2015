unit BoardProperties;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls,ADODB,DataModule,DataObjects,ReadData,ProjectManager,
  General,Math,contnrs,Grids,BoardGrades,ColorGrd,TeEngine,GraphUtil,ProjectWarnings;

type

  TDiskDataArray = Array of array of Double;


  TBoard = class
    BType : string;
    X0,Y0,X1,Y1: Integer;
    Length : Double;
    Width : Double;
    Thickness : Double;
    MeanMOE : Double;
    MeanWoodDensity : Double;
    MeanMFA : Double;
    MGPClass : String;
  end;

  TBoardClassRecord = record
    BoardClassName : String;
    BoardCount : Integer;
  end;

  TBoardClassRecordArray = array of TBoardClassRecord;

  Procedure BoardsMainRoutine(CurrentSegmentsData : TCAMBIUMSegmentDataArray;
    CantWidth : Integer; CantBoardThick : Integer;
    WingBoardWidth : Integer; WingBoardThick : INteger;
    TheBoardsList: TObjectList);

  Procedure GetCantBoards(BoardsList: TObjectList;
    WDArray : TDiskDataArray;
    MFAArray : TDiskDataArray;
    MOEArray : TDiskDataArray;
    StemRadius_mm : Double;
    CantWidth : Integer;
    BoardWidth : Integer;
    BandWidths_mm : double);

  Procedure GetWingBoards(BoardsList: TObjectList;
    WDArray : TDiskDataArray;
    MFAArray : TDiskDataArray;
    MOEArray : TDiskDataArray;
    StemRadius_mm : Double;
    CantWidth : Integer;
    BoardWidth : Integer;
    BoardHeight : Integer;
    BandWidths_mm : double;
    CutDirection : String);

  Function GetBoardDistribution(BoardList: TObjectList;
    MGPClassSG: TStringGrid):TBoardClassRecordArray;


implementation

uses CAMBIUMManager,SummaryGraphs;

Function ExtrapolatetoDisk(RadialData_DescendingPos: Array of double):TDiskDataArray;
var
  myangle,pos: integer;
  temparray : TDiskDataArray;
  RadialData_Asc : array of double;
  CurrentX,CurrentY : integer;
  i,j : integer;
  functionalradius : integer;

begin
  FunctionalRadius := length(RadialData_DescendingPos);

  SetLength(temparray,floor(FunctionalRadius*2),floor(FunctionalRadius*2));
  SetLength(RadialData_Asc,Length(RadialData_DescendingPos));
  j := 0;


  for i := Length(RadialData_DescendingPos)-1 downto 0 do begin
    RadialData_Asc[j] := RadialData_DescendingPos[i];
    j := j + 1;
  end;

  for myangle := 0 to 35900 do begin
    for pos := 0 to FunctionalRadius-1 do begin
      CurrentX := floor(FunctionalRadius + pos*cos((degtorad(myangle/100))));
      CurrentY := floor(FunctionalRadius + pos*sin((degtorad(myangle/100))));

      temparray[CurrentX-1,CurrentY-1] := RadialData_DescendingPos[pos];

    end;
  end;
  Result := TempArray;
end;



Function CalculateMGPClass(MeanMOE : Double;
  SpecifiedBoardThresholds : TStringGrid) : String;
var
  i : integer;
  LT,UT : Double;
begin
  LT := 0;
  UT := 0;

  for i := 1 to SpecifiedBoardThresholds.RowCount-1 do begin

    if i = 1 then begin
      LT := 0;
      UT := strtofloat(SpecifiedBoardThresholds.Cols[1].strings[i]);
    end else if (i > 1) then begin
      LT := strtofloat(SpecifiedBoardThresholds.Cols[1].strings[i-1]);
      UT := strtofloat(SpecifiedBoardThresholds.Cols[1].strings[i]);
    end;

    if (MeanMOE >= LT) and
      (MeanMOE < UT) then
       result := SpecifiedBoardThresholds.Cols[0].strings[i];
  end;
end;

Procedure BoardsMainRoutine(CurrentSegmentsData : TCAMBIUMSegmentDataArray;
  CantWidth : Integer; CantBoardThick : Integer;
  WingBoardWidth : Integer; WingBoardThick : INteger;
  TheBoardsList: TObjectList);
var
  PositionsArray,WoodDensityArray,MOEArray,MFAArray : array of double;
  i : integer;
  SegmentsCount : Integer;
  DiskDataArrayWD,DiskDataArrayMFA,DiskDataArrayMOE : TDiskDataArray;
  SegmentWidth_mm : Double;


begin
  formBoardGrades.UpdateBoardGradesSG;
  TheBoardsList.Clear;

  //SegmentWidth_mm := CurrentSegmentsData[0].SegmentWidth/1000;
  SegmentWidth_mm := 1;

  SetLength(PositionsArray,Length(CurrentSegmentsData));
  SetLength(WoodDensityArray,Length(CurrentSegmentsData));
  SetLength(MOEArray,Length(CurrentSegmentsData));
  SetLength(MFAArray,Length(CurrentSegmentsData));

  for I := 0 to length(CurrentSegmentsData)-1 do begin
    PositionsArray[i] := CurrentSegmentsData[i].SegmentPosition;
    WoodDensityArray[i] := CurrentSegmentsData[i].WoodDensity;
    MOEArray[i] := CurrentSegmentsData[i].MOE;
    MFAArray[i] := CurrentSegmentsData[i].MFA;
  end;

  SegmentsCount := Length(PositionsArray);

  DiskDataArrayWD := ExtrapolatetoDisk(WoodDensityArray);
  DiskDataArrayMFA := ExtrapolatetoDisk(MFAArray);
  DiskDataArrayMOE := ExtrapolatetoDisk(MOEArray);

  if SegmentsCount*SegmentWidth_mm > CantWidth/2 then begin

    GetCantBoards(TheBoardsList,DiskDataArrayWD,DiskDataArrayMFA,DiskDataArrayMOE,
      SegmentsCount*SegmentWidth_mm,CantWidth,CantBoardthick,SegmentWidth_mm);
    GetWingBoards(TheBoardsList,DiskDataArrayWD,DiskDataArrayMFA,DiskDataArrayMOE,
      SegmentsCount*SegmentWidth_mm,CantWidth,WingBoardThick,WingBoardWidth,SegmentWidth_mm,'Right');
    GetWingBoards(TheBoardsList,DiskDataArrayWD,DiskDataArrayMFA,DiskDataArrayMOE,
      SegmentsCount*SegmentWidth_mm,CantWidth,WingBoardThick,WingBoardWidth,SegmentWidth_mm,'Left');

  end else
    messagedlg('The tree is too small to saw the specified boards',mtWarning,[mbOK],0);

end;

Function GetBoardProperties(X0,Y0,X1,Y1: Integer;
  WDArray,MFAArray,MOEArray: TDiskDataArray;
  BoardType: string; BoardThick: Double;
  BoardWidth : DOuble): TBoard;
var
  Ypos,Xpos : Integer;
  WDSum,MOESum,MFASum : Double;
  COunter : integer;
  MyBoard : TBoard;
begin
  WDSum := 0;
  MOESum := 0;
  MFASum := 0;

  Counter := 0;

  for YPos := Y0 to Y1 do begin
    for Xpos := X0 to X1 do begin

      WDSum := WDSum + WDArray[Xpos,Ypos];
      MOESum := MOESum + MOEArray[Xpos,Ypos];
      MFASum := MFASum + MFAArray[Xpos,Ypos];

      Counter := Counter + 1;
    end;
  end;

  MyBoard := TBoard.Create;

  MyBoard.X0 := X0;
  MyBoard.X1 := X1;
  MyBoard.Y0 := Y0;
  MyBoard.Y1 := Y1;

  MyBoard.Width := BoardWidth;
  MyBoard.Thickness := BoardThick;

  MyBoard.BType := BoardType;
  MyBoard.MeanMOE := MOESum/Counter;
  MyBoard.MeanWoodDensity := WDSum/Counter;
  MyBoard.MeanMFA := MFASum/Counter;

  myBoard.MGPClass := CalculateMGPClass(MyBoard.MeanMOE,
    formBoardGrades.sgBoardGrades);

  Result := MyBoard;


end;

Procedure GetCantBoards(BoardsList: TObjectList;
  WDArray : TDiskDataArray;
  MFAArray : TDiskDataArray;
  MOEArray : TDiskDataArray;
  StemRadius_mm : Double;
  CantWidth : Integer;
  BoardWidth : Integer;
  BandWidths_mm : double);
var
  OffSet : integer;
  slen : integer;
  BoardCount: integer;
  gap: integer;
  StartPosY,StartPosX : Integer;
  BNum : integer;
  CurrentBoard : TBoard;

begin

  try
  slen := floor(sqrt(power(StemRadius_mm,2) - power((CantWidth/2),2)));
  OffSet := floor(StemRadius_mm - slen);
  BoardCount := floor(slen*2/BoardWidth);
  //gap := ((slen*2) - (BoardCount*BoardWidth));
  gap := 0;

  //StartPosY := floor(StemRadius_mm-offset);
  StartPosY := OffSet;
  StartPosX := floor(StemRadius_mm/BandWidths_mm - CantWidth/2);

  for BNum := 0 to BoardCount-1 do begin

    CurrentBoard := TBoard.Create;

    CurrentBoard := GetBoardProperties(StartPosX,StartPosY,
      StartPosX + CantWidth,
      StartPosY + BoardWidth,
      WDArray,MFAArray,MOEArray,'Cant',BoardWidth,CantWidth);

    BoardsList.Add(CurrentBoard);

    StartPosY := StartPosY + BoardWidth;

    if BNum = floor((BoardCount-1)/2)  then
      StartPosY := startPosY + Gap;
  end;
  except
    on E: Exception do begin
      formWarnings.memoWarnings.Lines.Add('There was a problem calculating cant board properties: ' +
        e.Message);
    end;
  end;
end;

Procedure GetWingBoards(BoardsList: TObjectList;
  WDArray : TDiskDataArray;
  MFAArray : TDiskDataArray;
  MOEArray : TDiskDataArray;
  StemRadius_mm : Double;
  CantWidth : Integer;
  BoardWidth : Integer;
  BoardHeight : Integer;
  BandWidths_mm : double;
  CutDirection : string);
var
  OffSet : integer;
  slen,slen_full : integer;
  BoardCount: integer;
  gap: integer;
  StartPosY,StartPosX : Integer;
  BNum : integer;
  CurrentBoard : TBoard;
  npass,ReSawPasses,SawCuts: Integer;

begin
  try
    npass := floor((StemRadius_mm - CantWidth/2)/(BoardWidth));
    slen_full := floor(sqrt(power(StemRadius_mm,2) - power((CantWidth/2+(npass*BoardWidth)),2)));

    if slen_full >= CantWidth/2 + npass*BoardWidth then
      ReSawPasses := npass
    else
      ReSawPasses := npass-1;

    for sawcuts := 0 to ResawPasses do begin
      slen := floor(sqrt(power(StemRadius_mm,2) - power((CantWidth/2 + BoardWidth*(SawCuts+1)),2)));
      OffSet := floor(StemRadius_mm - slen);

      BoardCount := floor(slen*2/BoardHeight);
      gap := 0;
      StartPosY := OffSet;

      if CutDirection = 'Right' then
        StartPosX := floor(StemRadius_mm/BandWidths_mm + CantWidth/2 + BoardWidth*SawCuts)
      else if CutDirection = 'Left' then
        StartPosX := floor(StemRadius_mm/BandWidths_mm - CantWidth/2 - BoardWidth*(SawCuts+1));

      for BNum := 0 to BoardCount-1 do begin

        CurrentBoard := TBoard.Create;

        CurrentBoard := GetBoardProperties(StartPosX,StartPosY,
          StartPosX + BoardWidth,
          StartPosY + BoardHeight,
          WDArray,MFAArray,MOEArray,'Wing',BoardWidth,BoardHeight);

        BoardsList.Add(CurrentBoard);

        StartPosY := StartPosY + BoardHeight;

        if BNum = floor((BoardCount-1)/2)  then
          StartPosY := startPosY + Gap;
      end;
    end;
  except
    on E: Exception do begin
      formWarnings.memoWarnings.Lines.Add('There was a problem calculating wing board properties: ' +
        e.Message);
    end;
  end;
end;

Function GetBoardDistribution(BoardList: TObjectList;
  MGPClassSG: TStringGrid):TBoardClassRecordArray;
var
  i,j : Integer;
begin
  SetLength(result,0);

  SetLength(Result,MGPClassSG.RowCount);

  for i := 0 to BoardList.Count-1 do begin
    for j := 1 to MGPClassSG.RowCount-1 do begin

      Result[j].BoardClassName := MGPClassSG.Cols[0].Strings[j];

      if TBoard(BoardList[i]).MGPClass = MGPClassSG.Cols[0].Strings[j] then
        Result[j].BoardCount := Result[j].BoardCount + 1;

    end;
  end;
end;





{Procedure GetBoards(WDArray : TDiskDataArray;
  MFAArray : TDiskDataArray;
  MOEArray : TDiskDataArray;
  StemRadius_mm : Double;
  CantWidth : Integer;
  BoardWidth : Integer;
  BoardHeight : Integer;
  BandWidths_mm : double);
var
  OffSet : integer;
  slen : integer;
  BoardCount: integer;
  gap : integer;
  StartPosY,StartPosX : Integer;

  BoardsList : TObjectList;
  MyBoard : TBoard;


  sawcuts,i,j,k : integer;

  OpWidthX,OpWidthY : Integer;

  npass,ReSawPasses : integer;

  CurrentBoardPos : string;

begin

  try
    npass := floor((StemRadius_mm - CantWidth/2)/(BoardWidth));
    slen := floor(sqrt(power(StemRadius_mm,2) - power((CantWidth/2+(npass*BoardWidth)),2)));

    if slen <= CantWidth/2 + npass*BoardWidth then
      ReSawPasses := npass
    else
      ReSawPasses := npass - 1;

    //SetLength(BoardsArray,0);

    BoardsList := TObjectList.Create;

    for sawcuts := 0 to ResawPasses do begin

      case sawcuts of
        0: begin
          OpWidthX := floor(CantWidth/2);
          OpWidthY := BoardWidth;
          StartPosX := floor(StemRadius_mm/BandWidths_mm);
          CurrentBoardPos:= 'Cant'
        end;
        1..99: begin
          OpWidthX := BoardWidth;
          opWidthY := BoardHeight;
          CurrentBoardPos := 'Wing' + inttostr(sawcuts);
          StartPosX := StartPosX + OpWidthX;
        end;
      end;

      slen := floor(sqrt(power(StemRadius_mm,2) - power((OpWidthX/2),2)));
      OffSet := floor(StemRadius_mm - slen);
      BoardCount := floor(slen*2/OpWidthY);

      //SetLength(BoardsArray,Length(BoardsArray) + BoardCount);

      //gap to add in mid cant to get the last board in the hisgest MOE wood
      gap := ((slen*2) - (BoardCount*BoardWidth))-1;

      StartPosY := floor(StemRadius_mm-offset);



      for i := 0 to BoardCount-1 do begin

        SummaryGraphs.DrawBoards(formSummaryGraphs.image2,
          MyBoard.X0,MyBoard.Y0,MyBoard.X1,MyBoard.Y1,0,floor((StemRadius_mm/BandWidths_mm)*2),
          formSummaryGraphs.PanelCentre.Left,formSummaryGraphs.PanelCentre.Top,
          clgreen);

        BoardsList.Add(MyBoard);



        StartPosY := StartPosY + BoardWidth;

      end;
    end;
  finally
    BoardsList.Free;

  end;
end;      }

end.
