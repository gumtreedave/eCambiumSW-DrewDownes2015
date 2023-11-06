unit ParallelProc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,SyncObjs;

type

  TParallelProc = reference to procedure(i: Integer; ThreadID: Integer);

  TParallel = class(TThread)
  private
    FProc: TParallelProc;
    FThreadID: Integer; //current thread ID
  protected
    procedure Execute; override;
    function GetNextValue: Integer;
  public
    constructor Create;
    destructor Destroy; override;

    property Proc: TParallelProc
      read FProc write FProc;
    class var
      CurrPos: Integer; //current loop index
      MaxPos: Integer;  //max loops index
      cs: TCriticalSection;
      ThCount: Integer; //thread counter - how much threads have finished execution
  end;




{** ParallelFor Loop - all iterations will be performed in chosen threads
@param nMin - Loop min value (first iteration)
@param nMax - Loop max value (last iteration)
@param nThreads - how much threads to use
@param  aProc - anonymous procedure which will be performed in loop thread
}
Procedure ParallelFor (nMin, nMax, nThreads: Integer;aProc: TParallelProc);overload;
{** ParallelFor Loop - all iterations will be performed in max cpu cores
@param nMin - Loop min value (first iteration)
@param nMax - Loop max value (last iteration)
@param  aProc - anonymous procedure which will be performed in loop thread
}
procedure ParallelFor(nMin, nMax: Integer; aProc: TParallelProc); overload;

implementation

{Procedure ParallelFor (nMin, nMax, nThreads: Integer;aProc: TProc<Integer>);
var
  threads: array of TParallel;
  I: Integer;
begin
  // inizialize TParallel class data
  TParallel.CurrPos := nMin;TParallel.MaxPos := nMax;TParallel.cs := TCriticalSection.Create;TParallel.ThCount := 0;
 // create the threads
  SetLength (threads, nThreads);
  for I := 0 to Length (threads) - 1 do begin
    threads[I] := TParallel.Create; // suspended
    threads[I].Proc := aProc;
    threads[I].Resume;
  end;
  while TParallel.ThCount > 0 do begin
    Application.ProcessMessages;
    Sleep (100);
  end;
end;}


procedure ParallelFor(nMin, nMax, nThreads: Integer; aProc: TParallelProc);
var
  threads: array of TParallel;
  I: Integer;
begin
  if nMin > nMax then
    Exit;
  // initialize TParallel class data
  TParallel.CurrPos := nMin;
  TParallel.MaxPos := nMax;
  TParallel.cs := TCriticalSection.Create;
  TParallel.ThCount := 0;

  // create the threads
  SetLength (threads, nThreads);
  for I := 0 to nThreads - 1 do
  begin

    threads[I] := TParallel.Create;// suspended
    threads[I].Proc := aProc;
    threads[I].Resume;
  end;

  for I := 0 to nThreads - 1 do
  begin
    threads[I].WaitFor;
  end;

  for I := 0 to nThreads - 1 do
  begin
    threads[I].Free;
  end;

  TParallel.cs.Free;
end;

procedure ParallelFor(nMin, nMax: Integer; aProc: TParallelProc);
begin
  ParallelFor(nMin, nMax, CPUCount, aProc);
end;

{ TParallel }

constructor TParallel.Create;
begin
  inherited Create(True); // suspended
  InterlockedIncrement(ThCount);
  FreeOnTerminate := False;
  FThreadID := 0;
end;

destructor TParallel.Destroy;
begin
  InterlockedDecrement(ThCount);
  inherited;
end;

procedure TParallel.Execute;
var
  nCurrent: Integer;
begin
  nCurrent := GetNextValue;
  while nCurrent <= MaxPos do
  begin
    Proc(nCurrent, FThreadID);
    nCurrent := GetNextValue;
  end;
end;

function TParallel.GetNextValue: Integer;
begin
  cs.Acquire;
  try
    Result := CurrPos;
    Inc(CurrPos);
  finally
    cs.Release;
  end;
end;

end.
