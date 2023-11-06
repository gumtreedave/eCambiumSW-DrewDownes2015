object formAbout: TformAbout
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'About e-Cambium'
  ClientHeight = 364
  ClientWidth = 457
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 71
    Width = 451
    Height = 243
    Align = alClient
    Lines.Strings = (
      'e-Cambium '#169' CSIRO 2013'
      ''
      
        'e-Cambium is a process-based modelling system designed to provid' +
        'e forest '
      
        'managers with a tool to predict the effect of changes in environ' +
        'mental '
      
        'conditions or management approaches on wood properties, particul' +
        'arly wood '
      
        'density.  The model can utilise either inputs from the CaBala st' +
        'and growth '
      
        'model or it can predict both growth and wood property variation ' +
        'together '
      
        'from a set of input daily weather, basic site and regime data us' +
        'ing an internal'
      
        'growth model based on 3PG.  The present version is still a proto' +
        'type,'
      'undergoing ongoing testing and adjustments.'
      ''
      'For further information or assistance please contact:'
      ''
      'David Drew (CSIRO Ecosystem Sciences)'
      'david.drew@csiro.au'
      '(03) 6237 5617 '
      ''
      'or'
      ''
      'Geoff Downes (Forest Quality)'
      'geoff.downes@forestquality.com'
      ''
      '******************************************'
      ''
      'Important changes since V1.0'
      ''
      '1. Changes to main graphics output window'
      '2. Various small bugs in the GUI fixed and new features added'
      '3. Bug fixed on the setting of EZ/CZ ratio'
      '4. Adjustment in timing of earlywood/latewood transition'
      '5. Adjustment in development of latewood differentiation zone'
      
        '6. Final carbohydrate content no longer recycled in the developi' +
        'ng zone'
      
        '7. Increased sensitivity of relative soil water content to dry z' +
        'ones'
      ''
      '')
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 320
    Width = 451
    Height = 41
    Align = alBottom
    TabOrder = 1
    object bbnOK: TBitBtn
      Left = 192
      Top = 8
      Width = 75
      Height = 25
      Caption = 'OK'
      TabOrder = 0
      OnClick = bbnOKClick
    end
  end
  object Panel2: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 451
    Height = 62
    Align = alTop
    TabOrder = 2
    object LabelVersion: TLabel
      Left = 16
      Top = 12
      Width = 58
      Height = 13
      Caption = 'Version: 1.4'
    end
    object labelCompileDate: TLabel
      Left = 16
      Top = 38
      Width = 66
      Height = 13
      Caption = 'Compile date:'
    end
  end
end
