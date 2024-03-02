unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, XPMan,Math;

type
  TForm1 = class(TForm)
    trckbr_prescaler: TTrackBar;
    edt_abp_freq: TEdit;
    lbl1: TLabel;
    edt_arr_duty: TEdit;
    edt_pwm_freq: TEdit;
    edt_prescaler: TEdit;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    pnl1: TPanel;
    btn1: TButton;
    btn2: TButton;
    xpmnfst1: TXPManifest;
    stat1: TStatusBar;
    procedure trckbr_prescalerChange(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure edt_prescalerChange(Sender: TObject);
    procedure edt_prescalerKeyPress(Sender: TObject; var Key: Char);
    procedure edt_abp_freqKeyPress(Sender: TObject; var Key: Char);
    procedure edt_arr_dutyKeyPress(Sender: TObject; var Key: Char);
    procedure edt_pwm_freqKeyPress(Sender: TObject; var Key: Char);
    procedure edt_arr_dutyChange(Sender: TObject);
    procedure edt_abp_freqChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.trckbr_prescalerChange(Sender: TObject);
var
  abp_freq:Extended;
  arr:Integer;
  pwm_freq:Extended;
  prescaler:Integer  ;
  timerFreq:Extended;
  timerPeriod:Extended;

begin

      if not (edt_abp_freq.Text = '') and not (edt_arr_duty.Text = '') and not (edt_prescaler.Text = '') then
    begin

    abp_freq := StrToFloat(edt_abp_freq.text);//StrToInt(edt_abp_freq.text);
    arr := StrToInt(edt_arr_duty.text)  ;
    prescaler :=  trckbr_prescaler.Position ;
    edt_prescaler.Text := IntToStr(prescaler);



    timerFreq := (abp_freq / prescaler); // mhz
    timerFreq := (timerFreq * 1000000) / arr ;

    timerPeriod := 1 / timerFreq ; // saniye 



    pwm_freq :=   (abp_freq * 1000) / (arr * prescaler );
    edt_pwm_freq .Text := FloatToStr(pwm_freq);

    stat1.Panels.Items[0].Text := 'Timer freq = ' +  formatfloat('0.0000000', timerFreq) + ' Hz';//(abp_freq / prescaler)) + ' Khz';
    stat1.Panels.Items[1].Text := 'Timer sec = ' +  formatfloat('0.0000000', timerPeriod) + ' sn';//(1 / (abp_freq*1000000 / prescaler))) + ' sec';
    stat1.Panels.Items[2].Text := 'PWM freq = ' +  formatfloat('0.0000000', pwm_freq) + ' Khz';
    stat1.Panels.Items[3].Text := 'ARR Counter Period  = ' +  formatfloat('0', arr -1) ;
    stat1.Panels.Items[4].Text := 'Prescaler = ' +  formatfloat('0', prescaler -1) ;
      end;
end;

procedure TForm1.btn1Click(Sender: TObject);
begin
 trckbr_prescaler.Position :=  trckbr_prescaler.Position-1;
end;

procedure TForm1.btn2Click(Sender: TObject);
begin
     trckbr_prescaler.Position :=  trckbr_prescaler.Position+1;
end;

procedure TForm1.edt_prescalerChange(Sender: TObject);
begin
    trckbr_prescaler.Position:= StrToInt(edt_prescaler.Text);
end;

procedure TForm1.edt_prescalerKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8, '.', '-']) then Key := #0;
  {
if not (Key in [#8, '0'..'9', '-', FormatSettings.DecimalSeparator]) then
 begin
    ShowMessage('Invalid key: ' + Key);
    Key := #0;
  end
  else if ((Key = FormatSettings.DecimalSeparator) ) and
          (Pos(Key, edt_prescaler.Text) > 0) then begin
    ShowMessage('Invalid Key: twice ' + Key);
    Key := #0;
  end ;
         }
end;

procedure TForm1.edt_abp_freqKeyPress(Sender: TObject; var Key: Char);
begin

   if not (Key in ['0'..'9', #8, ',']) then Key := #0;

  {
if not (Key in [#8, '0'..'9', '-', FormatSettings.DecimalSeparator]) then
 begin
    ShowMessage('Invalid key: ' + Key);
    Key := #0;
  end
  else if ((Key = FormatSettings.DecimalSeparator) ) and
          (Pos(Key, edt_prescaler.Text) > 0) then begin
    ShowMessage('Invalid Key: twice ' + Key);
    Key := #0;
  end ;
  }
end;

procedure TForm1.edt_arr_dutyKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8, ',']) then Key := #0;
         {
if not (Key in [#8, '0'..'9', '-', FormatSettings.DecimalSeparator]) then
 begin
    ShowMessage('Invalid key: ' + Key);
    Key := #0;
  end
  else if ((Key = FormatSettings.DecimalSeparator) ) and
          (Pos(Key, edt_prescaler.Text) > 0) then begin
    ShowMessage('Invalid Key: twice ' + Key);
    Key := #0;
  end ;
      }
end;

procedure TForm1.edt_pwm_freqKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8, ',']) then Key := #0;
     {
if not (Key in [#8, '0'..'9', '-', FormatSettings.DecimalSeparator]) then
 begin
    ShowMessage('Invalid key: ' + Key);
    Key := #0;
  end
  else if ((Key = FormatSettings.DecimalSeparator) ) and
          (Pos(Key, edt_prescaler.Text) > 0) then begin
    ShowMessage('Invalid Key: twice ' + Key);
    Key := #0;
  end ;
        }
end;

procedure TForm1.edt_arr_dutyChange(Sender: TObject);
begin
trckbr_prescalerChange(Self);
end;

procedure TForm1.edt_abp_freqChange(Sender: TObject);
begin
trckbr_prescalerChange(Self);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
trckbr_prescalerChange(Self);
end;

end.
