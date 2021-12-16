program PostoABC;

uses
  Vcl.Forms,
  System.SysUtils,
  unitPrincipal in 'unitPrincipal.pas' {formPrincipal},
  unitDM in 'unitDM.pas' {dm: TDataModule},
  unitHelpers in 'unitHelpers.pas',
  unitReport in 'unitReport.pas' {formReport},
  unitSplashScreen in 'unitSplashScreen.pas' {formSplashScreen},
  uKeyPress in 'uKeyPress.pas',
  unitCompsABC in 'unitCompsABC.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  FormSplashScreen := TformSplashScreen.SplashForm;
  Application.ProcessMessages;
  sleep(1000);
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TformPrincipal, formPrincipal);
  Application.CreateForm(TformReport, formReport);
  Application.Run;
end.
