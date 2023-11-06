unit SetSegmentWidth;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TformSegmentWidth = class(TForm)
    bbnSegmentWidth: TBitBtn;
    Label1: TLabel;
    cmbSegmentLength: TComboBox;
    procedure bbnSegmentWidthClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formSegmentWidth: TformSegmentWidth;

implementation

{$R *.dfm}

procedure TformSegmentWidth.bbnSegmentWidthClick(Sender: TObject);
begin
  formSegmentWidth.Close
end;

procedure TformSegmentWidth.FormShow(Sender: TObject);
begin
  cmbSegmentLength.Text := cmbSegmentLength.Items[cmbSegmentLength.Itemindex];
end;

end.
