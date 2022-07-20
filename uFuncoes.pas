unit uFuncoes;

interface
Uses
    SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls, Forms,
    Dialogs, Printers;
{  Functions  }

Function CemExtenso(StrValor: string): string;
Function ValorExtenso(Valor: extended): string;
function AllTrim(OQue : String) : String;
function PadLeft(StrToPad: String; LenToPad: Integer; StrFill: String) : String;
function PadRight(StrToPad: String; LenToPad: Integer; StrFill: String) : String;
Function Space(Numero : Integer) : string;
function ValidaData(sData : String) : Boolean;
function DiadaSemana(Data : TDateTime) : String;
function DiaSemanaAbrev(Data : TDateTime) : String;
function CompData(sDataIni, sDataFim, sMensagem1, sMensagem2 : String) : Boolean;
function MesExtenso(Data : TDateTime) : string;
function Mes(Data : TDateTime) : string;
function NomeEstado(Sigla : String) : String;
function VerificaEstado(Sigla : String) : Boolean;
function ValidaNum(sNum : String) : Boolean;
function Confirma_Exclusao : Boolean;
function Formata_CPFCGC(Valor, Tipo: String) : string;
//=============================================================
function BiosDate: String;
function CorrentPrinter :String;
function DateMais(Dat:TDateTime;Numdias:Integer): TDateTime;
function JanelaExiste(Classe,Janela:String) :Boolean;
function DelphiCarregado : Boolean;
function DetectaDrv(const drive : char): boolean;
function DiasNoMes(AYear, AMonth: Integer): Integer;
function DifDateUtil(dataini,datafin:string):integer;
function DifHora(Inicio,Fim : String):String;
function DiscoNoDrive(const drive : char): boolean;
function ExisteInt(Texto:String): Boolean;
function GetDefaultPrinterName : string;
function GetMemoryTotalPhys : DWord;
function IdadeAtual(Nasc : TDate): Integer;
function IdadeN(Nascimento:TDateTime) : String;
function isdigit(c:char):boolean;
function IsPrinter : Boolean;
function MemoryReturn(Categoria: integer): integer;
function NumeroSerie(Unidade:PChar):String;
function Percentdisk(unidade: byte): Integer;
function SystemDateTime(tDate: TDateTime; tTime: TDateTime): Boolean;
function TestaCgc(xCGC: String):Boolean;
function validapis(Dado : String) : boolean;
function AnoBis(Data: TDateTime): Boolean;

{ Procedures }
procedure Adverte(Mensagem,Cabecalho : String);
procedure Informacao(Mensagem,Cabecalho : String);
procedure Ampulheta;
procedure Seta;
procedure Delay(iMSecs: Integer);

var resultado : word;
    dDatavalida : TDateTime;
    iNumValido : Integer;

implementation

function CemExtenso(StrValor: string): string;
const cCent: array[0..8] of string = ('cento',        'duzentos',   'trezentos',
									   'quatrocentos', 'quinhentos', 'seicentos',
									   'setecentos',   'oitocentos', 'novecentos');
	   cDez: array[0..8] of string = ('dez',       'vinte',     'trinta',
									  'quarenta',  'cinquenta', 'sessenta',
									  'setenta',   'oitenta',   'noventa');
	   cVint: array[0..8] of string = ('onze',      'doze',    'treze',
									   'quatorze',  'quinze',  'dezesseis',
									   'dezessete', 'dezoito', 'dezenove');
	   cUnit: array[0..8] of string = ('um',     'dois',  'tr�s',
									   'quatro', 'cinco', 'seis',
									   'sete',   'oito',  'nove');
var iVal: array[0..2] of integer;
	 cExt: string;
	 iCode, iValor: integer;
begin
	cExt := '';
	Val(Copy(StrValor, 1, 1), iVal[0], iCode);
	Val(Copy(StrValor, 2, 1), iVal[1], iCode);
	Val(Copy(StrValor, 3, 1), iVal[2], iCode);
	Val(StrValor, iValor, iCode);
	if iValor > 0 then
	begin
		if iValor = 100 then
			cExt := 'cem'
		else
		begin
			if iVal[0] > 0 then
			begin
				cExt := cCent[iVal[0] - 1];
				if (iVal[1] + iVal[2]) > 0 then
					cExt := cExt + ' e '
				else
					cExt := cExt + ' ';
			end;
			if (iVal[1] = 1) and (iVal[2] > 0) then
				cExt := cExt + cVint[iVal[2] - 1]
			else
			begin
				if iVal[1] > 0 then
				begin
					cExt := cExt + cDez[iVal[1] - 1];
					if iVal[2] > 0 then
						cExt := cExt + ' e '
					else
						cExt := cExt + ' ';
				end;
				if iVal[2] > 0 then
					cExt := cExt + cUnit[iVal[2] - 1];
			end;
		end;
	end;
	CemExtenso := cExt + ' ';
end;

function ValorExtenso(Valor: extended): string;
const cCifra: array[0..5,0..1] of string = (('trilh�o', 'trilh�es'),
                                            ('bilh�o',  'bilh�es'),
					    ('milh�o',  'milh�es'),
                                            ('mil',     'mil'),
                                            ('',        ''),
                                            ('centavo', 'centavos'));
var iTrilhoes, iBilhoes, iMilhoes, iMilhares, iCentenas, iCentavos, iCode: integer;
	 cExtenso, cStr, cTrilhoes, cBilhoes, cMilhoes, cMilhares, cCentenas, cCentavos: string;
begin
	cExtenso := '';
	if Valor > 0.0 then
	begin
		cStr := FormatFloat ('000000000000000.00', Valor);
		cTrilhoes := Copy(cStr,  1, 3);
		cBilhoes  := Copy(cStr,  4, 3);
		cMilhoes  := Copy(cStr,  7, 3);
		cMilhares := Copy(cStr, 10, 3);
		cCentenas := Copy(cStr, 13, 3);
		cCentavos := Copy(cStr, 17, 2);
		Val(cTrilhoes, iTrilhoes, iCode);
		Val(cBilhoes,  iBilhoes, iCode);
		Val(cMilhoes,  iMilhoes, iCode);
		Val(cMilhares, iMilhares, iCode);
		Val(cCentenas, iCentenas, iCode);
		Val(cCentavos, iCentavos, iCode);
		if iTrilhoes > 0 then
		begin
			cExtenso := CemExtenso (cTrilhoes);
			if iTrilhoes = 1 then
				cExtenso := cExtenso + cCifra[0][0]
			else
				cExtenso := cExtenso + cCifra[0][1];
			if ((iBilhoes = 0) and (iMilhoes = 0) and (iMilhares = 0) and (iCentenas = 0)) then
				cExtenso := cExtenso + ' de '
			else
			begin
				if (((iBilhoes > 0) and (iMilhoes = 0) and (iMilhares = 0) and (iCentenas = 0) and (iCentavos = 0)) or
					((iMilhoes > 0) and (iBilhoes = 0) and (iMilhares = 0) and (iCentenas = 0) and (iCentavos = 0)) or
					((iMilhares > 0) and (iBilhoes = 0) and (iMilhoes = 0) and (iCentenas = 0) and (iCentavos = 0)) or
					((iCentenas > 0) and (iBilhoes = 0) and (iMilhoes = 0) and (iMilhares = 0) and (iCentavos = 0)) or
					((iCentavos > 0) and (iBilhoes = 0) and (iMilhoes = 0) and (iMilhares = 0) and (iCentenas = 0))) then
					cExtenso := cExtenso + ' e '
				else
					cExtenso := cExtenso + ', ';
			end;
		end;
		if iBilhoes > 0 then
		begin
			cExtenso := cExtenso + CemExtenso (cBilhoes);
			if iBilhoes = 1 then
				cExtenso := cExtenso + cCifra[1][0]
			else
				cExtenso := cExtenso + cCifra[1][1];
			if ((iMilhoes = 0) and (iMilhares = 0) and (iCentenas = 0)) then
				cExtenso := cExtenso + ' de '
			else
			begin
				if (((iMilhoes > 0) and (iMilhares = 0) and (iCentenas = 0) and (iCentavos = 0)) or
					((iMilhares > 0) and (iMilhoes = 0) and (iCentenas = 0) and (iCentavos = 0)) or
					((iCentenas > 0) and (iMilhoes = 0) and (iMilhares = 0) and (iCentavos = 0)) or
					((iCentavos > 0) and (iMilhoes = 0) and (iMilhares = 0) and (iCentenas = 0))) then
					cExtenso := cExtenso + ' e '
				else
					cExtenso := cExtenso + ', ';
			end;
		end;
		if iMilhoes > 0 then
		begin
			cExtenso := cExtenso + CemExtenso (cMilhoes);
			if iMilhoes = 1 then
				cExtenso := cExtenso + cCifra[2][0]
			else
				cExtenso := cExtenso + cCifra[2][1];
			if ((iMilhares = 0) and (iCentenas = 0)) then
				cExtenso := cExtenso + ' de '
			else
			begin
				if (((iMilhares > 0) and (iCentenas = 0) and (iCentavos = 0)) or
                                    ((iCentenas > 0) and (iMilhares = 0) and (iCentavos = 0)) or
                                    ((iCentavos > 0) and (iMilhares = 0) and (iCentenas = 0))) then
                                      cExtenso := cExtenso + ' e '
				else
					cExtenso := cExtenso + ', ';
			end;
		end;
		if iMilhares > 0 then
		begin
			cExtenso := cExtenso + CemExtenso (cMilhares);
			if iMilhares = 1 then
				cExtenso := cExtenso + cCifra[3][0]
			else
				cExtenso := cExtenso + cCifra[3][1];
			if (iCentenas = 0) then
				cExtenso := cExtenso + ' '
			else
			begin
				if (((iCentenas > 0) and (iCentavos = 0)) or
					((iCentavos > 0) and (iCentenas = 0))) then
					cExtenso := cExtenso + ' e '
				else
					cExtenso := cExtenso + ', ';
			end;
		end;
		if iCentenas > 0 then
		begin
			cExtenso := cExtenso + CemExtenso (cCentenas);
			if iMilhares = 1 then
				cExtenso := cExtenso + cCifra[4][0]
			else
				cExtenso := cExtenso + cCifra[4][1];
		end;
		if ((iTrilhoes > 0) or (iBilhoes > 0) or (iMilhoes > 0) or (iMilhares > 0) or (iCentenas > 0)) then
		begin
			if Valor >= 2.0 then
				cExtenso := cExtenso + 'reais'
			else
				cExtenso := cExtenso + 'real';
			if iCentavos > 0 then
				cExtenso := cExtenso + ' e '
			else
				cExtenso := cExtenso + '';
			if iCentavos > 0 then
			begin
				cCentavos := FormatFloat('000', iCentavos);
				cExtenso := cExtenso + CemExtenso(cCentavos);
				if iCentavos = 1 then
					cExtenso := cExtenso + cCifra[5][0]
				else
					cExtenso := cExtenso + cCifra[5][1];
				if Valor < 1.0 then
					cExtenso := cExtenso + ' de real'
				else
					cExtenso := cExtenso + '';
			end;
		end;
	end;
	ValorExtenso := AnsiUpperCase (cExtenso);
end;
{-----------------------------------------------------------------------------}
{ Fun��o : retira todos os em brancos da string                               }
{ Parametros : OQue - string que ser� retirado os brancos                     }
{ Retorno :  String                                                           }
{-----------------------------------------------------------------------------}
function AllTrim(OQue : String) : String;
Begin
     While Pos(' ',OQue) > 0 do
           Delete(OQue,Pos(' ',OQue),1);
     result := OQue;
end;

{-----------------------------------------------------------------------------}
{ Fun��o : Abrir janela de mensagem com o �cone de advert�ncia                }
{ Parametros : mensagem - string que conter� a mensagem                       }
{              cabecalho - cabecalho da caixa, vazio ser� assumido "Aten��o"  }
{-----------------------------------------------------------------------------}
Procedure Adverte(Mensagem,Cabecalho : String);
Begin
     if cabecalho = '' then
        cabecalho := 'Aten��o';

     MessageBeep(MB_ICONASTERISK);
     resultado := Application.MessageBox(Pchar(Mensagem),PChar(Cabecalho),
                  MB_APPLMODAL+MB_OK+MB_ICONWARNING);
end;
{-----------------------------------------------------------------------------}
{ Fun��o : Abrir janela de mensagem com o �cone de informa��o                 }
{ Parametros : mensagem - string que conter� a mensagem                       }
{              cabecalho - cabecalho da caixa, vazio ser� assumido "Aten��o"  }
{-----------------------------------------------------------------------------}
Procedure Informacao(Mensagem,Cabecalho : String);
Begin
     if cabecalho = '' then
        cabecalho := 'Informa��o';
     resultado := Application.MessageBox(Pchar(Mensagem),PChar(Cabecalho),
                  MB_APPLMODAL+MB_OK+MB_ICONEXCLAMATION);
end;

{-----------------------------------------------------------------------------}
{ Fun��o : retira todos os caracteres da esquerda da string                   }
{ Parametros : StrToPad - String para retirar os caracteres,                  }
{ LenToPad - tamanho para ser retirado, StrFill - caracter para ser eliminado }
{ Retorno :  String                                                           }
{-----------------------------------------------------------------------------}
function PadLeft(StrToPad: String; LenToPad: Integer; StrFill: String) : String;
var
   cStr : String;
   iCont, iLimite: Integer;
begin
     cStr := '';
     iLimite := LenToPad - Length(StrToPad);
     if LenToPad > Length(StrToPad) then
        for iCont := 1 to iLimite do
            cStr := cStr + StrFill;
     PadLeft := cStr + StrToPad;
end;

{-----------------------------------------------------------------------------}
{ Fun��o : retira todos os caracteres da direita da string                    }
{ Parametros : StrToPad - String para retirar os caracteres,                  }
{ LenToPad - tamanho para ser retirado, StrFill - caracter para ser eliminado }
{ Retorno :  String                                                           }
{-----------------------------------------------------------------------------}
function PadRight(StrToPad: String; LenToPad: Integer; StrFill: String) : String;
var
   cStr : String;
   iCont, iLimite: Integer;
begin
     cStr := '';
     iLimite := LenToPad - Length(StrToPad);
     if LenToPad > Length(StrToPad) then
        for iCont := 1 to iLimite do
            cStr := cStr + StrFill;
     PadRight := StrToPad + cStr;
end;

{-----------------------------------------------------------------------------}
{ Validar Datas                                                               }
{ Parametros :  DATA - string que conter� a daa que ser� avaliada             }
{ Retorno : Boolean - TRUE se Inv�lida                                        }
{-----------------------------------------------------------------------------}
function ValidaData(sData :String) : Boolean;
Begin
     Result := FAlse;  // se a data for v�lida retorna FALSE
     if AllTrim(sData) <> '//' then
     begin
         Try
            dDatavalida := StrToDate(sData);
         Except on EConvertError do
            begin
                 Adverte('Data Inv�lida !','');
                 Result := True; // se a data for inv�lida retorna TRUE
            end;
         end;
     end;
end;

{-----------------------------------------------------------------------------}
{ Retorna o dia da semana                                                     }
{ Parametros :  DATA - Data atual                                             }
{ Retorno : string com o dia da semana                                        }
{-----------------------------------------------------------------------------}
function DiadaSemana(Data : TDateTime) : String;
Var
   i : integer;
Const
     cSemana : Array[1..7] of string = ( 'Domingo','Segunda-Feira',
                                         'Ter�a-Feira','Quarta-Feira',
                                         'Quinta-Feira','Sexta-Feira',
                                         'S�bado' );
Begin
     i := DayOfWeek(Data);
     if i = 0 then
     begin
          Result := 'Dia inv�lido!!!';
          Exit;
     end;
     Result := cSemana[i];
end;

{-----------------------------------------------------------------------------}
{ Retorna a abreviatura do dia da semana                                      }
{ Parametros :  DATA - Data atual                                             }
{ Retorno : string com a abreviatura do dia da semana                         }
{-----------------------------------------------------------------------------}
function DiaSemanaAbrev(Data : TDateTime) : String;
Var
   i : integer;
Const
     cSemana : Array[1..7] of string = ( 'Dom','Seg','Ter','Qua','Qui','Sex',
                                         'S�b' );
Begin
     i := DayOfWeek(Data);
     if i = 0 then
     begin
          Result := 'Dia inv�lido!!!';
          Exit;
     end;
     Result := cSemana[i];
end;

function Space(Numero : Integer) : String;
var
   sSpace : String;
   i : Integer;
begin
     sSpace := '';
     for i := 1 to Numero do
         sSpace := sSpace + ' ';
     Result := sSpace;
end;

{------------------------------------------------------------------------------}
{ Testar se a Data Final � menor que a Data Inicial                            }
{ Parametros :  sDataIni - string que contera a data inicial                   }
{               sDataFim - string que contera a data final                     }
{ Retorno : Boolean - TRUE se Data Final menor  que inicial                    }
{------------------------------------------------------------------------------}
function CompData(sDataIni, sDataFim, sMensagem1, sMensagem2 : String) : Boolean;
Begin
     Result := FALSE; // se a data inicial maior que a data final
     if (alltrim(sDataIni) <> '//') and (alltrim(sDataIni) <> '//') then
     begin
          if StrToDate(sDataIni) > StrToDate(sDataFim) then
          begin
              Adverte(sMensagem2+' '+'deve ser maior que '+' '+sMensagem1,'');
              Result := True; // se a data inicial menor que a data final
          end;
     end;
end;

{------------------------------------------------------------------------------}
{ Retornar o mes por extenso                                                   }
{ Parametros :  Data - data atual                                              }
{ Retorno : string com o mes                                                   }
{------------------------------------------------------------------------------}
function MesExtenso(Data : TDateTime) : string;
var
   wDia, wMes, wAno : Word;
Const
     cMeses : Array[1..12] of String = ( 'Janeiro','Fevereiro','Mar�o',
                                         'Abril','Maio','Junho','Julho',
                                         'Agosto','Setembro','Outubro',
                                         'Novembro','Dezembro' );
begin
     DecodeDate(Data, wDia, wMes, wAno);
     Result := cMeses[wMes];
end;

{------------------------------------------------------------------------------}
{ Retornar a sigla do mes                                                      }
{ Parametros :  Data - Data atual                                              }
{ Retorno : string com a sigla do mes                                          }
{------------------------------------------------------------------------------}
function Mes(Data : TDateTime) : string;
var
   wDia, wMes, wAno : Word;
Const
     cMeses : Array[1..12] of String = ( 'JAN','FEV','MAR','ABR','MAI','JUN',
                                         'JUL','AGO','SET','OUT','NOV','DEZ' );
begin
     DecodeDate(Data, wDia, wMes, wAno);
     Result := cMeses[wMes];
end;

{--------------------------------------------------------------------------}
{ Retornar o nome do estado por extenso                                    }
{ Parametros :  Sigla - string que conter� a sigla do estado               }
{ Retorno : String com o nome do estado                                    }
{--------------------------------------------------------------------------}
function NomeEstado(Sigla : String) : String;
var
   iPosicao, iIndice : Integer;
Const
     cEstados : Array[1..28] of String = ( 'Acre','Alagoas','Amazonas','Amap�',
                                           'Bahia','Cear�','Distrito Federal',
                                           'Esp�rito Santo','Goi�s','Maranh�o',
                                           'Minas Gerais','Mato Grosso do Sul',
                                           'Mato Grosso','Para','Para�ba',
                                           'Pernambuco','Piaui','Paran�',
                                           'Rio de Janeiro','Rond�nia',
                                           'Rio Grande do Norte','Roraima',
                                           'Rio Grande do Sul','Santa Catarina',
                                           'Sergipe','S�o Paulo','Tocantins',
                                           'Fernando de Noronha' );
     cSiglas : Array[1..28] of String =  ( 'AC','AL','AM','AP','BA','CE','DF',
                                           'ES','GO','MA','MG','MS','MT','PA',
                                           'PB','PE','PI','PR','RJ','RO','RN',
                                           'RR','RS','SC','SE','SP','TO','FN' );
begin
     iPosicao := 0;
     for iIndice := 1 to High(cSiglas) do
     begin
          if cSiglas[iIndice] = Sigla then
             iPosicao := iIndice;
     end;
     if iPosicao = 0 then
        Result := 'Sigla de estado inv�lida!'
     else
         Result := cEstados[iPosicao];
end;

{----------------------------------------------------------------------------}
{ Verifica se o estado � valido ou n�o                                       }
{ Parametros : Sigla - string que conter� a sigla do estado                  }
{ Retorno : Booleano - se TRUE estado OK, se FALSE estado invalido           }
{----------------------------------------------------------------------------}
function VerificaEstado(Sigla : String) : Boolean;
var
   iPosicao, iIndice : Integer;
Const
     cSiglas : Array[1..28] of String =  ( 'AC','AL','AM','AP','BA','CE','DF',
                                           'ES','GO','MA','MG','MS','MT','PA',
                                           'PB','PE','PI','PR','RJ','RO','RN',
                                           'RR','RS','SC','SE','SP','TO','FN' );
begin
     iPosicao := 0;
     for iIndice := 1 to High(cSiglas) do
     begin
          if cSiglas[iIndice] = Sigla then
             iPosicao := iIndice;
     end;
     if iPosicao = 0 then
        Result := False
     else
         Result := True;
end;

{--------------------------------------------------------------------------}
{ Validar Numeros                                                          }
{ Parametros :  NUM - string que conter� numero que ser� avaliado          }
{ Retorno : Boolean - TRUE se Inv�lido                                     }
{--------------------------------------------------------------------------}
function ValidaNum(sNum :String) : Boolean;
Begin
     Result := False;  // se numero for v�lido retorna FALSE
     if AllTrim(sNum) <> '' then
     begin
         Try
            iNumValido := StrToInt(sNum);
         Except on EConvertError do
         begin
             Result := True; // se numero for inv�lido retorna TRUE
         end;
         end;
     end;
end;

Function Confirma_Exclusao : Boolean;
begin
     if Application.MessageBox('Confirma Exclus�o do Registro?','Confirma��o',
                               MB_APPLMODAL+MB_ICONQUESTION+MB_DEFBUTTON2+
                               MB_OKCANCEL) = IDCANCEL THEN
        Result := False
     else
         Result := True;
end;

Procedure Ampulheta;
Begin
     Screen.Cursor:=crHourGlass;
end;

Procedure Seta;
Begin
     Screen.Cursor:=crDefault;
end;

// Tipo: F- Fisica - CPF
//       J- Juridica - CGC
function Formata_CPFCGC(Valor, Tipo: String) : string;
begin
     if Tipo = 'F' then
     begin
          Result := Copy(Valor,1,3)+'.'+Copy(Valor,4,3)+'.'+
                    Copy(Valor,7,3)+'-'+Copy(Valor,10,2);
     end
     else
     begin
          Result := Copy(Valor,1,2)+'.'+Copy(Valor,3,3)+'.'+
                    Copy(Valor,6,3)+'/'+Copy(Valor,9,4)+'-'+
                    Copy(Valor,13,2);
     end;
end;

//========================================================================
//=======================================================================
//=======================================================================
//=======================================================================
// Retorna a data da fabrica��o do Chip da Bios do sistema
function BiosDate: String;
begin
     result := string(pchar(ptr($FFFF5)));
end;

// Retorna a impressora padr�o do windows
// Requer a unit printers declarada na clausula uses da unit
function CorrentPrinter :String;
var
   Device : array[0..255] of char;
   Driver : array[0..255] of char;
   Port   : array[0..255] of char;
   hDMode : THandle;
begin
     Printer.GetPrinter(Device, Driver, Port, hDMode);
     Result := Device+' na porta '+Port;
end;

{ Soma um determinado n�mero de dias a uma data }
function DateMais(Dat:TDateTime;Numdias:Integer): TDateTime;
begin
     Dat := Dat + Numdias;
     Result := Dat;
end;

{ Estas fun��es servem para verificar
 se o delphi est� carregado ou n�o}
Function JanelaExiste(Classe,Janela:String) :Boolean;
var
   PClasse,PJanela : array[0..79] of char;
begin
     if Classe = '' then
        PClasse[0] := #0
     else
         StrPCopy(PClasse,Classe);
     if Janela = '' then
        PJanela[0] := #0
     else
         StrPCopy(PJanela,Janela);
     if FindWindow(PClasse,PJAnela) <> 0 then
        result := true
     else
         Result := false;
end;

Function DelphiCarregado : Boolean;
begin
     Result :=  False;
     if JanelaExiste('TPropertyInspector','Object Inspector') then
     begin
          result := True;
     end
     else
     begin
          result := False;
     end;
end;

(*{ No evento OnCreate do form coloque:}
if not DelphiCarregado then
   showmessage('Delphi est� ativo, bom menino!')
else
begin
     Showmessage('Vc n�o poder� utilizar esta aplica��o! Mau garoto!');
     application.terminate;
end;*)

{Detecta quantas unidade possui no computador}
function DetectaDrv(const drive : char): boolean;
var
   Letra: string;
begin
     Letra := drive + ':\';
     if GetDriveType(PChar(Letra)) < 2 then
     begin
          result := False;
     end
     else
     begin
          result := True;
     end;
end;

// Retorna quantos dias tem um referido mes do ano
function DiasNoMes(AYear, AMonth: Integer): Integer;
var
   dData : TDateTime;
   sData : String;
   iDias : Integer;
const
     DaysInMonth: array[1..12] of Integer = ( 31, 28, 31, 30, 31, 30, 31, 31,
                                              30, 31, 30, 31);
begin
     {if Length(IntToStr(AYear)) <> 4 then
     begin
          Adverte( 'ERRO FATAL......'+#13+
                   'Parametro errado na fun��o DIASNOMES()!'+#13+
                   'Ano deve ter 4 digitos.','Aviso');
          Application.Terminate;
     end;}
     sData := '01/'+PadLeft(IntToStr(Amonth),2,'0')+'/'+IntToStr(AYear);
     dData := StrToDate(sData);
     if AMonth = 2 then
     begin
          if AnoBis(dData) then
          begin
               Inc(DaysInMonth[AMonth]);
          end;
     end;
     iDias := DaysInMonth[AMonth];
     if AMonth = 2 then
        DaysInMonth[AMonth] := 28;
     Result := iDias;
end;

{Retorna a quantidade de dias uteis entre duas datas}
function DifDateUtil(dataini,datafin:string):integer;
var a,b,c:tdatetime;
    ct,s:integer;
begin
     if StrToDate(DataFin) < StrtoDate(DataIni) then
     begin
          Result := 0;
          exit;
     end;
     ct := 0;
     s := 1;
     a := strtodate(dataFin);
     b := strtodate(dataIni);
     if a > b then
     begin
          c := a;
          a := b;
          b := c;
          s := 1;
     end;
     a := a + 1;
     while (dayofweek(a)<>2) and (a <= b) do
     begin
          if dayofweek(a) in [2..6] then
          begin
               inc(ct);
          end;
          a := a + 1;
     end;
     ct := ct + round((5*int((b-a)/7)));
     a := a + (7*int((b-a)/7));
     while a <= b do
     begin
          if dayofweek(a) in [2..6] then
          begin
               inc(ct);
          end;
          a := a + 1;
     end;
     if ct < 0 then
     begin
          ct := 0;
     end;
     result := s*ct;
end;

{Retorna a diferen�a entre duas horas}
function DifHora(Inicio,Fim : String):String;
var
   FIni,FFim : TDateTime;
begin
     Fini := StrTotime(Inicio);
     FFim := StrToTime(Fim);
     If (Inicio > Fim) then
     begin
          Result := TimeToStr((StrTotime('23:59:59')-Fini)+FFim)
     end
     else
     begin
          Result := TimeToStr(FFim-Fini);
     end;
end;

{Detecta se h� disco no Drive}
function DiscoNoDrive(const drive : char): boolean;
var
   DriveNumero : byte;
   EMode : word;
begin
     EMode := 0;
     result := false;
     DriveNumero := ord(Drive);
     if DriveNumero >= ord('a') then
     begin
          dec(DriveNumero,$20);
          EMode := SetErrorMode(SEM_FAILCRITICALERRORS);
     end;
     try
        if DiskSize(DriveNumero-$40) = -1 then
        begin
             Result := False;
        end
        else
        begin
             Result := True;
        end;
     Except
           SetErrorMode(EMode);
     end;
end;

{Testa se em uma string existe um numero inteiro valido ou n�o}
function ExisteInt(Texto:String): Boolean;
var
   i:integer;
begin
     try
        i := StrToInt(Texto);
        Result := True;
     except
           Result := False;
     end;
end;

// Retorna o nome da impressora padr�o do Windows
function GetDefaultPrinterName : string;
begin
     if(Printer.PrinterIndex > 0)then
     begin
          Result := Printer.Printers[Printer.PrinterIndex];
     end
     else
     begin
          Result := 'Nenhuma impressora Padr�o foi detectada';
     end;
end;

// Retorna o total de memoria do computador
function GetMemoryTotalPhys : DWord;
var
   ms : TMemoryStatus;
begin
     ms.dwLength := SizeOf( ms );
     GlobalMemoryStatus( ms );
     Result := ms.dwTotalPhys;
end;

// Retorna a idade Atual de uma pessoa a partir da data de nascimento
// Esta fun��o retorna a idade em formato integer
function IdadeAtual(Nasc : TDate): Integer;
Var AuxIdade, Meses : String;
    MesesFloat : Real;
    IdadeInc, IdadeReal : Integer;
begin
     AuxIdade := Format('%0.2f', [(Date - Nasc) / 365.6]);
     Meses := FloatToStr(Frac(StrToFloat(AuxIdade)));
     if AuxIdade = '0' then
     begin
          Result := 0;
          Exit;
     end;
     if Meses[1] = '-' then
     begin
          Meses := FloatToStr(StrToFloat(Meses) * -1);
     end;
     Delete(Meses, 1, 2);
     if Length(Meses) = 1 then
     begin
          Meses := Meses + '0';
     end;
     if (Meses <> '0') And (Meses <> '') then
     begin
          MesesFloat := Round(((365.6 * StrToInt(Meses)) / 100) / 30.47)
     end
     else
     begin
          MesesFloat := 0;
     end;
     if MesesFloat <> 12 then
     begin
          IdadeReal := Trunc(StrToFloat(AuxIdade)); // + MesesFloat;
     end
     else
     begin
          IdadeInc := Trunc(StrToFloat(AuxIdade));
          Inc(IdadeInc);
          IdadeReal := IdadeInc;
     end;
     Result := IdadeReal;
end;

// Retorna a idade de uma pessoa a partir da data de nascimento
function IdadeN(Nascimento:TDateTime) : String;
Type
    Data = Record
           Ano : Word;
           Mes : Word;
           Dia : Word;
    End;
Const
     Qdm:String = '312831303130313130313031'; // Qtde dia no mes
Var
   Dth : Data;                         // Data de hoje
   Dtn : Data;                         // Data de nascimento
   anos, meses, dias, nrd : Shortint;  // Usadas para calculo da idade
begin
     DecodeDate(Date,Dth.Ano,Dth.Mes,Dth.Dia);
     DecodeDate(Nascimento,Dtn.Ano,Dtn.Mes,Dtn.Dia);
     anos := Dth.Ano - Dtn.Ano;
     meses := Dth.Mes - Dtn.Mes;
     if meses < 0 then
     begin
          Dec(anos);
          meses := meses+12;
     end;
     dias := Dth.Dia - Dtn.Dia;
     if dias < 0 then
     begin
          nrd := StrToInt(Copy(Qdm,(Dth.Mes-1)*2-1,2));
          if ((Dth.Mes-1)=2) and ((Dth.Ano Div 4)=0) then
          begin
               Inc(nrd);
          end;
          dias := dias+nrd;
          meses := meses-1;
     end;
     Result := IntToStr(anos)+' Anos '+IntToStr(meses)+
               ' Meses '+IntToStr(dias)+' Dias';
end;

// Testa se o dado � um digito (numero) ou
// um caractere qualquer
function isdigit(c:char):boolean;
begin
     result := c in ['0'..'9']
end;

{Testa se a impressora est� ativa ou n�o, retornando .t.
 em caso positivo}
function IsPrinter : Boolean;
Const
    PrnStInt  : Byte = $17;
    StRq      : Byte = $02;
    PrnNum    : Word = 0;  { 0 para LPT1, 1 para LPT2, etc. }
Var
   nResult : byte;
Begin  (* IsPrinter*)
     Asm
        mov ah,StRq;
        mov dx,PrnNum;
        Int $17;
        mov nResult,ah;
     end;
     IsPrinter := (nResult and $80) = $80;
End;

// Retorna a memoria do sistema
// voce pode usar a tabela abaixo para fazer as devidas modifica��es
Function MemoryReturn(Categoria: integer): integer;
var
   MemoryStatus: TMemoryStatus;
   Retval : Integer;
begin
     RetVal := 0;
     MemoryStatus.dwLength:= sizeof(MemoryStatus);
     GlobalMemoryStatus(MemoryStatus);
     if categoria > 8 then
     begin
          Retval := 0;
     end;
     case categoria of
          1: Retval := MemoryStatus.dwTotalPhys;     // bytes de mem�ria f�sica
          2: Retval := MemoryStatus.dwLength;        // sizeof(MEMORYSTATUS)
          3: Retval := MemoryStatus.dwMemoryLoad;    // percentual de mem�ria em uso
          4: Retval := MemoryStatus.dwAvailPhys;     // bytes livres de mem�ria f�sica
          5: Retval := MemoryStatus.dwTotalPageFile; // bytes de pagina��o de arquivo
          6: Retval := MemoryStatus.dwAvailPageFile; // bytes livres de pagina��o de arquivo
          7: Retval := MemoryStatus.dwTotalVirtual;  // bytes em uso de espa�o de endere�o
          8: Retval := MemoryStatus.dwAvailVirtual;  // bytes livres
     end;
     result := Retval;
end;

{Retorna o N�mero serial da unidade especificada}
function NumeroSerie(Unidade:PChar):String;
var
   VolName,SysName : AnsiString;
   SerialNo,MaxCLength,FileFlags : DWord;
begin
     try
        SetLength(VolName,255);
        SetLength(SysName,255);
        GetVolumeInformation(Unidade,PChar(VolName),255,@SerialNo,
        MaxCLength,FileFlags,PChar(SysName),255);
        result := IntToHex(SerialNo,8);
     except
           result := ' ';
     end;
end;

{Retorna a porcentagem de espa�o livre em uma unidade de disco}
function Percentdisk(unidade: byte): Integer;
var
   A,B, Percentual : longint;
begin
     if DiskFree(Unidade)<> -1 then
     begin
          A := DiskFree(Unidade) div 1024;
          B := DiskSize(Unidade) div 1024;
          Percentual:=(A*100) div B;
          result := Percentual;
     end
     else
     begin
          result := -1;
     end;
end;

{Permite que voc� altere a data e a hora do sistema}
function SystemDateTime(tDate: TDateTime; tTime: TDateTime): Boolean;
var
   tSetDate: TDateTime;
   vDateBias: Variant;
   tSetTime: TDateTime;
   vTimeBias: Variant;
   tTZI: TTimeZoneInformation;
   tST: TSystemTime;
begin
     GetTimeZoneInformation(tTZI);
     vDateBias := tTZI.Bias / 1440;
     tSetDate := tDate + vDateBias;
     vTimeBias := tTZI.Bias / 1440;
     tSetTime := tTime + vTimeBias;
     with tST do
     begin
          wYear := StrToInt(FormatDateTime('yyyy', tSetDate));
          wMonth := StrToInt(FormatDateTime('mm', tSetDate));
          wDay := StrToInt(FormatDateTime('dd', tSetDate));
          wHour := StrToInt(FormatDateTime('hh', tSettime));
          wMinute := StrToInt(FormatDateTime('nn', tSettime));
          wSecond := StrToInt(FormatDateTime('ss', tSettime));
          wMilliseconds := 0;
     end;
     SystemDateTime := SetSystemTime(tST);
end;

{Testa se o CGC � v�lido ou n�o}
function TestaCgc(xCGC: String):Boolean;
Var
   d1,d4,xx,nCount,fator,resto,digito1,digito2 : Integer;
   Check : String;
begin
     d1 := 0;
     d4 := 0;
     xx := 1;
     for nCount := 1 to Length( xCGC )-2 do
     begin
          if Pos( Copy( xCGC, nCount, 1 ), '/-.' ) = 0 then
          begin
               if xx < 5 then
               begin
                    fator := 6 - xx;
               end
               else
               begin
                    fator := 14 - xx;
               end;
               d1 := d1 + StrToInt( Copy( xCGC, nCount, 1 ) ) * fator;
               if xx < 6 then
               begin
                    fator := 7 - xx;
               end
               else
               begin
                    fator := 15 - xx;
               end;
               d4 := d4 + StrToInt( Copy( xCGC, nCount, 1 ) ) * fator;
               xx := xx+1;
          end;
     end;
     resto := (d1 mod 11);
     if resto < 2 then
     begin
          digito1 := 0;
     end
     else
     begin
          digito1 := 11 - resto;
     end;
     d4 := d4 + 2 * digito1;
     resto := (d4 mod 11);
     if resto < 2 then
     begin
          digito2 := 0;
     end
     else
     begin
          digito2 := 11 - resto;
     end;
     Check := IntToStr(Digito1) + IntToStr(Digito2);
     if Check <> copy(xCGC,succ(length(xCGC)-2),2) then
     begin
          Result := False;
     end
     else
     begin
          Result := True;
     end;
end;

{Testa se o n�mero do pis � v�lido ou n�o}
function validapis(Dado : String) : boolean;
var
   i, wsoma, Wm11, Wdv,wdigito : Integer;
begin
     if AllTrim(Dado) <> '' Then
     begin
          wdv := strtoint(copy(Dado, 11, 1));
          wsoma := 0;
          wm11 := 2;
          for i := 1 to 10 do
          begin
               wsoma := wsoma + (wm11 *strtoint(copy(Dado,11 - I, 1)));
               if wm11 < 9 then
               begin
                    wm11 := wm11+1
               end
               else
               begin
                    wm11 := 2;
               end;
          end;
          wdigito := 11 - (wsoma MOD 11);
          if wdigito > 9 then
          begin
               wdigito := 0;
          end;
          if wdv = wdigito then
          begin
               validapis := true;
          end
          else
          begin
               validapis := false;
          end;
     end;
end;

{Testa se um ano � bixesto, retornando True em caso positivo}
function AnoBis(Data: TDateTime): Boolean;
var
   Dia,Mes,Ano : Word;
begin
     DecodeDate(Data,Ano,Mes,Dia);
     if Ano mod 4 <> 0 then
     begin
          AnoBis := False;
     end
     else if Ano mod 100 <> 0 then
     begin
          AnoBis := True;
     end
     else if Ano mod 400 <> 0 then
     begin
          AnoBis := False;
     end
     else
     begin
          AnoBis := True;
     end;
end;

//
// Promove um estado de espera no aplicativo
//
procedure Delay(iMSecs: Integer);
var
   lnTickCount: LongInt;
begin
     lnTickCount := GetTickCount;
     repeat
           Application.ProcessMessages;
     until ((GetTickCount - lnTickCount) >= LongInt(iMSecs));
end;

end.

