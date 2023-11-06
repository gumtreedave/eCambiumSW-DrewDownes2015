object FormSummaryStats: TFormSummaryStats
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Summary statistic'
  ClientHeight = 334
  ClientWidth = 204
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object rgSummaryStats: TRadioGroup
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 198
    Height = 118
    Align = alTop
    BiDiMode = bdLeftToRight
    Caption = 'Select summary statistic to view'
    ItemIndex = 0
    Items.Strings = (
      'Whole core mean'
      'Outer core mean'
      'Inner core mean')
    ParentBiDiMode = False
    TabOrder = 0
    WordWrap = True
    OnClick = rgSummaryStatsClick
    ExplicitWidth = 310
  end
  object Panel2: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 290
    Width = 198
    Height = 41
    Align = alBottom
    TabOrder = 1
    ExplicitWidth = 310
    object bbnOK: TBitBtn
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 190
      Height = 33
      Align = alClient
      Caption = 'OK'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 0
      OnClick = bbnOKClick
      ExplicitWidth = 302
    end
  end
  object Panel3: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 127
    Width = 198
    Height = 157
    Align = alClient
    TabOrder = 2
    ExplicitWidth = 310
    object GroupBox1: TGroupBox
      AlignWithMargins = True
      Left = 4
      Top = 86
      Width = 190
      Height = 67
      Align = alBottom
      TabOrder = 0
      ExplicitWidth = 302
      object leSummaryWidth: TLabeledEdit
        Left = 11
        Top = 32
        Width = 174
        Height = 21
        EditLabel.Width = 119
        EditLabel.Height = 13
        EditLabel.Caption = 'Zone width (mm or rings)'
        NumbersOnly = True
        TabOrder = 0
        Text = '50'
        OnChange = leSummaryWidthChange
      end
    end
    object rgSummaryType: TRadioGroup
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 190
      Height = 76
      Align = alClient
      Caption = 'Specify how to summarise the data'
      ItemIndex = 0
      Items.Strings = (
        'Average by distance'
        'Average by ring number')
      TabOrder = 1
      ExplicitWidth = 302
    end
  end
end
