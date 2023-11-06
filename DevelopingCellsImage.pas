unit DevelopingCellsImage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, Buttons, ExtCtrls, TeeProcs, TeEngine, Chart, Series,
  ComCtrls, jpeg,{FileCtrl,}Math,ProjectWarnings,contnrs,CambiumObjects;

type
  TformDevelopingCellsImage = class(TForm)
    imageDevelopingCells: TImage;
    Image1: TImage;
    procedure FormShow(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }

  end;

  Procedure DrawCellsDuringRun(
    CurrentImage: TImage;
    CellList: TObjectList;
    CambiumPosition : Integer;
    RefreshForm: Boolean);

  Procedure CellArtist(CurrentImage: TImage;
    CurrentCell:TCell;
    MaxPos:Integer);

  Function ConvertSaveImage(InputImage : TPicture;
    ImageFileName:string):boolean;

  Procedure DrawAllCells(TheImage: TImage;
    MaxPos : Double;
    AllCells : TObjectList);



var
  formDevelopingCellsImage: TformDevelopingCellsImage;

implementation

uses ColourChoice, RunInitialisation;



{$R *.dfm}

Function ConvertSaveImage(InputImage : TPicture; ImageFileName:string):boolean;
var
  JPGImage : TJPegImage;
  BMPImage : TBitmap;
begin

  Result:=False;
  BMPImage := TBitmap.Create;
  try

    BMPImage.assign(InputImage);
    JPGImage := TJpegImage.Create;

    if copy(imageFilename,length(imagefilename)-2,length(imagefilename)) = 'jpg' then begin
      try
        JPGImage.Assign(BMPImage) ;
        JPGImage.SaveToFile(ImageFileName) ;
        Result:=True;
      finally
        JPGImage.Free
      end;
    end else if copy(imageFilename,length(imagefilename)-2,length(imagefilename)) = 'bmp' then begin
      BMPImage.SaveToFile(ImageFileName);
    end;
  finally
   BMPImage.Free
  end;
end;

Procedure DrawCellsDuringRun(
  CurrentImage: TImage;
  CellList: TObjectList;
  CambiumPosition : Integer;
  RefreshForm: Boolean);
var
  WoodColour : TColor;
  MonthPositionCounter,TotalCells,i : Integer;
  MaxPos : Integer;

begin

  //formDevelopingCellsImage.Show;

  CurrentImage.Picture := nil;

  MaxPos := CambiumPosition + 10;

  MonthPositionCounter := 1;

  for i := 0 to CellList.count-1 do begin
    CellArtist(CurrentImage,
      TCell(CellList[i]),
      MaxPos);
  end;

  CurrentImage.Refresh;
  //formDevelopingCellsImage.Refresh;

  {  if (radposition[i] >= MonthMarkerPosition[MonthPositionCounter]) and
      (MonthPositionNumber >= MonthPositionCounter) then begin
      InputImage.Canvas.Pen.Color := clyellow;
      InputImage.Canvas.Pen.Width := 2;
      InputImage.Canvas.Brush.Color := clyellow;
      InputImage.Canvas.Rectangle(0,round((MaxInitialPosition - MonthMarkerPosition[MonthPositionCounter])/IMAGESCALAR),
        InputImage.Width,round((MaxInitialPosition - MonthMarkerPosition[MonthPositionCounter] + 2)/IMAGESCALAR));
      MonthPositionCounter := MonthPositionCounter + 1;
      InputImage.canvas.Font.Size := 50;
      InputImage.Canvas.TextOut(0,round((MaxInitialPosition - MonthMarkerPosition[MonthPositionCounter])/IMAGESCALAR),YearMonthLabel[MonthPositionCounter]);
    end;

  end;

  if (menusavemovie.Checked = true) and (MainMoviePath <> '')  then begin
    try
      ConvertSaveImage(formmovie.CurrentImage.Picture,MainMoviePath + ScenarioName + inttostr(LogDay),savepicturedialog2.FilterIndex)
    except
      MessageDlg('There was a problem saving the image for day ' + inttostr(LogDay),mtWarning,[mbOK],0);
    end;
  end;               }

  //AllCells.destroy;

end;

Procedure DrawAllCells(TheImage: TImage;
  MaxPos : Double;
  AllCells : TObjectList);
var
  AllCellsImage: TImage;
  i : integer;
begin


  for i := 0 to AllCells.count-1 do begin
    CellArtist(AllCellsImage,
      TCell(AllCells[i]),
      round(MaxPos));
  end;
  //formDevelopingCellsIMage.Refresh;

end;

procedure CellArtist(CurrentImage: TImage;
  CurrentCell:TCell;
  MaxPos : Integer);

const
	DARKWOOD = $425E85;
var
  MatureWoodColour : TColor;
  i : integer;
  RandomVal : Double;
begin

  //MatureWoodColour := DARKWOOD;
  //MatureWoodColour := formColourChoice.ColorDialog1.Color;
  //MatureWoodColour := 2400966;
  MatureWoodColour := 1146274;

  with CurrentImage do begin

    canvas.pen.width:=1;

  if CurrentCell.CellType = XMC then
      canvas.pen.color := clgreen;

    if CurrentCell.CellType = PMC then
      canvas.pen.color := clBlack;

    if CurrentCell.CellType = CINITIAL then begin
      canvas.pen.color := clYellow;
      canvas.pen.width := 2;
    end;

    {if CurrentCell.AuxinConcentration < 20 then
      canvas.Brush.Color := clWhite;
    if CurrentCell.AuxinConcentration < 18 then
      canvas.Brush.Color := clBlue;
    if CurrentCell.AuxinConcentration < 16 then
      canvas.Brush.Color := clgreen;
    if CurrentCell.AuxinConcentration < 14 then
      canvas.Brush.Color := clred;
    if CurrentCell.AuxinConcentration < 12 then
      canvas.Brush.Color := clblack;
    if CurrentCell.AuxinConcentration < 10 then
      canvas.Brush.Color := clyellow;
    if CurrentCell.AuxinConcentration < 8 then
      canvas.Brush.Color := clteal;
    if CurrentCell.AuxinConcentration < 6 then
      canvas.Brush.Color := clsilver;
    if CurrentCell.AuxinConcentration < 4 then
      canvas.Brush.Color := clnavy;
    if CurrentCell.AuxinConcentration < 2 then
      canvas.Brush.Color := clLime;
    if CurrentCell.AuxinConcentration < 1 then
      canvas.Brush.Color := clOlive;}


    if (CurrentCell.Process = STHICK) or (CurrentCell.Status = DEAD) then begin
      if round(CurrentCell.CellWT_um*6)>0 then
        canvas.pen.width:= 1 + round(CurrentCell.CellWT_um)
      else
        canvas.pen.width:=2;
    end else
      canvas.pen.width:=1;

    if CurrentCell.CellType = XCELL then begin

      canvas.pen.color := clblue;

      if CurrentCell.Process = STHICK then
        canvas.pen.color := clRed;

      if CurrentCell.Status = DEAD then
        canvas.Pen.Color := MatureWoodColour;

    end;


    if CurrentCell.CellType = PCELL then begin

      canvas.pen.color := clPurple;

    end;

    //MaxPos := 1000;


    for i := 0 to 10 do begin
      //RandomVal := RandomRange(90,110)/100;
      RandomVal := 1;

      canvas.RoundRect(round(CurrentCell.TanPosition_um + CurrentCell.CellTD_um*i),
        round(MaxPos + 50 - CurrentCell.RadPosition_um),
        round((CurrentCell.TanPosition_um + CurrentCell.CellTD_um + CurrentCell.CellTD_um*i)),
        round(MaxPos + 50 - (CurrentCell.RadPosition_um + CurrentCell.CellRD_um*RandomVal)),
        5,10);
    end;

    //formDevelopingCellsImage.Refresh;

 end;
end;

procedure TformDevelopingCellsImage.FormShow(Sender: TObject);
begin
  formDevelopingCellsImage.Width := round(strtofloat(formInitialisation.leTanDiam.Text) * 3);
end;

Procedure EnvironmentGraphs;
begin

    {if formMain.SaveSeqImages.Checked then begin
      if MyYear > 2003   then begin

      if ProjectManager.ImagesDirectory <> '' then begin
        if CurrentPosition.Position > 1.2 then begin

          TodaysImage := TImage.Create(nil);


          TodaysImage.Width := CellFileCount * 30 + 280;
          TodaysImage.Height :=  500;

          TempRect.Top := TodaysImage.Top;
          TempRect.Bottom := TempRect.Top +100;
          TempRect.Left := TodaysImage.Left +  CellFileCount * 30 + 10;
          TempRect.Right := TodaysImage.Left +  CellFileCount * 30 + 205;

          RainRect.Top := TempRect.Bottom+10;
          RainRect.Bottom := RainRect.Top + 100;
          RainRect.Left := TodaysImage.Left +  CellFileCount * 30 + 10;
          RainRect.Right := TodaysImage.Left +  CellFileCount * 30 + 245;

          NPPRect.Top := RainRect.Bottom+10;
          NPPRect.Bottom := NPPRect.Top + 100;
          NPPRect.Left := TodaysImage.Left +  CellFileCount * 30 + 20;
          NPPRect.Right := TodaysImage.Left +  CellFileCount * 30 + 245;

          WDRect.Top := NPPRect.Bottom+10;
          WDRect.Bottom := WDRect.Top + 100;
          WDRect.Left := TodaysImage.Left +  CellFileCount * 30 + 10;
          WDRect.Right := TodaysImage.Left +  CellFileCount * 30 + 200;

          DrawCellsDuringRun(TodaysImage,
            General.CombineObjectLists(DeadCellList,LivingCellList),
            round(GetMax(CurrentPosition.InitialCellPositions)),False);

          for i := Logday-40 to LogDay do begin
              TempChart.Series[0].AddXY(CurrentRunData[i].LogDate,CurrentRunData[i].MinTemp, FormatDateTime('mmm y', CurrentRunData[i].LogDate));
              TempChart.Series[0].Color := clAqua;
              TempChart.Series[1].AddXY(CurrentRunData[i].LogDate,CurrentRunData[i].MaxTemp,'MaxT',clRed);
              TempChart.Series[1].Color := clRed;
              SWCVPDChart.Series[0].AddXY(CurrentRunData[i].LogDate,CurrentRunData[i].SWC,FormatDateTime('mmm y', CurrentRunData[i].LogDate),clBlue);
              SWCVPDChart.Series[1].AddXY(CurrentRunData[i].LogDate,CurrentRunData[i].Rain,FormatDateTime('mmm y', CurrentRunData[i].Rain),clRed);
              SWCVPDChart.Series[1].Color := clBlue;
              NPPChart.Series[0].AddXY(CurrentRunData[i].LogDate,(CurrentRunData[i].NPP_tperha/CurrentRunData[i].SPH) *1000,FormatDateTime('mmm y', CurrentRunData[i].LogDate),clBlack);
              NPPChart.Series[1].AddXY(CurrentRunData[i].LogDate,CurrentRunData[i].LAI,FormatDateTime('mmm y', CurrentRunData[i].LogDate),clBlack);
              WDChart.Series[0].AddXY(CurrentRunData[i].LogDate,DailyDataArray[i].MeanWD*1000,FormatDateTime('mmm y', CurrentRunData[i].LogDate),clBlack);
              WDChart.Series[0].Color := clBlack;

          end;

          TempChart.DrawToMetaCanvas(TodaysImage.Canvas,
            TempRect);
          SWCVPDChart.DrawToMetaCanvas(TodaysImage.Canvas,
            RainRect);
          NPPChart.DrawToMetaCanvas(TodaysImage.Canvas,
            NPPRect);
          WDChart.DrawToMetaCanvas(TodaysImage.Canvas,
            WDRect);

          ConvertSaveImage(TodaysImage.Picture,
             ProjectManager.ImagesDirectory + '\' + 'Test' + floattostr(CurrentRunData[LogDay].LogDate) + '.jpg');

          TodaysImage.Free;
        end;
      end;

      end;
    end; }

    //TempCHart.Free;
    //TempSeries.Free;

  {TempChart := TChart.Create(nil);
  TempChart.Legend.Visible := false;
  tempChart.View3D := false;
  TempChart.Color := clWhite;
  TempChart.Border.Visible := false;
  TempChart.BevelOuter := TBevelCut(0);
  TempChart.Title.Caption := 'Temperature';
  TempChart.Axes.Left.Title.Caption := 'Temp (°C)';

  WDChart := TChart.Create(nil);
  WDchart.Legend.Visible := false;
  WDChart.View3D := false;
  WDChart.Color := clWhite;
  WDChart.Border.Visible := false;
  WDChart.BevelOuter := TBevelCut(0);
  WDChart.Title.Caption := 'Wood density';
  WDChart.Axes.Left.Title.Caption := 'Density (kg/m³)';

  SWCVPDChart := TChart.Create(nil);
  SWCVPDChart.Legend.Visible := false;
  SWCVPDChart.View3D := false;
  SWCVPDChart.Color := clWhite;
  SWCVPDChart.Border.Visible := false;
  SWCVPDChart.BevelOuter := TBevelCut(0);
  SWCVPDChart.Title.Caption := 'Soil water content & rainfall';
  SWCVPDChart.Axes.Right.Minimum := 0;
  SWCVPDCHart.Axes.Right.Title.Caption := 'Rainfall (mm)';
  SWCVPDCHart.Axes.Left.Title.Caption := 'SWC (mm/m)';

  NPPChart := TChart.Create(nil);
  NPPChart.Legend.Visible := false;
  NPPChart.View3D := false;
  NPPChart.Color := clWhite;
  NPPChart.Border.Visible := false;
  NPPChart.BevelOuter := TBevelCut(0);
  NPPChart.Title.Caption := 'Alloc NPP & LAI';
  NPPChart.Axes.Left.Title.Caption := 'Alloc carbs (kg/stem)';
  NPPChart.Axes.right.Title.Caption := 'LAI (m²/m²)';

  MinTempSeries := TLineSeries.Create(nil);
  MaxTempSeries := TLineSeries.Create(nil);

  NPPSeries := TLineSeries.Create(nil);
  LAISeries := TLineSeries.Create(nil);

  SWCSeries := TLineSeries.Create(nil);
  VPDSeries := TLineSeries.Create(nil);

  WDSeries := TLineSeries.Create(nil);
  //wdseries.Pointer.Style := psSmallDot;

  RainSeries := TBarSeries.Create(nil);

  NPPSeries.VertAxis := TVertAxis(0);
  LAISeries.VertAxis := TVertAxis(1);
  SWCSeries.VertAxis := TVertAxis(0);
  VPDSeries.VertAxis := TVertAxis(1);
  RainSeries.VertAxis := TVertAxis(1);
  RainSeries.Marks.Hide;

  MinTempSeries.ColorEachLine := true;
  MinTempSeries.Color := clBlue;
  MinTempSeries.Color := clRed;
  TempChart.AddSeries(MinTempSeries);
  TempChart.AddSeries(MaxTempSeries);
  SWCVPDChart.AddSeries(SWCSeries);
  SWCVPDCHart.AddSeries(RainSeries);
  NPPCHart.AddSeries(NPPSeries);
  NPPCHart.AddSeries(LAISeries);
  WDChart.AddSeries(WDSeries);   }

  {TempCHart.Free;
  TempChart.FreeAllSeries(nil);
  SWCVPDChart.Free;
  NPPChart.Free;
  WDChart.Free;}

end;

end.
