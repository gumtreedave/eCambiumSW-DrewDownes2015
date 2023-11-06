unit ColourChoice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TformColourCHoice = class(TForm)
    ColorDialog1: TColorDialog;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formColourCHoice: TformColourCHoice;

implementation

{$R *.dfm}

procedure TformColourCHoice.BitBtn1Click(Sender: TObject);
begin
  ColorDIalog1.Execute;
end;

end.
