unit BoardGrades;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids,General, Buttons,inifiles;

type
  TformBoardGrades = class(TForm)
    sgBoardGrades: TStringGrid;
    Panel1: TPanel;
    bbnOK: TBitBtn;
    bbnCancel: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure sgBoardGradesSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure bbnOKClick(Sender: TObject);
    procedure bbnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Procedure UpdateBoardGradesSG;
  end;

var
  formBoardGrades: TformBoardGrades;

const
  MGPClassNames : array[0..4] of string = ('Reject','F4','MGP10','MGP12','MGP15');
  //MGPClassLowerThresholds : array[0..4] of double = (0,4.56,6.12,9.23,16.69);
  //MGPClassUpperThresholds : array[0..4] of double = (4.55,6.11,9.22,16.68,999);
  MGPClassLowerThresholds : array[0..4] of double = (0,4,10,12,15);
  MGPClassUpperThresholds : array[0..4] of double = (4,10,12,15,999);
  //MGPClassLowerThresholds : array[0..4] of double = (0,3,9,11,14);
  //MGPClassUpperThresholds : array[0..4] of double = (2.9,8.9,10.9,13.9,999);


implementation

{$R *.dfm}

procedure TformBoardGrades.bbnCancelClick(Sender: TObject);
begin
  close;
end;

procedure TformBoardGrades.bbnOKClick(Sender: TObject);
var
  bgINI : TIniFile;
  i : integer;
begin
  bgINI := TINIFile.Create(ExtractFilePath(Application.EXEName) + 'bg.ini');

  try
    for i := 1 to sgBoardGrades.RowCount-1 do begin
      bgINI.writestring('Board grade '+ inttostr(i),'Class',sgBoardGrades.Cells[0,i]);
      //bgINI.writestring('Board grade '+ inttostr(i),'Lower threshold',sgBoardGrades.Cells[1,i]);
      bgINI.writestring('Board grade '+ inttostr(i),'Upper threshold',sgBoardGrades.Cells[1,i]);
    end;
  finally
    bgINI.Free;

  end;

  close;


end;

procedure TformBoardGrades.FormShow(Sender: TObject);

begin
  UpdateBoardGradesSG;


  //SGBoardGrades.Width := SGBoardGrades.ColWidths[0] + SGBoardGrades.ColWidths[1];
end;

procedure TformBoardGrades.sgBoardGradesSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if ACol = 0 then
    sgBoardGrades.Options := sgBoardGrades.Options-[goEditing]
  else
    sgBoardGrades.Options := sgBoardGrades.Options+[goEditing];

end;

Procedure TformBoardGrades.UpdateBoardGradesSG;
var
  i : integer;
  bgINI : TInifile;
begin
  bgINI := TINIFile.Create(ExtractFilePath(Application.EXEName) + 'bg.ini');


  try
    SGBoardGrades.Cols[0].Strings[0] := ('Board grade name');
    //SGBoardGrades.Cols[1].Strings[0] := ('Board grade lower threshold (GPa)');
    SGBoardGrades.Cols[1].Strings[0] := ('Board grade upper threshold (GPa)');

    GridColAutoSize(SGBoardGrades);

    for I := 1 to 5 do begin
      SGBoardGrades.Cols[0].Strings[i] :=
        bgINI.ReadString('Board grade ' + inttostr(i),'Class',MGPClassNames[i -1]);
      //SGBoardGrades.Cols[1].Strings[i] := bgINI.ReadString('Board grade ' + inttostr(i),'Lower threshold',
        //floattostr(MGPClassLowerthresholds[i -1]));
      SGBoardGrades.Cols[1].Strings[i] := bgINI.ReadString('Board grade ' + inttostr(i),'Upper threshold',
        floattostr(MGPClassUpperthresholds[i -1]));
    end;

  finally
    bgINI.Free;
  end;
end;

end.
