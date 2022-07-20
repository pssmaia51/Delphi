unit Unit_Principal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, jpeg, ExtCtrls, StdCtrls, ComCtrls, Vcl.AppEvnts;

type
  TFrm_Principal = class(TForm)
    MainMenu1: TMainMenu;
    Cadastro1: TMenuItem;
    Cliente1: TMenuItem;
    Especialidades1: TMenuItem;
    Funcionarios1: TMenuItem;
    Servios1: TMenuItem;
    Equipamentos1: TMenuItem;
    Agenda1: TMenuItem;
    N1: TMenuItem;
    Sair1: TMenuItem;
    Consultar1: TMenuItem;
    Ferramentas1: TMenuItem;
    Image1: TImage;
    StatusBar1: TStatusBar;
    Timer1: TTimer;
    Sobre1: TMenuItem;
    Usuario1: TMenuItem;
    Sair2: TMenuItem;
    SobreoSistema1: TMenuItem;
    ApplicationEvents1: TApplicationEvents;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Sair1Click(Sender: TObject);
    procedure Usuario1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure SobreoSistema1Click(Sender: TObject);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_Principal: TFrm_Principal;
  HoraIni, HoraFim, HoraDif: TDateTime;

implementation
uses
LanguageControl, U_Usu, UDm, U_Login, U_sobre;

{$R *.dfm}

procedure TFrm_Principal.Timer1Timer(Sender: TObject);
Begin
Statusbar1.Panels[1].Text := ' '+formatdatetime ('dddd","dd" de "mmmm" de "yyyy',now) + ' ' + 'às' + ' ' + formatdatetime ('hh:mm:ss',now);
end;

procedure TFrm_Principal.ApplicationEvents1Exception(Sender: TObject;
  E: Exception);
var
  NomeDoLog: string;
  Arquivo: TextFile;
begin
  NomeDoLog := ChangeFileExt(Application.Exename, '.log');
  AssignFile(Arquivo, NomeDoLog);
  if FileExists(NomeDoLog) then
    Append(arquivo) { se existir, apenas adiciona linhas }
  else
    ReWrite(arquivo); { cria um novo se não existir }
  try
    WriteLn(arquivo, DateTimeToStr(Now) + ':' + E.Message);
    WriteLn(arquivo, '----------------------------------------------------------------------');
    Application.ShowException(E);
  finally
    CloseFile(arquivo)
  end;

end;

procedure TFrm_Principal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Dm.Tb_Controle.Open;
   Dm.Tb_Controle.Edit;
   Dm.Tb_Controle.insert;

   Dm.Tb_Controledata.Value:=date;
   HoraIni := StrToTime(frm_login.Edit1.Text);
   Dm.Tb_Controleh_ini.AsDateTime:= HoraIni;
   HoraFim := Time;
   Dm.Tb_Controleh_fim.AsDateTime:= HoraFim;
   HoraDif := HoraFim - HoraIni;
   Dm.Tb_Controletempo.AsDateTime:= HoraDif;
   Dm.Tb_Controleusuario.AsString:= Dm.Tb_UsuNome_Usu.Value + ' ' + 'em: ' + ' ' + Frm_Sobre.GetComputerNameFunc;
   Dm.Tb_Controleacao.AsString:='Sistema Finalizado';
   Dm.Tb_Controle.Post;
end;

procedure TFrm_Principal.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
if MessageDlg('Deseja Realmente Sair do Sistema?',mtConfirmation,[mbyes,mbno],0)=mryes then
begin
Application.Terminate;
end;
end;

procedure TFrm_Principal.FormCreate(Sender: TObject);
begin
   Dm.Tb_Controle.Open;
   Dm.Tb_Controle.Edit;
   Dm.Tb_Controle.insert;

   Dm.Tb_Controledata.Value:=date;
   HoraIni := StrToTime(frm_login.Edit1.Text);
   Dm.Tb_Controleh_ini.AsDateTime:= HoraIni;
   HoraFim := Time;
   Dm.Tb_Controleh_fim.AsDateTime:= HoraFim;
   HoraDif := HoraFim - HoraIni;
   Dm.Tb_Controletempo.AsDateTime:= HoraDif;
   Dm.Tb_Controleusuario.AsString:= Dm.Tb_UsuNome_Usu.Value + ' ' + 'em: ' + ' ' + Frm_Sobre.GetComputerNameFunc;
   Dm.Tb_Controleacao.AsString:='Sistema Inicializado';
   Dm.Tb_Controlesetor.Value:= Dm.Tb_Ususetor.Value;
   Dm.Tb_Controle.Post;
end;

procedure TFrm_Principal.Sair1Click(Sender: TObject);
begin
close;
end;

procedure TFrm_Principal.SobreoSistema1Click(Sender: TObject);
begin
Dm.criarformulario(TFrm_Sobre, Frm_Sobre);
end;

procedure TFrm_Principal.Usuario1Click(Sender: TObject);
begin
Dm.criarformulario(TFrm_usu, Frm_Usu);
end;

procedure TFrm_Principal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key = VK_ESCAPE then
begin
Sair1Click(Sender);
 end;
  end;

procedure TFrm_Principal.FormShow(Sender: TObject);
begin
Statusbar1.Panels[0].Text :='  ' + 'Usuario Logando: ' + '  '+ Dm.Tb_UsuNome_Usu.Value;
end;

end.
