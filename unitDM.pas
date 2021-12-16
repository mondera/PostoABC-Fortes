unit unitDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  Tdm = class(TDataModule)
    FDConnection: TFDConnection;
    DataSource: TDataSource;
    FDTable: TFDTable;
    FDTablesequencia: TFDAutoIncField;
    FDTabledata: TDateTimeField;
    FDTabletanque: TIntegerField;
    FDTablebomba: TIntegerField;
    FDTablelitros: TFloatField;
    FDTablevalor: TFloatField;
    FDQuery: TFDQuery;
    FDQuerybomba: TIntegerField;
    FDQuerylitros: TFloatField;
    FDQueryvalor: TFloatField;
    FDQueryimposto: TFloatField;
    FDQuerydata: TWideStringField;
    FDQuerytanque: TWideStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  FDConnection.Params.Database := ExtractFilePath(ParamStr(0)) + 'abc.db';
//  FDConnection.Connected := True;
//  FDTable.Active := True;
end;

end.
