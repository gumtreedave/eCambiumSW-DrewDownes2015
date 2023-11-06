object formEvent: TformEvent
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'New event'
  ClientHeight = 277
  ClientWidth = 254
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
  object rgEventType: TRadioGroup
    Left = 8
    Top = 8
    Width = 233
    Height = 105
    Caption = 'Select an event type'
    ItemIndex = 0
    Items.Strings = (
      'Thinning'
      'Fertilization'
      'Pruning')
    TabOrder = 0
    OnClick = rgEventTypeClick
  end
  object leAge: TLabeledEdit
    Left = 8
    Top = 136
    Width = 233
    Height = 21
    EditLabel.Width = 171
    EditLabel.Height = 13
    EditLabel.Caption = 'Stand age at time of event (years):'
    TabOrder = 1
  end
  object leValue: TLabeledEdit
    Left = 8
    Top = 176
    Width = 233
    Height = 21
    EditLabel.Width = 168
    EditLabel.Height = 13
    EditLabel.Caption = 'Residual stand density (stems/Ha):'
    TabOrder = 2
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 203
    Width = 248
    Height = 71
    Align = alBottom
    TabOrder = 3
    object bbnCreateEvent: TBitBtn
      Left = 8
      Top = 24
      Width = 75
      Height = 25
      Caption = 'Add event'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 0
      OnClick = bbnCreateEventClick
    end
    object bbnCancel: TBitBtn
      Left = 166
      Top = 24
      Width = 75
      Height = 25
      Caption = 'Finish'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 1
      OnClick = bbnCancelClick
    end
  end
end
