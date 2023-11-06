unit SummaryStats;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons,ProjectManager,DataMOdule;

type
  TFormSummaryStats = class(TForm)
    rgSummaryStats: TRadioGroup;
    Panel2: TPanel;
    bbnOK: TBitBtn;
    Panel3: TPanel;
    GroupBox1: TGroupBox;
    leSummaryWidth: TLabeledEdit;
    rgSummaryType: TRadioGroup;
    procedure bbnOKClick(Sender: TObject);
    procedure rgSummaryStatsClick(Sender: TObject);
    procedure leSummaryWidthChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSummaryStats: TFormSummaryStats;

const
  DISTSUMMARY = 0;
  RINGSUMMARY = 1;

  WHOLECOREMEAN = 0;
  OUTERCOREMEAN = 1;
  INNERCOREMEAN = 2;

implementation

uses CAMBIUMManager;

{$R *.dfm}

procedure TFormSummaryStats.bbnOKClick(Sender: TObject);
begin
  close;
end;

procedure TFormSummaryStats.leSummaryWidthChange(Sender: TObject);
begin
  ProjectManager.GetAllScenarios(DataModule.DataModuleBoard.ADOCommandCAMBIUM,
    DataModule.DataModuleBoard.ADOTableAllScenarios,
    ProjectManager.TEMPALLSCENARIOSTABLE,
    formSummaryStats.rgSummaryStats.ItemIndex,
    formSummaryStats.rgSummaryType.ItemIndex,
    strtoint(formSummaryStats.leSummaryWidth.Text),
    '');
    //CambiumManager.CurrentSortField);
end;

procedure TFormSummaryStats.rgSummaryStatsClick(Sender: TObject);
begin
  ProjectManager.GetAllScenarios(DataModule.DataModuleBoard.ADOCommandCAMBIUM,
    DataModule.DataModuleBoard.ADOTableAllScenarios,
    ProjectManager.SCENARIOSTABLE,
    formSummaryStats.rgSummaryStats.ItemIndex,
    formSummaryStats.rgSummaryType.ItemIndex,
    strtoint(formSummaryStats.leSummaryWidth.Text),
    '');
    //CambiumManager.CurrentSortField);
end;

end.
