object formSelectDataType: TformSelectDataType
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Select data type'
  ClientHeight = 274
  ClientWidth = 203
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object rgDataTypes: TRadioGroup
    Left = 8
    Top = 8
    Width = 185
    Height = 227
    ItemIndex = 0
    Items.Strings = (
      'Site data'
      'Regime information'
      'Weather data'
      'CAMBIUM parameters'
      '3PG parameters')
    TabOrder = 0
  end
  object bbnNext: TBitBtn
    Left = 110
    Top = 241
    Width = 85
    Height = 25
    Caption = 'Next'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 1
    OnClick = bbnNextClick
  end
  object bbnBack: TBitBtn
    Left = 8
    Top = 241
    Width = 85
    Height = 25
    Caption = 'Back'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 2
  end
end
