object formImportWizard: TformImportWizard
  Left = 0
  Top = 0
  Caption = 'Data import wizard'
  ClientHeight = 470
  ClientWidth = 795
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 789
    Height = 212
    Align = alTop
    Caption = 'Select Input Data File'
    TabOrder = 0
    object labelCurrentFile: TLabel
      Left = 16
      Top = 76
      Width = 133
      Height = 13
      Caption = 'Current file: no file selected'
    end
    object sgData: TStringGrid
      AlignWithMargins = True
      Left = 5
      Top = 92
      Width = 779
      Height = 115
      Align = alClient
      RowCount = 3
      TabOrder = 0
    end
    object Panel1: TPanel
      Left = 2
      Top = 15
      Width = 785
      Height = 74
      Align = alTop
      Color = clGradientActiveCaption
      ParentBackground = False
      TabOrder = 1
      object LabelCurrentImportFile: TLabel
        Left = 95
        Top = 21
        Width = 58
        Height = 13
        Caption = 'Current file:'
        WordWrap = True
      end
      object bbnBrowse: TBitBtn
        Left = 14
        Top = 16
        Width = 75
        Height = 25
        Caption = 'Browse'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 0
        OnClick = bbnBrowseClick
      end
    end
  end
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 221
    Width = 789
    Height = 246
    Align = alClient
    Caption = 'Import Data'
    TabOrder = 1
    object Panel2: TPanel
      Left = 2
      Top = 15
      Width = 785
      Height = 63
      Align = alTop
      Color = clMoneyGreen
      ParentBackground = False
      TabOrder = 0
      object Label1: TLabel
        Left = 22
        Top = 12
        Width = 141
        Height = 13
        Caption = 'Specify the target data type:'
      end
      object cmbDataType: TComboBox
        AlignWithMargins = True
        Left = 14
        Top = 28
        Width = 243
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
        OnChange = cmbDataTypeChange
        Items.Strings = (
          'Stand growth data'
          'Weather data'
          'SilviScan profile data (distance-based)'
          'Ring average wood properties data')
      end
      object bbnImportData: TBitBtn
        AlignWithMargins = True
        Left = 704
        Top = 4
        Width = 77
        Height = 55
        Align = alRight
        Caption = 'Import'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 1
        OnClick = bbnImportDataClick
      end
      object leRowstoSkip: TLabeledEdit
        AlignWithMargins = True
        Left = 428
        Top = 28
        Width = 69
        Height = 21
        EditLabel.Width = 131
        EditLabel.Height = 13
        EditLabel.Caption = 'Rows to skip (incl. header):'
        NumbersOnly = True
        TabOrder = 2
        Text = '1'
      end
    end
    object PanelLowerMain: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 81
      Width = 779
      Height = 160
      Align = alClient
      TabOrder = 1
      object sgFieldstoColumns: TStringGrid
        Left = 1
        Top = 1
        Width = 777
        Height = 158
        Hint = 
          'Specify which columns match to the data fields needed by CAMBIUM' +
          ' for the current data set.  /n For example, if column 2 in your ' +
          'input file is the required "date" field, then type "2" next to t' +
          'he field "date" listed in this table.'
        Align = alClient
        ColCount = 3
        DefaultColWidth = 150
        FixedCols = 0
        RowCount = 1
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
        ParentShowHint = False
        ScrollBars = ssVertical
        ShowHint = False
        TabOrder = 0
        OnSelectCell = sgFieldstoColumnsSelectCell
      end
    end
  end
  object odDataFile: TOpenDialog
    Filter = 'Comma delimited files|*.csv'
    OnCanClose = odDataFileCanClose
    Left = 60
    Top = 36
  end
end
