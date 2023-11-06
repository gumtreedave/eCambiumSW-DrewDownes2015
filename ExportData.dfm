object formExportData: TformExportData
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Export data to text file'
  ClientHeight = 179
  ClientWidth = 213
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
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 125
    Height = 13
    Caption = 'Select the data to export:'
  end
  object Label2: TLabel
    Left = 8
    Top = 82
    Width = 143
    Height = 13
    Caption = 'Select the scenario to export:'
  end
  object cmbDataType: TComboBox
    Left = 8
    Top = 35
    Width = 193
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    Items.Strings = (
      'Wood property profiles'
      'Daily growth and developmental data'
      'All scenario summaries'
      'Hypothetical board output')
  end
  object bbnExportData: TBitBtn
    Left = 60
    Top = 136
    Width = 91
    Height = 25
    Caption = 'Export data'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 1
    OnClick = bbnExportDataClick
  end
  object cmbScenario: TComboBox
    Left = 8
    Top = 101
    Width = 191
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 2
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '*.csv'
    Filter = 'Comma delimited files|*.csv'
    OnCanClose = SaveDialog1CanClose
    Left = 24
    Top = 120
  end
end
