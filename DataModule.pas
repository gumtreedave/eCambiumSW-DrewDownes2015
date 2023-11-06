unit DataModule;

interface

uses
  SysUtils, Classes, OleServer, ADOMD_TLB, Dialogs, ADODB, DB, ADOX_TLB;

type
  TDataModuleBoard = class(TDataModule)
    Catalog1: TCatalog;
    ADOConnectionCAMBIUM: TADOConnection;
    ADOCommandCAMBIUM: TADOCommand;
    ADOConnectionCABALA: TADOConnection;
    ADOCommandCABALA: TADOCommand;
    ADOQueryCAMBIUM: TADOQuery;
    ADOQueryCABALA: TADOQuery;
    ADOTableInputParam: TADOTable;
    ADOTableOutputDataSegments: TADOTable;
    ADOTableCAMBIUMGeneral: TADOTable;
    ADOQueryWeatherDisplay: TADOQuery;
    ADOTableOutputDataDaily: TADOTable;
    ADOConnection_ForImporting: TADOConnection;
    ADOQueryExport: TADOQuery;
    ADOTableAllScenarios: TADOTable;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModuleBoard: TDataModuleBoard;

implementation

uses ProjectManager;

{$R *.dfm}



end.
