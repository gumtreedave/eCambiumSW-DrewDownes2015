unit Event;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, DataObjects,AddEditData,DBGrids,Grids,
  General;

type
  TformEvent = class(TForm)
    rgEventType: TRadioGroup;
    leAge: TLabeledEdit;
    leValue: TLabeledEdit;
    Panel1: TPanel;
    bbnCreateEvent: TBitBtn;
    bbnCancel: TBitBtn;
    procedure rgEventTypeClick(Sender: TObject);
    procedure bbnCreateEventClick(Sender: TObject);
    procedure bbnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

Procedure BuildRegime(RegimeName: String;
  EventType : String;
  EventAge : String;
  EventValue : String;
  EventValueMin,EventValueMax : Double;
  EstablishmentDate: TDate;
  HarvestDate : TDate;
  var CurrentRegimeDataArray: TRegimeDataArray);



var
  formEvent: TformEvent;

const
  EVENTPLANT = 'Establishment';
  EVENTTHIN = 'Thinning';
  EVENTPRUN = 'Pruning';
  EVENTFERT = 'Fertilization';
  EVENTHARVEST = 'Harvest';

implementation

{$R *.dfm}

procedure TformEvent.bbnCancelClick(Sender: TObject);
begin
  formEvent.Close;
  if formAddEditData.lbRegimeNames.ItemIndex > -1 then
      SaveRegimeChanges(formAddEditData.lbRegimeNames.Items[formAddEditData.lbRegimeNames.ItemIndex]);
end;

procedure TformEvent.bbnCreateEventClick(Sender: TObject);
var
  EventType : String;
  EventValueMin,EventValueMax : Double;
begin
  case rgEventType.ItemIndex of
    0 : begin
      EventType := EVENTTHIN;
      EventValueMin := 0;
      EventValueMax := strtofloat(formAddEditData.leInitialSpacing.Text);
    end;
    1 : begin
      EventType := EVENTFERT;
      EventValueMin := 0;
      EventValueMax := 1;
    end;
    2 : begin
      EventType := EVENTPRUN;
      EventValueMin := 0;
      EventValueMax := 1;
    end;

  end;

  if leValue.Text <> '' then begin
    if leAge.Text <> '' then begin

      BuildRegime(formAddEditData.lbRegimeNames.items[formAddEditData.lbRegimeNames.ItemIndex],
        EventType,leAge.Text,leValue.Text,EventValueMin,EventValueMax,
        formAddEditData.DateTimePicker1.Date,
        formAddEditData.DateTimePicker2.Date,
        CurrentRegimeDataArray);

      UpdateRegimeSG(CurrentRegimeDataArray,
        formAddEditData.sgRegimeEvents);

    end else
      Messagedlg('Specify the age of the stand at which the event will take place',
        mtError,[mbOK],0);
  end else
    Messagedlg('Specify a value for the event',mtError,[mbOK],0);

end;

Function CreateEvent(RegimeName: String;
  EventType : String;
  EventDate: TDate;
  EventValue : Double): TRegimeData;
begin
  Result.RegimeName := RegimeName;
  Result.EventType := EventType;
  Result.EventDate := EventDate;
  Result.EventValue := EventValue;
end;


Procedure BuildRegime(RegimeName: String;
  EventType : String;
  EventAge : String;
  EventValue : String;
  EventValueMin,EventValueMax : Double;
  EstablishmentDate: TDate;
  HarvestDate : TDate;
  var CurrentRegimeDataArray: TRegimeDataArray);
var
  NewEvent : TRegimeData;
  EventDate : TDate;
  EventValue_Flt : Double;
  i : integer;
begin
  try
    EventDate := EstablishmentDate + strtofloat(EventAge)*365.25;

    if (EventDate < HarvestDate) and (EventDate > EstablishmentDate) then begin
      if strtofloat(EventValue) >= EventValueMin then begin
        if strtofloat(EventValue) <= EventValueMax then begin

          try
            EventValue_Flt := strtofloat(EventValue);

            SetLength(CurrentRegimeDataArray,Length(CurrentRegimeDataArray) + 1);

            NewEvent := CreateEvent(RegimeName,EventType,EventDate,EventValue_Flt);

            i := Length(CurrentRegimeDataArray) -1;

            CurrentRegimeDataArray[i] := NewEvent;
          except
            on E:Exception do
              Messagedlg('There was a problem with the specified event value: ' + E.Message,
              mtError,[mbOK],0);
          end;
        end else
          Messagedlg('The event value must be less than ' + floattostr(EventValueMax),mtError,[mbOK],0);

      end else
        Messagedlg('The event value must be greater than ' + floattostr(EventValueMin),mtError,[mbOK],0);
    end else
      Messagedlg('The regime event must fall within the specified rotation',
        mtError,[mbOK],0);
  except
    on E: Exception do
      Messagedlg('There was a problem with the specified event age: ' + E.Message,
        mtError,[mbOK],0);
  end;
end;


procedure TformEvent.rgEventTypeClick(Sender: TObject);
begin
  case rgEventType.ItemIndex of
    0 : leValue.EditLabel.Caption := 'Residual stand density (stems/Ha)';
    1 : leValue.EditLabel.Caption := 'Expected gain in "fertility rating" (0 - 1)';
    2 : leValue.EditLabel.Caption := 'Pruning intensity (0 (none) - 1 (whole crown))';

  end;
end;

end.
