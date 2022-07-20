program Ordem_de_servicos;

uses
  SysUtils,
  Forms,
  Unit_Principal in 'Unit_Principal.pas' {Frm_Principal},
  UDm in 'UDm.pas' {Dm: TDataModule},
  U_Usu in 'U_Usu.pas' {Frm_Usu},
  U_Login in 'U_Login.pas' {Frm_Login},
  ColorDBEdit in 'ColorDBEdit.pas',
  U_ColorEdit in 'U_ColorEdit.pas',
  U_splash in 'U_splash.pas' {Frm_Splash},
  U_sobre in 'U_sobre.pas' {Frm_Sobre};

{$R *.res}

begin
  frm_Splash := Tfrm_Splash.Create(Application);
  frm_Splash.Show;
  frm_Splash.Refresh;
  frm_Splash.Gauge1.progress := 10;
if frm_Splash.Gauge1.Progress = 10 then
  begin
  frm_Splash.Caption := 'Iniciando Carregamento.........';
  Sleep(100);
  end;
  frm_Splash.Gauge1.progress := 20;
if frm_Splash.Gauge1.Progress = 20 then
  begin
  frm_Splash.caption := 'Aguarde ..........';
  Sleep(100);
  end;
  frm_Splash.Gauge1.progress := 30;
if frm_Splash.Gauge1.Progress = 30 then
  begin
  frm_Splash.caption := 'Carregado Banco de Dados do Sistema ..........';
  Sleep(100);
  end;
frm_Splash.Gauge1.progress := 40;
if frm_Splash.Gauge1.Progress = 40 then
  begin
  frm_Splash.caption := 'Aguarde ..........';
  Sleep(100);
  end;
  frm_Splash.Gauge1.progress := 50;
if frm_Splash.Gauge1.Progress = 50 then
  begin
  frm_Splash.caption := 'Carregado Formularios do Sistema ..........';
  Sleep(100);
  end;
  frm_Splash.Gauge1.progress := 60;
if frm_Splash.Gauge1.Progress = 60 then
  begin
  frm_Splash.caption := 'Aguarde ..........';
  Sleep(100);
  end;
  frm_Splash.Gauge1.progress := 70;
if frm_Splash.Gauge1.Progress = 70 then
  begin
  frm_Splash.caption := 'Carregado Relatorios do Sistema ..........';
  Sleep(100);
  end;
  frm_Splash.Gauge1.progress := 80;
if frm_Splash.Gauge1.Progress = 80 then
  begin
  frm_Splash.caption := 'Aguarde ..........';
  Sleep(100);
  end;
  frm_Splash.Gauge1.progress := 90;
if frm_Splash.Gauge1.Progress = 90 then
  begin
  frm_Splash.caption := 'Finalizando Carregamento ..........';
  Sleep(100);
  end;
  frm_Splash.Gauge1.progress := 100;
if frm_Splash.Gauge1.Progress = 100 then
  begin
  frm_Splash.caption := 'Sistema Inicializado ..........';
  Sleep(100);
  end;


  Application.Initialize;
  Application.Title := 'Sistema de Gestão e Controle de Processos Logisticos (SGCPL) vS.: 1.2.7.0';
  Application.CreateForm(TFrm_Login, Frm_Login);
  Application.CreateForm(TDm, Dm);
  frm_Splash.Hide;
  frm_Splash.Free;
  frm_Splash := Nil;
  Application.Run;
end.
