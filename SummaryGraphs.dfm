object formSummaryGraphsDist: TformSummaryGraphsDist
  Left = 0
  Top = 0
  ClientHeight = 522
  ClientWidth = 847
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
  object pcSummaryGraphs: TPageControl
    AlignWithMargins = True
    Left = 204
    Top = 36
    Width = 640
    Height = 483
    ActivePage = tsMOESummary
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 633
    ExplicitHeight = 473
    object tsMOESummary: TTabSheet
      Caption = 'MOE Summary'
      ExplicitWidth = 625
      ExplicitHeight = 445
      object PanelTop: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 626
        Height = 214
        Align = alTop
        TabOrder = 0
        ExplicitWidth = 619
        object ChartMOEDist: TChart
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 618
          Height = 206
          Legend.Alignment = laTop
          Title.Text.Strings = (
            'TChart')
          Title.Visible = False
          BottomAxis.Grid.Visible = False
          BottomAxis.Title.Caption = 'Distance from pith (mm)'
          DepthAxis.Automatic = False
          DepthAxis.AutomaticMaximum = False
          DepthAxis.AutomaticMinimum = False
          DepthAxis.Maximum = 0.169999999999999800
          DepthAxis.Minimum = -0.830000000000000300
          DepthTopAxis.Automatic = False
          DepthTopAxis.AutomaticMaximum = False
          DepthTopAxis.AutomaticMinimum = False
          DepthTopAxis.Maximum = 0.169999999999999800
          DepthTopAxis.Minimum = -0.830000000000000300
          LeftAxis.Automatic = False
          LeftAxis.AutomaticMaximum = False
          LeftAxis.AutomaticMinimum = False
          LeftAxis.Grid.Visible = False
          LeftAxis.Maximum = 753.750000000000000000
          LeftAxis.Minimum = -371.250000000000000000
          LeftAxis.Title.Caption = 'Wood MOE (GPa)'
          RightAxis.Automatic = False
          RightAxis.AutomaticMaximum = False
          RightAxis.AutomaticMinimum = False
          View3D = False
          Align = alClient
          Color = clWhite
          TabOrder = 0
          ExplicitWidth = 611
          object ChartMOERings: TChart
            Left = 1
            Top = 1
            Width = 616
            Height = 204
            Legend.Alignment = laBottom
            Legend.Visible = False
            Title.Font.Color = clBlack
            Title.Font.Style = [fsBold]
            Title.Text.Strings = (
              'Modulus of Elasticity (MOE) (GPa)')
            BottomAxis.AxisValuesFormat = '0'
            BottomAxis.Title.Caption = 'Annual ring year'
            DepthAxis.Automatic = False
            DepthAxis.AutomaticMaximum = False
            DepthAxis.AutomaticMinimum = False
            DepthAxis.Maximum = 0.169999999999999800
            DepthAxis.Minimum = -0.830000000000000300
            DepthTopAxis.Automatic = False
            DepthTopAxis.AutomaticMaximum = False
            DepthTopAxis.AutomaticMinimum = False
            DepthTopAxis.Maximum = 0.169999999999999800
            DepthTopAxis.Minimum = -0.830000000000000300
            LeftAxis.Grid.Visible = False
            RightAxis.Automatic = False
            RightAxis.AutomaticMaximum = False
            RightAxis.AutomaticMinimum = False
            View3D = False
            Align = alClient
            Color = clWhite
            TabOrder = 0
            ExplicitWidth = 609
            object Series25: TLineSeries
              Marks.Arrow.Visible = True
              Marks.Callout.Brush.Color = clBlack
              Marks.Callout.Arrow.Visible = True
              Marks.Visible = False
              Title = 'Estimated'
              Pointer.InflateMargins = True
              Pointer.Style = psRectangle
              Pointer.Visible = True
              XValues.Name = 'X'
              XValues.Order = loAscending
              YValues.Name = 'Y'
              YValues.Order = loNone
            end
            object Series26: TLineSeries
              Marks.Arrow.Visible = True
              Marks.Callout.Brush.Color = clBlack
              Marks.Callout.Arrow.Visible = True
              Marks.Visible = False
              Title = 'Measured'
              Pointer.InflateMargins = True
              Pointer.Style = psRectangle
              Pointer.Visible = True
              XValues.Name = 'X'
              XValues.Order = loAscending
              YValues.Name = 'Y'
              YValues.Order = loNone
            end
            object Series27: TLineSeries
              Marks.Arrow.Visible = True
              Marks.Callout.Brush.Color = clBlack
              Marks.Callout.Arrow.Visible = True
              Marks.Visible = False
              SeriesColor = 4227072
              Title = 'Mean + 1 X SD'
              LinePen.Style = psDot
              Pointer.InflateMargins = True
              Pointer.Style = psRectangle
              Pointer.Visible = False
              XValues.Name = 'X'
              XValues.Order = loAscending
              YValues.Name = 'Y'
              YValues.Order = loNone
            end
            object Series28: TLineSeries
              Marks.Arrow.Visible = True
              Marks.Callout.Brush.Color = clBlack
              Marks.Callout.Arrow.Visible = True
              Marks.Visible = False
              SeriesColor = 4227072
              Title = 'Mean - 1 X SD'
              LinePen.Style = psDot
              Pointer.InflateMargins = True
              Pointer.Style = psRectangle
              Pointer.Visible = False
              XValues.Name = 'X'
              XValues.Order = loAscending
              YValues.Name = 'Y'
              YValues.Order = loNone
            end
          end
          object Series16: TLineSeries
            Marks.Arrow.Visible = True
            Marks.Callout.Brush.Color = clBlack
            Marks.Callout.Arrow.Visible = True
            Marks.Visible = False
            Title = 'Actual'
            Pointer.InflateMargins = True
            Pointer.Style = psRectangle
            Pointer.Visible = False
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Y'
            YValues.Order = loNone
          end
          object Series1: TLineSeries
            Marks.Arrow.Visible = True
            Marks.Callout.Brush.Color = clBlack
            Marks.Callout.Arrow.Visible = True
            Marks.Visible = False
            SeriesColor = clGreen
            Title = 'Modelled'
            LinePen.Color = clGreen
            OutLine.Visible = True
            Pointer.InflateMargins = True
            Pointer.Style = psRectangle
            Pointer.Visible = False
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Y'
            YValues.Order = loNone
          end
          object Series7: TBarSeries
            BarPen.Visible = False
            Marks.Arrow.Visible = True
            Marks.Callout.Brush.Color = clBlack
            Marks.Callout.Arrow.Visible = True
            Marks.Visible = False
            SeriesColor = clBlue
            Title = 'Annual rings'
            AutoMarkPosition = False
            BarWidthPercent = 1
            DepthPercent = 1
            Gradient.Direction = gdTopBottom
            Shadow.Visible = False
            SideMargins = False
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Bar'
            YValues.Order = loNone
          end
        end
      end
      object PanelLeft: TPanel
        Left = 0
        Top = 220
        Width = 193
        Height = 235
        Align = alLeft
        TabOrder = 1
        ExplicitHeight = 225
        object Image1: TImage
          Left = 1
          Top = 1
          Width = 191
          Height = 233
          Align = alClient
          AutoSize = True
          Center = True
          Stretch = True
          ExplicitWidth = 208
          ExplicitHeight = 223
        end
      end
      object PanelCentre: TPanel
        Left = 289
        Top = 220
        Width = 184
        Height = 235
        Align = alLeft
        TabOrder = 2
        ExplicitHeight = 225
        object Image2: TImage
          Left = 1
          Top = 1
          Width = 182
          Height = 233
          Align = alClient
          AutoSize = True
          Center = True
          Stretch = True
          ExplicitLeft = 90
          ExplicitTop = -73
          ExplicitWidth = 176
          ExplicitHeight = 223
        end
      end
      object PanelRight: TPanel
        Left = 473
        Top = 220
        Width = 159
        Height = 235
        Align = alClient
        TabOrder = 3
        ExplicitLeft = 504
        ExplicitWidth = 121
        ExplicitHeight = 225
        object ChartBD: TChart
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 151
          Height = 227
          Legend.Alignment = laTop
          Title.Text.Strings = (
            'TChart')
          Title.Visible = False
          LeftAxis.Automatic = False
          LeftAxis.AutomaticMaximum = False
          LeftAxis.Maximum = 1.100000000000000000
          View3D = False
          Align = alClient
          Color = clWhite
          TabOrder = 0
          ExplicitLeft = -68
          ExplicitTop = -100
          ExplicitWidth = 137
          ExplicitHeight = 217
          object Series10: TBarSeries
            ColorEachPoint = True
            Marks.Arrow.Visible = True
            Marks.Callout.Brush.Color = clBlack
            Marks.Callout.Arrow.Visible = True
            Marks.Visible = False
            Gradient.Direction = gdTopBottom
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Bar'
            YValues.Order = loNone
          end
        end
      end
      object PanelScale: TPanel
        Left = 193
        Top = 220
        Width = 96
        Height = 235
        Align = alLeft
        TabOrder = 4
        ExplicitHeight = 225
        object PanelColourScale: TPanel
          Left = 1
          Top = 1
          Width = 48
          Height = 233
          Align = alLeft
          TabOrder = 0
          ExplicitHeight = 223
          object ImageColourKey: TImage
            AlignWithMargins = True
            Left = 4
            Top = 28
            Width = 40
            Height = 177
            Align = alClient
            ExplicitLeft = -74
            ExplicitTop = 104
            ExplicitWidth = 105
            ExplicitHeight = 105
          end
          object PanelUpperScaleColour: TPanel
            Left = 1
            Top = 1
            Width = 46
            Height = 24
            Align = alTop
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -8
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            ExplicitLeft = 4
            ExplicitTop = 4
            ExplicitWidth = 40
          end
          object panelLowerScaleColour: TPanel
            Left = 1
            Top = 208
            Width = 46
            Height = 24
            Align = alBottom
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -8
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            ExplicitLeft = 4
            ExplicitTop = 195
            ExplicitWidth = 40
          end
        end
        object PanelSizeScale: TPanel
          Left = 49
          Top = 1
          Width = 46
          Height = 233
          Align = alClient
          TabOrder = 1
          ExplicitLeft = 52
          ExplicitTop = 4
          ExplicitWidth = 40
          ExplicitHeight = 217
          object ImageScaleLineUpper: TImage
            Left = 1
            Top = 1
            Width = 44
            Height = 231
            Align = alClient
            ExplicitWidth = 37
            ExplicitHeight = 160
          end
          object labelScale: TLabel
            Left = 3
            Top = 105
            Width = 20
            Height = 10
            Alignment = taCenter
            BiDiMode = bdLeftToRight
            Caption = 'ggggg'
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -8
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentBiDiMode = False
            ParentColor = False
            ParentFont = False
            Transparent = False
          end
        end
      end
    end
    object tsWD_MFA_RingMeans: TTabSheet
      Caption = 'Wood density and MFA ring means'
      ImageIndex = 3
      ExplicitWidth = 625
      ExplicitHeight = 445
      object ChartWoodDensityRings: TChart
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 626
        Height = 250
        Legend.Alignment = laBottom
        Legend.LegendStyle = lsSeries
        Legend.Visible = False
        Title.Font.Color = clBlack
        Title.Font.Style = [fsBold]
        Title.Text.Strings = (
          'Wood density (kg/m'#179')')
        BottomAxis.AxisValuesFormat = '0'
        BottomAxis.Title.Caption = 'Annual ring year'
        LeftAxis.Automatic = False
        LeftAxis.AutomaticMinimum = False
        LeftAxis.Grid.Visible = False
        View3D = False
        Align = alTop
        Color = clWhite
        TabOrder = 0
        ExplicitWidth = 619
        object Series19: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          Title = 'Estimated'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series17: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Shadow.Color = 8487297
          Marks.Visible = False
          Title = 'Measured'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series29: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          SeriesColor = 4227072
          Title = 'Mean + 1 X SD'
          LinePen.Style = psDot
          OutLine.Style = psDot
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series30: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          SeriesColor = 4227072
          Title = 'Mean - 1 X SD'
          LinePen.Style = psDot
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
      object ChartMFARings: TChart
        AlignWithMargins = True
        Left = 3
        Top = 259
        Width = 626
        Height = 193
        Legend.Alignment = laBottom
        Legend.Visible = False
        Title.Font.Color = clBlack
        Title.Font.Style = [fsBold]
        Title.Text.Strings = (
          'Microfibril angle (MFA) (degrees)')
        BottomAxis.AxisValuesFormat = '0'
        BottomAxis.Title.Caption = 'Annual ring year'
        LeftAxis.Grid.Visible = False
        View3D = False
        Align = alClient
        Color = clWhite
        TabOrder = 1
        ExplicitWidth = 619
        ExplicitHeight = 183
        object Series18: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          Title = 'Estimated'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = True
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
          Title = 'Measured'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series31: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          SeriesColor = 4227072
          LinePen.Style = psDot
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series32: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          SeriesColor = 4227072
          LinePen.Style = psDot
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
    object ts_TRD_WT_RingMeans: TTabSheet
      Caption = 'Tracheid radial diameter and wall thickness ring means'
      ImageIndex = 4
      ExplicitWidth = 625
      ExplicitHeight = 445
      object CHartTRDRings: TChart
        Left = 0
        Top = 0
        Width = 632
        Height = 250
        Legend.Alignment = laBottom
        Legend.Visible = False
        Title.Font.Color = clBlack
        Title.Font.Style = [fsBold]
        Title.Text.Strings = (
          'Tracheid radial diameter ('#181'm)')
        BottomAxis.AxisValuesFormat = '0'
        BottomAxis.Title.Caption = 'Annual ring year'
        LeftAxis.Automatic = False
        LeftAxis.AutomaticMinimum = False
        LeftAxis.Grid.Visible = False
        View3D = False
        Align = alTop
        Color = clWhite
        TabOrder = 0
        ExplicitWidth = 625
        object Series21: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          Title = 'Estimated'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series22: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          Title = 'Measured'
          Pointer.Gradient.EndColor = 2152289
          Pointer.Gradient.MidColor = 7548915
          Pointer.Gradient.StartColor = 10109259
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series33: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          SeriesColor = 4227072
          LinePen.Style = psDot
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series34: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          SeriesColor = 4227072
          LinePen.Style = psDot
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
      object CHartWTRings: TChart
        Left = 0
        Top = 250
        Width = 632
        Height = 205
        Legend.Alignment = laBottom
        Legend.Visible = False
        Title.Font.Color = clBlack
        Title.Font.Style = [fsBold]
        Title.Text.Strings = (
          'Tracheid wall thickness ('#181'm)')
        BottomAxis.AxisValuesFormat = '0'
        BottomAxis.Title.Caption = 'Annual ring year'
        LeftAxis.Automatic = False
        LeftAxis.AutomaticMinimum = False
        LeftAxis.Grid.Visible = False
        View3D = False
        Align = alClient
        Color = clWhite
        TabOrder = 1
        ExplicitWidth = 625
        ExplicitHeight = 195
        object Series23: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          Title = 'Estimated'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series24: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          Title = 'Measured'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series35: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          SeriesColor = 4227072
          LinePen.Style = psDot
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series36: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          SeriesColor = 4227072
          LinePen.Style = psDot
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
    object tsOtherProps: TTabSheet
      Caption = 'Wood density and MFA pith-to-bark'
      ImageIndex = 1
      ExplicitWidth = 625
      ExplicitHeight = 445
      object ChartWoodDensityDist: TChart
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 626
        Height = 108
        Title.Text.Strings = (
          '')
        Title.Visible = False
        BottomAxis.Grid.Visible = False
        BottomAxis.Title.Caption = 'Distance from pith (mm)'
        LeftAxis.Grid.Visible = False
        LeftAxis.MinorTickCount = 0
        LeftAxis.Title.Caption = 'Wood density (kg/m'#179')'
        RightAxis.Automatic = False
        RightAxis.AutomaticMinimum = False
        RightAxis.Grid.Visible = False
        RightAxis.Title.Angle = 90
        RightAxis.Title.Caption = 'Microfibril angle (deg)'
        View3D = False
        OnAfterDraw = ChartWoodDensityDistAfterDraw
        Align = alTop
        Color = clWhite
        TabOrder = 0
        ExplicitWidth = 619
        object Series9: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          SeriesColor = clGreen
          Title = 'Actual'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
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
          Title = 'Modelled'
          LinePen.Color = clBlue
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series6: TBarSeries
          BarPen.Visible = False
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          Title = 'Annual rings'
          AutoMarkPosition = False
          BarWidthPercent = 1
          Dark3D = False
          DepthPercent = 1
          Gradient.Direction = gdTopBottom
          Shadow.Color = 8487297
          SideMargins = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Bar'
          YValues.Order = loNone
        end
      end
      object ChartMFADist: TChart
        AlignWithMargins = True
        Left = 3
        Top = 117
        Width = 626
        Height = 335
        Title.Text.Strings = (
          '')
        Title.Visible = False
        BottomAxis.Grid.Visible = False
        BottomAxis.Title.Caption = 'Distance from pith (mm)'
        LeftAxis.Grid.Visible = False
        LeftAxis.Title.Caption = 'Microfibril angle (degrees)'
        View3D = False
        Align = alClient
        Color = clWhite
        TabOrder = 1
        ExplicitWidth = 619
        ExplicitHeight = 325
        object Series11: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          SeriesColor = clGreen
          Title = 'Actual'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series8: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          Title = 'Modelled'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series12: TBarSeries
          BarPen.Color = clYellow
          BarPen.Visible = False
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Callout.Length = 8
          Marks.Visible = False
          SeriesColor = clBlack
          Title = 'Annual rings'
          BarWidthPercent = 1
          DepthPercent = 1
          Gradient.Direction = gdTopBottom
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Bar'
          YValues.Order = loNone
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Tracheid radial diameter and wall thickness pith-to-bark'
      ImageIndex = 2
      ExplicitWidth = 625
      ExplicitHeight = 445
      object ChartTRDDist: TChart
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 626
        Height = 202
        Title.Text.Strings = (
          'TChart')
        Title.Visible = False
        AxisBehind = False
        BottomAxis.Grid.Visible = False
        BottomAxis.Title.Caption = 'Distance from pith (mm)'
        DepthAxis.Automatic = False
        DepthAxis.AutomaticMaximum = False
        DepthAxis.AutomaticMinimum = False
        DepthAxis.Maximum = 0.500000000000000100
        DepthAxis.Minimum = -0.500000000000000000
        DepthTopAxis.Automatic = False
        DepthTopAxis.AutomaticMaximum = False
        DepthTopAxis.AutomaticMinimum = False
        DepthTopAxis.Maximum = 0.500000000000000100
        DepthTopAxis.Minimum = -0.500000000000000000
        LeftAxis.Grid.Visible = False
        LeftAxis.Title.Caption = 'Tracheid radial diameter ('#181'm)'
        RightAxis.Grid.Visible = False
        RightAxis.Title.Angle = 90
        View3D = False
        Align = alTop
        Color = clWhite
        TabOrder = 0
        ExplicitWidth = 619
        object Series4: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          SeriesColor = clGreen
          Title = 'Actual'
          LinePen.Color = clBlue
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
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
          Title = 'Modelled'
          LinePen.Color = clGreen
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series2: TBarSeries
          BarPen.Visible = False
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          SeriesColor = clBlue
          Title = 'Annual rings'
          AutoMarkPosition = False
          BarWidthPercent = 1
          DepthPercent = 1
          Gradient.Direction = gdTopBottom
          Shadow.Visible = False
          SideMargins = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Bar'
          YValues.Order = loNone
        end
      end
      object ChartTWTDist: TChart
        AlignWithMargins = True
        Left = 3
        Top = 211
        Width = 626
        Height = 241
        Title.Text.Strings = (
          'TChart')
        Title.Visible = False
        BottomAxis.Grid.Visible = False
        BottomAxis.Title.Caption = 'Distance from pith (mm)'
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
        LeftAxis.Grid.Visible = False
        LeftAxis.Title.Caption = 'Tracheid wall thickness ('#181'm)'
        RightAxis.Automatic = False
        RightAxis.AutomaticMaximum = False
        RightAxis.AutomaticMinimum = False
        View3D = False
        Align = alClient
        Color = clWhite
        TabOrder = 1
        ExplicitWidth = 619
        ExplicitHeight = 231
        object Series13: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          SeriesColor = clGreen
          Title = 'Actual'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series14: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          Title = 'Modelled'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series15: TBarSeries
          BarPen.Visible = False
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Callout.Length = 8
          Marks.Visible = False
          SeriesColor = -1
          Title = 'Annual rings'
          BarWidthPercent = 1
          DepthPercent = 1
          Gradient.Direction = gdTopBottom
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Bar'
          YValues.Order = loNone
        end
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 33
    Width = 201
    Height = 489
    Align = alLeft
    TabOrder = 1
    ExplicitHeight = 479
    object gbSSData: TGroupBox
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 193
      Height = 245
      Align = alTop
      Caption = 'Individual samples (pith-to-bark plot)'
      TabOrder = 0
      object lbSSDataSets: TListBox
        AlignWithMargins = True
        Left = 5
        Top = 18
        Width = 183
        Height = 222
        Align = alClient
        ItemHeight = 13
        TabOrder = 0
        OnClick = lbSSDataSetsClick
        OnKeyDown = lbSSDataSetsKeyDown
      end
    end
    object gbSSDataRingMeans: TGroupBox
      AlignWithMargins = True
      Left = 4
      Top = 255
      Width = 193
      Height = 230
      Align = alClient
      Caption = 'Ring mean datasets (ring year plot)'
      TabOrder = 1
      ExplicitHeight = 220
      object lbRingMeanDataSets: TListBox
        AlignWithMargins = True
        Left = 5
        Top = 18
        Width = 183
        Height = 207
        Align = alClient
        ItemHeight = 13
        TabOrder = 0
        OnClick = lbRingMeanDataSetsClick
        OnKeyDown = lbRingMeanDataSetsKeyDown
        ExplicitHeight = 197
      end
    end
  end
  object Panel4: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 841
    Height = 27
    Align = alTop
    Alignment = taLeftJustify
    Caption = 'Click on the name of an available dataset to view data'
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 2
    ExplicitWidth = 834
    object Image3: TImage
      Left = 617
      Top = 1
      Width = 223
      Height = 25
      Align = alRight
      Picture.Data = {
        0954506E67496D61676589504E470D0A1A0A0000000D49484452000001380000
        00360806000000530285AE000000017352474200AECE1CE90000000467414D41
        0000B18F0BFC6105000000097048597300000EC300000EC301C76FA864000005
        9F4944415478DAED9C3B76DB4614401F779105582972BC026A05E102DCA6A34A
        ABC902724EBA34746975695DA5225760ADC095C9BD28104510BFF9BC1910BFA7
        7B4B49F8BCCF5C0C8081562F050200609015820300AB203800300B820300B320
        3800300B820300B3203800300B820300B3203800300B820300B3203800300B82
        0300B3203800300B820300B3203800300B8283E1387D91FBBB477996B5EC8EDF
        E5F387A94F084C12E8B374C17DB917797CEE71366B91E2248466B74F0FC19D0E
        F772F75FBF3EDBFD551CF397A9930083B364C19D8AE3DD298EB7DE1DE5FBA053
        84833CAC36F234CAB18CB020C1B5FB2CB5C6CDED99B18E0A82BB01D724166CF7
        F2F2F5F7E18E6585050BAE28B2EC5FBE8AAACAF5DE28B7DEBF082D32122604B7
        DE159B7D1EE6CEF6F020ABCD796E1618880B9CC1A9E21A90250A6EBD96F5F3F3
        5956DA3A5FB7DD6E65FBF474EE11043722082EC2D422188AA9E35AA4E076B2FF
        F44D36EA9EAB2E7CDBFD5E64B3417063E3EBB3E2E708EE95A945301453C7B550
        C11DFF15F9E372CB19155599E3737FFE2AFFAC10DCE8F8FAECB5369605E77A7E
        57BFED883EDF6B1CF354847E276FA7D2BE75A97E5736F6E1612567B738F72535
        F994449EF974FEBEDCACFB3C302DAEC6869D67491A397A9F5F2D5570456E8E65
        FD82CF5BDB3D71ACCDE60282CBC97342FD9D71D58F14E85FEF6DB9B796EDDEAF
        66B4EE6365C62FE97DF6FAF746055725DD790697A40F22B8DD4E7E3CB68B572F
        C89FF2D37B6EAE22371B46BCFBADE4982EB870BEDE0EE11A48E1735B6FB7224F
        4F8B14DC07CDECF73AB0CAFC1F2282CBC9737AFD35C76AF6F08D04E7EAFD463C
        E3F6995DC1799BF32DC1DF3EB58AA8BA95D309EE1A656CA6588F27F886F6525C
        57FCB5ABBAB33195B7A8D56CB3FB77F5736F0FDAFA2CB5F1BBCE157A818253BC
        543A74667961C1E5E539B3FE4963E036822BF1CD5E47EFB3393D83AB82489C8D
        388A5BBDD5522EE7B8B1E0BA056EFEDED544559C09CB13C435C812E352DC463A
        2F32B5E6720F8A7ACCDD7DFBEA7DDD7A20C145FBAC1663B826A5CCEAB1050497
        9BE7CCFAA78D81DB09CE7B6B3E499F9DE62238FF49F6129C76E67043C1F91A24
        DABC992F0482FB55EC5335A8AEFBA906BA4AC8AA41E13EB76104A7E833CFE06A
        0F5C77DEFC82CBCD736EFDD3C6C08D041790E9347D36A365222957D638ED69B3
        F601EE84828B5EE122CF2F3205D7791912C4D178A1BA04625AC20CCE3F78BB2F
        952E7BF70A2E37CFB58C24D63F650CDC4670A1758353F5D96C04E7A3CF5B5457
        52F39F554D273855738C2CB8EB76998D1763FA6770811C7A675AC3082EBBFEA2
        1D03F3155CDF3E332DB86E02CAFCB5A6D273165C7D79406849485FC1257E7EF6
        6E04D779D920815A2B0497FA995F9FFA3B6B218E7D8D28B891FBEC7D08AEBDAF
        F69577C6828B157894677029B954C4A4DAFF6C04D78AF5F89BFCED8DA9E73338
        07BDEA1F8AB351B7E10537559FBD2BC1853EE9880FC48905E7B9F205078026AE
        C083745D2E356BBE962D38E7C2D4C87A2DFF5BD4B43CF7AABF3BD08C0B69F84D
        A5467053F59941C15D02FED86E885A22DAFB8ABE8A6E6E3FA6E0A2EBA3AE690D
        0F4CEDF391D0334ADFE2D0CEB9995807D7F8AD72AD97761D9C3ECF79F54F1F03
        F5E334CE2D5A4BA5E032E3EFDB67B3FF8FBEDA7F97545DE1E2ABA563EBD4AA7C
        A57FC970FB970C9195ECE57FBF500ECC6E5C8A635C376BC5E6FCE4A69EE7F2E3
        F3F97FE3AB5FC6738ECC73BB14FB922127CF39F5BFE118B8FEBDAF967AC14DD1
        67060577DE4A39B01B470A7E8D30F53291EE5BA8CBDFC9653B6F6CB1B81A0771
        7FEF185C97E5C875E76B00038253FDBBAC98E0F2F39C5EFF9C3110FA86DA57CB
        14C1E5C79FDB67B3171C00402E080E00CC82E000C02C080E00CC82E000C02C08
        0E00CC82E000C02C080E00CC82E000C02C080E00CC82E000C02C080E00CC82E0
        00C02C080E00CC82E000C02C080E00CC82E000C02C080E00CC82E000C02CFF03
        C6D85D1946EDB27F0000000049454E44AE426082}
      Stretch = True
      ExplicitLeft = 616
    end
  end
end
