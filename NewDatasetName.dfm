object formNewDatasetName: TformNewDatasetName
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'New dataset'
  ClientHeight = 110
  ClientWidth = 195
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
  object leNewDatasetName: TLabeledEdit
    Left = 8
    Top = 24
    Width = 179
    Height = 21
    EditLabel.Width = 172
    EditLabel.Height = 13
    EditLabel.Caption = 'Specify a name for the new dataset'
    MaxLength = 50
    TabOrder = 0
  end
  object bbnOK: TBitBtn
    Left = 64
    Top = 67
    Width = 75
    Height = 25
    Caption = 'OK'
    DoubleBuffered = True
    ModalResult = 1
    ParentDoubleBuffered = False
    TabOrder = 1
    OnClick = bbnOKClick
  end
end
