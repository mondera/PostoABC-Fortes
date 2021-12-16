unit unitHelpers;

interface

uses
	System.Classes, Vcl.ExtCtrls, vcl.stdCtrls, SysUtils;

type
	   TImageABC = class helper for TImage
	   private
	   public
	      procedure carregapng(arquivo: string);
	end;


implementation
uses Vcl.Imaging.pngimage;

procedure TImageABC.carregapng(arquivo: string);
begin
  var Stream := TMemoryStream.Create;
  try
    Stream.LoadFromFile(arquivo);
    var Image := TPngImage.Create;
    try
      Stream.Position := 0;
      Image.LoadFromStream(Stream);
      Picture.Graphic := Image;
    finally
      Image.Free;
    end;
  finally
    Stream.Free;
  end;
end;

end.
