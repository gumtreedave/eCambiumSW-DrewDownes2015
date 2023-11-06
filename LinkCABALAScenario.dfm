object formLinkCABALAScenario: TformLinkCABALAScenario
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Link to a CaBala scenario'
  ClientHeight = 351
  ClientWidth = 341
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
  object Label2: TLabel
    Left = 14
    Top = 195
    Width = 128
    Height = 13
    Caption = 'e-Cambium parameter set:'
  end
  object Label5: TLabel
    Left = 91
    Top = 235
    Width = 51
    Height = 13
    Caption = 'Tree type:'
  end
  object Label6: TLabel
    Left = 55
    Top = 274
    Width = 87
    Height = 13
    Caption = 'Stem position (m):'
  end
  object cmbCAMBIUMParamSpecies: TComboBox
    Left = 148
    Top = 192
    Width = 185
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
  end
  object cmbTreeType: TComboBox
    Left = 148
    Top = 232
    Width = 185
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 1
    Text = 'Average'
    Items.Strings = (
      'Average')
  end
  object cmbStemPosition: TComboBox
    Left = 148
    Top = 271
    Width = 185
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 2
    Items.Strings = (
      '0.1'
      '0.2'
      '0.3'
      '0.4'
      '0.5'
      '0.6'
      '0.7'
      '0.8'
      '0.9'
      '1'
      '1.1'
      '1.2'
      '1.3'
      '1.4'
      '1.5'
      '1.6'
      '1.7'
      '1.8'
      '1.9'
      '2'
      '2.1'
      '2.2'
      '2.3'
      '2.4'
      '2.5'
      '2.6'
      '2.7'
      '2.8'
      '2.9'
      '3'
      '3.1'
      '3.2'
      '3.3'
      '3.4'
      '3.5'
      '3.6'
      '3.7'
      '3.8'
      '3.9'
      '4'
      '4.1'
      '4.2'
      '4.3'
      '4.4'
      '4.5'
      '4.6'
      '4.7'
      '4.8'
      '4.9'
      '5'
      '5.1'
      '5.2'
      '5.3'
      '5.4'
      '5.5'
      '5.6'
      '5.7'
      '5.8'
      '5.9'
      '6'
      '6.1'
      '6.2'
      '6.3'
      '6.4'
      '6.5'
      '6.6'
      '6.7'
      '6.8'
      '6.9'
      '7'
      '7.1'
      '7.2'
      '7.3'
      '7.4'
      '7.5'
      '7.6'
      '7.7'
      '7.8'
      '7.9'
      '8'
      '8.1'
      '8.2'
      '8.3'
      '8.4'
      '8.5'
      '8.6'
      '8.7'
      '8.8'
      '8.9'
      '9'
      '9.1'
      '9.2'
      '9.3'
      '9.4'
      '9.5'
      '9.6'
      '9.7'
      '9.8'
      '9.9'
      '10'
      '10.1'
      '10.2'
      '10.3'
      '10.4'
      '10.5'
      '10.6'
      '10.7'
      '10.8'
      '10.9'
      '11'
      '11.1'
      '11.2'
      '11.3'
      '11.4'
      '11.5'
      '11.6'
      '11.7'
      '11.8'
      '11.9'
      '12'
      '12.1'
      '12.2'
      '12.3'
      '12.4'
      '12.5'
      '12.6'
      '12.7'
      '12.8'
      '12.9'
      '13'
      '13.1'
      '13.2'
      '13.3'
      '13.4'
      '13.5'
      '13.6'
      '13.7'
      '13.8'
      '13.9'
      '14'
      '14.1'
      '14.2'
      '14.3'
      '14.4'
      '14.5'
      '14.6'
      '14.7'
      '14.8'
      '14.9'
      '15'
      '20'
      '25'
      '30'
      '35')
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 307
    Width = 335
    Height = 41
    Align = alBottom
    TabOrder = 3
    object bbnLinkCABALAScenario: TBitBtn
      Left = 15
      Top = 8
      Width = 109
      Height = 25
      Caption = 'OK'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 0
      OnClick = bbnLinkCABALAScenarioClick
    end
    object bbnCancel: TBitBtn
      Left = 195
      Top = 8
      Width = 109
      Height = 25
      Caption = 'Cancel'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 1
      OnClick = bbnCancelClick
    end
  end
  object Panel2: TPanel
    Left = 8
    Top = -9
    Width = 325
    Height = 195
    TabOrder = 4
    object GroupBox1: TGroupBox
      Left = 14
      Top = 49
      Width = 299
      Height = 104
      Caption = 'Select a CaBala scenario by opening an existing mbc file:'
      TabOrder = 0
      object bbnOpenCABALAProject: TBitBtn
        Left = 10
        Top = 28
        Width = 279
        Height = 25
        Caption = 'Browse for CaBala project'
        DoubleBuffered = True
        Glyph.Data = {
          16020000424D160200000000000076000000280000001A0000001A0000000100
          040000000000A001000000000000000000001000000010000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
          8888888888888800000088888888888888888888888888000000888888888888
          8888888888888800000088888888888888888888888888000000888800000000
          00000008888888000000888800FBFBFBFBFBFB08888888000000888800BFBFBF
          BFBFBF088888880002208888070BFBFBFBFBFBF088888840440888880B0FBFBF
          BFBFBFB08888880000008888070BFBFBFBFBFBF088888800022188880B70BFBF
          BFBFBFBF08888884804C888807B0FBFBFBFBFBFB08888800000088880B700000
          00000000088888001010888807B7B7B0AEA0B0888888882462208888000B7B00
          0AEA008808888800000088888880008880AEA080088888001010888888888888
          880AEA0A088888A684228888888888888880AEAE088888222226888888888888
          88880AEA0888880000008888888888888880AEAE08888874657F888888888888
          880000000888889505D188888888888888888888888888000000888888888888
          888888888888885CE74788888888888888888888888888000000888888888888
          8888888888888800000088888888888888888888888888105100}
        ParentDoubleBuffered = False
        TabOrder = 0
        OnClick = bbnOpenCABALAProjectClick
      end
      object cmbCABALAScenarios: TComboBox
        Left = 10
        Top = 72
        Width = 279
        Height = 21
        AutoDropDown = True
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 1
      end
    end
    object leScenarioName: TLabeledEdit
      Left = 96
      Top = 22
      Width = 217
      Height = 21
      EditLabel.Width = 74
      EditLabel.Height = 13
      EditLabel.Caption = 'Scenario name:'
      LabelPosition = lpLeft
      TabOrder = 1
    end
    object cbUseAll: TCheckBox
      Left = 63
      Top = 163
      Width = 210
      Height = 17
      Caption = 'Use all scenarios in the CaBala project'
      TabOrder = 2
      OnClick = cbUseAllClick
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.mbc'
    Filter = 'CaBala files|*.mbc'
    OnCanClose = OpenDialog1CanClose
    Left = 32
    Top = 200
  end
end
