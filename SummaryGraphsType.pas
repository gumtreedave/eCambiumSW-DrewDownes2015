unit SummaryGraphsType;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons,ScenarioManager,ProjectManager;

type
  TformSummaryGraphsType = class(TForm)
    rgSummaryGraphsType: TRadioGroup;
    bbnSummaryGraphsType: TBitBtn;
    procedure bbnSummaryGraphsTypeClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

  Procedure CallWoodPropertyGraphs;
  Procedure CallGrowthDevGraphs;

var
  formSummaryGraphsType: TformSummaryGraphsType;

implementation

uses SummaryGraphs, CAMBIUMManager, DataModule, DiagnosticGraphs;

{$R *.dfm}

procedure TformSummaryGraphsType.bbnSummaryGraphsTypeClick(Sender: TObject);
begin
  formSummaryGraphsType.Close;
  try
    Screen.Cursor := crHourglass;
    case rgSummaryGraphsType.ItemIndex of
      0 : CallWoodPropertyGraphs;
      1 : CallgrowthDevGraphs;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;


Procedure CallWoodPropertyGraphs;
var
  ScenarioNamesList : TStringList;
begin
  ScenarioNamesList := TStringList.Create;

  ScenarioManager.GetSelectedScenarioNames(formMain.dbGridScenarios,
    formMain.DataSource1,
    DataModule.DataModuleBoard.ADOTableAllScenarios,
    ProjectManager.SCENARIONAMEFIELD_LONG,
    ScenarioNamesList);
  if ScenarioNamesList.Count > 0 then begin
    if ScenarioNamesList.Count = 1 then
      SummaryGraphs.MainLoop(ScenarioNamesList.Strings[0]);
  end;

  ScenarioNamesList.free;
end;


Procedure CallGrowthDevGraphs;
var
  ScenarioNamesList : TStringList;
begin
  ScenarioNamesList := TStringList.Create;
  ScenarioManager.GetSelectedScenarioNames(formMain.dbGridScenarios,
    formMain.DataSource1,
    DataModule.DataModuleBoard.ADOTableAllScenarios,
    ProjectManager.SCENARIONAMEFIELD_LONG,
    ScenarioNamesList);
  if ScenarioNamesList.Count > 0 then begin
    if ScenarioNamesList.Count = 1 then
        DiagnosticGraphs.MainLoop(ScenarioNamesList.Strings[0]);
  end;
  ScenarioNamesList.Free;
end;


end.
