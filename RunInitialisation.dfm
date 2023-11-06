object formInitialisation: TformInitialisation
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Initialise critical variables'
  ClientHeight = 231
  ClientWidth = 484
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object gbInitialisation: TGroupBox
    Left = 8
    Top = 8
    Width = 469
    Height = 173
    Caption = 'Xylem variables'
    TabOrder = 0
    object leCZWidth: TLabeledEdit
      Left = 12
      Top = 32
      Width = 209
      Height = 21
      EditLabel.Width = 161
      EditLabel.Height = 13
      EditLabel.Caption = 'Initial cambial zone width (# cells)'
      NumbersOnly = True
      TabOrder = 0
      Text = '10'
    end
    object leRadDiam: TLabeledEdit
      Left = 12
      Top = 84
      Width = 209
      Height = 21
      EditLabel.Width = 181
      EditLabel.Height = 13
      EditLabel.Caption = 'Initial cambial cell radial diameter (um)'
      NumbersOnly = True
      TabOrder = 1
      Text = '12'
    end
    object leTanDiam: TLabeledEdit
      Left = 12
      Top = 137
      Width = 209
      Height = 21
      EditLabel.Width = 203
      EditLabel.Height = 13
      EditLabel.Caption = 'Initial cambial cell tangential diameter (um)'
      NumbersOnly = True
      TabOrder = 2
      Text = '30'
    end
    object leLength: TLabeledEdit
      Left = 248
      Top = 32
      Width = 209
      Height = 21
      EditLabel.Width = 140
      EditLabel.Height = 13
      EditLabel.Caption = 'Initial cambial cell length (um)'
      NumbersOnly = True
      TabOrder = 3
      Text = '750'
    end
    object leXprop: TLabeledEdit
      Left = 248
      Top = 84
      Width = 209
      Height = 21
      EditLabel.Width = 187
      EditLabel.Height = 13
      EditLabel.Caption = 'Initial xylem mother cell proportion (%)'
      NumbersOnly = True
      TabOrder = 4
      Text = '75'
    end
  end
  object bbnClose: TBitBtn
    Left = 168
    Top = 198
    Width = 151
    Height = 25
    Caption = 'Close and save'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 1
    OnClick = bbnCloseClick
  end
end
