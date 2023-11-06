unit SummaryGraphs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls,ADODB,DataModule,DataObjects,ReadData,ProjectManager,
  CAMBIUMManager,contnrs,math, StdCtrls,GraphUtil,General, ComCtrls, TeEngine,
  Series, TeeProcs, Chart,BoardDimensions, ColorGrd,Grids,BoardGrades,Boardproperties,
  ToolWin, pngimage;

type
  TEllipseDimensions = array[0..3] of integer;

  TformSummaryGraphsDist = class(TForm)
    pcSummaryGraphs: TPageControl;
    tsMOESummary: TTabSheet;
    tsOtherProps: TTabSheet;
    PanelTop: TPanel;
    PanelLeft: TPanel;
    Image1: TImage;
    PanelCentre: TPanel;
    Image2: TImage;
    PanelRight: TPanel;
    ChartMOEDist: TChart;
    Series1: TLineSeries;
    ChartBD: TChart;
    Series10: TBarSeries;
    Series7: TBarSeries;
    TabSheet1: TTabSheet;
    Series16: TLineSeries;
    Panel3: TPanel;
    gbSSData: TGroupBox;
    lbSSDataSets: TListBox;
    tsWD_MFA_RingMeans: TTabSheet;
    ts_TRD_WT_RingMeans: TTabSheet;
    ChartWoodDensityRings: TChart;
    Series19: TLineSeries;
    Series17: TLineSeries;
    CHartTRDRings: TChart;
    CHartWTRings: TChart;
    Series21: TLineSeries;
    Series22: TLineSeries;
    Series23: TLineSeries;
    Series24: TLineSeries;
    ChartMFARings: TChart;
    Series18: TLineSeries;
    Series20: TLineSeries;
    ChartMOERings: TChart;
    Series25: TLineSeries;
    gbSSDataRingMeans: TGroupBox;
    lbRingMeanDataSets: TListBox;
    Series26: TLineSeries;
    Series27: TLineSeries;
    Series28: TLineSeries;
    Series29: TLineSeries;
    Series30: TLineSeries;
    Series31: TLineSeries;
    Series32: TLineSeries;
    Series33: TLineSeries;
    Series34: TLineSeries;
    Series35: TLineSeries;
    Series36: TLineSeries;
    Panel4: TPanel;
    Image3: TImage;
    ChartWoodDensityDist: TChart;
    Series9: TLineSeries;
    Series3: TLineSeries;
    Series6: TBarSeries;
    ChartMFADist: TChart;
    Series11: TLineSeries;
    Series8: TLineSeries;
    Series12: TBarSeries;
    ChartTRDDist: TChart;
    Series4: TLineSeries;
    Series5: TLineSeries;
    Series2: TBarSeries;
    ChartTWTDist: TChart;
    Series13: TLineSeries;
    Series14: TLineSeries;
    Series15: TBarSeries;
    PanelScale: TPanel;
    PanelColourScale: TPanel;
    ImageColourKey: TImage;
    PanelUpperScaleColour: TPanel;
    panelLowerScaleColour: TPanel;
    PanelSizeScale: TPanel;
    ImageScaleLineUpper: TImage;
    labelScale: TLabel;
    procedure FormResize(Sender: TObject);
    procedure ChartWoodDensityDistAfterDraw(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lbSSDataSetsClick(Sender: TObject);
    procedure lbRingMeanDataSetsClick(Sender: TObject);
    procedure lbSSDataSetsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbRingMeanDataSetsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);


  private

    Procedure ScaleFormObjects;
    Procedure InitialiseGraphs;
    Procedure DrawBoardDistGraph(BoardDistArray : TBoardClassRecordArray;
      MGPClassSG: TStringGrid);

    { Private declarations }
  public

    { Public declarations }
      Procedure DrawRings(Position: Double;
    Value : Double;
    RingPresent : SmallInt;
    Chart : TChart);
  end;

  Procedure MainLoop(ScenarioName: String);

  Procedure DrawBand(CurrentImage : TImage;
    BandColour : TColor; RadPosMin : Integer; RadPosMax: Integer;
    CurrentRadPos: Integer; BandWidth : Integer;
    AnnualRing : SmallInt);

  procedure DrawEllipseFromCenter(Canvas: TCanvas;
    CenterOfEllipse: TPoint;
    RadiusOfCircle: Integer);

  Procedure DrawBoard(Image:TImage;
    X0,Y0,X1,Y1: Integer;
    RadPosMin,RadPosMax: Integer;
    BoardColour : Tcolor);

  Procedure DrawIndSampleSSDataGraphs(CurrentSSData : TSSDataArray);

  Procedure DrawRingMeansDataGraphs(CurrentSSRingMeansData:  TRingMeanDataArray);

  {Function GetSequenceColour(MyColourList: TColorArray;
    MinValue: Double;
    MaxValue: Double;
    CurrentValue: Double):TColor;}

  Function GetSequenceColour(MyColourArray: TColorArray;
    MinValue: Double;
    MaxValue: Double;
    CurrentValue: Double):TColor;

  Function GradVertical(Canvas:TCanvas;
    Rect:TRect;
    FromColor, ToColor:TColor):TColorArray ;

  Procedure DrawColourSequence(OutImage: Timage;
    ColorArray : Array of TColor);



var
  formSummaryGraphsDist: TformSummaryGraphsDist;



implementation

//uses BoardProperties;




{$R *.dfm}



Function GetBoardColour(MGPClassName : String;
  MGPClassSG : TStringGrid): TColor;
var
  i : integer;

begin

  for i := 1 to MGPClassSG.RowCount-1 do begin
    if MGPClassName = MGPClassSG.Cols[0].Strings[i] then
      Result := MyColours[i-1];
      //Result := WebColorNametoColor(WebNamedColors[i+100].Name);
  end;
end;

Function GetColourList(ColourCount : Integer;
  StartColour : Integer): TColorArray;

var
  i : integer;
  ColorList : GraphUtil.TColorArray;
  OutputArray : TColorArray;
begin
  //SortColorArray(WebNamedColors,0,WebNamedColorsCount-1,stHue,False);


  SetLength(ColorList,WebNamedColorsCount);
  //fill the list the colors in this case using webcolors
  for i := 0 to WebNamedColorsCount - 1 do
  begin
   ColorList[i].Value:=WebNamedColors[i].Value;
   ColorList[i].name := WebNamedColors[i].Name;

  end;
  //sort the colors by HUE
  //SortColorArray(ColorList,0,WebNamedColorsCount-1,stHue,false);

  SetLength(OutputArray,ColourCount);

  for i := StartColour to ColourCOunt + StartColour - 1 do begin
    OutputArray[i] := WebColorNameToColor(ColorList[i].Name);
  end;

  Result := OutputArray



end;

{Function GetSequenceColour(MyColourList: TColorArray;
  MinValue: Double;
  MaxValue: Double;
  CurrentValue: Double):TColor;
var
 RelValue : Double;
 ColourNumber : Integer;
begin

  RelValue := (CurrentValue - MinValue)/(MaxValue - MinValue);
  //ColourNumber := floor(RelValue * length(ColourList)-1);
  ColourNumber := floor(relValue * Length(MyColourList));

  Result :=  MyColourList[ColourNumber];
end;  }

Function GetSequenceColour(MyColourArray: TColorArray;
  MinValue: Double;
  MaxValue: Double;
  CurrentValue: Double):TColor;
var
 RelValue : Double;
 ArrayPos : Integer;
begin

  if MaxValue > MinValue then begin
    RelValue := (CurrentValue - MinValue)/(MaxValue - MinValue);
    //ColourNumber := floor(RelValue * length(ColourList)-1);
    ArrayPos := Round(Length(MyColourArray) * RelValue);

    Result := MyColourArray[ArrayPos];
  end else
   Result := MyColourArray[0];

end;

Procedure PaintColourScale(ColourScaleImage: TImage;
  ColourList: TColorArray;
  UpperLabelObject: TPanel; lowerLabelObject: TPanel;
  UpperLabel : String; LowerLabel: String);
var
  i : integer;
  RelValue : Double;
begin

  ColourScaleImage.Picture:= nil;

  with ColourScaleImage do begin
    for I := 0 to Length(ColourList)-1 do begin

      Canvas.Pen.Color := ColourList[i];
      Canvas.Pen.Width := 1;
      Canvas.Brush.Color := ColourList[i];
      //Canvas.Brush.Style := bsclear;

      RelValue := (i + 1)/Length(ColourList);

      Canvas.Rectangle(Left,round(RelValue * Height),
        Left + Width, Height);

      colourscaleimage.refresh;
    end;
  end;

  UpperLabelObject.Caption := inttostr(round(strtofloat(UpperLabel)));
  LowerLabelObject.Caption := inttostr(round(strtofloat(LowerLabel)));
end;

Function IsolateRequiredField(INputData: TCAMBIUMSegmentDataArray;
  DataType: integer): TDoubleArray;
var
  i : integer;
begin
  SetLength(Result,0);
  SetLength(Result,Length(INputData));
  for i := 0 to Length(InputData) - 1 do begin
    case DataType of
      0 : Result[i] := InputData[i].WoodDensity;
      1 : Result[i] := InputData[i].MOE;
      2 : Result[i] := InputData[i].MFA;
    end;
  end;
end;

procedure TformSummaryGraphsDist.ChartWoodDensityDistAfterDraw(Sender: TObject);
begin
  ChartWoodDensityDist.Canvas.Pen.Color := clred;
  ChartWoodDensityDist.Canvas.dovertline(20000,0,1000);
end;

Procedure TformSummaryGraphsDist.DrawBoardDistGraph(BoardDistArray : TBoardClassRecordArray;
  MGPClassSG: TStringGrid);
var
  i : integer;
  RelCount : Double;
  Sum : Integer;
begin
  Sum := 0;

  for i :=  1 to Length(BoardDistArray)-1 do
    Sum := Sum + BoardDistArray[i].BoardCount;

  if Sum > 0 then begin
    for i :=  1 to Length(BoardDistArray)-1 do begin

      RelCount := BoardDistArray[i].BoardCount/Sum;

      ChartBD.Series[0].AddY(RelCount,
        BoardDistArray[i].BoardClassName,
        GetBoardColour(BoardDistArray[i].BoardClassName,MGPClassSG));
    end;
  end;

end;


Procedure TformSummaryGraphsDist.InitialiseGraphs;
begin
  ClearChart(formSummaryGraphsDist.ChartMOEDist);
  ClearChart(formSummaryGraphsDist.ChartWoodDensityDist);
  ClearChart(formSummaryGraphsDist.ChartMFADist);
  ClearChart(formSummaryGraphsDist.ChartTRDDist);
  ClearChart(formSummaryGraphsDist.ChartTWTDist);
  ClearChart(formSummaryGraphsDist.ChartBD);
  ClearChart(formSummaryGraphsDist.ChartWoodDensityRings);
  ClearChart(formSummaryGraphsDist.ChartMFARings);
  ClearChart(formSummaryGraphsDist.ChartTRDRings);
  ClearChart(formSummaryGraphsDist.ChartWTRings);
  ClearChart(formSummaryGraphsDist.ChartMOERings);

  image1.Picture := nil;
  image2.picture := nil;
end;

procedure TformSummaryGraphsDist.lbRingMeanDataSetsClick(Sender: TObject);
var
  MySSRingMeansData : TRingMeanDataArray;
begin
  if lbRingMeanDataSets.ItemIndex > -1 then begin
      MySSRingMeansData := ReadRingMeansData(lbRingMeanDataSets.Items[lbRingMeanDataSets.itemindex],
        ProjectManager.MEANRINGPROPSTABLE,
        ProjectManager.RINGPROPSLABELFIELD,
        DataModule.DataModuleBoard.ADOQueryCAMBIUM);

      DrawRingMeansDataGraphs(MySSRingMeansData);

  end;
end;

procedure TformSummaryGraphsDist.lbRingMeanDataSetsKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if lbRingMeanDataSets.ItemIndex > -1 then begin
    if Key = VK_DELETE then begin
      if Messagedlg('Are you sure you want to delete this ring means wood property dataset?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin

        ClearFilteredRecords(MEANRINGPROPSTABLE,
          RINGPROPSLABELFIELD,
          lbRingMeanDataSets.Items[lbRingMeanDataSets.ItemIndex],
          DataModule.DataModuleBoard.ADOCommandCAMBIUM);

        General.GetDistinctValuesinField(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
          ProjectManager.MEANRINGPROPSTABLE,
          ProjectManager.RINGPROPSLABELFIELD,
          lbRingMeanDataSets.Items);
      end;
    end;
  end;
end;

procedure TformSummaryGraphsDist.lbSSDataSetsClick(Sender: TObject);
var
  MySSData : TSSDataArray;
  MySSRingMeansData : TRingMeanDataArray;

begin
  if lbSSDataSets.itemindex > -1 then begin

      MySSData := ReadSSData(lbSSDataSets.items[lbSSDataSets.ItemIndex],
        ProjectManager.REALSSDATATABLE,
        ProjectManager.SSDATASETNAMEFIELD,
        DataModule.DataModuleBoard.ADOQueryCAMBIUM);

      DrawIndSampleSSDataGraphs(MySSData);
  end;
end;


procedure TformSummaryGraphsDist.lbSSDataSetsKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if lbSSDataSets.ItemIndex > -1 then begin
    if Key = VK_DELETE then begin
      if Messagedlg('Are you sure you want to delete this pith-to-bark wood property dataset?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
        ClearFilteredRecords(REALSSDATATABLE,
          SSDATASETNAMEFIELD,
          lbSSDataSets.Items[lbSSDataSets.ItemIndex],
          DataModule.DataModuleBoard.ADOCommandCAMBIUM);

        General.GetDistinctValuesinField(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
          ProjectManager.REALSSDATATABLE,
          ProjectManager.SSDATASETNAMEFIELD,
          lbSSDataSets.Items);
      end;
    end;
  end;
end;

Procedure DrawIndSampleSSDataGraphs(CurrentSSData : TSSDataArray);
var
  i : integer;
begin
  formSummaryGraphsDist.ChartMOEDist.Series[0].Clear;
  formSummaryGraphsDist.ChartWoodDensityDist.Series[0].Clear;
  formSummaryGraphsDist.ChartMFADist.Series[0].Clear;
  formSummaryGraphsDist.ChartTRDDist.Series[0].Clear;
  formSummaryGraphsDist.ChartTWTDist.Series[0].Clear;

  for i := 0 to length(CurrentSSData)-1 do begin
    formSummaryGraphsDist.ChartMOEDist.Series[0].AddXY(CurrentSSData[i].SSPos,
      CurrentSSData[i].MOE);

    formSummaryGraphsDist.ChartWoodDensityDist.Series[0].AddXY(CurrentSSData[i].SSPos,
      CurrentSSData[i].WD);
    formSummaryGraphsDist.ChartMFADist.Series[0].AddXY(CurrentSSData[i].SSPos,
      CurrentSSData[i].MFA);

    formSummaryGraphsDist.ChartTRDDist.Series[0].AddXY(CurrentSSData[i].SSPos,
      CurrentSSData[i].TRD);
    formSummaryGraphsDist.ChartTWTDist.Series[0].AddXY(CurrentSSData[i].SSPos,
      CurrentSSData[i].TWT);

  end;
end;


Procedure DrawRingMeansDataGraphs(CurrentSSRingMeansData:  TRingMeanDataArray);
var
  i : integer;
begin
  formSummaryGraphsDist.ChartWoodDensityRings.Series[1].Clear;
  formSummaryGraphsDist.CHartWoodDensityRings.Series[2].Clear;
  formSummaryGraphsDist.CHartWoodDensityRings.Series[3].Clear;

  formSummaryGraphsDist.ChartMOERings.Series[1].Clear;
  formSummaryGraphsDist.ChartMOERings.Series[2].Clear;
  formSummaryGraphsDist.ChartMOERings.Series[3].Clear;

  formSummaryGraphsDist.CHartTRDRings.Series[1].Clear;
  formSummaryGraphsDist.CHartTRDRings.Series[2].Clear;
  formSummaryGraphsDist.CHartTRDRings.Series[3].Clear;

  formSummaryGraphsDist.ChartWTRings.Series[1].Clear;
  formSummaryGraphsDist.ChartWTRings.Series[2].Clear;
  formSummaryGraphsDist.ChartWTRings.Series[3].Clear;

  formSummaryGraphsDist.ChartMFARings.Series[1].Clear;
  formSummaryGraphsDist.ChartMFARings.Series[2].Clear;
  formSummaryGraphsDist.ChartMFARings.Series[3].Clear;


  for i := 0 to length(CurrentSSRingMeansData) - 1 do begin
    formSummaryGraphsDist.ChartWoodDensityRings.Series[1].AddXY(CurrentSSRingMeansData[i].RingYear,
      CurrentSSRingMeansData[i].MeanWD);
    formSummaryGraphsDist.ChartWoodDensityRings.Series[2].AddXY(CurrentSSRingMeansData[i].RingYear,
      CurrentSSRingMeansData[i].MeanWD + CurrentSSRingMeansData[i].WDSD);
    formSummaryGraphsDist.ChartWoodDensityRings.Series[3].AddXY(CurrentSSRingMeansData[i].RingYear,
      CurrentSSRingMeansData[i].MeanWD - CurrentSSRingMeansData[i].WDSD);

    formSummaryGraphsDist.ChartMFARings.Series[1].AddXY(CurrentSSRingMeansData[i].RingYear,
      CurrentSSRingMeansData[i].MeanMFA);
    formSummaryGraphsDist.ChartMFARings.Series[2].AddXY(CurrentSSRingMeansData[i].RingYear,
      CurrentSSRingMeansData[i].MeanMFA + CurrentSSRingMeansData[i].MFASD);
    formSummaryGraphsDist.ChartMFARings.Series[3].AddXY(CurrentSSRingMeansData[i].RingYear,
      CurrentSSRingMeansData[i].MeanMFA - CurrentSSRingMeansData[i].MFASD);

    formSummaryGraphsDist.ChartMOERings.Series[1].AddXY(CurrentSSRingMeansData[i].RingYear,
      CurrentSSRingMeansData[i].MeanMOE);
    formSummaryGraphsDist.ChartMOERings.Series[2].AddXY(CurrentSSRingMeansData[i].RingYear,
      CurrentSSRingMeansData[i].MeanMOE +  CurrentSSRingMeansData[i].MOESD);
    formSummaryGraphsDist.ChartMOERings.Series[3].AddXY(CurrentSSRingMeansData[i].RingYear,
      CurrentSSRingMeansData[i].MeanMOE -  CurrentSSRingMeansData[i].MOESD);


    formSummaryGraphsDist.CHartTRDRings.Series[1].AddXY(CurrentSSRingMeansData[i].RingYear,
      CurrentSSRingMeansData[i].MeanTRD);
    formSummaryGraphsDist.CHartTRDRings.Series[2].AddXY(CurrentSSRingMeansData[i].RingYear,
      CurrentSSRingMeansData[i].MeanTRD + CurrentSSRingMeansData[i].TRDSD);
    formSummaryGraphsDist.CHartTRDRings.Series[3].AddXY(CurrentSSRingMeansData[i].RingYear,
      CurrentSSRingMeansData[i].MeanTRD - CurrentSSRingMeansData[i].TRDSD);

    formSummaryGraphsDist.ChartWTRings.Series[1].AddXY(CurrentSSRingMeansData[i].RingYear,
      CurrentSSRingMeansData[i].MeanWT);
    formSummaryGraphsDist.ChartWTRings.Series[2].AddXY(CurrentSSRingMeansData[i].RingYear,
      CurrentSSRingMeansData[i].MeanWT + CurrentSSRingMeansData[i].WTSD);
    formSummaryGraphsDist.ChartWTRings.Series[3].AddXY(CurrentSSRingMeansData[i].RingYear,
      CurrentSSRingMeansData[i].MeanWT - CurrentSSRingMeansData[i].WTSD);

  end;


end;

Procedure MainLoop(ScenarioName: String);
var
  //CurrentScenariosList :  TSelectedScenariosInfo;
  CurrentSegmentsData,CurrentSegmentsData_mm : TCAMBIUMSegmentDataArray;
  CurrentRingMeansData : TRingMeanDataArray;
  i : integer;
  RadPosMin,RadPOsMax : Integer;
  SegmentWidth,SSSegmentWidth : Integer;
  CurrentColour : TColor;
  MOEMax,MOEMin : Double;
  BoardsList : TObjectList;
  CurrentBoard : TBoard;
  Centre:TPoint;
  MyColourList : TColorArray;
  myScaleCount : Integer;
  MyLabel : TLabel;
  relpos : DOuble;
begin
  try
    formSummaryGraphsDist.ScaleFormObjects;

    formSummaryGraphsDist.InitialiseGraphs;

    formMain.LabelStatus.Caption := 'Reading data';
    formMain.Refresh;
    screen.Cursor := crHourGlass;

    if ScenarioName <> '' then begin

      formSummaryGraphsDist.Caption := 'Summary of wood property data from ' +
        ScenarioName;

      CurrentSegmentsData := ReadSegmentsData(ScenarioName,
        ProjectManager.CAMBIUMSEGMENTSDATATABLE,
        ProjectManager.SCENARIONAMEFIELD,
        DataModule.DataModuleBoard.ADOQueryCAMBIUM);

      CurrentSegmentsData_mm := ReadSegmentsData_inmm(ScenarioName,
        ProjectManager.CAMBIUMSEGMENTSDATATABLE,
        ProjectManager.SCENARIONAMEFIELD,
        DataModule.DataModuleBoard.ADOQueryCAMBIUM);

      CurrentRingMeansData :=  ReadSegmentsData_RingMeans(ScenarioName,
        ProjectManager.CAMBIUMSEGMENTSDATATABLE,
        ProjectManager.SCENARIONAMEFIELD,
        DataModule.DataModuleBoard.ADOQueryCAMBIUM,
        -6);

      SegmentWidth := floor(CurrentSegmentsdata[0].SegmentWidth);

      //This needs to be improved somewhat
      RadPosMin := 0;
      RadPosMax := floor(Length(CurrentSegmentsData)*SegmentWidth);

      formSummaryGraphsDist.Image1.picture := nil;

      MOEMax :=  GetMax(IsolateRequiredField(CurrentSegmentsData_mm,1));
      MOEMin :=  GetMin(IsolateRequiredField(CurrentSegmentsData_mm,1));

      formMain.LabelStatus.Caption := 'Calculating board properties';
      formMain.Refresh;

      BoardsList := TObjectList.Create;
      try
        formSummaryGraphsDist.Show;

        BoardProperties.BoardsMainRoutine(CurrentSegmentsData_mm,
          strtoint(formBoardDimensions.leCantWidth.Text),
          strtoint(formBoardDimensions.leBoardWidthCant.Text),
          strtoint(formBoardDimensions.leBoardHeightWing.Text),
          strtoint(formBoardDimensions.leBoardWidthWing.Text),
          BoardsList);

        formMain.LabelStatus.Caption := 'Updating summary graphics';
        formMain.Refresh;

        //MyColourList := GetColourList(100,0);

        MOEMax :=  GetMax(IsolateRequiredField(CurrentSegmentsData,1));
        MOEMin :=  GetMin(IsolateRequiredField(CurrentSegmentsData,1));

        formSummaryGraphsDist.PanelUpperScaleColour.Caption := Inttostr(round(MOEMin)) + ' GPa';
        formSummaryGraphsDist.PanelLowerScaleColour.Caption := Inttostr(round(MOEMax)) + ' GPa';

        {PaintColourScale(formSummaryGraphsDist.ImageColourScale,
          MyColourList,formSummaryGraphsDist.PanelUpperScaleColour,
          formSummaryGraphsDist.panelLowerScaleColour,
          floattostr(MOEMin),floattostr(MOEMax));}

        MyColourList := GradVertical(formSummaryGraphsDist.ImageColourKey.Canvas,
            formSummaryGraphsDist.ImageColourKey.ClientRect,
            //formSummaryGraphsDist.PanelColourScale.ClientRect,
            clYellow,ClRed);

        DrawColourSequence(formSummaryGraphsDist.ImageColourKey,
          MyColourList);

        formSummaryGraphsDist.labelScale.Caption :=
          floattostr(RadPosMax/10000*2) + ' cm';

        {formSummaryGraphsDist.ImageScaleLineLower.Canvas.Pen.Color := clBlack;
        formSummaryGraphsDist.ImageScaleLineLower.Canvas.Pen.width := 2;
        formSummaryGraphsDist.ImageScaleLineLower.Canvas.MoveTo(formSummaryGraphsDist.ImageScaleLineLower.Left +
          round(formSummaryGraphsDist.ImageScaleLineLower.width/2),
          formSummaryGraphsDist.ImageScaleLineLower.Top);
        formSummaryGraphsDist.ImageScaleLineLower.Canvas.LineTo(formSummaryGraphsDist.ImageScaleLineLower.Left +
          round(formSummaryGraphsDist.ImageScaleLineLower.width/2),
          formSummaryGraphsDist.ImageScaleLineLower.Top+
          formSummaryGraphsDist.ImageScaleLineLower.Height);   }

        formSummaryGraphsDist.ImageScaleLineUpper.Canvas.Pen.Color := clBlack;
        formSummaryGraphsDist.ImageScaleLineUpper.Canvas.Pen.width := 2;
        formSummaryGraphsDist.ImageScaleLineUpper.Canvas.MoveTo(formSummaryGraphsDist.ImageScaleLineUpper.Left +
          round(formSummaryGraphsDist.ImageScaleLineUpper.width/2),
          formSummaryGraphsDist.ImageScaleLineUpper.Top);
        formSummaryGraphsDist.ImageScaleLineUpper.Canvas.LineTo(formSummaryGraphsDist.ImageScaleLineUpper.Left +
          round(formSummaryGraphsDist.ImageScaleLineUpper.width/2),
          formSummaryGraphsDist.ImageScaleLineUpper.Top+
          formSummaryGraphsDist.ImageScaleLineUpper.Height);

        formSummaryGraphsDist.labelScale.Top := formSummaryGraphsDist.ImageScaleLineUpper.Top+
          round(formSummaryGraphsDist.ImageScaleLineUpper.Height/2);

        for i := 0 to length(CurrentSegmentsData)-1 do begin

          CurrentColour := GetSequenceColour(MyColourList,
            MOEMin,MOEMax,CurrentSegmentsData[i].MOE);

          DrawBand(formSummaryGraphsDist.Image1,
            CurrentColour,
            RadPosMin,RadPosMax,
            round(CurrentSegmentsData[i].SegmentPosition),
            round(SegmentWidth),0);//CurrentSegmentsData[i].RinginSegment);

          DrawBand(formSummaryGraphsDist.Image2,
            CurrentColour,
            RadPosMin,RadPosMax,
            round(CurrentSegmentsData[i].SegmentPosition),
            round(SegmentWidth),0);//CurrentSegmentsData[i].RinginSegment);


          formSummaryGraphsDist.ChartWoodDensityDist.Series[1].AddXY(CurrentSegmentsData[i].SegmentPosition/1000,
            CurrentSegmentsData[i].WoodDensity);

          formSummaryGraphsDist.ChartMFADist.Series[1].AddXY(CurrentSegmentsData[i].SegmentPosition/1000,
            CurrentSegmentsData[i].MFA);

          formSummaryGraphsDist.ChartWoodDensityDist.Series[2].Color := clBlack;

          formSummaryGraphsDist.ChartMFADist.Series[2].Color := clBlack;

          formSummaryGraphsDist.ChartMOEDist.Series[1].AddXY(CurrentSegmentsData[i].SegmentPosition/1000,
            CurrentSegmentsData[i].MOE);

          formSummaryGraphsDist.ChartMOEDist.Series[2].Color := clBlack;
          formSummaryGraphsDist.ChartMOEDist.Series[2].AddXY(CurrentSegmentsData[i].SegmentPosition/1000,
            CurrentSegmentsData[i].RinginSegment* CurrentSegmentsData[i].MOE);

          formSummaryGraphsDist.ChartTRDDist.Series[1].AddXY(CurrentSegmentsData[i].SegmentPosition/1000,
            CurrentSegmentsData[i].MeanRD);
          formSummaryGraphsDist.ChartTWTDist.Series[1].AddXY(CurrentSegmentsData[i].SegmentPosition/1000,
            CurrentSegmentsData[i].MeanWT);

          formSummaryGraphsDist.ChartTRDDist.Series[2].Color := clBlack;

          formSummaryGraphsDist.ChartTWTDist.Series[2].Color := clBlack;
          if (i > 0) and
          (CurrentSegmentsData[i].RinginSegment < CurrentSegmentsData[i-1].RinginSegment) then begin
            formSummaryGraphsDist.ChartWoodDensityDist.Series[2].AddXY(CurrentSegmentsData[i].SegmentPosition/1000,
              CurrentSegmentsData[i].WoodDensity);
            formSummaryGraphsDist.ChartTWTDist.Series[2].AddXY(CurrentSegmentsData[i].SegmentPosition/1000,
              CurrentSegmentsData[i].MeanWT);
            formSummaryGraphsDist.ChartMFADist.Series[2].AddXY(CurrentSegmentsData[i].SegmentPosition/1000,
              CurrentSegmentsData[i].MFA);
            formSummaryGraphsDist.ChartTRDDist.Series[2].AddXY(CurrentSegmentsData[i].SegmentPosition/1000,
              CurrentSegmentsData[i].MeanRD);
          end;
        end;


        for I := 0 to BoardsList.Count-1 do begin
          CurrentBoard := TBoard(BoardsList[i]);

          SummaryGraphs.DrawBoard(formSummaryGraphsDist.image2,
            CurrentBoard.X0,CurrentBoard.Y0,CurrentBoard.X1,CurrentBoard.Y1,
            RadPOsMin,round(Length(CurrentSegmentsData_mm)*2),GetBoardColour(CurrentBoard.MGPClass,formBoardGrades.sgBoardGrades));

        end;

        for I := 0 to length(CurrentRingMeansData)-1 do begin
          formSummaryGraphsDist.ChartWoodDensityRings.Series[0].AddXY(CurrentRingMeansData[i].RingYear,
            CurrentRingMeansData[i].MeanWD);
          formSummaryGraphsDist.ChartMFARings.Series[0].AddXY(CurrentRingMeansData[i].RingYear,
            CurrentRingMeansData[i].MeanMFA);
          formSummaryGraphsDist.ChartMOERings.Series[0].AddXY(CurrentRingMeansData[i].RingYear,
            CurrentRingMeansData[i].MeanMOE);
          formSummaryGraphsDist.ChartTRDRings.Series[0].AddXY(CurrentRingMeansData[i].RingYear,
            CurrentRingMeansData[i].MeanTRD);
          formSummaryGraphsDist.ChartWTRings.Series[0].AddXY(CurrentRingMeansData[i].RingYear,
            CurrentRingMeansData[i].MeanWT);
        end;

        formSummaryGraphsDist.DrawBoardDistGraph(GetBoardDistribution(BoardsList,formBoardGrades.sgBoardGrades),
          formBoardGrades.sgBoardGrades);


      finally
        BoardsList.Free;;
      end;
    end;
  finally
    formMain.LabelStatus.Caption := '';
    screen.Cursor := crDefault;
  end;
end;

Procedure TformSummaryGraphsDist.DrawRings(Position: Double;
  Value : Double;
  RingPresent : SmallInt;
  Chart : TChart);
begin
  With Chart do begin

    {if RingPresent > 0 then begin
      canvas.pen.color := clBlack;
      canvas.pen.width := 2;
      Canvas.DoVertLine(round(Position),Chart.LeftAxis.IStartPos,Chart.LeftAxis.IEndPos);
      Chart.refresh;

    end;    }
  end;
end;

procedure DrawEllipseFromCenter(Canvas: TCanvas;
  CenterOfEllipse: TPoint;
  RadiusOfCircle: Integer);
var
R: TRect;
begin
  with Canvas do begin
    R.Top := CenterOfEllipse.Y - RadiusOfCircle;
    R.Left := CenterOfEllipse.X - RadiusOfCircle;
    R.Bottom := CenterOfEllipse.Y + RadiusOfCircle;
    R.Right := CenterOfEllipse.X + RadiusOfCircle;
    Ellipse(R);
    MoveTo(CenterOfEllipse.X, CenterOfEllipse.Y);
    LineTo(CenterOfEllipse.X, CenterOfEllipse.Y);
  end;
end;

Procedure DrawBoard(Image:TImage;
  X0,Y0,X1,Y1: Integer;
  RadPosMin,RadPosMax: Integer;
  BoardColour : Tcolor);
var
  X0Rel,Y0Rel,X1Rel,Y1Rel:Integer;

begin
  X0Rel := floor(((X0 - RadPosMin)/
    (RadPosMax - RadPosMin))*Image.width);
  Y0Rel := floor(((Y0 - RadPosMin)/
    (RadPosMax - RadPosMin))*Image.height);
  X1Rel := floor(((X1 - RadPosMin)/
    (RadPosMax - RadPosMin))*Image.width);
  Y1Rel := floor(((Y1 - RadPosMin)/
    (RadPosMax - RadPosMin))*Image.height);

  with Image.canvas do begin
    Pen.Color := clBlack;
    Brush.Color := BoardColour;
    rectangle(X0Rel,Y0Rel,
      X1Rel,Y1Rel);
    //rectangle(10,10,20,20);
    refresh;
  end;
  formSummaryGraphsDist.refresh;
end;



Procedure DrawBand(CurrentImage : TImage;
  BandColour : TColor; RadPosMin : Integer; RadPosMax: Integer;
  CurrentRadPos: Integer; BandWidth : Integer;
  AnnualRing : SmallInt);
var
  Centre : TPoint;
  RadPosRel : Double;


begin
  Centre.X := floor(CurrentImage.left + CurrentImage.width/2);
  Centre.Y := floor(CurrentImage.top + CurrentImage.height/2);

  with CurrentImage do begin
    //if AnnualRing = 0  then begin
      canvas.Pen.Color := BandColour;
      canvas.Brush.Color := BandColour;
      canvas.pen.width := 3;
    {end else begin
      canvas.Pen.Color := clBlue;
      canvas.Brush.Color := clBlue;
      canvas.Pen.Width := 2;
    end;}

    canvas.Brush.Style := bsclear;

    RadPosRel := (CurrentRadPos - RadPosMin)/
      (RadPosMax - RadPosMin);

    DrawEllipseFromCenter(CurrentImage.Canvas,
      Centre,round(RadPosRel * CurrentImage.Width/2));
  end;
end;




procedure TformSummaryGraphsDist.FormResize(Sender: TObject);
begin
  if (formSummaryGraphsDist.Width > 200) and (formSummaryGraphsDist.Height> 140) then
    ScaleFormObjects;
end;

function GetPigmentBetween(P1, P2, Percent: Double): Integer;
  {Returns a number that is Percent of the way between P1 and P2}
begin
  {Find the number between P1 and P2}
  Result := Round(((P2 - P1) * Percent) + P1);
  {Make sure we are within bounds for color.}
  if Result > 255 then
    Result := 255;
  if Result < 0 then
    Result := 0;
end;

function ColorFromRGB(Red, Green, Blue: Integer): Integer;
  {Returns the color made up of the red, green, and blue components.
  Red, Green, and Blue can be from 0 to 255.}
begin
  {Convert Red, Green, and Blue values to color.}
  Result := Red + Green * 256 + Blue * 65536;
end;

Function GradVertical(Canvas:TCanvas;
  Rect:TRect;
  FromColor, ToColor:TColor):TColorArray ;
 var
   Y:integer;
   dr,dg,db:Extended;
   C1,C2:TColor;
   r1,r2,g1,g2,b1,b2:Byte;
   R,G,B:Byte;
   cnt:Integer;
   myarray : TColorArray;
 begin
    SetLength(myarray,Rect.Bottom - rect.Top);

    C1 := FromColor;
    R1 := GetRValue(C1) ;
    G1 := GetGValue(C1) ;
    B1 := GetBValue(C1) ;

    C2 := ToColor;
    R2 := GetRValue(C2) ;
    G2 := GetGValue(C2) ;
    B2 := GetBValue(C2) ;

    dr := (R2-R1) / Rect.Bottom-Rect.Top;
    dg := (G2-G1) / Rect.Bottom-Rect.Top;
    db := (B2-B1) / Rect.Bottom-Rect.Top;

    cnt := 0;
    for Y := Rect.Top to Rect.Bottom-1 do
    begin
       R := R1+Ceil(dr*cnt) ;
       G := G1+Ceil(dg*cnt) ;
       B := B1+Ceil(db*cnt) ;

       myarray[cnt] :=  RGB(R,G,B);

       Inc(cnt) ;
    end;

    Result := myarray;
 end;

Procedure DrawColourSequence(OutImage: Timage;
  ColorArray : Array of TColor);
var
  Y,i : integer;
begin
  i := 0;
  for Y := OutImage.ClientRect.Top to OutImage.ClientRect.Bottom-1 do begin
  //for Y := formSummaryGraphsDist.PanelColourScale.ClientRect.top to formSummaryGraphsDist.PanelColourScale.ClientRect.Bottom-1 do begin

     OutImage.Canvas.pen.Color := ColorArray[i] ;
     OutImage.Canvas.MoveTo(OutImage.ClientRect.Left,Y) ;
     OutImage.Canvas.LineTo(OutImage.ClientRect.Right,Y) ;
     //OutImage.Canvas.MoveTo(formSummaryGraphsDist.PanelColourScale.ClientRect.Left,Y) ;
     //OutImage.Canvas.LineTo(formSummaryGraphsDist.PanelColourScale.ClientRect.Right,Y) ;
     inc(i);
  end;
end;




procedure TformSummaryGraphsDist.FormShow(Sender: TObject);
begin
  ScaleFormObjects;
  PCSummaryGraphs.ActivePageIndex := 0;
  lbSSDataSets.Clear;
  lbRingMeanDataSets.Clear;

  try
    General.GetDistinctValuesinField(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
      ProjectManager.REALSSDATATABLE,
      ProjectManager.SSDATASETNAMEFIELD,
      lbSSDataSets.Items);
  except
  end;

  try
    General.GetDistinctValuesinField(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
      ProjectManager.MEANRINGPROPSTABLE,
      ProjectManager.RINGPROPSLABELFIELD,
      lbRingMeanDataSets.Items);
  except
  end;

  //PCSummaryGraphs.Pages[1].TabVisible := false;
  //PCSummaryGraphs.Pages[2].TabVisible := false;

end;

Procedure TformSummaryGraphsDist.ScaleFormObjects;
var
    MyColourList : TColorArray;

begin
  formSummaryGraphsDist.PanelTop.Height := floor(formSummaryGraphsDist.Height/3);

  PanelLeft.Width := PanelLeft.Height;
  //PanelCentre.Width := PanelCentre.Height;
  PanelCentre.Width := Panelleft.width;

  ChartWoodDensityDist.Height := round((pcSummaryGraphs.Height)/2);
  ChartTRDDist.Height := round((pcSummaryGraphs.Height)/2);

  ChartWoodDensityRings.Height := round(pcSummaryGraphs.Height/2);
  ChartTRDRings.Height := round(pcSummaryGraphs.Height/2);
  gbSSData.Height :=  round(pcSummaryGraphs.Height/2);

end;

end.
