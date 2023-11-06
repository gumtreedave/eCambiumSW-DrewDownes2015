unit BoardDimensions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons,INIFiles;

type
  TformBoardDimensions = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    leCantWidth: TLabeledEdit;
    leCantBoardCount: TLabeledEdit;
    leBoardWidthWing: TLabeledEdit;
    leBoardHeightWing: TLabeledEdit;
    leBoardWidthCant: TLabeledEdit;
    bbnOK: TBitBtn;
    procedure bbnOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    Procedure ReadbdINIFileIntoForm(PathName: String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formBoardDimensions: TformBoardDimensions;

const
  BDINIFILE = 'bd.ini';

implementation

{$R *.dfm}

procedure TformBoardDimensions.bbnOKClick(Sender: TObject);
var
  bdINI : TIniFile;

begin
  close;

  bdINI := TINIFile.Create(ExtractFilePath(Application.EXEName) + BDINIFILE);

  try
    bdINI.writestring('Cant boards','Width',formBoardDimensions.leCantWidth.Text);
    bdINI.writestring('Cant boards','Number',formBoardDimensions.leCantBoardCount.Text);
    bdINI.writestring('Cant boards','Thickness',formBoardDimensions.leBoardWidthCant.Text);

    bdINI.writestring('Wing boards','Width',formBoardDimensions.leBoardHeightWing.Text);
    bdINI.writestring('Wing boards','Thickness',formBoardDimensions.leBoardWidthWing.Text);

  finally
    bdINI.Free;
  end;

  close;

end;

procedure TformBoardDimensions.FormShow(Sender: TObject);
begin
  ReadbdINIFileIntoForm(ExtractFilePath(Application.EXEName) + BDINIFILE);
end;


Procedure TformBoardDimensions.ReadbdINIFileIntoForm(PathName: String);
var
  bdIni : TIniFile;
begin
    bdINI := TINIFile.Create(PathName);

    formBoardDimensions.leCantWidth.Text := bdINI.readstring('Cant boards','Width','100');
    formBoardDimensions.leCantBoardCount.Text := bdINI.readstring('Cant boards','Number','1');
    formBoardDimensions.leBoardWidthCant.Text := bdINI.readstring('Cant boards','Thickness','40');

    formBoardDimensions.leBoardHeightWing.Text := bdINI.readstring('Wing boards','Width','100');
    formBoardDimensions.leBoardWidthWing.Text := bdINI.readstring('Wing boards','Thickness','40');

    bdini.Free;

end;

end.
