object formSummaryGraphsType: TformSummaryGraphsType
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Summary graphs type'
  ClientHeight = 162
  ClientWidth = 236
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
  object rgSummaryGraphsType: TRadioGroup
    Left = 8
    Top = 8
    Width = 217
    Height = 105
    Caption = 'Select data to view'
    ItemIndex = 0
    Items.Strings = (
      'Wood properties data'
      'Daily growth and developmental data')
    TabOrder = 0
  end
  object bbnSummaryGraphsType: TBitBtn
    Left = 80
    Top = 129
    Width = 75
    Height = 25
    Caption = 'OK'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 1
    OnClick = bbnSummaryGraphsTypeClick
  end
end
