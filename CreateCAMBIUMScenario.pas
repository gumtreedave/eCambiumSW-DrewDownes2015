unit CreateCAMBIUMScenario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, General,ScenarioManager;

type
  TformCreateCAMBIUMScenario = class(TForm)
    leScenarioName: TLabeledEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    cmbSite: TComboBox;
    cmbWeather: TComboBox;
    cmbSpecies: TComboBox;
    cmbRegime: TComboBox;
    Panel1: TPanel;
    bbnOK: TBitBtn;
    bbnCancel: TBitBtn;
    cmbTreeType: TComboBox;
    Label5: TLabel;
    cmbStemPosition: TComboBox;
    Label6: TLabel;
    procedure bbnOKClick(Sender: TObject);
    Procedure AddCAMBIUMScenario;
    procedure FormShow(Sender: TObject);
    procedure bbnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  Procedure UpdateListsonForm;

var
  formCreateCAMBIUMScenario: TformCreateCAMBIUMScenario;

implementation

uses ProjectManager, DataModule, CAMBIUMManager, SummaryStats;

{$R *.dfm}

procedure TformCreateCAMBIUMScenario.bbnCancelClick(Sender: TObject);
begin
  formCreateCAMBIUMScenario.Close;
end;

procedure TformCreateCAMBIUMScenario.bbnOKClick(Sender: TObject);
begin
  try
    if leScenarioName.Text <> '' then begin
      if ((General.IsNewValueUnique(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
        leScenarioName.Text,
        ProjectManager.SCENARIOSTABLE,
        ProjectManager.SCENARIONAMEFIELD) = false) and
        (Messagedlg('Scenario "' + leScenarioName.Text + '" already exists. Replace?',
          mtWarning,[mbYes,mbNo],0) = mrYes)) or
        (General.IsNewValueUnique(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
                leScenarioName.Text,
                ProjectManager.SCENARIOSTABLE,
                ProjectManager.SCENARIONAMEFIELD) = true) then begin

        if (cmbSite.text <> 'Select a site') and (cmbSite.text <> '') then begin
          if (cmbweather.text <> 'Select a weather dataset') and (cmbweather.text <> '') then begin
            if (cmbspecies.text <> 'Select species to use for this run') and (cmbspecies.text <> '') then begin
              if (cmbregime.text <> 'Select a regime') and (cmbregime.text <> '') then begin
                if (cmbTreeType.Text <> 'Select a tree type') and (cmbTreeType.Text <> '') then begin
                  if (cmbStemPosition.Text <> 'Select a stem position') and (cmbStemPosition.Text <> '') then begin

                    General.DeleteFromTable(DataModule.DataModuleBoard.ADOCommandCAMBIUM,
                      ProjectManager.SCENARIOSTABLE,
                      'ScenarioName = "' + formCreateCAMBIUMScenario.leScenarioName.Text + '"');

                    General.DeleteFromTable(DataModule.DataModuleBoard.ADOCommandCAMBIUM,
                      ProjectManager.CABALASCENARIOSTABLE,
                      'ScenarioName = "' + formCreateCAMBIUMScenario.leScenarioName.Text + '"');

                    General.DeleteFromTable(DataModule.DataModuleBoard.ADOCommandCAMBIUM,
                      ProjectManager.DAILYOUTPUTDATATABLE,
                      'ScenarioName = "' + formCreateCAMBIUMScenario.leScenarioName.Text + '"');

                    General.DeleteFromTable(DataModule.DataModuleBoard.ADOCommandCAMBIUM,
                      ProjectManager.CAMBIUMSEGMENTSDATATABLE,
                      'ScenarioName = "' + formCreateCAMBIUMScenario.leScenarioName.Text + '"');

                    AddCAMBIUMScenario;

                    ProjectManager.GetAllScenarios(DataModule.DataModuleBoard.ADOCommandCAMBIUM,
                      DataModule.DataModuleBoard.ADOTableAllScenarios,
                      ProjectManager.TEMPALLSCENARIOSTABLE,
                      formSummaryStats.rgSummaryStats.ItemIndex,
                      formSummarySTats.rgSummaryType.ItemIndex,
                      strtoint(formSummaryStats.leSummaryWidth.Text),
                      '');
                      //CurrentSortField);

                    close;

                  end else messagedlg('Select a stem position',mtError,[mbOK],0);
                end else messagedlg('Select a tree type',mtError,[mbOK],0);
              end else messagedlg('Select a regime',mtError,[mbOK],0);
            end else messagedlg('Select a CAMBIUM patameter set/species',mtError,[mbOK],0);
          end else messagedlg('Select a weather dataset',mtError,[mbOK],0);
        end else messagedlg('Select a site',mtError,[mbOK],0);
      end;
    end else Messagedlg('Specify a name for the new scenario',mtError,[mbOK],0);

  finally
    {eScenarioName.Text := '';
    cmbSite.text := 'Select a site';
    cmbweather.text := 'Select a weather dataset';
    cmbspecies.text := 'Select species to use for this run';
    cmbregime.text := 'Select a regime';
    cmbTreeType.Text := 'Select a tree type';
    cmbStemPosition.Text := 'Select a stem position';

    cmbSite.ItemIndex := -1;
    cmbweather.ItemIndex := -1;
    cmbspecies.ItemIndex := -1;
    cmbregime.ItemIndex := -1;
    cmbTreeType.ItemIndex := -1;
    cmbStemPosition.ItemIndex := -1; }

  end;
end;

procedure TformCreateCAMBIUMScenario.FormShow(Sender: TObject);
begin
  //if leScenarioName.Text = '' then
    UpdatelistsonForm;
end;

Procedure UpdateListsonForm;
var
   i : integer;
begin
  with formCreateCAMBIUMScenario do begin
    General.GetDistinctValuesinField(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
      ProjectManager.SITESTABLE,
      ProjectManager.SITENAMEFIELD,
      cmbSite.Items);
    General.GetDistinctValuesinField(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
      ProjectManager.REGIMESTABLE,
      ProjectManager.REGIMENAMEFIELD,
      cmbRegime.Items);
    General.GetDistinctValuesinField(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
      ProjectManager.WEATHERDATASETNAMESTABLE,
      ProjectManager.WEATHERDATASETNAMEFIELD,
      cmbWeather.Items);
    General.GetDistinctValuesinField(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
      ProjectManager.SPECIESNAMESTABLE,
      ProjectManager.SPECIESNAMEFIELD,
      cmbSpecies.Items);
    //for i := 0 to Length(Scenariomanager.TREETYPES)-1 do
      //cmbTreeType.Items[i] := Scenariomanager.TREETYPES[i];

  end;
end;

Procedure TformCreateCAMBIUMScenario.AddCAMBIUMScenario;
var
  SQLString : string;
  MyWeatherDateSL : TStringList;
  MyRegimeDateSL : TStringList;
  MinWeatherDate,maxWeatherDate : TDate;
  MinRegimeDate,MaxRegimeDate: TDate;
begin
  MyWeatherDateSL := TStringList.Create;
  MyRegimeDateSL := TStringList.Create;

  try

    GetMinMaxDatesFromTable(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
      WEATHERDATATABLE,
      WEATHERDATEFIELD,
      WEATHERDATASETNAMEFIELD,
      cmbweather.Text,
      MinWeatherDate,MaxWeatherDate);

    GetMinMaxDatesFromTable(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
      REGIMESTABLE,
      EVENTDATEFIELD,
      REGIMENAMEFIELD,
      cmbRegime.text,
      MinRegimeDate,MaxRegimeDate);

    if (MinWeatherDate <= MinRegimeDate) and (MaxWeatherDate >= MaxRegimeDate) then begin
      SQLString := '';
      SQLString := 'INSERT INTO ' +
        ProjectManager.SCENARIOSTABLE + '( ' +
        ProjectManager.SCENARIONAMEFIELD + ',' +
        ProjectManager.SCENARIOTYPEFIELD + ',' +
        ProjectManager.SCENARIOSITEFIELD + ',' +
        ProjectManager.SCENARIOWEATHERDATAFIELD + ',' +
        ProjectManager.SCENARIOREGIMEFIELD + ',' +
        ProjectManager.SCENARIOCAMBIUMPARAMSFIELD + ',' +
        ProjectManager.SCENARIOTREETYPEFIELD + ',' +
        ProjectManager.SCENARIOSTEMPOSFIELD + ') ' +
        ' SELECT "' + leScenarioName.Text + '","' + CAMBIUM_SCENARIO_TYPE + '","' + cmbSite.text  + '","' + cmbweather.Text + '","' +
          cmbRegime.text + '","' + cmbSpecies.Text + '","' + cmbTreeType.Text + '","' +
          cmbStemPosition.Text + '"';

      DataModule.DataModuleBoard.ADOCommandCAMBIUM.CommandText := SQLString;

      try
        DataModule.DataModuleBoard.ADOCommandCAMBIUM.Execute;
      except
        on E:exception do begin
          messagedlg('CAMBIUM could not create the new scenario: ' +
            E.Message,mtWarning,[mbOK],0);
        end;
      end;
    end else
      messagedlg('The weather dataset dates do not span your specified regime',mtError,[mbOK],0);
  finally
    MyWeatherDateSL.Free;
    MyRegimeDateSL.Free;
  end;
end;

end.
