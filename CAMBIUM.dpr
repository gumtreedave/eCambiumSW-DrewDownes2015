program CAMBIUM;

uses
  Forms,
  BoardDimensions in 'BoardDimensions.pas' {formBoardDimensions},
  CAMBIUMManager in 'CAMBIUMManager.pas' {formMain},
  DataModule in 'DataModule.pas' {DataModuleBoard: TDataModule},
  ProjectManager in 'ProjectManager.pas',
  ImportWizard in 'ImportWizard.pas' {formImportWizard},
  DataObjects in 'DataObjects.pas',
  LinkCABALAScenario in 'LinkCABALAScenario.pas' {formLinkCABALAScenario},
  General in 'General.pas',
  AddEditData in 'AddEditData.pas' {formAddEditData},
  RunManager in 'RunManager.pas',
  ScenarioManager in 'ScenarioManager.pas',
  CambiumObjects in 'CambiumObjects.pas',
  CAMBIUMModel in 'CAMBIUMModel.pas',
  ProjectWarnings in 'ProjectWarnings.pas' {formWarnings},
  RunInitialisation in 'RunInitialisation.pas' {formInitialisation},
  ModellingHeight in 'ModellingHeight.pas' {formModellingHeight},
  DevelopingCellsImage in 'DevelopingCellsImage.pas' {formDevelopingCellsImage},
  TreePhysModel in 'TreePhysModel.pas',
  SetSegmentWidth in 'SetSegmentWidth.pas' {formSegmentWidth},
  WriteData in 'WriteData.pas',
  ReadData in 'ReadData.pas',
  BoardProperties in 'BoardProperties.pas',
  BoardGrades in 'BoardGrades.pas' {formBoardGrades},
  ScenarioType in 'ScenarioType.pas' {formScenarioType},
  CreateCAMBIUMScenario in 'CreateCAMBIUMScenario.pas' {formCreateCAMBIUMScenario},
  Event in 'Event.pas' {formEvent},
  ImportDataProgress in 'ImportDataProgress.pas' {formImportDataProgress},
  AddEditCAMBIUMParams in 'AddEditCAMBIUMParams.pas',
  SummaryGraphsType in 'SummaryGraphsType.pas' {formSummaryGraphsType},
  ExportData in 'ExportData.pas' {formExportData},
  ColourChoice in 'ColourChoice.pas' {formColourCHoice},
  AboutCambium in 'AboutCambium.pas' {formAbout},
  GrowthGraphs in 'GrowthGraphs.pas' {formGrowthGraphs},
  DiagnosticGraphs in 'DiagnosticGraphs.pas' {formDiagnosticGraphs},
  DetailedGraphs in 'DetailedGraphs.pas' {formDetailedGraphs},
  ParallelProc in 'ParallelProc.pas',
  SummaryGraphs in 'SummaryGraphs.pas' {formSummaryGraphsDist},
  SummaryStats in 'SummaryStats.pas' {FormSummaryStats},
  ImportCambiumProjectData in 'ImportCambiumProjectData.pas' {formImportCambiumProject},
  OKCANCL2 in 'OKCANCL2.pas' {OKRightDlg};
  //AcroPDFLib_TLB in 'C:\Users\dre066\Documents\RAD Studio\6.0\Imports\AcroPDFLib_TLB.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'CAMBIUM xylem development prediction tool';
  Application.CreateForm(TformMain, formMain);
  Application.CreateForm(TformInitialisation, formInitialisation);
  Application.CreateForm(TformBoardDimensions, formBoardDimensions);
  Application.CreateForm(TDataModuleBoard, DataModuleBoard);
  Application.CreateForm(TformImportWizard, formImportWizard);
  Application.CreateForm(TformLinkCABALAScenario, formLinkCABALAScenario);
  Application.CreateForm(TformAddEditData, formAddEditData);
  Application.CreateForm(TformWarnings, formWarnings);
  Application.CreateForm(TformModellingHeight, formModellingHeight);
  Application.CreateForm(TformDevelopingCellsImage, formDevelopingCellsImage);
  Application.CreateForm(TformSegmentWidth, formSegmentWidth);
  Application.CreateForm(TformBoardGrades, formBoardGrades);
  Application.CreateForm(TformScenarioType, formScenarioType);
  Application.CreateForm(TformCreateCAMBIUMScenario, formCreateCAMBIUMScenario);
  Application.CreateForm(TformEvent, formEvent);
  Application.CreateForm(TformImportDataProgress, formImportDataProgress);
  Application.CreateForm(TformSummaryGraphsType, formSummaryGraphsType);
  Application.CreateForm(TformSummaryGraphsDist, formSummaryGraphsDist);
  Application.CreateForm(TformExportData, formExportData);
  Application.CreateForm(TformColourCHoice, formColourCHoice);
  Application.CreateForm(TformAbout, formAbout);
  Application.CreateForm(TformGrowthGraphs, formGrowthGraphs);
  Application.CreateForm(TformDiagnosticGraphs, formDiagnosticGraphs);
  Application.CreateForm(TformDetailedGraphs, formDetailedGraphs);
  Application.CreateForm(TFormSummaryStats, FormSummaryStats);
  Application.CreateForm(TformImportCambiumProject, formImportCambiumProject);
  Application.CreateForm(TOKRightDlg, OKRightDlg);
  Application.Run;
end.
