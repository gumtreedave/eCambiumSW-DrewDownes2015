object DataModuleBoard: TDataModuleBoard
  OldCreateOrder = False
  Height = 375
  Width = 673
  object Catalog1: TCatalog
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    Left = 232
    Top = 104
  end
  object ADOConnectionCAMBIUM: TADOConnection
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 64
    Top = 16
  end
  object ADOCommandCAMBIUM: TADOCommand
    Connection = ADOConnectionCAMBIUM
    Parameters = <>
    Left = 48
    Top = 88
  end
  object ADOConnectionCABALA: TADOConnection
    Left = 184
    Top = 16
  end
  object ADOCommandCABALA: TADOCommand
    Connection = ADOConnectionCABALA
    Parameters = <>
    Left = 136
    Top = 112
  end
  object ADOQueryCAMBIUM: TADOQuery
    Connection = ADOConnectionCAMBIUM
    Parameters = <>
    Left = 48
    Top = 192
  end
  object ADOQueryCABALA: TADOQuery
    Connection = ADOConnectionCABALA
    Parameters = <>
    Left = 168
    Top = 192
  end
  object ADOTableInputParam: TADOTable
    Connection = ADOConnectionCAMBIUM
    Left = 568
    Top = 16
  end
  object ADOTableOutputDataSegments: TADOTable
    Connection = ADOConnectionCAMBIUM
    Left = 432
    Top = 88
  end
  object ADOTableCAMBIUMGeneral: TADOTable
    Connection = ADOConnectionCAMBIUM
    Left = 56
    Top = 272
  end
  object ADOQueryWeatherDisplay: TADOQuery
    Connection = ADOConnectionCAMBIUM
    Parameters = <>
    Left = 560
    Top = 152
  end
  object ADOTableOutputDataDaily: TADOTable
    Connection = ADOConnectionCAMBIUM
    Left = 424
    Top = 32
  end
  object ADOConnection_ForImporting: TADOConnection
    LoginPrompt = False
    Left = 392
    Top = 248
  end
  object ADOQueryExport: TADOQuery
    Connection = ADOConnection_ForImporting
    Parameters = <>
    Left = 512
    Top = 280
  end
  object ADOTableAllScenarios: TADOTable
    Connection = ADOConnectionCAMBIUM
    Left = 408
    Top = 192
  end
end
