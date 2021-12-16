unit unitPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.Buttons,
  unitCompsABC, System.RegularExpressions, Vcl.ButtonGroup;

type
  TformPrincipal = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure btnGasolinaClick(Sender: TObject);
    procedure btnDieselClick(Sender: TObject);
    procedure ImageSairClick(Sender: TObject);
    procedure ImageReportClick(Sender: TObject);
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure EditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    ImageGasolina, ImageDiesel: TImage;
    btnGasolina, btnDiesel: TButton;
    fprecoGasolina, fprecoDiesel: Real;
    edValorGasolina, edLitrosGasolina, edValorDiesel, edLitrosDiesel: TEditABC;
    RadioGroupGasolina, RadioGroupDiesel: TRadioGroup;
    procedure GarregaConfiguracoes;
  public
    property precoGasolina: Real read fprecoGasolina;
    property precoDiesel: Real read fprecoDiesel;
  end;

var
  formPrincipal: TformPrincipal;
const
  PatternValores = '^\d{1,3}(.\d{0,3})?[\b]?';
  PatternLitros = '^\d{1,3}(.\d{0,2})?[\b]?';


implementation
uses System.IniFiles, pngimage, unitHelpers, unitReport, uKeyPress, unitDM;
{$R *.dfm}


procedure carregapng(image1: TImage; arquivo: String);
begin
  var Stream := TMemoryStream.Create;
  try
    var Image := TPngImage.Create;
    try
      Stream.Position := 0;
      Image.LoadFromStream(Stream);
      Image1.Picture.Graphic := Image;
    finally
      Image.Free;
    end;
  finally
    Stream.Free;
  end;
end;


procedure TformPrincipal.EditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  litros: Float32;
begin
  var ativo := TEdit(Sender).Text <> '';
  litros := 0;
  case TEdit(Sender).Tag of
    1 :  begin
            btnGasolina.Enabled :=  ativo;
            if ativo then
              litros := StrToFloat(edValorGasolina.Text) / precoGasolina;
            edLitrosGasolina.Text := FloatToStrF(litros, ffNumber, 4, 2);
         end;
    2 :  begin
           btnDiesel.Enabled :=  ativo;
           if ativo then
             litros := StrToFloat(edValorDiesel.Text) / precoDiesel;
           edLitrosDiesel.Text := FloatToStrF(litros, ffNumber, 4, 2);
         end

  end;
end;

procedure TformPrincipal.EditKeyPress(Sender: TObject; var Key: Char);
begin
  TEditABC(Sender).ABCKeyPress(Sender, Key);
end;

procedure TformPrincipal.ImageSairClick(Sender: TObject);
begin
  Close;
end;

procedure TformPrincipal.GarregaConfiguracoes;
var
   Ini: TIniFile;
 begin
   Ini := TIniFile.Create( ChangeFileExt( Application.ExeName, '.INI' ) );
   try
     fPrecoGasolina  := Ini.ReadFloat('Preco', 'Gasolina', 0 );
     fPrecoDiesel    := Ini.ReadFloat( 'Preco', 'Diesel', 0 );
   finally
     Ini.Free;
   end;
 end;

procedure TformPrincipal.FormCreate(Sender: TObject);
begin

  GarregaConfiguracoes;

  Width := 1024;
  Height := 768;
  Position := TPosition.poScreenCenter;
  BorderStyle := TFormBorderStyle.bsNone;

  var PanelTop := TPanel.Create(self);
  with PanelTop do begin
    Parent := Self;
    Align := TAlign.alTop;
    BorderStyle := bsNone;
    Caption := 'POSTO  A B C';
    Font.Size := 40;
    Height := 100;
  end;

  var PanelButton := TPanel.Create(self);
   with PanelButton do begin
    Parent := Self;
    Align := TAlign.alBottom;
    Height := 70;
    BevelOuter := bvNone;
    Margins.Top := 50;
    AlignWithMargins := True
   end;



  var ImageReport := TImage.Create(self);
  with ImageReport do begin
    Parent := PanelButton;
    Width := 90;
    Align := TAlign.alLeft;
    carregapng(Format('%sImagens\Report.png', [ExtractFilePath(ParamStr(0))]));
    Stretch := True;
    OnClick := ImageReportClick;
  end;


  var ImageExit := TImage.Create(self);
  with ImageExit do begin
    Parent := PanelButton;
    Width := 90;
    Align := TAlign.alRight;
    Stretch := True;
    carregapng(Format('%sImagens\Exit.png', [ExtractFilePath(ParamStr(0))]));
    OnClick := ImageSairClick;
  end;


  ImageGasolina := TImage.Create(self);
  with ImageGasolina do begin
    Parent := Self;
    Width := 400;
    Align := TAlign.alLeft;
    Stretch := True;
    Transparent := True;
    carregapng(Format('%sImagens\Gasolina.png', [ExtractFilePath(ParamStr(0))]));
    Margins.Bottom := 40;
    Margins.Bottom :=50;
  end;

  edValorGasolina := TEditABC.Create(self);
  with edValorGasolina do begin
    Parent := Self;
    Enabled := True;
    Alignment := TAlignment.taCenter;
    Font.Size := 10;
    Font.Style := [fsBold];
    Left := 145;
    Top := 202;
    Width := 110;
    Tag := 1; //Identifica o edit da gasolina
    Pattern := PatternValores;
    OnKeyPress := EditKeyPress;
    OnKeyUp := EditKeyUp;
  end;

  edLitrosGasolina := TEditABC.Create(self);
  with edLitrosGasolina do begin
    Parent := Self;
    Alignment := TAlignment.taCenter;
    Color := clSilver;
    Font.Size := 10;
    Font.Style := [fsBold];
    Left := 145;
    Top := 235;
    Width := 110;
    Pattern := PatternLitros;
  end;

  RadioGroupGasolina := TRadioGroup.Create(self);
  with RadioGroupGasolina do begin
    Parent := Self;
    ShowFrame := False;
    Columns := 2;
    items.Text := 'Bomba 1'#$D#$A'Bomba 2';
    ItemIndex := 0;
    Height := 40;
    Left := 120;
    top := 320;
  end;

  var edPrecoGasolina := TEditABC.Create(self);
  with edPrecoGasolina do begin
    Parent := Self;
    Alignment := TAlignment.taCenter;
    Font.Size := 14;
    Font.Style := [fsBold];
    Left := 155;
    Top := 405;
    Width := 90;
    Text := FloatToStrF(fprecoGasolina, ffCurrency, 4, 3);
  end;

  btnGasolina := TButton.Create(self);
  with btnGasolina do begin
    Parent := Self;
    Left := 165;
    Top := 490;
    Caption := 'Abastecer';
    OnClick := btnGasolinaClick;
    Enabled := False;
  end;

//************************* Abaixo criação dos componentes para DIESEL ****************************

  ImageDiesel := TImage.Create(self);
  with ImageDiesel do begin
    Parent := Self;
    Width := 400;
    Align := TAlign.alRight;
    Stretch := True;
    Transparent := True;
    Margins.Bottom :=50;
    carregapng(Format('%sImagens\Diesel.png', [ExtractFilePath(ParamStr(0))]));
  end;

  edValorDiesel := TEditABC.Create(self);
  with edValorDiesel do begin
    Parent := Self;
    Enabled := True;
    Alignment := TAlignment.taCenter;
    Font.Size := 10;
    Font.Style := [fsBold];
    Left := 772;
    Top := 204;
    Width := 110;
    Tag := 2; //Identifica o edit do diesel
    Pattern := PatternValores;
    OnKeyPress := EditKeyPress;
    OnKeyUp := EditKeyUp;
  end;

  edLitrosDiesel := TEditABC.Create(self);
  with edLitrosDiesel do begin
    Parent := Self;
    Alignment := TAlignment.taCenter;
    Color := clSilver;
    Font.Size := 10;
    Font.Style := [fsBold];
    Left := 772;
    Top := 237;
    Width := 110;
    Pattern := PatternLitros;
    OnKeyPress := EditKeyPress;
  end;

  RadioGroupDiesel := TRadioGroup.Create(self);
  with RadioGroupDiesel do begin
    Parent := Self;
    ShowFrame := False;
    Columns := 2;
    items.Text := 'Bomba 1'#$D#$A'Bomba 2';
    ItemIndex := 0;
    Height := 40;
    Left := 745;
    top := 320;
  end;

  var edPrecoDiesel := TEditABC.Create(self);
  with edPrecoDiesel do begin
    Parent := Self;
    Alignment := TAlignment.taCenter;
    Font.Size := 14;
    Font.Style := [fsBold];
    Left :=780;
    Top := 405;
    Width := 90;
    Text := FloatToStrF(fprecoDiesel, ffCurrency, 4, 3);
  end;

  btnDiesel := TButton.Create(self);
  with btnDiesel do begin
    Parent := Self;
    Left := 788;
    Top := 490;
    Caption := 'Abastecer';
    OnClick := btnDieselClick;
    Enabled := False;
  end;
end;


procedure TformPrincipal.btnGasolinaClick(Sender: TObject);
begin

  var s :=  'INSERT INTO abastecimentos(tanque, bomba, litros, valor) values(1,:b,:l,:v)';
  var litros := edLitrosGasolina.Text;
  var valor := edValorGasolina.Text;
  dm.FDConnection.Open;
  dm.FDConnection.ExecSQL(s, [RadioGroupGasolina.ItemIndex + 1, litros, valor]);
  dm.FDConnection.Close;
  edValorGasolina.Text := '';
  edLitrosGasolina.Text := '';

end;

procedure TformPrincipal.btnDieselClick(Sender: TObject);
begin
  var s :=  'INSERT INTO abastecimentos(tanque, bomba, litros, valor) values(2,:b,:l,:v)';
  var litros := edLitrosDiesel.Text;
  var valor := edValorDiesel.Text;
  dm.FDConnection.Open;
  dm.FDConnection.ExecSQL(s, [RadioGroupDiesel.ItemIndex + 1, litros, valor]);
  dm.FDConnection.Close;
  edValorDiesel.Text := '';
  edLitrosDiesel.Text := '';
end;

procedure TformPrincipal.ImageReportClick(Sender: TObject);
begin
  formReport.RLReport.Preview()
end;

initialization
  FormatSettings.DecimalSeparator := '.';
  FormatSettings.ThousandSeparator := ',';
end.
