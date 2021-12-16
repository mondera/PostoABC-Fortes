unit uKeyPress;

interface
uses System.Rtti, System.SysUtils, System.StrUtils, System.RegularExpressions; //Vcl.StdCtrls;
  type
  TKeyPress = class
  public
  //Definie qual o conjunto de caracter permitido para o Controle
  class Var FPattern:String;
  //M�todo que motificara ou n�o o Key digitado no controle
  class procedure KeyPress(Sender: TObject; var Key:Char);
  private
  //M�todo interno que montar� um previem do Texto digitado no controle
  //esses texto ser� analizado se � um texto v�lido ou n�o
  class function Formats_Inputs(sender:Tobject;const key:Char):String;
  end;


implementation

class function TKeyPress.Formats_Inputs(sender: Tobject;const key:Char): String;
const
  Property_Array : Array [0..2] of String = ('Text','SelLength','SelStart');
var
  Context:TRttiContext;
  Prop:TRttiProperty;
  Tipo:TRttiType;
  _SelStart:Integer;
  _SelLength:integer;
begin
  result:=EmptyStr; //inicializa
  Tipo:=Context.GetType(Sender.ClassType);
  for Prop in Tipo.GetProperties do //varre as propriedades
  case AnsiIndexText(Prop.Name,Property_Array) of
    0:result:=Prop.GetValue(sender).ToString; //obtem o texto
    1:_SelLength:=strtoint(Prop.GetValue(sender).ToString); //obtem a selecao
   2:_SelStart:= strtoint(Prop.GetValue(sender).ToString); //obtem a posicao cursor
  end;
  _SelStart:=_SelStart+_SelLength+1; //posicao de inser�ao do carracter key sera a soma
  Insert(Key,result,_SelStart); //inseri no texto original o Key digitado na Posicao
end;

class procedure TKeyPress.KeyPress(Sender: TObject; var Key: Char);
var
  _Mathes:TMatchCollection;
  _Mathe:TMatch;
  _Input:String;
  _Output:String;
begin
  _Input:=TKeyPress.Formats_Inputs(sender,Key);//retorna o texto do Controle inserido o Key
  _Mathes:=TRegEx.Matches(_Input,FPattern); //Carrega a colecao seguindo o texto e o Patternn
  for _Mathe in _Mathes do //varre a colecao e armazena cada item na variavel output
    _Output:=_Output+_Mathe.Value;
  if (_Output <> _Input) then  //compara se s�o diferentes
    key:=#0; //este caracter n�o esta permitido segundo o Pattern.
end;

end.
