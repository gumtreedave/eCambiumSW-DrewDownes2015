object formDatasetName: TformDatasetName
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Dataset name'
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
  object lblEditDSName: TLabeledEdit
    Left = 8
    Top = 32
    Width = 187
    Height = 21
    EditLabel.Width = 176
    EditLabel.Height = 13
    EditLabel.Caption = 'Specify a name for the new dataset:'
    MaxLength = 50
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
    OnClick = bbnBackClick
  end
end
