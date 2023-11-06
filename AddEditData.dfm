object formAddEditData: TformAddEditData
  Left = 0
  Top = 0
  Caption = 'Add or edit input datasets'
  ClientHeight = 520
  ClientWidth = 796
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poMainFormCenter
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pcDataAddEdit: TPageControl
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 790
    Height = 514
    ActivePage = tsWeather
    Align = alClient
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnChange = pcDataAddEditChange
    object tsParams: TTabSheet
      Caption = 'Modelling parameters'
      ImageIndex = 3
      OnShow = tsParamsShow
      object gbCAMBIUMParams: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 214
        Height = 480
        Align = alLeft
        Color = clInfoBk
        ParentBackground = False
        ParentColor = False
        TabOrder = 0
        object rgParamsTypes: TRadioGroup
          AlignWithMargins = True
          Left = 5
          Top = 18
          Width = 204
          Height = 70
          Align = alTop
          Caption = 'Select model component'
          ItemIndex = 0
          Items.Strings = (
            'Wood properties model'
            'Stand growth model')
          TabOrder = 0
          OnClick = rgParamsTypesClick
        end
        object lbParamSets: TListBox
          AlignWithMargins = True
          Left = 5
          Top = 94
          Width = 204
          Height = 220
          Align = alClient
          ItemHeight = 13
          Items.Strings = (
            'Existing parameter sets:'
            'None')
          TabOrder = 1
          OnClick = lbParamSetsClick
        end
        object GroupBox4: TGroupBox
          AlignWithMargins = True
          Left = 5
          Top = 320
          Width = 204
          Height = 155
          Align = alBottom
          TabOrder = 2
          object bbnCreateNewParams: TBitBtn
            AlignWithMargins = True
            Left = 5
            Top = 18
            Width = 194
            Height = 25
            Hint = 'e-Cambium will create a default parameter set'
            Align = alTop
            Caption = 'Create a new parameter set'
            DoubleBuffered = True
            ParentDoubleBuffered = False
            TabOrder = 0
            OnClick = bbnCreateNewParamsClick
          end
          object bbnDeleteParams: TBitBtn
            AlignWithMargins = True
            Left = 5
            Top = 80
            Width = 194
            Height = 25
            Align = alTop
            Caption = 'Delete selected'
            DoubleBuffered = True
            ParentDoubleBuffered = False
            TabOrder = 1
            OnClick = bbnDeleteParamsClick
          end
          object bbnSaveParams: TBitBtn
            AlignWithMargins = True
            Left = 5
            Top = 111
            Width = 194
            Height = 25
            Align = alTop
            Caption = 'Save changes'
            DoubleBuffered = True
            ParentDoubleBuffered = False
            TabOrder = 2
            OnClick = bbnSaveParamsClick
          end
          object bbnCopyParams: TBitBtn
            AlignWithMargins = True
            Left = 5
            Top = 49
            Width = 194
            Height = 25
            Hint = 'Copy the currently selected parameter set'
            Align = alTop
            Caption = 'Copy selected parameter set'
            DoubleBuffered = True
            ParentDoubleBuffered = False
            TabOrder = 3
            OnClick = bbnCopyParamsClick
          end
        end
      end
      object dbgParams: TDBGrid
        AlignWithMargins = True
        Left = 223
        Top = 3
        Width = 556
        Height = 480
        Align = alClient
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
    end
    object tsSite: TTabSheet
      Caption = 'Site information'
      OnShow = tsSiteShow
      object PanelSite: TPanel
        AlignWithMargins = True
        Left = 223
        Top = 3
        Width = 556
        Height = 480
        Align = alClient
        Color = clMoneyGreen
        ParentBackground = False
        TabOrder = 0
        object GroupBox5: TGroupBox
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 548
          Height = 105
          Align = alTop
          TabOrder = 0
          object Label6: TLabel
            Left = 19
            Top = 27
            Width = 90
            Height = 13
            Caption = 'Site latitude (deg):'
          end
          object cmbSiteLat: TComboBox
            Left = 19
            Top = 47
            Width = 160
            Height = 21
            Hint = 'Site latitude in degrees S (-ve degrees)'
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 0
            Items.Strings = (
              '0'
              '-1'
              '-2'
              '-3'
              '-4'
              '-5'
              '-6'
              '-7'
              '-8'
              '-9'
              '-10'
              '-11'
              '-12'
              '-13'
              '-14'
              '-15'
              '-16'
              '-17'
              '-18'
              '-19'
              '-20'
              '-21'
              '-22'
              '-23'
              '-24'
              '-25'
              '-26'
              '-27'
              '-28'
              '-29'
              '-30'
              '-31'
              '-32'
              '-33'
              '-34'
              '-35'
              '-36'
              '-37'
              '-38'
              '-39'
              '-40'
              '-41'
              '-42'
              '-43'
              '-44'
              '-45'
              '-46'
              '-47'
              '-48'
              '-49'
              '-50')
          end
        end
        object GroupBox6: TGroupBox
          AlignWithMargins = True
          Left = 4
          Top = 115
          Width = 548
          Height = 105
          Align = alTop
          Caption = 'Soil texture and fertility rating'
          TabOrder = 1
          object Label3: TLabel
            Left = 22
            Top = 28
            Width = 110
            Height = 13
            Caption = #39'Dominant'#39' soil texture:'
          end
          object Label7: TLabel
            Left = 256
            Top = 32
            Width = 86
            Height = 13
            Caption = 'Site fertility rating'
          end
          object cmbSoilTexture: TComboBox
            Left = 22
            Top = 49
            Width = 160
            Height = 21
            Hint = 
              'This refers to the texture class expected in the uppermost layer' +
              '/s of soil where most rooting would be expected'
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 0
            Items.Strings = (
              'Sand'
              'Loamy sand'
              'Sandy loam'
              'Loam'
              'Silt loam'
              'Sandy clay loam'
              'Clay loam'
              'Silty clay loam'
              'Sandy clay'
              'Silty clay'
              'Clay')
          end
          object cmbSiteFR: TComboBox
            Left = 256
            Top = 49
            Width = 160
            Height = 21
            Hint = 
              'A site FR of 0 would be a site where the soil is completely infe' +
              'rtile (incapable of supporting growth).  A site FR of 1 would be' +
              ' the most fertile soil possible.  Typical values for forest soil' +
              's are between about 0.25 and 0.6'
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 1
            Items.Strings = (
              '0.10'
              '0.15'
              '0.20'
              '0.25'
              '0.30'
              '0.35'
              '0.40'
              '0.45'
              '0.50'
              '0.55'
              '0.60'
              '0.65'
              '0.70'
              '0.75'
              '0.80'
              '0.85'
              '0.90'
              '0.95'
              '1.00')
          end
        end
        object GroupBox7: TGroupBox
          AlignWithMargins = True
          Left = 4
          Top = 226
          Width = 548
          Height = 231
          Align = alTop
          Caption = 'Soil depth and water availability'
          TabOrder = 2
          object Label2: TLabel
            Left = 19
            Top = 33
            Width = 70
            Height = 13
            Caption = 'Soil depth (m):'
          end
          object cmbSoilDepth: TComboBox
            Left = 19
            Top = 58
            Width = 160
            Height = 21
            Hint = 'The depth that the roots will explore in m'
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 0
            Items.Strings = (
              '0.5'
              '1'
              '1.5'
              '2'
              '2.5'
              '3'
              '3.5'
              '4'
              '4.5'
              '5'
              '5.5'
              '6'
              '6.5'
              '7'
              '7.5'
              '8'
              '8.5'
              '9'
              '9.5'
              '10'
              '10.5'
              '11'
              '11.5'
              '12'
              '12.5'
              '13'
              '13.5'
              '14'
              '14.5'
              '15')
          end
          object leMaxASW: TLabeledEdit
            Left = 256
            Top = 124
            Width = 160
            Height = 21
            Hint = 'This refers to soil water content at field capacity'
            EditLabel.Width = 153
            EditLabel.Height = 13
            EditLabel.Caption = 'Max available soil water (mm/m)'
            NumbersOnly = True
            TabOrder = 3
            Text = '0'
            OnChange = leMaxASWChange
          end
          object leMinASW: TLabeledEdit
            Left = 256
            Top = 58
            Width = 160
            Height = 21
            Hint = 
              'This refers to soil water content at or near permanent wilting p' +
              'oint'
            EditLabel.Width = 149
            EditLabel.Height = 13
            EditLabel.Caption = 'Min available soil water (mm/m)'
            NumbersOnly = True
            TabOrder = 1
            Text = '0'
            OnChange = leMinASWChange
          end
          object leInitialASW: TLabeledEdit
            Left = 19
            Top = 124
            Width = 160
            Height = 21
            Hint = 
              'This is the soil water content at the time of stand establishmen' +
              't'
            EditLabel.Width = 159
            EditLabel.Height = 13
            EditLabel.Caption = 'Initial available soil water (mm/m)'
            TabOrder = 2
            Text = '0'
            OnChange = leInitialASWChange
          end
        end
      end
      object Panel5: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 214
        Height = 480
        Align = alLeft
        Color = clMoneyGreen
        ParentBackground = False
        TabOrder = 1
        object GroupBox2: TGroupBox
          AlignWithMargins = True
          Left = 4
          Top = 336
          Width = 206
          Height = 140
          Align = alBottom
          TabOrder = 1
          object bbnSaveSite: TBitBtn
            AlignWithMargins = True
            Left = 5
            Top = 80
            Width = 196
            Height = 25
            Align = alTop
            Caption = 'Save changes'
            DoubleBuffered = True
            ParentDoubleBuffered = False
            TabOrder = 2
            OnClick = bbnSaveSiteClick
          end
          object bbnDeleteSite: TBitBtn
            AlignWithMargins = True
            Left = 5
            Top = 49
            Width = 196
            Height = 25
            Align = alTop
            Caption = 'Delete selected site'
            DoubleBuffered = True
            ParentDoubleBuffered = False
            TabOrder = 1
            OnClick = bbnDeleteSiteClick
          end
          object bbnCreateNewSite: TBitBtn
            AlignWithMargins = True
            Left = 5
            Top = 18
            Width = 196
            Height = 25
            Align = alTop
            Caption = 'Create a new site'
            DoubleBuffered = True
            ParentDoubleBuffered = False
            TabOrder = 0
            OnClick = bbnCreateNewSiteClick
          end
        end
        object lbSiteNames: TListBox
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 206
          Height = 326
          Align = alClient
          ItemHeight = 13
          TabOrder = 0
          OnClick = lbSiteNamesClick
        end
      end
    end
    object tsRegime: TTabSheet
      Caption = 'Regime information'
      ImageIndex = 1
      OnShow = tsRegimeShow
      object PanelStartStop: TPanel
        AlignWithMargins = True
        Left = 225
        Top = 3
        Width = 130
        Height = 480
        Align = alLeft
        Color = clGradientInactiveCaption
        ParentBackground = False
        TabOrder = 0
        object Label4: TLabel
          Left = 18
          Top = 20
          Width = 95
          Height = 13
          Caption = 'Establishment date:'
        end
        object Label5: TLabel
          Left = 18
          Top = 76
          Width = 67
          Height = 13
          Caption = 'Harvest date:'
        end
        object labelRotationLength: TLabel
          Left = 18
          Top = 136
          Width = 78
          Height = 13
          Caption = 'Rotation length:'
          WordWrap = True
        end
        object Label1: TLabel
          Left = 71
          Top = 211
          Width = 45
          Height = 13
          Caption = 'stems/Ha'
        end
        object DateTimePicker1: TDateTimePicker
          Left = 18
          Top = 39
          Width = 96
          Height = 21
          Hint = 'The date on which the stand was planted'
          Date = 40963.000000000000000000
          Time = 40963.000000000000000000
          MinDate = 2.000000000000000000
          TabOrder = 0
          OnChange = DateTimePicker1Change
        end
        object DateTimePicker2: TDateTimePicker
          Left = 18
          Top = 95
          Width = 96
          Height = 21
          Hint = 'The date on which the simulation will terminate'
          Date = 40963.000000000000000000
          Time = 40963.000000000000000000
          MinDate = 3.000000000000000000
          TabOrder = 1
          OnChange = DateTimePicker2Change
        end
        object leInitialSpacing: TLabeledEdit
          Left = 18
          Top = 208
          Width = 47
          Height = 21
          Hint = 'The number of trees/Ha at time of planting'
          EditLabel.Width = 94
          EditLabel.Height = 13
          EditLabel.Caption = 'Initial stand density'
          NumbersOnly = True
          TabOrder = 2
          Text = '1200'
          OnChange = leInitialSpacingChange
        end
      end
      object PanelControls: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 216
        Height = 480
        Align = alLeft
        Color = clGradientActiveCaption
        ParentBackground = False
        TabOrder = 1
        object lbRegimeNames: TListBox
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 208
          Height = 198
          Align = alClient
          ItemHeight = 13
          TabOrder = 0
          OnClick = lbRegimeNamesClick
        end
        object GroupBox1: TGroupBox
          AlignWithMargins = True
          Left = 4
          Top = 208
          Width = 208
          Height = 268
          Align = alBottom
          TabOrder = 1
          object bbnSaveRegime: TBitBtn
            AlignWithMargins = True
            Left = 5
            Top = 238
            Width = 198
            Height = 25
            Align = alBottom
            Caption = 'Save changes'
            DoubleBuffered = True
            ParentDoubleBuffered = False
            TabOrder = 0
            OnClick = bbnSaveRegimeClick
          end
          object GroupBox8: TGroupBox
            AlignWithMargins = True
            Left = 5
            Top = 18
            Width = 198
            Height = 119
            Align = alTop
            Caption = 'Regime'
            TabOrder = 1
            object bbnAddRegime: TBitBtn
              AlignWithMargins = True
              Left = 5
              Top = 18
              Width = 188
              Height = 25
              Hint = 
                'Create a new silvilcultural regime (it will use the currently sp' +
                'ecified dates and initial stand density)'
              Align = alTop
              Caption = 'Create a new regime'
              DoubleBuffered = True
              ParentDoubleBuffered = False
              TabOrder = 0
              OnClick = bbnAddRegimeClick
            end
            object bbnDeleteRegime: TBitBtn
              AlignWithMargins = True
              Left = 5
              Top = 80
              Width = 188
              Height = 25
              Align = alTop
              Caption = 'Delete selected regime'
              DoubleBuffered = True
              ParentDoubleBuffered = False
              TabOrder = 1
              OnClick = bbnDeleteRegimeClick
            end
            object bbnCopyRegime: TBitBtn
              AlignWithMargins = True
              Left = 5
              Top = 49
              Width = 188
              Height = 25
              Hint = 'Copy all events in the currently selected regime'
              Align = alTop
              Caption = 'Copy selected regime'
              DoubleBuffered = True
              ParentDoubleBuffered = False
              TabOrder = 2
              OnClick = bbnCopyRegimeClick
            end
          end
          object GroupBox9: TGroupBox
            AlignWithMargins = True
            Left = 5
            Top = 143
            Width = 198
            Height = 85
            Align = alTop
            Caption = 'Event'
            TabOrder = 2
            object bbnAddEvent: TBitBtn
              AlignWithMargins = True
              Left = 5
              Top = 18
              Width = 188
              Height = 25
              Hint = 'Add a silvilcultural event to the regime (e.g. a thinning)'
              Align = alTop
              Caption = 'Add a new event'
              DoubleBuffered = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentDoubleBuffered = False
              ParentFont = False
              TabOrder = 0
              OnClick = bbnAddEventClick
            end
            object bbnDeleteEvent: TBitBtn
              AlignWithMargins = True
              Left = 5
              Top = 49
              Width = 188
              Height = 25
              Align = alTop
              Caption = 'Delete selected event'
              DoubleBuffered = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentDoubleBuffered = False
              ParentFont = False
              TabOrder = 1
              OnClick = bbnDeleteEventClick
            end
          end
        end
      end
      object sgRegimeEvents: TStringGrid
        AlignWithMargins = True
        Left = 361
        Top = 3
        Width = 418
        Height = 480
        Align = alClient
        ColCount = 4
        FixedCols = 0
        RowCount = 1
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
        TabOrder = 2
        OnDrawCell = sgRegimeEventsDrawCell
      end
    end
    object tsWeather: TTabSheet
      Caption = 'Weather data'
      ImageIndex = 3
      OnShow = tsWeatherShow
      object Panel1: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 776
        Height = 480
        Align = alClient
        Color = clGray
        ParentBackground = False
        TabOrder = 0
        object Panel2: TPanel
          AlignWithMargins = True
          Left = 224
          Top = 4
          Width = 548
          Height = 472
          Align = alClient
          Color = clActiveBorder
          ParentBackground = False
          TabOrder = 0
          object DBChartSREvap: TDBChart
            Left = 1
            Top = 251
            Width = 546
            Height = 220
            Title.Text.Strings = (
              'TDBChart')
            Title.Visible = False
            DepthAxis.Automatic = False
            DepthAxis.AutomaticMaximum = False
            DepthAxis.AutomaticMinimum = False
            DepthAxis.Maximum = 1.010000000000000000
            DepthAxis.Minimum = 0.010000000000000060
            DepthTopAxis.Automatic = False
            DepthTopAxis.AutomaticMaximum = False
            DepthTopAxis.AutomaticMinimum = False
            DepthTopAxis.Maximum = 1.010000000000000000
            DepthTopAxis.Minimum = 0.010000000000000060
            LeftAxis.Grid.Visible = False
            LeftAxis.Title.Caption = 'Solar radiation (MJ/m'#178')'
            Legend.Alignment = laTop
            RightAxis.Grid.Visible = False
            RightAxis.Title.Angle = 90
            RightAxis.Title.Caption = 'Pan evaporation (mm)'
            View3D = False
            Zoom.Pen.Color = clSkyBlue
            Align = alClient
            Color = clWhite
            TabOrder = 0
            object Series4: TLineSeries
              Marks.Arrow.Visible = True
              Marks.Callout.Brush.Color = clBlack
              Marks.Callout.Arrow.Visible = True
              Marks.Visible = False
              SeriesColor = 33023
              Title = 'Solar radiation'
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
              SeriesColor = clBlue
              Title = 'Pan evaporation'
              VertAxis = aRightAxis
              Pointer.InflateMargins = True
              Pointer.Style = psRectangle
              Pointer.Visible = False
              XValues.Name = 'X'
              XValues.Order = loAscending
              YValues.Name = 'Y'
              YValues.Order = loNone
            end
          end
          object dbchartraintemp: TDBChart
            Left = 1
            Top = 1
            Width = 546
            Height = 250
            Title.Text.Strings = (
              'TDBChart')
            Title.Visible = False
            LeftAxis.Grid.Visible = False
            LeftAxis.Title.Caption = 'Rainfall (mm)'
            Legend.Alignment = laTop
            RightAxis.Grid.Visible = False
            RightAxis.Title.Angle = 90
            RightAxis.Title.Caption = 'Temperature ('#176'C)'
            View3D = False
            Zoom.Pen.Color = clSkyBlue
            Align = alTop
            Color = clWhite
            TabOrder = 1
            object Series1: TBarSeries
              BarPen.Visible = False
              Marks.Arrow.Visible = True
              Marks.Callout.Brush.Color = clBlack
              Marks.Callout.Arrow.Visible = True
              Marks.Visible = False
              SeriesColor = 4210816
              Title = 'Rainfall'
              Gradient.Direction = gdTopBottom
              Shadow.Color = 8684676
              XValues.DateTime = True
              XValues.Name = 'X'
              XValues.Order = loAscending
              YValues.Name = 'Bar'
              YValues.Order = loNone
            end
            object Series2: TLineSeries
              Marks.Arrow.Visible = True
              Marks.Callout.Brush.Color = clBlack
              Marks.Callout.Arrow.Visible = True
              Marks.Visible = False
              SeriesColor = 12615680
              Title = 'Minimum temperature'
              VertAxis = aRightAxis
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
              Title = 'Maximum temperature'
              VertAxis = aRightAxis
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
        object Panel3: TPanel
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 214
          Height = 472
          Align = alLeft
          Color = clActiveBorder
          ParentBackground = False
          TabOrder = 1
          object GroupBox3: TGroupBox
            AlignWithMargins = True
            Left = 4
            Top = 356
            Width = 206
            Height = 112
            Align = alBottom
            TabOrder = 1
            object bbnImportCustomWeatherData: TBitBtn
              AlignWithMargins = True
              Left = 5
              Top = 49
              Width = 196
              Height = 25
              Align = alTop
              Caption = 'Import new custom data'
              DoubleBuffered = True
              ParentDoubleBuffered = False
              TabOrder = 1
              OnClick = bbnImportCustomWeatherDataClick
            end
            object bbnImportSILO: TBitBtn
              AlignWithMargins = True
              Left = 5
              Top = 18
              Width = 196
              Height = 25
              Hint = 
                'Import SILO space-delimited data with format: "Date,Day,T.Max,Sm' +
                'x,T.Min,Smn,Rain,Srn,Evap,Sev,Radn,Ssl,VP,Svp,RHmaxT,RHminT,Date' +
                '2"'
              Align = alTop
              Caption = 'Import new SILO data'
              DoubleBuffered = True
              ParentDoubleBuffered = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              OnClick = bbnImportSILOClick
            end
            object bbnDeleteWeatherDS: TBitBtn
              AlignWithMargins = True
              Left = 5
              Top = 80
              Width = 196
              Height = 25
              Align = alTop
              Caption = 'Delete selected dataset'
              DoubleBuffered = True
              ParentDoubleBuffered = False
              TabOrder = 2
              OnClick = bbnDeleteWeatherDSClick
            end
          end
          object lbWeatherDatasets: TListBox
            AlignWithMargins = True
            Left = 4
            Top = 4
            Width = 206
            Height = 346
            Align = alClient
            ItemHeight = 13
            TabOrder = 0
            OnClick = lbWeatherDatasetsClick
          end
        end
      end
    end
  end
  object OpenDialogSILO: TOpenDialog
    DefaultExt = '*.txt'
    Filter = 'Text files|*.txt'
    Title = 'Select SILO data file'
    Left = 176
    Top = 352
  end
  object dsAddEditParams: TDataSource
    Left = 312
    Top = 88
  end
  object dsAddEditWeatherData: TDataSource
    DataSet = DataModuleBoard.ADOQueryWeatherDisplay
    Left = 312
    Top = 208
  end
  object MainMenu1: TMainMenu
    Left = 512
    Top = 136
    object Import1: TMenuItem
      Caption = 'Import'
      object DatafromaneCambiumproject1: TMenuItem
        Caption = 'Data from an e-Cambium project'
        OnClick = DatafromaneCambiumproject1Click
      end
    end
  end
end
