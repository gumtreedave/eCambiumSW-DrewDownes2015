unit TreePhysModel;

interface

  uses ReadData,DataMOdule,DataObjects,General,Math,ProjectManager,
    RunInitialisation,SysUtils,Event,ProjectWarnings,DetailedGraphs;

  Function MainLoop(InputSiteInfo: TSiteData;
    InputRegimeInfo : TRegimeDataArray;
    Var TPGParameters : T3PGParameters;
    InputWeatherData : TWeatherDataArray;
    DayCounter: Integer;
    BaseDiam_mm: Double;
    DevZoneWidth_mm : DOuble;
    MeanWD_kgperm3 : Double;
    EstablishmentDate : TDate;
    Var TreeHt_m,RootDepth_m: Double;
    Var FertRating,MyPooledSW,MyStemNo,WF,WS,WR: Double;
    Var ASWLayers: Array of DOuble): TCambiumInputData;

implementation



Procedure doThinning(RemainingSPH: Integer;
  var WF,WR,WS : Double;
  var CurrentSPH : Double);
  //If it is time to do a thinning, carry out the thinning (if there are
  //stems to remove) and update the thinnning eventNo
var
  ThinningProp : Double;
begin
  if CurrentSPH > RemainingSPH then
    ThinningProp := RemainingSPH/CurrentSPH
  else begin
    ThinningProp := 1;
    formWarnings.memoWarnings.Lines.Add('Thinning scheduled to ' + Inttostr(remainingSPH) + ' SPH from ' +
     floattostr(CurrentSPH) + ' SPH was ignored.')
  end;

  WF := WF * ThinningProp;
  WR := WR * ThinningProp;
  WS := WS * ThinningProp;

  if CurrentSPH > RemainingSPH then
    CurrentSPH := RemainingSPH;

End;

Function getTranspiration (Qa,Qb,Q : Double;
   VPD : Double;
   h : Double;
   gBL : Double;
   gC : Double): Double;

    //Penman-Monteith equation for computing canopy transpiration
    //in kg/m2/day, which is conmverted to mm/day.
    //The following are constants in the PM formula (Landsberg & Gower, 1997)
Const
  e20 = 2.2;          //rate of change of saturated VP with T at 20C
  rhoAir = 1.2;       //density of air, kg/m3
  lambda = 2460000;   //latent heat of vapourisation of H2O (J/kg)
  VPDconv = 0.000622; //convert VPD to saturation deficit = 18/29/1000' +

var
  netRad : Double;
  defTerm : Double;
  mydiv : Double;
  Etransp : Double;
begin
  netRad := Qa + Qb * (Q * power(10,6) / h);                 // Q in MJ/m2/day --> W/m2
  defTerm := rhoAir * lambda * (VPDconv * VPD) * gBL;
  mydiv := gC * (1 + e20) + gBL;
  Etransp := gC * (e20 * netRad + defTerm) / mydiv;       // in J/m2/s

  Result := Etransp / lambda * h;             //converted to kg/m2/day
                                              //which is equivalent to mm water/day

End;

Function getMortality(oldN : Double;
   oldW : Double;
   mS : double;
   wsx1000 : double;
   thinpower : double): Double;
  //This function determines the number of stems to remove to ensure the
  //self-thinning rule is satisfied. It applies the Newton-Rhapson method
  //to solve for N to an accuracy of 1 stem or less. To change this,
  //change the value of "accuracy".
Const
  accuracy = 1 / 1000;
var
  i : Integer;
  fN,dfN,dN,n,x1,x2 : Double;
begin

  n := oldN / 1000;
  x1 := 1000 * mS * oldW / oldN;
  i := 0;
  repeat
    i := i + 1;
    x2 := wSx1000 * power(n,(1 - thinPower));
    fN := x2 - x1 * n - (1 - mS) * oldW;
    dfN := (1 - thinPower) * x2 / n - x1;
    dN := -fN / dfN;
    n := n + dN;
  until (Abs(dN) <= accuracy) Or (i >= 5);

  Result := oldN - 1000 * n;
End;


Function gammaFoliage(age : Double;
  tgammaF: Double;
  gammaF1 : Double;
  gammaF0 : Double): Double;
var
  kgammaF : Double;
begin
  If tgammaF * gammaF1 = 0 Then
    Result := gammaF1
  Else begin
    kgammaF := 365 * Log10(1 + gammaF1 / gammaF0) / tgammaF;
    Result := gammaF1 * gammaF0 / (gammaF0 + (gammaF1 - gammaF0) * Exp(-kgammaF * age));
  End;
End;

Function GetDailyVPD(MeanT_C : Real; MeanRH_Perc: Real): Real;
//Returns average daily VPD in kPa from known mean daily RH and Temperature
begin

  Result := (100-MeanRH_Perc)/100 * ((610.7*power(10,7.5*MeanT_C/(237.3+MeanT_C)))/1000);

end;

Procedure Initialise3PG;
begin

end;

Function MainLoop(InputSiteInfo: TSiteData;
  InputRegimeInfo : TRegimeDataArray;
  Var TPGParameters : T3PGParameters;
  InputWeatherData : TWeatherDataArray;
  DayCounter: Integer;
  BaseDiam_mm: Double;
  DevZoneWidth_mm : DOuble;
  MeanWD_kgperm3 : Double;
  EstablishmentDate : TDate;
  Var TreeHt_m,RootDepth_m: Double;
  Var FertRating,MyPooledSW,MyStemNo,WF,WS,WR: Double;
  Var ASWLayers : array of double): TCambiumInputData;
var
  fT,fVPD,fSW,fNutr,fAge,VPDToday : Double;
  PhysMod : Double;
  RelAge,StandAge : Double;
  SLA,LAI,CanCover : Double;
  LightIntcptn : Double;
  AlphaC, epsilon,RAD,Radint: Double;
  GPP,NPP,WUE: Double;
  CanCond,Transp,EvapTransp,TranspScaleFactor : Double;
  FracRainIntcptn,RainIntcptn : Double;
  SupIrrig,RunOff,ExcessSW: Double;
  m,pFS,pR,pS,pF: Double;//,pFSPower,pFSConst : Double;
  incrWF,incrWS,incrWR,LossWF,LossWR:DOuble;
  WL,TotalW,AvStemMass_kg,wsMax: Double;
  FracBB,gammaF: Double;
  gammaN,delStems,Mortality:Double;
  cRADint,aRADint,cGPP,aGPP,cNPP,aNPP,cLitter,cStemDM,aStemDM,
      cRainInt,cTransp,aTransp,cEvapTransp,aEvapTransp,cRunOff,aRunOff,
      cLAI:Double;
  PDLWP,MDLWP: Double;
  i : integer;

  OutputData : TCambiumInputData;
  StemVol_m3 : Double;

  myFormFactor : Double;

  AvailableTopUp_mm, ExcessWaterInPreviousLayer_mm,ASWInRootZone_mm : Double;
  ASWInUpperHalfRootZone_mm,MyMaxASW : Double;
  RelSWC : Double;
  RemET,DepthDivider,PotETFromLayer : Double;
  MySoilEvap_mm : Double;
  CurrentpFS : Double;

  StemArea_cm2, HWArea_cm2, SWArea_cm2 : Double;
  TargetLeafArea_m2,CurrentLeafArea_m2 : DOuble;
  LARatio: Double;
  MeanRingWidth_cm : Double;


const
  Qa = -90;             //intercept of net v. solar radiation relationship (W/m2)
  Qb = 0.8;             //slope of net v. solar radiation relationship
  gDM_mol = 24;         //conversion of mol to gDM
  molPAR_MJ = 2.3;      //conversion of MJ to PAR

begin

  //pfsPower := Log10(TPGParameters.pFS20 / TPGParameters.pFS2) / Log10(20 / 2);
  //pfsConst := power((TPGParameters.pFS2 / 2),pfsPower);

  //Convert VPD from kPa to mBar for subsequent calcs...
  VPDToday :=  10*GetDailyVPD((InputWeatherData[DayCounter].MinTemp +  InputWeatherData[DayCounter].MaxTemp)/2,
    (InputWeatherData[DayCounter].MinRH + InputWeatherData[DayCounter].MaxRH)/2);
  //In years
  StandAge := (InputWeatherData[DayCounter].LogDate - EstablishmentDate)/365.25;

  for i := 1 to length(InputRegimeInfo)-1 do begin
    if round(InputWeatherData[DayCounter].LogDate) = round(InputRegimeInfo[i].EventDate) then begin
      if InputRegimeInfo[i].EventType = Event.EVENTTHIN then
        doThinning(round(InputRegimeInfo[i].EventValue),
          WF,WR,WS,MyStemNo);

      if InputRegimeInfo[i].EventType = Event.EVENTFERT then
        FertRating := min(1,FertRating + InputRegimeInfo[i].EventValue);

      if InputRegimeInfo[i].EventType = Event.EVENTPRUN then
        WF := max(0,min(WF,WF - WF * InputRegimeInfo[i].EventValue));
    end;
  end;

  if FertRating > InputSiteInfo.FR then
    FertRating := Max(InputSiteInfo.FR,FertRating - 0.001);

  //Set age-dependent factors for this time step
  SLA := General.expF(StandAge, TPGParameters.SLA0, TPGParameters.SLA1, TPGParameters.tSLA, 2);
  LAI := WF * SLA * 0.1;
  RootDepth_m := max(RootDepth_m,min(RootDepth_m + 0.01,min(InputSiteInfo.SoilDepth,
    ((WR*1000)/MyStemNo) * TPGParameters.RootConversion)));

  //if formMain.Detailedgraphs1.Checked then begin
  formdetailedgraphs.Chart_LAI_SLA.Series[0].AddXY(InputWeatherData[DayCounter].LogDate,
    LAI);
  formdetailedgraphs.Chart_LAI_SLA.Series[1].AddXY(InputWeatherData[DayCounter].LogDate,
    SLA);
  formdetailedgraphs.CHart_WF_WS_WR.Series[0].AddXY(InputWeatherData[DayCounter].LogDate,
    WF);
  formdetailedgraphs.CHart_WF_WS_WR.Series[1].AddXY(InputWeatherData[DayCounter].LogDate,
    WS);
  formdetailedgraphs.CHart_WF_WS_WR.Series[2].AddXY(InputWeatherData[DayCounter].LogDate,
    WR);
  formdetailedgraphs.CHart_WF_WS_WR.Series[3].AddXY(InputWeatherData[DayCounter].LogDate,
    RootDepth_m);

  //fracBB := expF(StandAge, TPGParameters.fracBB0, TPGParameters.fracBB1, TPGParameters.tBB, 1);
  //Loss of foliage is calculated daily here, so parameters are per day, not per month
  gammaF := max(0,
    gammaFoliage(StandAge,TPGParameters.tgammaF,TPGParameters.gammaF1,TPGParameters.gammaF0));

  //Calculate temperature modifier for this time step
  try
    fT := General.TemperatureFunction(InputWeatherData[DayCounter].MinTemp,
      InputWeatherData[DayCounter].MaxTemp,
      TPGParameters.Tmin,
      TPGParameters.TOpt,
      TPGParameters.TMax);
  except
    on E:exception do begin
      formWarnings.memowarnings.lines.Add('There was a problem calculating the temperature modifier: ' +
        E.Message);
    end;
  end;

  //calculate VPD modifier.  VPD needs to be in mBar
  fVPD := Exp(-TPGParameters.CoeffCond * VPDToday);

  ASWInUpperHalfRootZone_mm := 0;
  ASWInRootZone_mm := 0;
  MyMaxASW := 0;

  //calculate soil water modifier
  for i := 0 to round(RootDepth_m*10)-1 do begin
      ASWInRootZone_mm := ASWLayers[i] + ASWInRootZone_mm;

      if (i  < max(1,round(RootDepth_m*10/2))) then begin
        ASWInUpperHalfRootZone_mm := ASWLayers[i] + ASWInUpperHalfRootZone_mm;
      end;

      if (ASWLayers[i] > MyMaxASW) then
        MyMaxASW := ASWLayers[i];

  end;

  RelSWC := min(1,(ASWInRootZone_mm - inputsiteinfo.MinASW * RootDepth_m)/
    (InputSiteInfo.MaxASW * RootDepth_m - InputSiteInfo.MinASW * RootDepth_m));
  //RelSWC := min(1,MyMaxASW/(InputSiteInfo.MaxASW * 0.1));
  //RelSWC := min(1,(MyMaxASW- InputSiteInfo.MinASW*0.1)/((InputSiteInfo.MaxASW- InputSiteInfo.MinASW) * 0.1));

  PDLWP := (-0.2 - TPGParameters.PSIMin) *
    ((1/(1-exp(-InputSiteInfo.SoilClass)))*
    (1-exp(-InputSiteInfo.SoilClass*RelSWC)))
    +TPGParameters.PSIMin;

  fSW := max(0.1,min(1,1-PDLWP/TPGParameters.PSIMin));

  //calculate soil nutrition modifier
  If TPGParameters.fNn = 0 Then
    fNutr := 1
  Else
    fNutr := 1 - (1 - TPGParameters.fN0) * power((1 - FertRating),TPGParameters.fNn);

  //calculate age modifier
  If TPGParameters.nAge = 0 Then
    fAge := 1
  Else begin
      RelAge := StandAge / TPGParameters.maxAge;
      fAge := (1 / (1 + power((RelAge / TPGParameters.rAge),TPGParameters.nAge)));
  End;

  //calculate physiological modifier applied to conductance and alphaCx.
  PhysMod := Min(fVPD, fSW) * fAge;

  //Determine gross and net biomass production

  //canopy cover and light interception.
  If (TPGParameters.fullCanAge > 0) And (StandAge < TPGParameters.fullCanAge) Then
    CanCover := (StandAge + 0.01) / TPGParameters.fullCanAge
  Else
    CanCover := 1;

  LightIntcptn := (1 - (Exp(-TPGParameters.k * LAI / CanCover)));

  //Calculate NPP
  alphaC := TPGParameters.alphaCx * fNutr * fT * PhysMod;
  epsilon := gDM_mol * molPAR_MJ * alphaC;
  RAD := InputWeatherData[DayCounter].SolRad;        //MJ/m^2
  RADint := RAD * lightIntcptn * CanCover;
  GPP := epsilon * RADint / 100;               //tDM/ha
  NPP := GPP * TPGParameters.y;             //assumes respiratory rate is constant

  //******************************
  //Now do the water balance ...

  //calculate canopy conductance and transpiration
  CanCond := TPGParameters.MaxCond * PhysMod * Min(1, LAI / TPGParameters.LAIgcx);

  //Calculate minimum leaf water potential based on the VPD modifier
  MDLWP := PDLWP - 1;
    //(TPGParameters.DeltaPSIMax + (TreeHt_m * TPGParameters.TreeHtHyd))*fVPD;

  Transp := getTranspiration(TPGParameters.Qa,TPGParameters.Qb,
    InputWeatherData[DayCounter].SolRad, VPDToday,
    General.GetDayLength((InputSiteInfo.Latitude),InputWeatherData[DayCounter].LogDate),
    TPGParameters.BLCond, CanCond);

  //water balance
  SupIrrig := 0;
  ASWInRootZone_mm := 0;

  //Calculate rainfall interception
  FracRainIntcptn := min(1,TPGParameters.Maxintcptn/TPGParameters.LAImaxIntcptn);
  RainIntcptn := fracRainIntcptn * LAI;

  AvailableTopUp_mm := max(0,InputWeatherData[DayCounter].Rainfall -
     RainIntcptn);

  for i := 0 to Length(ASWLayers)-1 do begin

    if ASWLayers[i] + AvailableTopUp_mm < InputSiteInfo.MaxASW * 0.1 then begin
      ASWLayers[i] := ASWLayers[i] + AvailableTopUp_mm;
      AvailableTopUp_mm := 0;
    end else begin
      AvailableTopUp_mm := AvailableTopUp_mm + ASWLayers[i] - InputSiteInfo.MaxASW * 0.1;
      ASWLayers[i] :=  InputSiteInfo.MaxASW * 0.1;
    end;

    if (i > 0) and (i <= RootDepth_m*10) then begin
      if ASWLayers[i-1] <> ASWLayers[i]  then begin
        ASWLayers[i -1] := (ASWLayers[i-1] + ASWLayers[i])/2;
        ASWLayers[i] :=  ASWLayers[i -1];
      end;
    end;

    if round(RootDepth_m * 10)-1 >= i then
     ASWInRootZone_mm := ASWLayers[i] + ASWInRootZone_mm;
  end;

  EvapTransp := Min(ASWInRootZone_mm, Transp + RainIntcptn);              //ET can not exceed ASW
  excessSW := Max(ASWInRootZone_mm - EvapTransp - InputSiteInfo.MaxASW*InputSiteInfo.SoilDepth, 0);

  MySoilEvap_mm := min(((1 - min(0.9,LAI/TPGParameters.LAImaxIntcptn))
    * InputWeatherData[DayCounter].Evap)
    *(ASWLayers[0]/(InputSiteInfo.MaxASW * 0.1)),
    InputWeatherData[DayCounter].Evap*0.01);

  formDetailedGraphs.Chart_EvapTrans.Series[0].AddXY(InputWeatherData[DayCounter].LogDate,
    EvapTransp);
  formDetailedGraphs.Chart_EvapTrans.Series[1].AddXY(InputWeatherData[DayCounter].LogDate,
    MySoilEvap_mm);
  formDetailedGraphs.Chart_EvapTrans.Series[2].AddXY(InputWeatherData[DayCounter].LogDate,
     ASWInRootZone_mm);

  //MySoilEvap_mm := 0;
  ASWInRootZone_mm := 0;

  RemET := EvapTransp + MySoilEvap_mm;
  DepthDivider := max(0.25,1/max(1,round(RootDepth_m * 10/3)));

  for i := 0 to round(RootDepth_m * 10)-1 do begin

    if ASWLayers[i] > InputSiteInfo.MinASW * 0.1 then
      PotETFromLayer := Min(ASWLayers[i] - InputSiteInfo.MinASW * 0.1,RemET * DepthDivider)
    else
      PotETFromLayer := 0;

    ASWLayers[i] := max(InputSiteInfo.MinASW * 0.1,
      ASWLayers[i] - PotETFromLayer);

    ASWInRootZone_mm := ASWLayers[i] + ASWInRootZone_mm;

    RemET := RemET - PotETFromLayer;

  end;

  //correct for actual ET
  if Transp + RainIntcptn > 0 then
    TranspScaleFactor := EvapTransp / (Transp + RainIntcptn) //scales NPP and GPP
  else
    TranspScaleFactor := 0;

  GPP := TranspScaleFactor * GPP;
  NPP := TranspScaleFactor * NPP;
  If EvapTransp <> 0 Then
    WUE := 100 * NPP / EvapTransp         //in case ET is zero!
  else
    WUE := 0;

  formdetailedgraphs.CHart_NPPStand_SPH.Series[0].AddXY(InputWeatherData[DayCounter].LogDate,
    NPP);
  formdetailedgraphs.CHart_NPPStand_SPH.Series[1].AddXY(InputWeatherData[DayCounter].LogDate,
    MyStemNo);

 //******************************************************
 //Determine biomass increments and losses

  //calculate partitioning coefficients
  m :=  TPGParameters.m0 + (1 - TPGParameters.m0) * fNutr;
  //pFS := pfsConst * power(BaseDiam_mm/10,pfsPower);

  //if RootDepth_m < InputSiteInfo.SoilDepth then
    pR := TPGParameters.pRx * TPGParameters.pRn /
      (TPGParameters.pRn + (TPGParameters.pRx - TPGParameters.pRn) * PhysMod * m);
  //else
    //pR := TPGParameters.gammaR;}

  {MeanRingWidth_cm := (BaseDiam_mm/10)/2/max(StandAge,1);
  StemArea_cm2 := power((BaseDiam_mm/10)/2,2) * pi;
  HWArea_cm2 := power(max(0,((BaseDiam_mm/10)/2 - MeanRingWidth_cm * 2)),2)*pi;
  SWArea_cm2 := StemArea_cm2 - HWArea_cm2;

  TargetLeafArea_m2 := SWArea_cm2/5;

  CurrentLeafArea_m2 := WF*1000/MyStemNo * SLA;

  LARatio := max(0,min(1,TargetLeafArea_m2/CurrentLeafArea_m2));  }

  pR := pR * min(1,1/INputSiteInfo.SoilClass);

  //Calculate the foliage stem allocation based on the size of the stem
  CurrentpFS := min(max(min(TPGParameters.pFS20,TPGParameters.pFS2),
    ((TPGParameters.pFS20 - TPGParameters.pFS2)*(BaseDiam_mm/10 - 2))/
    (20 - 2) + TPGParameters.pFS2),
    max(TPGParameters.pFS20,TPGParameters.pFS2));

  pS := (1-pR)*CurrentpFS;
  pF := 1 - (pR + pS);

  //pF := min(PhysMod,(1-pR) * power(LARatio,1));
  //pS := 1 - (pR + pF);

  //calculate biomass increments
  incrWF := NPP * pF;
  incrWR := NPP * pR;
  incrWS := NPP * pS;

  //calculate litterfall & root turnover -
  lossWF := gammaF * WF;
  lossWR := TPGParameters.gammaR * WR;

  //Calculate the day's biomass

  WF := WF + incrWF - lossWF;
  WR := WR + incrWR - lossWR;
  WS := WS + incrWS;
  TotalW := WF + WR + WS;

  wSmax := TPGParameters.wSx1000 * power((1000 / MyStemNo),TPGParameters.thinPower);
  AvStemMass_kg := WS * 1000 / MyStemNo;

  If wSmax < AvStemMass_kg Then begin
    delStems := getMortality(MyStemNo, WS,TPGParameters.mS,TPGParameters.wSx1000,
      TPGParameters.thinPower);
    WF := WF - (WF * delStems/MyStemNo);
    WS := WS - (WS * delStems/MyStemNo);
    WR := WR - (WR * delStems/MyStemNo);

    MyStemNo := MyStemNo - delStems;
    wSmax := TPGParameters.wSx1000 * power((1000 / MyStemNo),TPGParameters.thinPower);
    AvStemMass_kg := WS * 1000 / MyStemNo;
  End;

  StemVol_m3 := ((WS*1000)/MyStemNo)/MeanWD_Kgperm3;
  //StemVol_m3 := ((WS*1000)/MyStemNo)/500;
  TreeHt_m := min(TreeHt_m + 0.05,
    max(TreeHt_m,max(BaseDiam_mm/10*TPGParameters.MinHDRatio,
    min(BaseDiam_mm/10*TPGParameters.MaxHDRatio,
    (StemVol_m3*3)/(pi*power((BaseDiam_mm/2000),2))))));

  //update stand characteristics
  LAI := WF * SLA * 0.1;

  OutputData.LogDate := InputWeatherData[DayCounter].LogDate;
  OutputData.LAI := LAI;
  OutputData.NPP_tperha := NPP;
  OutputData.GPP_tperha := GPP;
  OutputData.SPH := round(MyStemNo);
  OutputData.etaf := pF;
  OutputData.etacr := pR;
  OutputData.etas := pS;
  OutputData.MinTemp := InputWeatherData[DayCounter].MinTemp;
  OutputData.MaxTemp := InputWeatherData[DayCounter].MaxTemp;
  OutputData.Rain := InputWeatherData[DayCounter].Rainfall;
  OutputData.SWCRZ := ASWInRootZone_mm;

  OutputData.PDWP_Mpa := PDLWP;
  OutputData.MDWP_Mpa := MDLWP;
  OutputData.SWC := ASWInRootZone_mm;
  OutputData.wfr := WR *0.1;
  OutputData.wcr := WR *0.9;
  OutputData.wf := WF;
  OutputData.ws := WS;
  OutputData.Transp := Transp;
  OutputData.VPD_kpa := VPDToday/10;
  OutputData.DayLength := General.GetDayLength((InputSiteInfo.Latitude),InputWeatherData[DayCounter].LogDate);
  OutputData.TreeHt_m := TreeHt_m;
  OutputData.FinalStandVol :=  round(MyStemNo) * StemVol_m3;

  Result := OutputData;
end;

end.
