unit RunInitialisation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons,Chart,General,DiagnosticGraphs,inifiles;

type
  TformInitialisation = class(TForm)
    gbInitialisation: TGroupBox;
    leCZWidth: TLabeledEdit;
    leRadDiam: TLabeledEdit;
    leTanDiam: TLabeledEdit;
    leLength: TLabeledEdit;
    leXprop: TLabeledEdit;
    bbnClose: TBitBtn;
    procedure bbnCloseClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    Procedure UpdateInitialValues;
    procedure FormCreate(Sender: TObject);
    Procedure ReadivINIFileIntoForm(PathName: String);

  private
    { Private declarations }
  public
    { Public declarations }
  end;



var
  formInitialisation: TformInitialisation;

const
  DEFAULTCZWIDTH = 10;
  DEFAULTRD = 12;
  DEFAULTTD = 30;
  DEFAULTLENGTH = 1750;
  DEFAULTPROP = 75;
  IVINIFILE = 'iv.ini';

implementation

{$R *.dfm}

Function InitialisationFieldsOK(ICZ: Integer;
  IRD : Integer;
  ITD: Integer;
  IL: Integer;
  IXP: Integer):Boolean;
begin
  Result := False;

  if (ICZ < 50) and (ICZ>0)  then begin
    if (IRD > 0) and (ITD > 0) and (IL > 0) then begin
      if (IXP >0) and (IXP < 101) then begin
        Result := True
      end else begin
        Result := False;
        //Messagedlg('Initial site water availability cannot exceed 1000
        Messagedlg('Proportion of xylem to phloem and initials must be between 1 and 100%',mtError,[mbOK],0);
      end;
    end else
      messagedlg('Cells must have a starting size greater than zero',mtError,[mbOK],0);
  end else
    messagedlg('The initial cambial zone must be greater than 0 and less than 50 cells wide',mtError,[mbOK],0);
end;

procedure TformInitialisation.bbnCloseClick(Sender: TObject);
var
  ivINI : TIniFile;

begin

  if initialisationFieldsOK(strtoint(leCZWidth.Text),
    strtoint(leRadDiam.text),strtoint(leTanDiam.Text),strtoint(leLength.Text),
    strtoint(leXProp.Text)) then begin

    ivINI := TINIFile.Create(ExtractFilePath(Application.EXEName) + IVINIFILE);

    try
      ivINI.writestring('Initial','CZ Width',leCZWidth.Text);
      ivINI.writestring('Initial','Cambial cell RD',leRadDiam.Text);
      ivINI.writestring('Initial','Cambial cell TD',leTanDiam.Text);
      ivINI.writestring('Initial','Cambial cell L',leLength.Text);
      ivINI.writestring('Initial','XMC proportion',leXProp.Text);

    finally
      ivINI.Free;

    end;
    close;
  end;

end;


procedure TformInitialisation.FormCreate(Sender: TObject);
begin
  UpdateInitialValues;
end;

procedure TformInitialisation.FormDestroy(Sender: TObject);
begin
   if initialisationFieldsOK(strtoint(leCZWidth.Text),
    strtoint(leRadDiam.text),strtoint(leTanDiam.Text),strtoint(leLength.Text),
    strtoint(leXProp.Text)) then close;
end;

procedure TformInitialisation.FormShow(Sender: TObject);

begin
  UpdateInitialValues;
end;

Procedure TformInitialisation.UpdateInitialValues;
begin
  ReadivINIFileIntoForm(ExtractFilePath(Application.EXEName) + IVINIFILE);
end;

Procedure TformInitialisation.ReadivINIFileIntoForm(PathName: String);
var
  ivINI : TInifile;
begin
  ivINI := TINIFile.Create(PathName);

  try
    leCZWidth.Text :=  ivINI.ReadString('Initial','CZ Width',inttostr(DEFAULTCZWIDTH));
    leRadDiam.Text :=  ivINI.ReadString('Initial','Cambial cell RD',inttostr(DEFAULTRD));
    leTanDiam.Text :=  ivINI.ReadString('Initial','Cambial cell TD',inttostr(DEFAULTTD));
    leLength.Text :=  ivINI.ReadString('Initial','Cambial cell L',inttostr(DEFAULTLENGTH));
    leXProp.Text :=  ivINI.ReadString('Initial','XMC proportion',inttostr(DEFAULTPROP));

  finally
    ivINI.Free;
  end;

end;

end.
