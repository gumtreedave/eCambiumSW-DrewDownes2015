unit ScenarioType;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;

type
  TformScenarioType = class(TForm)
    rgScenarioType: TRadioGroup;
    bbnScenarioType: TBitBtn;
    bbnExit: TBitBtn;
    procedure bbnScenarioTypeClick(Sender: TObject);
    procedure bbnExitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formScenarioType: TformScenarioType;

implementation

uses LinkCABALAScenario, CreateCAMBIUMScenario;

{$R *.dfm}

procedure TformScenarioType.bbnExitClick(Sender: TObject);
begin
  close;
end;

procedure TformScenarioType.bbnScenarioTypeClick(Sender: TObject);
begin
  formScenarioType.close;
  formScenarioType.Visible := false;

  case rgScenarioType.ItemIndex of
    0 : formCreateCAMBIUMScenario.showmodal;
    1: formLinkCABALAScenario.showmodal;
  end;

end;

end.
