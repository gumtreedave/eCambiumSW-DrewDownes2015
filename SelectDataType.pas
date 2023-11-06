unit SelectDataType;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons,ProjectManager;

type
  TformSelectDataType = class(TForm)
    rgDataTypes: TRadioGroup;
    bbnNext: TBitBtn;
    bbnBack: TBitBtn;
    procedure bbnNextClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  Function GetDataSetTableName(rgCode : Integer):string;

var
  formSelectDataType: TformSelectDataType;

implementation

uses DataSetName;

{$R *.dfm}

Function GetDataSetTableName(rgCode : Integer):string;
begin
  case rgCode of
    0: Result := ProjectManager.SITESTABLE;
    1: Result := ProjectManager.REGIMESTABLE;
    2: Result := ProjectManager.WEATHERDATATABLE;
    3: Result := ProjectManager.CAMBIUMPARAMSTABLE;
    4: Result := ProjectManager.TPGPARAMSTABLE;
  end;
end;

procedure TformSelectDataType.bbnNextClick(Sender: TObject);
begin
  formSelectDataType.Close;
  formDataSetName.showmodal;
end;

end.
