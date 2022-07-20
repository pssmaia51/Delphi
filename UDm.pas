unit UDm;
interface

uses
  SysUtils, Classes, DB, Data.DBXMySQL, Data.FMTBcd, Data.SqlExpr,
  ZConnection, ZAbstractConnection, ZSqlUpdate, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, ZAbstractTable, Forms;
  Type
  TDm = class(TDataModule)
    Connection: TZConnection;
    Tb_Usu: TZQuery;
    Tb_UsuId: TIntegerField;
    Tb_UsuNome_Usu: TWideStringField;
    Tb_UsuNome: TWideStringField;
    Tb_UsuSenha: TWideStringField;
    Tb_UsuConfirmar: TWideStringField;
    Tb_UsuForcar: TWideStringField;
    Tb_UsuTravar: TWideStringField;
    Tb_UsuDt_Ini: TDateField;
    Tb_UsuDt_Fim: TDateField;
    Tb_UsuDias_Uso: TFloatField;
    Tb_UsuPrevilegio: TWideStringField;
    Ds_Usu: TDataSource;
    Query_Config: TZQuery;
    Query_ConfigEmpresa: TWideStringField;
    Query_ConfigRegiao: TWideStringField;
    Query_ConfigCidade: TWideStringField;
    Query_ConfigCentro_Distribuicao: TWideStringField;
    Query_ConfigVisao: TWideStringField;
    Query_ConfigMissao: TWideStringField;
    Query_ConfigValores: TWideStringField;
    Query_ConfigCoordenador: TWideStringField;
    Query_ConfigCEP: TWideStringField;
    Query_ConfigEndereco: TWideStringField;
    Query_ConfigBairro: TWideStringField;
    Query_ConfigCidade_End: TWideStringField;
    Query_ConfigUf: TWideStringField;
    Query_ConfigComplemento: TWideStringField;
    Query_ConfigFone: TWideStringField;
    Query_ConfigEmail: TWideStringField;
    Query_ConfigCNPJ: TWideStringField;
    Query_ConfigInstal: TDateField;
    Query_ConfigPeriodo: TFloatField;
    Query_ConfigTravar: TWideStringField;
    Query_ConfigLogo: TBlobField;
    Ds_Config: TDataSource;
    Tb_Controle: TZTable;
    Ds_Controle: TDataSource;
    Tb_Controleid: TIntegerField;
    Tb_Controleusuario: TWideStringField;
    Tb_Controledata: TDateField;
    Tb_Controleh_ini: TTimeField;
    Tb_Controleh_fim: TTimeField;
    Tb_Controletempo: TTimeField;
    Tb_Controleacao: TWideStringField;
    Tb_Controlesetor: TWideStringField;
    Tb_Ususetor: TWideStringField;
    procedure criarformulario(T: TFormClass; F: TForm);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Dm: TDm;

implementation

{$R *.dfm}

{ TDm }

procedure TDm.criarformulario(T: TFormClass; F: TForm);
begin
try
Application.CreateForm(T,F);
F.ShowModal;
finally
F.Free;
end;
end;

end.
