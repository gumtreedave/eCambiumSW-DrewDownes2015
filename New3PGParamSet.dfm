object formNew3PGParamSet: TformNew3PGParamSet
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Create a parameter set'
  ClientHeight = 104
  ClientWidth = 186
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
    Width = 173
    Height = 13
    Caption = 'Select an associated parameter set:'
  end
  object cmbExistingParamSets: TComboBox
    Left = 8
    Top = 24
    Width = 170
    Height = 21
    Style = csDropDownList
    ItemHeight = 0
    TabOrder = 0
  end
  object bbnOK: TBitBtn
    Left = 56
    Top = 64
    Width = 75
    Height = 25
    Caption = 'OK'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 1
    OnClick = bbnOKClick
  end
end
