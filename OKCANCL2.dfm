object OKRightDlg: TOKRightDlg
  Left = 227
  Top = 108
  BorderStyle = bsDialog
  Caption = 'New dataset'
  ClientHeight = 109
  ClientWidth = 202
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object OKBtn: TButton
    Left = 8
    Top = 64
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object CancelBtn: TButton
    Left = 112
    Top = 64
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object leNewDatasetName: TLabeledEdit
    Left = 8
    Top = 24
    Width = 179
    Height = 21
    EditLabel.Width = 172
    EditLabel.Height = 13
    EditLabel.Caption = 'Specify a name for the new dataset'
    MaxLength = 50
    TabOrder = 2
  end
end
