unit ModellingHeight;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TformModellingHeight = class(TForm)
    leHeight1: TLabeledEdit;
    leHeight2: TLabeledEdit;
    leHeight3: TLabeledEdit;
    bbnClose: TBitBtn;
    procedure bbnCloseClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formModellingHeight: TformModellingHeight;

implementation

{$R *.dfm}

procedure TformModellingHeight.bbnCloseClick(Sender: TObject);
begin
  formModellingHeight.CloseQuery;
end;

procedure TformModellingHeight.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  try
    strtofloat(leHeight1.Text);
    strtofloat(leHeight2.Text);
    strtofloat(leHeight2.Text);
    if (strtofloat(leHeight2.Text) > strtofloat(leHeight1.Text)) and
      (strtofloat(leHeight3.Text) > strtofloat(leHeight2.Text))then begin
      CanClose := True;
    end else begin
      messagedlg('Modelling heights must increase from 1 to 3.  To ignore heights 2 and 3 in the model run,' +
        ' enter values above 9999',mtError,[mbOK],0);
      CanClose := False;
    end;
  except
    messagedlg('Only numbers can be entered',mtError,[mbOK],0);
    CanClose := False;
  end;

end;

end.
