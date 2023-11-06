object formScenarioType: TformScenarioType
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Specify scenario type'
  ClientHeight = 180
  ClientWidth = 239
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
  object rgScenarioType: TRadioGroup
    Left = 8
    Top = 8
    Width = 217
    Height = 105
    ItemIndex = 0
    Items.Strings = (
      'Create a new e-Cambium scenario'
      'Link to an existing CaBala scenario')
    TabOrder = 0
  end
  object bbnScenarioType: TBitBtn
    Left = 150
    Top = 136
    Width = 75
    Height = 25
    Caption = 'Next'
    DoubleBuffered = True
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333333333333333333333333333333333333333333333
      3333333333333333333333333333333333333333333FF3333333333333003333
      3333333333773FF3333333333309003333333333337F773FF333333333099900
      33333FFFFF7F33773FF30000000999990033777777733333773F099999999999
      99007FFFFFFF33333F7700000009999900337777777F333F7733333333099900
      33333333337F3F77333333333309003333333333337F77333333333333003333
      3333333333773333333333333333333333333333333333333333333333333333
      3333333333333333333333333333333333333333333333333333}
    NumGlyphs = 2
    ParentDoubleBuffered = False
    TabOrder = 1
    OnClick = bbnScenarioTypeClick
  end
  object bbnExit: TBitBtn
    Left = 8
    Top = 136
    Width = 75
    Height = 25
    Caption = 'Close'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 2
    OnClick = bbnExitClick
  end
end
