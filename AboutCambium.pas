unit AboutCambium;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TformAbout = class(TForm)
    Memo1: TMemo;
    Panel1: TPanel;
    bbnOK: TBitBtn;
    Panel2: TPanel;
    LabelVersion: TLabel;
    labelCompileDate: TLabel;
    procedure bbnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formAbout: TformAbout;

implementation

{$R *.dfm}

function getVersion : string;
{ ---------------------------------------------------------
   Extracts the FileVersion element of the VERSIONINFO
   structure that Delphi maintains as part of a project's
   options.

   Results are returned as a standard string.  Failure
   is reported as "".

   Note that this implementation was derived from similar
   code used by Delphi to validate ComCtl32.dll.  For
   details, see COMCTRLS.PAS, line 3541.
  -------------------------------------------------------- }
const
   NOVIDATA = '';

var
  dwInfoSize,           // Size of VERSIONINFO structure
  dwVerSize,            // Size of Version Info Data
  dwWnd: DWORD;         // Handle for the size call.
  FI: PVSFixedFileInfo; // Delphi structure; see WINDOWS.PAS
  ptrVerBuf: Pointer;   // pointer to a version buffer
  strFileName,          // Name of the file to check
  strVersion : string;  // Holds parsed version number
begin

   //strFileName := ExtractFilePath(Application.ExeName);
   strFileName := paramStr(0);
   dwInfoSize :=
      getFileVersionInfoSize( pChar( strFileName ), dwWnd);

   if ( dwInfoSize = 0 ) then
      result := NOVIDATA
   else
   begin

      getMem( ptrVerBuf, dwInfoSize );
      try

         if getFileVersionInfo( pChar( strFileName ),
            dwWnd, dwInfoSize, ptrVerBuf ) then

            if verQueryValue( ptrVerBuf, '\',
                              pointer(FI), dwVerSize ) then

            strVersion :=
               format( '%d.%d.%d.%d',
                       [ hiWord( FI.dwFileVersionMS ),
                         loWord( FI.dwFileVersionMS ),
                         hiWord( FI.dwFileVersionLS ),
                         loWord( FI.dwFileVersionLS ) ] );

      finally
        freeMem( ptrVerBuf );
      end;
    end;
  Result := strVersion;
end;

procedure TformAbout.bbnOKClick(Sender: TObject);
begin
  close;
end;

function GetAppVersionStr: string;
var
  Rec: LongRec;
begin
  Rec := LongRec(GetFileVersion(ParamStr(0)));
  //Result := Format('%d.%d', [Rec.Hi, Rec.Lo])
  Result := '1.4';
end;

procedure TformAbout.FormCreate(Sender: TObject);
var
  lSearchRec: TSearchRec;
begin
  // look for your Application Exe-File
  if FindFirst(Application.EXEName, faAnyFile, lSearchRec) = 0 then begin
    // extract DateTime from File-Date
    LabelCompileDate.Caption := DateTimeToStr(FileDateToDateTime(lSearchRec.Time));
    FindClose(lSearchRec);
  end;
  LabelVersion.Caption := 'Version: ' + GetAppVersionStr;
end;

end.
