unit LinkCABALAScenario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ProjectManager,DataModule,General,ADODB, ExtCtrls,
  ScenarioManager;

type
  TformLinkCABALAScenario = class(TForm)
    cmbCAMBIUMParamSpecies: TComboBox;
    Label2: TLabel;
    cmbTreeType: TComboBox;
    cmbStemPosition: TComboBox;
    Label5: TLabel;
    Label6: TLabel;
    Panel1: TPanel;
    bbnLinkCABALAScenario: TBitBtn;
    bbnCancel: TBitBtn;
    OpenDialog1: TOpenDialog;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    bbnOpenCABALAProject: TBitBtn;
    cmbCABALAScenarios: TComboBox;
    leScenarioName: TLabeledEdit;
    cbUseAll: TCheckBox;
    procedure bbnOpenCABALAProjectClick(Sender: TObject);
    procedure ProjectOpenDialogFileOkClick(Sender: TObject;
      var CanClose: Boolean);

    procedure bbnLinkCABALAScenarioClick(Sender: TObject);
    Procedure AddCABALAScenario(ScenarioName: string;
      CABALAScenarioName : String;
      CABALAProjectName : string);
    procedure FormShow(Sender: TObject);
    procedure bbnCancelClick(Sender: TObject);
    procedure OpenDialog1CanClose(Sender: TObject; var CanClose: Boolean);
    procedure cbUseAllClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

  Procedure UpdateCABALAScenariosList;
  Procedure UpdateListsonForm;



var
  formLinkCABALAScenario: TformLinkCABALAScenario;

const
  CABALAPW = 'MBCABALA111062';

  CABALASCENARIOPARENTINFOTABLE = 'abScenarioParent';
  CABALASCENARIOINFOTABLE = 'bbScenarios';
  CABALA_OUTPUTALL_TABLE = 'OutputAll';

  CABALASITEINFOTABLE = 'ddSiteFactors';
  CABALASITEIDFIELD = 'SiteID';
  CABALASITELATFIELD = 'Lat';

  CABALASCENARIONAMEFIELD_CABALADB = 'sName';
  CABALADATEFIELD = 'wDate';
  CABALASCENARIOPARENTIDFIELD = 'ScenarioParentID';
  CABALASCENARIOIDFIELD = 'ScenarioID';
  CABALADATA_LATFIELD = 'Lat';
  CABALADATA_SITEIDFIELD = 'siteID';
	CABALADATA_DATEFIELD='wDate';
	CABALADATA_GPPFIELD = 'G';
	CABALADATA_NPPFIELD = 'NPP';
	CABALADATA_LAIFIELD = 'l';
	CABALADATA_PREDAWNWPFIELD = 'minmonthpredawn';
	CABALADATA_MIDDAYWPFIELD = 'psileafmin';
	CABALADATA_SOILWATERFIELD = 'ASWTree';
	CABALADATA_ETACRFIELD = 'etacr';
	CABALADATA_ETAFFIELD = 'etaf';
	CABALADATA_WFFIELD = 'wf';
	CABALADATA_ETASFIELD = 'etas';
	CABALADATA_DBHFIELD = 'diam';
	CABALADATA_HEIGHTFIELD = 'ht';
	CABALADATA_GREENHTFIELD = 'GreenHt';
	CABALADATA_MINTEMPFIELD = 'tn';
	CABALADATA_MAXTEMPFIELD = 'tx';
	CABALADATA_GS1FIELD = 'Gs1';
	CABALADATA_GS2FIELD = 'Gs2';
	CABALADATA_QAFIELD = 'Qa';
	CABALADATA_RAINFIELD = 'Rain';
	CABALADATA_SPHFIELD = 'Stocking';
	CABALADATA_VPDFIELD = 'vpdnow';
  CABALADATA_WCRFIELD = 'wcr';
  CABALADATA_WFRFIELD = 'wfr';
  CABALADATA_WSFIELD = 'ws';
  CABALADATA_STEMRESPIRATIONFIELD = 'rS';
  CABALADATA_CROWNLENGTHFIELD = 'CrownLength';
  CABALADATA_SPECIESIDFIELD = 'SpeciesID';
  CABALADATA_FINALVOLFIELD = 'vol';


implementation

{$R *.dfm}

Uses SummaryStats, CAMBIUMManager;

procedure TformLinkCABALAScenario.bbnCancelClick(Sender: TObject);
begin
  formLinkCABALAScenario.Close;
end;

procedure TformLinkCABALAScenario.bbnLinkCABALAScenarioClick(Sender: TObject);
var
  i : integer;
begin
  try
    if OpenDialog1.filename <> '' then begin
      if (leScenarioName.Text <> '') or (cbUseAll.Checked = true) then begin

        if ((General.IsNewValueUnique(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
          leScenarioName.Text,
          ProjectManager.SCENARIOSTABLE,
          ProjectManager.SCENARIONAMEFIELD) = false) and
          (cbUseAll.Checked = false) and
          (Messagedlg('Scenario "' + leScenarioName.Text + '" already exists. Replace?',
            mtWarning,[mbYes,mbNo],0) = mrYes)) or
          (General.IsNewValueUnique(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
            leScenarioName.Text,
            ProjectManager.SCENARIOSTABLE,
            ProjectManager.SCENARIONAMEFIELD) = true) or
            (cbUseAll.Checked = true)  then begin

          if (cmbCABALAScenarios.Text <> 'Select a scenario') and (cmbCABALAScenarios.Text <> '') or
            (cbUseAll.Checked = true) then begin
            if (cmbCAMBIUMParamSpecies.Text <> 'Select species to use for this run') and (cmbCAMBIUMParamSpecies.Text <> '') then begin
              if (cmbTreeType.Text <> 'Select a tree type') and (cmbTreeType.Text <> '') then begin
                if (cmbStemPosition.Text <> 'Select a stem position') and (cmbStemPosition.Text <> '') then begin

                    try
                      Screen.cursor := CRHourglass;

                      if (cbUseAll.Checked = true) then begin

                        for i := 0 to cmbCABALAScenarios.Items.Count-1 do begin
                          if (General.IsNewValueUnique(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
                            'Cambium_Scenario_' + cmbCABALAScenarios.Items[i] + '_' + cmbStemPosition.Text,
                            ProjectManager.SCENARIOSTABLE,
                            ProjectManager.SCENARIONAMEFIELD) = true) then begin

                            General.DeleteFromTable(DataModule.DataModuleBoard.ADOCommandCAMBIUM,
                              ProjectManager.SCENARIOSTABLE,
                              'ScenarioName = "Cambium_Scenario_' + cmbCABALAScenarios.Items[i] + '_' + cmbStemPosition.Text +'"');

                            General.DeleteFromTable(DataModule.DataModuleBoard.ADOCommandCAMBIUM,
                              ProjectManager.CABALASCENARIOSTABLE,
                              'ScenarioName = "Cambium_Scenario_' + cmbCABALAScenarios.Items[i] + '_' + cmbStemPosition.Text + '"');

                            General.DeleteFromTable(DataModule.DataModuleBoard.ADOCommandCAMBIUM,
                              ProjectManager.DAILYOUTPUTDATATABLE,
                              'ScenarioName = "Cambium_Scenario_' + cmbCABALAScenarios.Items[i] + '_' + cmbStemPosition.Text +'"');

                            General.DeleteFromTable(DataModule.DataModuleBoard.ADOCommandCAMBIUM,
                              ProjectManager.CAMBIUMSEGMENTSDATATABLE,
                              'ScenarioName = "Cambium_Scenario_' + cmbCABALAScenarios.Items[i] + '_' + cmbStemPosition.Text +'"');

                            AddCabalaScenario('Cambium_Scenario_' + cmbCABALAScenarios.Items[i]+ '_' + cmbStemPosition.Text,
                              cmbCABALAScenarios.Items[i],
                              OpenDialog1.FileName);
                          end;
                        end;
                      end else begin
                        General.DeleteFromTable(DataModule.DataModuleBoard.ADOCommandCAMBIUM,
                          ProjectManager.SCENARIOSTABLE,
                          'ScenarioName = "' + formlinkCABALAScenario.leScenarioName.Text + '"');

                        General.DeleteFromTable(DataModule.DataModuleBoard.ADOCommandCAMBIUM,
                          ProjectManager.CABALASCENARIOSTABLE,
                          'ScenarioName = "' + formlinkCABALAScenario.leScenarioName.Text + '"');

                        General.DeleteFromTable(DataModule.DataModuleBoard.ADOCommandCAMBIUM,
                          ProjectManager.DAILYOUTPUTDATATABLE,
                          'ScenarioName = "' + formlinkCABALAScenario.leScenarioName.Text + '"');

                        General.DeleteFromTable(DataModule.DataModuleBoard.ADOCommandCAMBIUM,
                          ProjectManager.CAMBIUMSEGMENTSDATATABLE,
                          'ScenarioName = "' + formlinkCABALAScenario.leScenarioName.Text + '"');

                        AddCabalaScenario(leScenarioName.Text,
                          cmbCABALAScenarios.text,
                          OpenDialog1.FileName);
                      end;

                      ProjectManager.GetAllScenarios(DataModule.DataModuleBoard.ADOCommandCAMBIUM,
                        DataModule.DataModuleBoard.ADOTableAllScenarios,
                        ProjectManager.TEMPALLSCENARIOSTABLE,
                        formSummaryStats.rgSummaryStats.ItemIndex,
                        formSUmmaryStats.rgSummaryType.ItemIndex,
                        strtoint(formSummaryStats.leSummaryWidth.Text),
                        '');
                        //CambiumManager.CurrentSortField);

                      formLinkCABALAScenario.Close;

                      formMain.dbGridScenarios.Refresh;


                    finally
                      Screen.cursor := crDefault;
                    end;

                end else
                  messagedlg('Select a stem position',mtError,[mbOK],0);
              end else
                messagedlg('Select a tree type',mtError,[mbOK],0);
            end else
              messagedlg('Select a CAMBIUM parameter set/species',mtError,[mbOK],0);
          end else
            messagedlg('Select a CaBala scenario',mtError,[mbOK],0);
        end;
      end else
        messagedlg('Specify a name for the new scenario',mtError,[mbOK],0);
    end else
      messagedlg('Open a CaBala file',mtError,[mbOK],0);

  finally
    {cmbCABALAScenarios.Text := 'Select a scenario';
    cmbCAMBIUMParamSpecies.Text := 'Select species to use for this run';
    cmbTreeType.Text := 'Select a tree type';
    cmbStemPosition.Text := 'Select a stem position';
    leScenarioName.Text := '';

    cmbCABALAScenarios.ItemIndex := -1;
    cmbCAMBIUMParamSpecies.ItemIndex := -1;
    cmbTreeType.ItemIndex := -1;
    cmbStemPosition.ItemIndex := -1;}

  end;

end;

procedure TformLinkCABALAScenario.bbnOpenCABALAProjectClick(Sender: TObject);
begin
  OpenDialog1.Execute;
end;

procedure TformLinkCABALAScenario.cbUseAllClick(Sender: TObject);
begin
  if cbUseAll.checked then begin
    leScenarioName.text := '';
    leScenarioName.Enabled := false;
    cmbCABALAScenarios.Enabled := false;
  end else begin
    leScenarioName.Enabled := true;
    cmbCABALAScenarios.Enabled := true;
  end;
end;

procedure TformLinkCABALAScenario.FormShow(Sender: TObject);
begin
  //if leScenarioName.Text = '' then
    UpdateListsonForm;
end;

procedure TformLinkCABALAScenario.OpenDialog1CanClose(Sender: TObject;
  var CanClose: Boolean);
begin
    If ProjectManager.ConnectDatabase(OpenDialog1.FileName,
      DataModule.DataModuleBoard.ADOConnectionCABALA,
      CABALAPW) then begin
      UpdateCABALAScenariosList;
      if cbUseAll.Checked <> true then
        cmbCabalaScenarios.DroppedDown := true;
    end else
      cmbCabalaScenarios.Items.Clear;
end;

Procedure UpdateListsonForm;
begin
  try

    General.GetDistinctValuesinField(DataModule.DataModuleBoard.ADOQueryCAMBIUM,
      ProjectManager.SPECIESNAMESTABLE,
      ProjectManager.SPECIESNAMEFIELD,
      formlinkCabalaScenario.cmbCAMBIUMParamSpecies.Items);

  except
  end;
end;


Procedure UpdateCABALAScenariosList;
var
  MyScenarioNames : TStringList;

begin
  MyScenarioNames := TStringList.Create;
  try
    General.GetDistinctValuesinField(DataModule.DataModuleBoard.ADOQueryCABALA,
    CABALASCENARIOPARENTINFOTABLE,CABALASCENARIONAMEFIELD_CABALADB,
    MyScenarioNames);

    formLinkCABALAScenario.cmbCABALAScenarios.Items := MyScenarioNames;
  finally
    MyScenarioNames.Free;
  end;
end;

procedure TformLinkCABALAScenario.ProjectOpenDialogFileOkClick(Sender: TObject;
  var CanClose: Boolean);
begin
  If ProjectManager.ConnectDatabase(OpenDialog1.FileName,
    DataModule.DataModuleBoard.ADOConnectionCABALA,
    CABALAPW) then
    UpdateCABALAScenariosList;

end;

Procedure TFormLinkCABALAScenario.AddCABALAScenario(ScenarioName: string;
  CABALAScenarioName : String;
  CABALAProjectName : string);
var
  SQLString : string;

begin

  SQLString := '';
  SQLString := 'INSERT INTO ' +
    ProjectManager.CABALASCENARIOSTABLE + '( ' +
    ProjectManager.SCENARIONAMEFIELD + ',' +
    ProjectManager.CABALASCENARIONAMEFIELD + ',' +
    ProjectManager.CABALAPROJECTFIELD + ')' +
    ' SELECT "' +
    ScenarioName + '","' + CABALAScenarioName + '","' + CABALAProjectName + '"';

  DataModule.DataModuleBoard.ADOCommandCAMBIUM.CommandText := SQLString;
  try
    DataModule.DataModuleBoard.ADOCommandCAMBIUM.Execute;

    SQLString := '';
    SQLString := 'INSERT INTO ' +
      ProjectManager.SCENARIOSTABLE + '( ' +
      ProjectManager.SCENARIONAMEFIELD + ',' +
      ProjectManager.SCENARIOTYPEFIELD + ',' +
      ProjectManager.SCENARIOCAMBIUMPARAMSFIELD + ',' +
      ProjectManager.SCENARIOTREETYPEFIELD + ',' +
      ProjectManager.SCENARIOSTEMPOSFIELD + ') ' +
      ' SELECT "' + ScenarioName + '","' + CABALA_SCENARIO_TYPE + '","' +
        cmbCAMBIUMParamSpecies.Items[cmbCAMBIUMParamSpecies.ItemIndex] + '","' + cmbTreeType.Items[cmbTreeType.ItemIndex] + '","' +
        cmbStemPosition.Items[cmbStemPosition.ItemIndex] + '"';

    DataModule.DataModuleBoard.ADOCommandCAMBIUM.CommandText := SQLString;

    try
      DataModule.DataModuleBoard.ADOCommandCAMBIUM.Execute;
    except
    end;

  except
    on E:exception do begin
      messagedlg('CAMBIUM could not link to the selected CABALA scenario: ' +
        E.Message,mtWarning,[mbOK],0);
    end;
  end;
end;

end.
