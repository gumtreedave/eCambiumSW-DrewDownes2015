object formBoardGrades: TformBoardGrades
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Board grades'
  ClientHeight = 258
  ClientWidth = 285
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
  object sgBoardGrades: TStringGrid
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 279
    Height = 194
    Align = alClient
    ColCount = 2
    FixedCols = 0
    RowCount = 6
    Options = [goFixedVertLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 0
    OnSelectCell = sgBoardGradesSelectCell
    ExplicitWidth = 531
  end
  object Panel1: TPanel
    Left = 0
    Top = 200
    Width = 285
    Height = 58
    Align = alBottom
    TabOrder = 1
    ExplicitWidth = 537
    object bbnOK: TBitBtn
      Left = 11
      Top = 16
      Width = 89
      Height = 25
      Caption = 'Save changes'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 0
      OnClick = bbnOKClick
    end
    object bbnCancel: TBitBtn
      Left = 184
      Top = 16
      Width = 89
      Height = 25
      Caption = 'Cancel'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 1
      OnClick = bbnCancelClick
    end
  end
end
