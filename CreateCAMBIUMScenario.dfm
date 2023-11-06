object formCreateCAMBIUMScenario: TformCreateCAMBIUMScenario
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Add or edit an e-Cambium scenario'
  ClientHeight = 326
  ClientWidth = 310
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
  object Label1: TLabel
    Left = 72
    Top = 46
    Width = 22
    Height = 13
    Caption = 'Site:'
  end
  object Label2: TLabel
    Left = 8
    Top = 86
    Width = 86
    Height = 13
    Caption = 'Weather dataset:'
  end
  object Label3: TLabel
    Left = 46
    Top = 126
    Width = 51
    Height = 13
    Caption = 'Genotype:'
  end
  object Label4: TLabel
    Left = 14
    Top = 166
    Width = 80
    Height = 13
    Caption = 'Rotation regime:'
  end
  object Label5: TLabel
    Left = 43
    Top = 206
    Width = 51
    Height = 13
    Caption = 'Tree type:'
  end
  object Label6: TLabel
    Left = 8
    Top = 246
    Width = 87
    Height = 13
    Caption = 'Stem position (m):'
  end
  object leScenarioName: TLabeledEdit
    Left = 100
    Top = 8
    Width = 193
    Height = 21
    EditLabel.Width = 74
    EditLabel.Height = 13
    EditLabel.Caption = 'Scenario name:'
    LabelPosition = lpLeft
    TabOrder = 0
  end
  object cmbSite: TComboBox
    Left = 100
    Top = 46
    Width = 193
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 1
  end
  object cmbWeather: TComboBox
    Left = 100
    Top = 86
    Width = 193
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 2
  end
  object cmbSpecies: TComboBox
    Left = 100
    Top = 126
    Width = 193
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 3
  end
  object cmbRegime: TComboBox
    Left = 100
    Top = 166
    Width = 193
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 4
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 282
    Width = 304
    Height = 41
    Align = alBottom
    TabOrder = 7
    object bbnOK: TBitBtn
      Left = 11
      Top = 8
      Width = 109
      Height = 25
      Caption = 'OK'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 0
      OnClick = bbnOKClick
    end
    object bbnCancel: TBitBtn
      Left = 181
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
  object cmbTreeType: TComboBox
    Left = 100
    Top = 206
    Width = 193
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 5
    Text = 'Average'
    Items.Strings = (
      'Average')
  end
  object cmbStemPosition: TComboBox
    Left = 100
    Top = 246
    Width = 193
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 6
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
end
