unit DetailedGraphs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TeEngine, Series, ExtCtrls, TeeProcs, Chart, ComCtrls, StdCtrls;

type
  TformDetailedGraphs = class(TForm)
    PageControl1: TPageControl;
    tsStand: TTabSheet;
    tsTree: TTabSheet;
    tsPosition: TTabSheet;
    TSFile: TTabSheet;
    tsCell: TTabSheet;
    ChartCellCarbs: TChart;
    Series3: TLineSeries;
    Series4: TLineSeries;
    ChartWPOP: TChart;
    ChartWTYT: TChart;
    Series7: TLineSeries;
    Series8: TLineSeries;
    ChartPPTree: TChart;
    ChartAllocSL: TChart;
    ChartCarbAuxinToday: TChart;
    ChartHtD: TChart;
    Series9: TLineSeries;
    Series10: TLineSeries;
    Series11: TLineSeries;
    Series12: TLineSeries;
    Series13: TLineSeries;
    Series14: TLineSeries;
    Series15: TLineSeries;
    Series16: TLineSeries;
    CHartVolSA: TChart;
    Series17: TLineSeries;
    Series18: TLineSeries;
    Series19: TLineSeries;
    ChartTotAuxCarbsPerFile: TChart;
    Series23: TLineSeries;
    Series24: TLineSeries;
    ChartRDLength: TChart;
    Series26: TLineSeries;
    Series27: TLineSeries;
    ChartWTVol: TChart;
    Series28: TLineSeries;
    Series29: TLineSeries;
    Series30: TLineSeries;
    ScrollBar1: TScrollBar;
    ChartXPP: TChart;
    Series33: TLineSeries;
    Series34: TLineSeries;
    ChartTemperature: TChart;
    Series35: TLineSeries;
    Series36: TLineSeries;
    Series37: TBarSeries;
    Series5: TLineSeries;
    Series6: TLineSeries;
    Series44: TLineSeries;
    ChartCellCounts: TChart;
    Series38: TAreaSeries;
    Series39: TAreaSeries;
    Series40: TAreaSeries;
    ChartDurations: TChart;
    ChartAuxConcCZExit: TChart;
    Series48: TLineSeries;
    ChartExcessCarbs: TChart;
    Series49: TLineSeries;
    ChartTurgYTExt: TChart;
    Series50: TLineSeries;
    Series51: TLineSeries;
    Series52: TLineSeries;
    ScrollBar2: TScrollBar;
    Series41: TLineSeries;
    Series42: TLineSeries;
    Series43: TLineSeries;
    ChartTRDWTDead: TChart;
    Series31: TLineSeries;
    Series32: TLineSeries;
    ChartLengthVolDead: TChart;
    Series45: TLineSeries;
    Series46: TLineSeries;
    Series21: TLineSeries;
    Series22: TLineSeries;
    Series47: TLineSeries;
    ChartWE: TChart;
    Series53: TLineSeries;
    Series54: TLineSeries;
    Series55: TLineSeries;
    Series56: TLineSeries;
    ChartDistAlpha: TChart;
    Series1: TLineSeries;
    Series25: TLineSeries;
    ChartCarbConcInCell: TChart;
    Series2: TLineSeries;
    Series20: TLineSeries;
    ChartAllocCarb: TChart;
    Series57: TLineSeries;
    TabSheet1: TTabSheet;
    Chart_TRD_WT_TimeAxis: TChart;
    Series58: TLineSeries;
    Series59: TLineSeries;
    TabSheet2: TTabSheet;
    ChartTurgOPCell: TChart;
    Series61: TLineSeries;
    Series62: TLineSeries;
    Chart_WTRD_CellNum: TChart;
    Series60: TLineSeries;
    Series63: TLineSeries;
    Chart_OP_CumCarb_CellNum: TChart;
    Series64: TLineSeries;
    Series65: TLineSeries;
    Chart_turg_cellnum: TChart;
    Series66: TLineSeries;
    Series67: TLineSeries;
    Chart_ThickDur_CellNum: TChart;
    Series68: TLineSeries;
    Series69: TLineSeries;
    TabSheet3: TTabSheet;
    Chart_LAI_SLA: TChart;
    Series70: TLineSeries;
    Series71: TLineSeries;
    Chart_WF_WS_WR: TChart;
    Series72: TLineSeries;
    Series73: TLineSeries;
    Series74: TLineSeries;
    Chart_NPPStand_SPH: TChart;
    Series75: TLineSeries;
    Series76: TLineSeries;
    Series77: TLineSeries;
    Series78: TLineSeries;
    ScrollBar3: TScrollBar;
    TabSheet4: TTabSheet;
    Chart_EvapTrans: TChart;
    Series79: TLineSeries;
    Series80: TLineSeries;
    Series81: TLineSeries;
    TabSheet5: TTabSheet;
    Series82: TLineSeries;
    ChartDL: TChart;
    Series83: TLineSeries;
    Series84: TLineSeries;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formDetailedGraphs: TformDetailedGraphs;

implementation

{$R *.dfm}

end.
