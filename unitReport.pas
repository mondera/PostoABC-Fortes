unit unitReport;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, Data.DB, dxGDIPlusClasses;

type
  TformReport = class(TForm)
    DataSource1: TDataSource;
    RLReport: TRLReport;
    RLBand6: TRLBand;
    RLBand7: TRLBand;
    RLGroup1: TRLGroup;
    RLLabel7: TRLLabel;
    RLSystemInfo6: TRLSystemInfo;
    RLSystemInfo7: TRLSystemInfo;
    RLBand8: TRLBand;
    RLLabel8: TRLLabel;
    RLDBText6: TRLDBText;
    RLBand9: TRLBand;
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    RLLabel12: TRLLabel;
    RLLabel13: TRLLabel;
    RLBand10: TRLBand;
    RLDBText8: TRLDBText;
    RLDBText9: TRLDBText;
    RLDBText10: TRLDBText;
    RLDBText11: TRLDBText;
    RLBand1: TRLBand;
    RLDBResult1: TRLDBResult;
    RLBand2: TRLBand;
    RLDBResult2: TRLDBResult;
    RLLabel1: TRLLabel;
    RLDBText1: TRLDBText;
    RLDBResult3: TRLDBResult;
    RLDBResult4: TRLDBResult;
    RLImage1: TRLImage;
    procedure RLReportBeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formReport: TformReport;

implementation

uses
  unitdm;

{$R *.dfm}

procedure TformReport.RLReportBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  dm.FDQuery.Close;
  dm.FDQuery.Open();
end;

end.
