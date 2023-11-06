unit DataSetName;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons,ADODB,DataModule;

type
  TformDatasetName = class(TForm)
    lblEditDSName: TLabeledEdit;
    bbnNext: TBitBtn;
    bbnBack: TBitBtn;
    procedure bbnNextClick(Sender: TObject);
    procedure bbnBackClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formDatasetName: TformDatasetName;

implementation

uses SelectDataType, ProjectManager;

{$R *.dfm}

procedure TformDatasetName.bbnBackClick(Sender: TObject);
begin
  formDataSetName.Close;
  formSelectDataType.showmodal;
end;

Function GetDataSetNameField(TableName : string):string;
begin
  if TableName = ProjectManager.SITESTABLE
    then Result := ProjectManager.SITENAMEFIELD;

end;

Function NewNameOK(CurrentADOQuery: TADOQuery;
  CurrentTableName : string;
  ProposedName : string):boolean;

var
  SQLString : string;
  DatasetNameField : string;
  NameTest : string;
begin
    Result := true;

    DataSetNameField := GetDataSetNameField(CurrentTableName);

    SQLString := '';
    SQLString := 'SELECT DISTINCT([' +
    DataSetNameField +
    ']) FROM ' + CurrentTableName;
    CurrentADOQuery.SQL.Add(SQLString);
    CurrentADOQuery.Active := true;

    CurrentADOQuery.First;

    while not CurrentADOQuery.Eof do begin
      NameTest := CurrentADOQuery.FieldByName(DataSetNameField).AsString;
      if NameTest = ProposedName  then
        Result := False;
    end;

end;

procedure TformDatasetName.bbnNextClick(Sender: TObject);

begin
  if lbleditdsName.Text <> '' then begin
    if NewNameOK(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
      SelectDataType.GetDataSetTableName(formSelectDataType.rgDataTypes.ItemIndex),
      lbleditdsName.Text) = True then
      formDataSetName.Close;

  end else
    messagedlg('Specify a name for the new dataset',mtError,[mbOK],0);
end;



end.
