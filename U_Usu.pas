unit U_Usu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DBCtrls, ExtCtrls, Grids, DBGrids, ComCtrls,
  Buttons, DateUtils;

type
  TFrm_Usu = class(TForm)
    Panel1: TPanel;
    Label2: TLabel;
    Editusu: TDBEdit;
    Label3: TLabel;
    Editnome: TDBEdit;
    Label4: TLabel;
    Editsenha: TDBEdit;
    Label5: TLabel;
    Editconfirme: TDBEdit;
    Label6: TLabel;
    EditForcar: TDBEdit;
    Label7: TLabel;
    Edittravar: TDBEdit;
    Label8: TLabel;
    Editini: TDBEdit;
    Label9: TLabel;
    Editfim: TDBEdit;
    Label10: TLabel;
    Edituso: TDBEdit;
    Label11: TLabel;
    Editprevilegio: TDBEdit;
    TrackBar1: TTrackBar;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn5: TBitBtn;
    Label1: TLabel;
    DBComboBox1: TDBComboBox;
    Label12: TLabel;
    procedure BitBtn5Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure EditconfirmeExit(Sender: TObject);
    procedure EditusoExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ControlChange(Sender: TObject);
  private
  CompAnt : TEdit;
     { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_Usu: TFrm_Usu;

implementation

uses UDm, Unit_Principal;

{$R *.dfm}

function SenhaSegura(const cSenha:String):Boolean;
function SoLetras(s:string):boolean;
const
 c :Array [1..10]  of char  = ('0','1','2','3','4','5','6','7','8','9');
var
 idx:integer;
begin    //tem letras
result:=true;
for idx:=1 to length(c) do
  if pos(c[idx],s)>0 then
     begin
       result:=false;
       Break;
     end;
 end;
Const
cCharMin=6;
var
n:Int64;
begin
result:=(length(cSenha) > cCharMin)and(not TryStrToInt64(cSenha,n))and(not SoLetras(cSenha));
end;

procedure TFrm_Usu.BitBtn5Click(Sender: TObject);
begin
if MessageDlg('Voltar para o Menu Principal?',mtConfirmation,[mbyes,mbno],0)=mryes then
begin
Close;
 end;
end;

procedure TFrm_Usu.ControlChange(Sender: TObject);
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
(ActiveControl is TDateTimePicker) or
(ActiveControl is TLabeledEdit) or
(ActiveControl is TDBComboBox)
then begin
TEdit(ActiveControl).Color := $008A0000;
TEdit(ActiveControl).Font.Color := clWhite;
CompAnt := TEdit(ActiveControl);
end else CompAnt := nil;
if (ActiveControl is TDBLookupComboBox) then TDBLookupComboBox(ActiveControl).DropDown;
end;

procedure TFrm_Usu.EditconfirmeExit(Sender: TObject);
begin
if Editconfirme.Text <> Editsenha.Text then
MessageDlg('Existe divergencias entre as senhas, tente novamente!',mtInformation,[mbOk],0)
else
begin
if SenhaSegura(Editconfirme.Text) then
begin
   Label1.Caption:= 'Senha Forte';
   Label1.Font.Color:= clblue;
   Label1.Font.Size:= 10;
   end
else
  Label1.Caption:= 'Senha Fraca';
   Label1.Font.Color:= Clred;
   Label1.Font.Size:= 10;
  end;
end;


procedure TFrm_Usu.EditusoExit(Sender: TObject);
var
  data : tdatetime;
begin
   data := Dm.Tb_UsuDt_Ini.Value;
   data := data + Strtoint(edituso.Text);
   Dm.Tb_UsuDt_Fim.AsDateTime:= data;
   TrackBar1.SetFocus;
end;

procedure TFrm_Usu.FormShow(Sender: TObject);
begin
Dm.Tb_Usu.ReadOnly:=true;
BitBtn2.Enabled:= False;
Label1.Caption:= 'A Senha deve conter letras' + #13 + 'numeros  e caracteres';
bitbtn1.SetFocus;
end;

procedure TFrm_Usu.FormActivate(Sender: TObject);
begin
Screen.OnActiveControlChange := ControlChange;
end;

procedure TFrm_Usu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Screen.OnActiveControlChange := Nil;
end;

procedure TFrm_Usu.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key = VK_ESCAPE then
begin
BitBtn5Click(Sender);
end;
if Key = VK_RETURN then
begin
perform(WM_NEXTDLGCTL,0,0);
end;
 end;

procedure TFrm_Usu.BitBtn1Click(Sender: TObject);
begin
if MessageDlg('Incluir Novo Usuario?',mtConfirmation,[mbyes,mbno],0)=mryes then
begin
Bitbtn2.Enabled:=True;
Dm.Tb_Usu.Active:= True;
dm.Tb_Usu.ReadOnly:= False;
dm.Tb_Usu.Edit;
dm.Tb_Usu.Append;
Editusu.SetFocus;
end
else
begin
Dm.Tb_Usu.Active:= False;
dm.Tb_Usu.ReadOnly:= True;
Close;
end;
end;

procedure TFrm_Usu.BitBtn2Click(Sender: TObject);
begin
if Editconfirme.Text <> Editsenha.Text then
begin
MessageDlg('Existe divergencias entre as senhas, tente novamente!',mtInformation,[mbOk],0);
Editconfirme.SetFocus;
 end
else
begin
    Dm.Tb_Usu.Edit;
    Dm.Tb_Usu.Post;
    Dm.Tb_Usu.Refresh;
MessageDlg('Registro Gravado com sucesso!',mtInformation,[mbOk],0);
BitBtn1Click(sender);
end;
end;

end.
