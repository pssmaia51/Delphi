unit U_Login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DBCtrls, ExtCtrls, Grids, DBGrids, ComCtrls,
  Buttons, DateUtils, Vcl.Imaging.jpeg, U_Usu;

type
  TFrm_Login = class(TForm)
    Image1: TImage;
    EditUsuario: TLabeledEdit;
    EditSenha: TLabeledEdit;
    Image2: TImage;
    Label2: TLabel;
    BtnEntrar: TBitBtn;
    BtnCancelar: TBitBtn;
    Edit1: TEdit;
    procedure BtnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BtnEntrarClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure ControlChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EditSenhaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditUsuarioExit(Sender: TObject);
    procedure EditUsuarioKeyPress(Sender: TObject; var Key: Char);
  private
    CompAnt : TEdit;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_Login: TFrm_Login;
  tentativas: integer;
  senha:string;

implementation

{$R *.dfm}

uses Unit_Principal, UDm;

function PrimeiraLetraMaiscula(Str: string): string;
var
  i: integer;
  esp: boolean;
begin
  str := LowerCase(Trim(str));
  for i := 1 to Length(str) do
  begin
    if i = 1 then
      str[i] := UpCase(str[i])
    else
      begin
        if i <> Length(str) then
        begin
          esp := (str[i] = ' ');
          if esp then
            str[i+1] := UpCase(str[i+1]);
        end;
      end;
  end;
  Result := Str;
end;

procedure TFrm_Login.BtnCancelarClick(Sender: TObject);
begin
Close;
end;

procedure TFrm_Login.BtnEntrarClick(Sender: TObject);
begin
    if (Editusuario.Text='') then
     begin
       tentativas := tentativas + 1;
        MessageDlg(Format('O Campo USUARIO esta em branco, tente novamente: Tentativa %d de 3', [tentativas]), mtError, [mbOk], 0);
       if tentativas >= 3 then
        begin
          Application.MessageBox('O sistema será encerrado por motivo de'#13+'segurança, entre em contato com o administrador'#13+'do sistema!','Sistema de Gestão em Logistica',MB_ICONERROR+MB_OK);
          Application.Terminate;
       end
    else
        begin
//          Editsenha.Text :='';
          Editusuario.SetFocus;
          Abort;
          end;
    end;
    if(Editsenha.Text ='') then
     begin
        tentativas := tentativas + 1;
        MessageDlg(Format('O Campo SENHA esta em branco, tente novamente: Tentativa %d de 3', [tentativas]), mtError, [mbOk], 0);
        if tentativas >= 3 then
         begin
           Application.MessageBox('O sistema será encerrado por motivo de'#13+'segurança, entre em contato com o administrador'#13+'do sistema!','Sistema de Gestão em Logistica',MB_ICONERROR+MB_OK);
           Application.Terminate;
         end
        else
            begin
//              Editusuario.Text :='';
              Editsenha.Text :='';
              Editsenha.SetFocus;
              Abort;
            end;
     end;
        senha := Editsenha.Text;
    with dm.Tb_Usu do
        begin
          close;
          sql.Clear;
          sql.Add('select * from usuario where Nome_Usu ='''+Editusuario.Text +'''');
          Open;
    if IsEmpty then
     begin
       tentativas := tentativas + 1;
       MessageDlg(Format('Este USUARIO não cadastrado, tente novamente: Tentativa %d de 3 Se o problema persistir' +#13+ 'entre em contato com administrador do sistema', [tentativas]), mtError, [mbOk], 0);
       if tentativas >= 3 then
        begin
          Application.MessageBox('O sistema será encerrado por motivo de'#13+'segurança, entre em contato com o administrador'#13+'do sistema!','Sistema de Gestão em Logistica',MB_ICONERROR+MB_OK);
          Application.Terminate;
        end
       else
           begin
              Editusuario.Text :='';
              Editsenha.Text :='';
              Editusuario.SetFocus;
              Abort;
           end;
        end
       else
           senha := fieldbyname('Senha').AsString;
        end;
       if senha <> Editsenha.Text then
        begin
           tentativas := tentativas + 1;
           MessageDlg(Format('SENHA incorreta, tente novamente: Tentativa %d de 3 Se o problema persistir' +#13+ 'entre em contato com administrador do sistema', [tentativas]), mtError, [mbOk], 0);
           if tentativas >= 3 then
           begin
             Application.MessageBox('O sistema será encerrado por motivo de'#13+'segurança, entre em contato com o administrador'#13+'do sistema!','Sistema de Gestão em Logistica',MB_ICONERROR+MB_OK);
             Application.Terminate;
           end
          else
              begin
//              Editusuario.Text :='';
              Editsenha.Text :='';
              Editsenha.SetFocus;
              Abort;
        end;
          end
          else
              begin
                 Application.MessageBox('Seja bem vindo ao sistema!','Sistema de Gestão de Logistica',MB_OK+MB_ICONINFORMATION);
                 frm_login.Hide;
                 Dm.criarformulario(TFrm_Principal, Frm_principal);
              end;
end;

procedure TFrm_Login.ControlChange(Sender: TObject);
begin
if Assigned(CompAnt) then begin
CompAnt.Color := clWindow;
CompAnt.Font.Color := clWindowText;
end;
if (ActiveControl is TEdit) or
(ActiveControl is TMemo) or
(ActiveControl is TMaskEdit) or
(ActiveControl is TDBEdit) or
(ActiveControl is TDBMemo) or
(ActiveControl is TDateTimePicker)or
(ActiveControl is TLabeledEdit) or
(ActiveControl is TDBComboBox)
then begin
TEdit(ActiveControl).Color := $008A0000;
TEdit(ActiveControl).Font.Color := clWhite;
CompAnt := TEdit(ActiveControl);
end else CompAnt := nil;
if (ActiveControl is TDBLookupComboBox) then TDBLookupComboBox(ActiveControl).DropDown;
end;

procedure TFrm_Login.EditSenhaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = Vk_Return then
begin
    if (Editusuario.Text='') then
     begin
       tentativas := tentativas + 1;
        MessageDlg(Format('O Campo USUARIO esta em branco, tente novamente: Tentativa %d de 3', [tentativas]), mtError, [mbOk], 0);
       if tentativas >= 3 then
        begin
          Application.MessageBox('O sistema será encerrado por motivo de'#13+'segurança, entre em contato com o administrador'#13+'do sistema!','Sistema de Gestão em Logistica',MB_ICONERROR+MB_OK);
          Application.Terminate;
       end
    else
        begin
//          Editsenha.Text :='';
          Editusuario.SetFocus;
          Abort;
          end;
    end;
    if(Editsenha.Text ='') then
     begin
        tentativas := tentativas + 1;
        MessageDlg(Format('O Campo SENHA esta em branco, tente novamente: Tentativa %d de 3', [tentativas]), mtError, [mbOk], 0);
        if tentativas >= 3 then
         begin
           Application.MessageBox('O sistema será encerrado por motivo de'#13+'segurança, entre em contato com o administrador'#13+'do sistema!','Sistema de Gestão em Logistica',MB_ICONERROR+MB_OK);
           Application.Terminate;
         end
        else
            begin
//              Editusuario.Text :='';
              Editsenha.Text :='';
              Editsenha.SetFocus;
              Abort;
            end;
     end;
        senha := Editsenha.Text;
    with dm.Tb_Usu do
        begin
          close;
          sql.Clear;
          sql.Add('select * from usuario where Nome_Usu ='''+Editusuario.Text +'''');
          Open;
    if IsEmpty then
     begin
       tentativas := tentativas + 1;
       MessageDlg(Format('Este USUARIO não cadastrado, tente novamente: Tentativa %d de 3 Se o problema persistir' +#13+ 'entre em contato com administrador do sistema', [tentativas]), mtError, [mbOk], 0);
       if tentativas >= 3 then
        begin
          Application.MessageBox('O sistema será encerrado por motivo de'#13+'segurança, entre em contato com o administrador'#13+'do sistema!','Sistema de Gestão em Logistica',MB_ICONERROR+MB_OK);
          Application.Terminate;
        end
       else
           begin
              Editusuario.Text :='';
              Editsenha.Text :='';
              Editusuario.SetFocus;
              Abort;
           end;
        end
       else
           senha := fieldbyname('Senha').AsString;
        end;
       if senha <> Editsenha.Text then
        begin
           tentativas := tentativas + 1;
           MessageDlg(Format('SENHA incorreta, tente novamente: Tentativa %d de 3 Se o problema persistir' +#13+ 'entre em contato com administrador do sistema', [tentativas]), mtError, [mbOk], 0);
           if tentativas >= 3 then
           begin
             Application.MessageBox('O sistema será encerrado por motivo de'#13+'segurança, entre em contato com o administrador'#13+'do sistema!','Sistema de Gestão em Logistica',MB_ICONERROR+MB_OK);
             Application.Terminate;
           end
          else
              begin
//              Editusuario.Text :='';
              Editsenha.Text :='';
              Editsenha.SetFocus;
              Abort;
        end;
          end
          else
              begin
                 Application.MessageBox('Seja bem-vindo ao Sistema de Gestão e Controle de Processos Logisticos - SGCPL vS:. 1.2.7.0!','Sistema de Gestão em Logistica',MB_OK+MB_ICONINFORMATION);
                 frm_login.Hide;
                 Dm.criarformulario(TFrm_Principal, Frm_principal);
              end;
         end;
end;

procedure TFrm_Login.EditUsuarioExit(Sender: TObject);
begin
//EditUsuario.Text:= PrimeiraLetraMaiscula();
end;

procedure TFrm_Login.EditUsuarioKeyPress(Sender: TObject; var Key: Char);
begin
 if key=#13 then begin
   SelectNext(ActiveControl as TWinControl,True,True);
    key:=#0;
     end;
end;

procedure TFrm_Login.FormActivate(Sender: TObject);
begin
Screen.OnActiveControlChange := ControlChange;
end;

procedure TFrm_Login.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Screen.OnActiveControlChange := Nil;
end;

procedure TFrm_Login.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
if MessageDlg('Com esta ação voce ira sair da tela de login,Deseja Continuar?',mtConfirmation,[mbyes,mbno],0)=mryes then
begin
Application.Terminate;
end;
end;

procedure TFrm_Login.FormCreate(Sender: TObject);
begin
tentativas := 0;
edit1.Text:= TimetoStr(Time);
end;

procedure TFrm_Login.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = Vk_Escape then
close;
end;

end.
