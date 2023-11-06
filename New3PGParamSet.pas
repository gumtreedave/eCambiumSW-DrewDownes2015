unit New3PGParamSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,General,DataModule,ProjectManager,AddEditCAMBIUMParams;

type
  TformNew3PGParamSet = class(TForm)
    cmbExistingParamSets: TComboBox;
    Label1: TLabel;
    bbnOK: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure bbnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formNew3PGParamSet: TformNew3PGParamSet;

implementation

{$R *.dfm}

procedure TformNew3PGParamSet.bbnOKClick(Sender: TObject);
begin
    if cmbExistingParamSets.Text <> '' then begin

      AddEditCAMBIUMParams.WriteDefaultParamSet(formNew3PGParamSet.cmbExistingParamSets.Text,
        ProjectManager.SPECIESNAMESTABLE,
        ProjectManager.TPGPARAMSTABLE,
        AddEditCAMBIUMParams.DefaultParameterItems_RadiataStand);
      formNew3PGParamSet.Close;

    end else
      Messagedlg('Select an existing CAMBIUM parameter set',mtError,[mbOK],0);

end;

procedure TformNew3PGParamSet.FormShow(Sender: TObject);
var
  MyParamSets : TStringList;
begin
  cmbExistingParamSets.Clear;
  MyParamSets := TStringList.Create;
  try

    General.GetDistinctValuesinField(Datamodule.DataModuleBoard.ADOQueryCAMBIUM,
    ProjectManager.SPECIESNAMESTABLE,
    ProjectManager.SPECIESNAMEFIELD,
    MyParamSets);

    cmbExistingParamSets.Items := myParamSets;
  finally
    MyParamSets.Free;
  end;

end;

end.
