unit unitCompsABC;

interface
uses
	System.Classes, Vcl.ExtCtrls, vcl.stdCtrls, SysUtils, Vcl.Forms;

type
  TEditABC = class(TEdit)
    constructor Create(AOwner: TComponent); override;
    procedure ABCKeyPress(Sender: TObject; var Key: Char);
    procedure EditExit(Sender: TObject);
  private
    FPattern: string;
  protected
  public
  published
    property Pattern: String Read FPattern write FPattern;
  end;

implementation

uses uKeyPress;
constructor TEditABC.Create(AOwner: TComponent);
begin
  OnKeyPress := ABCKeyPress;
  OnExit := EditExit;
  Inherited;
  Enabled := False;
  BorderStyle := bsNone;

end;

procedure TEditABC.ABCKeyPress(Sender: TObject; var Key: Char);
begin
  if Pattern <> '' then
    begin
      if TKeyPress.FPattern <> Pattern then
        TKeyPress.FPattern := Pattern;
      TKeyPress.KeyPress(Sender,Key);
    end;
end;

procedure TEditABC.EditExit(Sender: TObject);
var
  v: Real;
begin
  with TEdit(Sender) do begin
    v := StrToFloatDef(Text, 0);
    Text := FloatToStrF(v, ffNumber, 4, 2);
  end;
end;


end.
