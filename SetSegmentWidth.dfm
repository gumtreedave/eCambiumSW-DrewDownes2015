object formSegmentWidth: TformSegmentWidth
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Set segment length'
  ClientHeight = 111
  ClientWidth = 163
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
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 143
    Height = 13
    Caption = 'Set the segment length (mm):'
  end
  object bbnSegmentWidth: TBitBtn
    Left = 48
    Top = 64
    Width = 75
    Height = 25
    Caption = 'OK'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 0
    OnClick = bbnSegmentWidthClick
  end
  object cmbSegmentLength: TComboBox
    Left = 10
    Top = 27
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 2
    TabOrder = 1
    Text = '0.20'
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
      '0.95'
      '1.00')
  end
end
