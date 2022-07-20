object Dm: TDm
  OldCreateOrder = False
  Height = 441
  Width = 684
  object Connection: TZConnection
    ControlsCodePage = cCP_UTF16
    Catalog = ''
    Properties.Strings = (
      'controls_cp=CP_UTF16')
    AutoCommit = False
    TransactIsolationLevel = tiReadCommitted
    Connected = True
    SQLHourGlass = True
    HostName = 'localhost'
    Port = 3306
    Database = 'logistica'
    User = 'root'
    Password = 'B3m8dsn#@'
    Protocol = 'mysql-5'
    Left = 624
    Top = 16
  end
  object Tb_Usu: TZQuery
    Connection = Connection
    SQL.Strings = (
      'SELECT * FROM usuario')
    Params = <>
    Left = 29
    Top = 19
    object Tb_UsuId: TIntegerField
      FieldName = 'Id'
      Required = True
    end
    object Tb_UsuNome_Usu: TWideStringField
      FieldName = 'Nome_Usu'
      Required = True
    end
    object Tb_UsuNome: TWideStringField
      FieldName = 'Nome'
      Required = True
      Size = 100
    end
    object Tb_UsuSenha: TWideStringField
      FieldName = 'Senha'
      Required = True
      Size = 15
    end
    object Tb_UsuConfirmar: TWideStringField
      FieldName = 'Confirmar'
      Required = True
      Size = 15
    end
    object Tb_UsuForcar: TWideStringField
      Alignment = taCenter
      FieldName = 'Forcar'
      Size = 1
    end
    object Tb_UsuTravar: TWideStringField
      Alignment = taCenter
      FieldName = 'Travar'
      Size = 1
    end
    object Tb_UsuDt_Ini: TDateField
      FieldName = 'Dt_Ini'
      EditMask = '!99/99/0000;1;_'
    end
    object Tb_UsuDt_Fim: TDateField
      FieldName = 'Dt_Fim'
      EditMask = '!99/99/0000;1;_'
    end
    object Tb_UsuDias_Uso: TFloatField
      FieldName = 'Dias_Uso'
    end
    object Tb_UsuPrevilegio: TWideStringField
      FieldName = 'Previlegio'
      Required = True
      Size = 30
    end
    object Tb_Ususetor: TWideStringField
      FieldName = 'setor'
      Size = 50
    end
  end
  object Ds_Usu: TDataSource
    DataSet = Tb_Usu
    Left = 85
    Top = 19
  end
  object Query_Config: TZQuery
    Connection = Connection
    SQL.Strings = (
      'SELECT * FROM config')
    Params = <>
    Left = 26
    Top = 75
    object Query_ConfigEmpresa: TWideStringField
      FieldName = 'Empresa'
      Required = True
      Size = 100
    end
    object Query_ConfigRegiao: TWideStringField
      FieldName = 'Regiao'
      Required = True
      Size = 100
    end
    object Query_ConfigCidade: TWideStringField
      FieldName = 'Cidade'
      Required = True
      Size = 100
    end
    object Query_ConfigCentro_Distribuicao: TWideStringField
      FieldName = 'Centro_Distribuicao'
      Required = True
      Size = 100
    end
    object Query_ConfigVisao: TWideStringField
      FieldName = 'Visao'
      Size = 100
    end
    object Query_ConfigMissao: TWideStringField
      FieldName = 'Missao'
      Size = 100
    end
    object Query_ConfigValores: TWideStringField
      FieldName = 'Valores'
      Size = 200
    end
    object Query_ConfigCoordenador: TWideStringField
      FieldName = 'Coordenador'
      Required = True
      Size = 100
    end
    object Query_ConfigCEP: TWideStringField
      FieldName = 'CEP'
      Required = True
      EditMask = '00000\-9999;_'
      Size = 9
    end
    object Query_ConfigEndereco: TWideStringField
      FieldName = 'Endereco'
      Required = True
      Size = 100
    end
    object Query_ConfigBairro: TWideStringField
      FieldName = 'Bairro'
      Required = True
      Size = 30
    end
    object Query_ConfigCidade_End: TWideStringField
      FieldName = 'Cidade_End'
      Required = True
      Size = 30
    end
    object Query_ConfigUf: TWideStringField
      FieldName = 'Uf'
      Required = True
      Size = 2
    end
    object Query_ConfigComplemento: TWideStringField
      FieldName = 'Complemento'
      Required = True
      Size = 50
    end
    object Query_ConfigFone: TWideStringField
      FieldName = 'Fone'
      Required = True
      EditMask = '!\(99\)0000-0000;1;_'
      Size = 10
    end
    object Query_ConfigEmail: TWideStringField
      FieldName = 'Email'
      Required = True
      Size = 50
    end
    object Query_ConfigCNPJ: TWideStringField
      FieldName = 'CNPJ'
      Required = True
      EditMask = '00\.000\.000\.0000\-00;1;_'
      Size = 30
    end
    object Query_ConfigInstal: TDateField
      FieldName = 'Instal'
      EditMask = '!99/99/0000;1;_'
    end
    object Query_ConfigPeriodo: TFloatField
      FieldName = 'Periodo'
    end
    object Query_ConfigTravar: TWideStringField
      FieldName = 'Travar'
      Size = 1
    end
    object Query_ConfigLogo: TBlobField
      FieldName = 'Logo'
    end
  end
  object Ds_Config: TDataSource
    DataSet = Query_Config
    Left = 96
    Top = 75
  end
  object Tb_Controle: TZTable
    Connection = Connection
    TableName = 'logon'
    Left = 24
    Top = 136
    object Tb_Controleid: TIntegerField
      FieldName = 'id'
      Required = True
    end
    object Tb_Controleusuario: TWideStringField
      FieldName = 'usuario'
      Size = 50
    end
    object Tb_Controledata: TDateField
      FieldName = 'data'
    end
    object Tb_Controleh_ini: TTimeField
      FieldName = 'h_ini'
    end
    object Tb_Controleh_fim: TTimeField
      FieldName = 'h_fim'
    end
    object Tb_Controletempo: TTimeField
      FieldName = 'tempo'
    end
    object Tb_Controlesetor: TWideStringField
      FieldName = 'setor'
      Size = 50
    end
    object Tb_Controleacao: TWideStringField
      FieldName = 'acao'
      Size = 100
    end
  end
  object Ds_Controle: TDataSource
    DataSet = Tb_Controle
    Left = 96
    Top = 137
  end
end
