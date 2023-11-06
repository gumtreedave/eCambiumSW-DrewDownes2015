object formDiagnosticGraphs: TformDiagnosticGraphs
  Left = 0
  Top = 0
  Caption = 'Growth and developmental data'
  ClientHeight = 488
  ClientWidth = 784
  Color = clBtnFace
  Constraints.MinHeight = 500
  Constraints.MinWidth = 800
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    AlignWithMargins = True
    Left = 167
    Top = 3
    Width = 614
    Height = 482
    ActivePage = TabSheet10
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Biomass allocation and primary production'
      object ChartCarbohydrate: TChart
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 600
        Height = 225
        Legend.Alignment = laBottom
        Title.Text.Strings = (
          'Net primary productivity')
        View3D = False
        Align = alTop
        Color = clWhite
        TabOrder = 0
        object Series12: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          Title = 'NPP (stand-level) (t/Ha)'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.DateTime = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series4: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          Title = 'NPP per tree (kg)'
          VertAxis = aRightAxis
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.DateTime = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series16: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          SeriesColor = clBlue
          Title = 'NPP allocated to stem per tree (kg)'
          VertAxis = aRightAxis
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.DateTime = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
      object ChartBiomass: TChart
        Left = 0
        Top = 231
        Width = 606
        Height = 223
        Legend.Alignment = laBottom
        Title.Text.Strings = (
          'Biomass in tree components (t/Ha)')
        View3D = False
        Align = alClient
        Color = clWhite
        TabOrder = 1
        object Series9: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          Title = 'Foliage'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series10: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          Title = 'Stems'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series11: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          SeriesColor = clBlue
          Title = 'Roots'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Stand structure'
      ImageIndex = 4
      object ChartLAI: TChart
        AlignWithMargins = True
        Left = 3
        Top = 253
        Width = 600
        Height = 198
        Legend.Visible = False
        Title.Text.Strings = (
          'Leaf area index')
        View3D = False
        Align = alClient
        Color = clWhite
        TabOrder = 0
        object Series1: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          Title = 'LAI'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.DateTime = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
      object ChartSPH: TChart
        Left = 0
        Top = 0
        Width = 606
        Height = 250
        Legend.Visible = False
        Title.Text.Strings = (
          'Stand density (stems/Ha)')
        View3D = False
        Align = alTop
        Color = clWhite
        TabOrder = 1
        object Series8: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          Title = 'Stand density'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.DateTime = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Developing zones'
      ImageIndex = 3
      object ChartZoneCounts: TChart
        AlignWithMargins = True
        Left = 3
        Top = 253
        Width = 600
        Height = 198
        Legend.Alignment = laBottom
        Title.Text.Strings = (
          'Mean width of developmental zones (cells per file)')
        View3D = False
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        object Series13: TAreaSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Callout.Length = 20
          Marks.Visible = False
          SeriesColor = clGreen
          Title = 'Cambial'
          AreaLinesPen.Visible = False
          DrawArea = True
          MultiArea = maStacked
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.DateTime = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series14: TAreaSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Callout.Length = 20
          Marks.Visible = False
          SeriesColor = clBlue
          Title = 'Growing'
          AreaLinesPen.Visible = False
          DrawArea = True
          LinePen.Visible = False
          MultiArea = maStacked
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.DateTime = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series15: TAreaSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Callout.Length = 20
          Marks.Visible = False
          Title = 'Secondary thickening'
          AreaLinesPen.Visible = False
          DrawArea = True
          MultiArea = maStacked
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
      object ChartDurations: TChart
        Left = 0
        Top = 0
        Width = 606
        Height = 250
        Legend.Alignment = laBottom
        Title.Text.Strings = (
          'Developmental durations (days)')
        View3D = False
        Align = alTop
        Color = clWhite
        TabOrder = 1
        object Series2: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          SeriesColor = clGreen
          Title = 'Cell cycle (left axis)'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.DateTime = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series3: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          SeriesColor = clBlue
          Title = 'Growing (left axis)'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.DateTime = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series5: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          Title = 'Secondary thickening (right axis)'
          VertAxis = aRightAxis
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.DateTime = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'Environment'
      ImageIndex = 4
      object ChartTemperature: TChart
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 600
        Height = 250
        Legend.Alignment = laBottom
        Title.Text.Strings = (
          'Daily temperature ('#176'C)')
        View3D = False
        Align = alTop
        Color = clWhite
        TabOrder = 0
        object Series17: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          SeriesColor = clAqua
          Title = 'Minimum'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.DateTime = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series19: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          Title = 'Maximum'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.DateTime = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
      object ChartWaterPotential: TChart
        Left = 0
        Top = 256
        Width = 606
        Height = 198
        Legend.Alignment = laBottom
        Title.Text.Strings = (
          'Xylem water potential and soil water availability')
        View3D = False
        Align = alClient
        Color = clWhite
        TabOrder = 1
        object Series18: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          SeriesColor = clGreen
          Title = 'Pre-dawn xylem water potential (MPa)'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.DateTime = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series20: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          SeriesColor = clBlue
          Title = 'Available soil water in the rooting zone (mm)'
          VertAxis = aRightAxis
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.DateTime = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
    end
    object TabSheet10: TTabSheet
      Caption = 'Mensuration'
      ImageIndex = 9
      object ChartHeight: TChart
        AlignWithMargins = True
        Left = 3
        Top = 167
        Width = 600
        Height = 142
        Legend.Alignment = laBottom
        Title.Text.Strings = (
          'Tree height (m)')
        View3D = False
        Align = alClient
        Color = clWhite
        TabOrder = 0
        ExplicitTop = 103
        ExplicitHeight = 228
        object Series44: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          Title = 'Cambium tree height (m)'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.DateTime = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series45: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          Title = 'CaBala tree height (m) (if available)'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series49: TPointSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          Title = 'Observed height'
          ClickableLine = False
          Pointer.InflateMargins = True
          Pointer.Style = psCircle
          Pointer.Visible = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
      object ChartDBH: TChart
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 600
        Height = 158
        Legend.Alignment = laBottom
        Title.Text.Strings = (
          'Diameter (cm)')
        DepthAxis.Automatic = False
        DepthAxis.AutomaticMaximum = False
        DepthAxis.AutomaticMinimum = False
        DepthAxis.Maximum = 0.560000000000000100
        DepthAxis.Minimum = -0.439999999999999900
        DepthTopAxis.Automatic = False
        DepthTopAxis.AutomaticMaximum = False
        DepthTopAxis.AutomaticMinimum = False
        DepthTopAxis.Maximum = 0.560000000000000100
        DepthTopAxis.Minimum = -0.439999999999999900
        View3D = False
        Align = alTop
        Color = clWhite
        TabOrder = 1
        object Series6: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          Title = 'Cambium diameter (cm) (at modelled position, underbark)'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.DateTime = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series7: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          Title = 'CaBala DBH (cm) (if available)'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series48: TPointSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          Title = 'Observed DBH data (if available)'
          ClickableLine = False
          Pointer.Brush.Color = clLime
          Pointer.InflateMargins = True
          Pointer.Shadow.Color = clLime
          Pointer.Style = psCircle
          Pointer.Visible = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
      object ChartStandVol: TChart
        Left = 0
        Top = 312
        Width = 606
        Height = 142
        Legend.Visible = False
        Title.Text.Strings = (
          'Stand volume (m'#179'/Ha)')
        View3D = False
        Align = alBottom
        Color = clWhite
        TabOrder = 2
        object Series21: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          Title = 'Stand volume'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.DateTime = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
    end
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 158
    Height = 482
    Align = alLeft
    TabOrder = 1
    object gbMensData: TGroupBox
      Left = 1
      Top = 1
      Width = 156
      Height = 480
      Align = alClient
      Caption = 'Actual mensuration data'
      TabOrder = 0
      object lbMensDatasets: TListBox
        Left = 2
        Top = 15
        Width = 152
        Height = 463
        Align = alClient
        ItemHeight = 13
        TabOrder = 0
        OnClick = lbMensDatasetsClick
        OnKeyDown = lbMensDatasetsKeyDown
      end
    end
  end
end
