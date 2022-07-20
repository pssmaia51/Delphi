unit U_sobre;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls, Vcl.Buttons;

type
  TFrm_Sobre = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Memo1: TMemo;
    Image2: TImage;
    BitBtn1: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BitBtn1Click(Sender: TObject);

  private
    { Private declarations }
  public
      function GetComputerNameFunc : string;
    { Public declarations }
  end;

var
  Frm_Sobre: TFrm_Sobre;

implementation

{$R *.dfm}

uses Unit_Principal, Registry, Winsock;

function GetLocalIP(const ASeparator: string = ''): string;
type
  TInAddrList = array[0..0] of PInAddr;
  PInAddrList = ^TInAddrList;
var
  HostEnt: PHostEnt;
  InAddrList: PInAddrList;
  Buffer: array[0..63] of AnsiChar;
  I: Integer;
  GInitData: TWSADATA;
begin
  Result := '';
  WSAStartup($101, GInitData);
  try
    GetHostName(Buffer, SizeOf(Buffer));
    HostEnt := GetHostByName(Buffer);
    if Assigned(HostEnt) then
    begin
      InAddrList := PInAddrList(HostEnt^.h_addr_list);
      I := 0;
      while InAddrList[I] <> nil do
      begin
        if Result <> '' then
          Result := Result + ',';
        Result := Result + StrPas(inet_ntoa(InAddrList[I]^));
        if ASeparator = '' then
          Exit;
        Inc(I);
      end;
    end;
  finally
    WSACleanup;
  end;
end;



procedure TFrm_Sobre.BitBtn1Click(Sender: TObject);
begin
Close;
end;

procedure TFrm_Sobre.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = Vk_Escape then
close;
end;

procedure TFrm_Sobre.FormShow(Sender: TObject);
const
cBytesPorMb = 1024 * 1024;
var
  M: TMemoryStatus;
begin
  M.dwLength := SizeOf(M);
  GlobalMemoryStatus(M);
  Memo1.Clear;
  with Memo1.Lines do begin

    Add(Format('Endereçamento de IP: %s ',
    [GetLocalIP]));
    Add(Format('Nome da Maquina: %s ',
    [GetComputerNameFunc]));
    Add(Format('Total de memória física: %f MB',
      [M.dwTotalPhys / cBytesPorMb]));
    Add(Format('Memória física disponível: %f MB',
      [M.dwAvailPhys / cBytesPorMb]));
    Add(Format('Total de memória virtual: %f MB',
      [M.dwTotalVirtual / cBytesPorMb]));
    Add(Format('Memória virtual disponível: %f MB',
      [M.dwAvailVirtual / cBytesPorMb]));
    Add(Format('Memoria em uso: %d%%',
    [M.dwMemoryLoad]));
    Add(Format('Tamanho máximo do arquivo de paginação: %f MB',
      [M.dwTotalPageFile / cBytesPorMb]));
    Add(Format('Disponível no arquivo de paginação: %f MB',
      [M.dwAvailPageFile / cBytesPorMb]));
  end;
end;

function TFrm_Sobre.GetComputerNameFunc: string;
var ipbuffer : string;
      nsize : dword;
begin
   nsize := 255;
   SetLength(ipbuffer,nsize);
   if GetComputerName(pchar(ipbuffer),nsize) then
      result := ipbuffer;
end;

end.
