unit unitSplasForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls;

type
  TformSplasForm = class(TForm)
    Image: TImage;
    StartupTimer: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure StartupTimerTimer(Sender: TObject);
    constructor CreateNew(AOwner: TComponent; Dummy: Integer  = 0); overload; virtual;
  private
    FInitialized: Boolean;
  public
  end;

var
  formSplasForm: TformSplasForm;

implementation

{$R *.dfm}

uses unitHelpers, unitPrincipal;

constructor TformSplasForm.CreateNew(AOwner: TComponent; Dummy: Integer);
begin
  Inherited;
  OnPaint := FormPaint;
end;


procedure TformSplasForm.FormPaint(Sender: TObject);
begin
  Image.carregapng(Format('%sImagens\Logo.png', [ExtractFilePath(ParamStr(0))]));
  Position := TPosition.poScreenCenter;
  BorderStyle := TFormBorderStyle.bsNone;
end;

procedure TformSplasForm.FormCreate(Sender: TObject);
begin
{
  Image.carregapng(Format('%sImagens\Logo.png', [ExtractFilePath(ParamStr(0))]));
  Position := TPosition.poScreenCenter;
  BorderStyle := TFormBorderStyle.bsNone;
  StartupTimer.Enabled := True;
  StartupTimer.Interval := 1500;
  }
end;

procedure TformSplasForm.StartupTimerTimer(Sender: TObject);
begin
{
  StartupTimer.Enabled := false;
  if not FInitialized then begin
    FInitialized := true;
    LoadMainForm;
  end;
  }
end;

end.
