object formImportCambiumProject: TformImportCambiumProject
  Left = 0
  Top = 0
  Caption = 'Import data from an e-Cambium Project'
  ClientHeight = 453
  ClientWidth = 614
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pcDataTypes: TPageControl
    AlignWithMargins = True
    Left = 3
    Top = 93
    Width = 608
    Height = 325
    ActivePage = tsParams
    Align = alClient
    TabOrder = 0
    object tsParams: TTabSheet
      Caption = 'Parameters'
      object lbParams: TListBox
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 594
        Height = 245
        Align = alClient
        Color = clInfoBk
        ItemHeight = 13
        TabOrder = 0
      end
      object Panel3: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 254
        Width = 594
        Height = 40
        Align = alBottom
        TabOrder = 1
        object cbParamsAll: TCheckBox
          Left = 13
          Top = 8
          Width = 97
          Height = 17
          Caption = 'Import all'
          TabOrder = 0
        end
        object bbnImportParams: TBitBtn
          Left = 94
          Top = 8
          Width = 75
          Height = 25
          Caption = 'Import'
          DoubleBuffered = True
          ParentDoubleBuffered = False
          TabOrder = 1
          OnClick = bbnImportParamsClick
        end
      end
    end
    object tsSites: TTabSheet
      Caption = 'Sites'
      ImageIndex = 1
      object lbSites: TListBox
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 594
        Height = 245
        Align = alClient
        Color = clMoneyGreen
        ItemHeight = 13
        TabOrder = 0
      end
      object Panel4: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 254
        Width = 594
        Height = 40
        Align = alBottom
        TabOrder = 1
        object cbSitesAll: TCheckBox
          Left = 13
          Top = 8
          Width = 97
          Height = 17
          Caption = 'Import all'
          TabOrder = 0
        end
        object bbnImportSites: TBitBtn
          Left = 94
          Top = 8
          Width = 75
          Height = 25
          Caption = 'Import'
          DoubleBuffered = True
          ParentDoubleBuffered = False
          TabOrder = 1
          OnClick = bbnImportSitesClick
        end
      end
    end
    object tsRegimes: TTabSheet
      Caption = 'Regimes'
      ImageIndex = 2
      object lbRegimes: TListBox
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 594
        Height = 245
        Align = alClient
        Color = clGradientActiveCaption
        ItemHeight = 13
        TabOrder = 0
      end
      object Panel5: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 254
        Width = 594
        Height = 40
        Align = alBottom
        TabOrder = 1
        object cbRegimesAll: TCheckBox
          Left = 13
          Top = 8
          Width = 97
          Height = 17
          Caption = 'Import all'
          TabOrder = 0
        end
        object bbnImportRegimes: TBitBtn
          Left = 94
          Top = 8
          Width = 75
          Height = 25
          Caption = 'Import'
          DoubleBuffered = True
          ParentDoubleBuffered = False
          TabOrder = 1
          OnClick = bbnImportRegimesClick
        end
      end
    end
    object tsWeather: TTabSheet
      Caption = 'Weather'
      ImageIndex = 3
      object lbWeather: TListBox
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 594
        Height = 245
        Align = alClient
        ItemHeight = 13
        TabOrder = 0
      end
      object Panel6: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 254
        Width = 594
        Height = 40
        Align = alBottom
        TabOrder = 1
        object cbWeatherAll: TCheckBox
          Left = 13
          Top = 8
          Width = 97
          Height = 17
          Caption = 'Import all'
          TabOrder = 0
        end
        object bbnImportWeather: TBitBtn
          Left = 94
          Top = 8
          Width = 75
          Height = 25
          Caption = 'Import'
          DoubleBuffered = True
          ParentDoubleBuffered = False
          TabOrder = 1
          OnClick = bbnImportWeatherClick
        end
      end
    end
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 424
    Width = 608
    Height = 26
    Align = alBottom
    TabOrder = 1
    object pbCambiumDataImport: TProgressBar
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 600
      Height = 18
      Align = alClient
      Min = 8
      Max = 8
      Position = 8
      Step = 1
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 608
    Height = 84
    Align = alTop
    TabOrder = 2
    object GroupBox1: TGroupBox
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 600
      Height = 76
      Align = alClient
      Caption = 'Select an e-Cambium project'
      TabOrder = 0
      object labelFile: TLabel
        Left = 97
        Top = 31
        Width = 58
        Height = 13
        Caption = 'Current file:'
        WordWrap = True
      end
      object bbnBrowse: TBitBtn
        Left = 16
        Top = 26
        Width = 75
        Height = 25
        Caption = 'Browse'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 0
        OnClick = bbnBrowseClick
      end
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.cambium'
    Filter = 'Cambium files|*.cambium'
    Title = 'Open a Cambium project'
    OnCanClose = OpenDialog1CanClose
    Left = 256
    Top = 32
  end
end
