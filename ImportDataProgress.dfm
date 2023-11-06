object formImportDataProgress: TformImportDataProgress
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Import progress'
  ClientHeight = 75
  ClientWidth = 260
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
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 147
    Height = 13
    Caption = 'Importing data.  Please wait...'
  end
  object ProgressBar1: TProgressBar
    Left = 16
    Top = 43
    Width = 225
    Height = 17
    TabOrder = 0
  end
end
