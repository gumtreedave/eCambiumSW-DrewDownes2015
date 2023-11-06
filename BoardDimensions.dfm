object formBoardDimensions: TformBoardDimensions
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Set board dimensions'
  ClientHeight = 334
  ClientWidth = 184
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 0
    Width = 161
    Height = 172
    Caption = 'Cant boards'
    TabOrder = 0
    object leCantWidth: TLabeledEdit
      Left = 16
      Top = 40
      Width = 130
      Height = 21
      EditLabel.Width = 79
      EditLabel.Height = 13
      EditLabel.Caption = 'Cant width (mm)'
      NumbersOnly = True
      TabOrder = 0
      Text = '100'
    end
    object leCantBoardCount: TLabeledEdit
      Left = 16
      Top = 88
      Width = 130
      Height = 21
      EditLabel.Width = 131
      EditLabel.Height = 13
      EditLabel.Caption = 'Number of adjacent boards'
      Enabled = False
      NumbersOnly = True
      TabOrder = 1
      Text = '1'
    end
    object leBoardWidthCant: TLabeledEdit
      Left = 16
      Top = 134
      Width = 130
      Height = 21
      EditLabel.Width = 102
      EditLabel.Height = 13
      EditLabel.Caption = 'Board thickness (mm)'
      NumbersOnly = True
      TabOrder = 2
      Text = '40'
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 178
    Width = 161
    Height = 117
    Caption = 'Wing boards'
    TabOrder = 1
    object leBoardWidthWing: TLabeledEdit
      Left = 16
      Top = 84
      Width = 130
      Height = 21
      EditLabel.Width = 102
      EditLabel.Height = 13
      EditLabel.Caption = 'Board thickness (mm)'
      NumbersOnly = True
      TabOrder = 1
      Text = '40'
    end
    object leBoardHeightWing: TLabeledEdit
      Left = 16
      Top = 36
      Width = 130
      Height = 21
      EditLabel.Width = 86
      EditLabel.Height = 13
      EditLabel.Caption = 'Board Width (mm)'
      NumbersOnly = True
      TabOrder = 0
      Text = '100'
    end
  end
  object bbnOK: TBitBtn
    Left = 56
    Top = 301
    Width = 75
    Height = 25
    Caption = 'OK'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 2
    OnClick = bbnOKClick
  end
end
