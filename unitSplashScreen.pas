unit unitSplashScreen;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls;

type
  TformSplashScreen = class(TForm)
    class function SplashForm: TformSplashScreen;
  private
  public
  end;

var
  FormSplashScreen: TformSplashScreen;

implementation

{$R *.dfm}

uses unitHelpers, unitPrincipal;

class function TformSplashScreen.SplashForm:TFormSplashScreen;
var
   f: TFormSplashScreen;
begin
  f := TFormSplashScreen.CreateNew(nil, 0);
  with f do begin
    BorderStyle := bsNone;
    Position := poSCreenCenter;

    var pnl := TPanel.Create(f);
    with pnl do begin
      parent := f;
      Align := alClient;
      BevelOuter := bvNone;
    end;


    Color := clWhite;

    var image := TImage.Create(f);
    with image do begin
      Parent := pnl;
      Align := TAlign.alClient;
      carregapng(Format('%sImagens\Logo.png', [ExtractFilePath(ParamStr(0))]));
    end;

    Width := 516;
    Height := 289;
    Show;
  end;

  result := f;
end;


end.
