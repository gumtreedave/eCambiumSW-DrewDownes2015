unit NewDatasetName;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons,DataObjects,DataModule,General,
  AddEditCAMBIUMParams;

type
  TformNewDatasetName = class(TForm)
    leNewDatasetName: TLabeledEdit;
    bbnOK: TBitBtn;
  procedure bbnOKClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

  Procedure AddNewData;

var
  formNewDatasetName: TformNewDatasetName;
  CurrentTargetTable : string;
  CurrentRelevantField : string;


implementation

uses AddEditData, ProjectManager;

{$R *.dfm}




procedure TformNewDatasetName.bbnOKClick(Sender: TObject);
begin
  ModalResult := mrOK;
  formNewDataSetName.Close;
end;

Procedure AddNewData;
begin
end;


end.
