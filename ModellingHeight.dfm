object formModellingHeight: TformModellingHeight
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Set modelling heights'
  ClientHeight = 211
  ClientWidth = 176
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object leHeight1: TLabeledEdit
    Left = 8
    Top = 32
    Width = 160
    Height = 21
    EditLabel.Width = 109
    EditLabel.Height = 13
    EditLabel.Caption = 'Modelling height 1 (m):'
    TabOrder = 0
    Text = '1.3'
  end
  object leHeight2: TLabeledEdit
    Left = 8
    Top = 84
    Width = 160
    Height = 21
    EditLabel.Width = 109
    EditLabel.Height = 13
    EditLabel.Caption = 'Modelling height 2 (m):'
    TabOrder = 1
    Text = '4'
  end
  object leHeight3: TLabeledEdit
    Left = 8
    Top = 136
    Width = 160
    Height = 21
    EditLabel.Width = 109
    EditLabel.Height = 13
    EditLabel.Caption = 'Modelling height 3 (m):'
    TabOrder = 2
    Text = '7.5'
  end
  object bbnClose: TBitBtn
    Left = 56
    Top = 172
    Width = 75
    Height = 25
    Caption = 'Close'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 3
    OnClick = bbnCloseClick
  end
end
