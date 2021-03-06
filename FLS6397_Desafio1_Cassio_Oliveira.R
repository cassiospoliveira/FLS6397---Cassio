# FLS6307 - Introdu��o � Programa��o e Ferramentas Computacionais para as Ci�ncias Sociais
# Prof. Dr. Leonardo Barone
# Desafio 1

### nome <- "Cassio Santos Pinto de Oliveira"
### programa <- "Mestrado em Ci�ncia Pol�tica"
### n_usp <- 6912700
### data_entrega: "13/04/2017"


# Instalando pacotes que ser�o utilizados (no caso, o TidyR j� cont�m todas as
# bibliotecas necess�rias)
install.packages("tidyr")
# Chamando as bibliotecas
library(data.table)
library(dplyr)
library(readr)

# Removendo objetos que porventura estejam na mem�ria
rm(list=ls())

# Criando e selecionando diret�rio de trabalho
wordir <- "C:\\Users\\Cassio\\Dropbox\\Mestrado\\Disciplinas\\Introdu��o � Programa��o e Ferramentas Computacionais para as Ci�ncias Sociais\\Desafio 1"
setwd(wordir)


#------- PARTE 1 - ABRINDO OS DADOS -------#

# Criando objetos com endere�os de arquivos (copiados do site do TSE) a serem
# baixados, cf. Tutorial 4
arq1 <- "http://agencia.tse.jus.br/estatistica/sead/odsele/votacao_candidato_munzona/votacao_candidato_munzona_2016.zip"
arq2 <- "http://agencia.tse.jus.br/estatistica/sead/odsele/consulta_cand/consulta_cand_2016.zip"
# Baixando arquivos tempor�rios em formato .zip
download.file(arq1, "temp1.zip", quiet = T)
download.file(arq2, "temp2.zip", quiet = T)
# Descompactando arquivos
unzip("temp1.zip")
# Renomeando arquivo "LEIAME", para identific�-lo e evitar que este seja
# substitu�do ao fazer a segunda descompacta��o
file.rename(list.files(, pattern = "LEIAME.pdf"), "LEIAME_resultados.pdf")
unzip("temp2.zip")
# Renomeando arquivo "LEIAME" dos candidatos
file.rename(list.files(, pattern = "LEIAME.pdf"), "LEIAME_candidatos.pdf")
# Apagando arquivos compactados
file.remove("temp1.zip")
file.remove("temp2.zip")

# Criando bancos de dados de vota��o e candidatura e checando cada um para
# verificar se as vari�veis s�o as mesmas
# N�o criamos loop porque estamos lidando apenas com tr�s bancos

bd_resultados_RS <- read.table("votacao_candidato_munzona_2016_RS.txt", sep=";", head=F)
head(bd_resultados_RS)
bd_resultados_PR <- read.table("votacao_candidato_munzona_2016_PR.txt", sep=";", head=F)
head(bd_resultados_PR)
bd_resultados_SC <- read.table("votacao_candidato_munzona_2016_SC.txt", sep=";", head=F)
head(bd_resultados_SC)
# Segunda checagem - igualdade de vari�veis
all.equal(dim(bd_resultados_RS)[2], dim(bd_resultados_PR)[2], 
						dim(bd_resultados_SC)[2])

bd_candidatos_RS <- read.table("consulta_cand_2016_RS.txt", sep=";", head=F)
head(bd_candidatos_RS)
bd_candidatos_PR <- read.table("consulta_cand_2016_PR.txt", sep=";", head=F)
head(bd_candidatos_PR)
bd_candidatos_SC <- read.table("consulta_cand_2016_SC.txt", sep=";", head=F)
head(bd_candidatos_SC)
dim(bd_candidatos_RS) == dim(bd_candidatos_PR) == dim(bd_candidatos_SC)
# Segunda checagem - igualdade de vari�veis
all.equal(dim(bd_candidatos_RS)[2], dim(bd_candidatos_PR)[2], 
						dim(bd_candidatos_SC)[2])


# Certificado que as vari�veis s�o as mesmas, unimos os bancos de dados
bd_resultados <- bind_rows(bd_resultados_RS, bd_resultados_PR, bd_resultados_SC)
bd_candidatos <- bind_rows(bd_candidatos_RS, bd_candidatos_PR, bd_candidatos_SC)

# Removendo objetos obsoletos
# Determinando posi��es na lista
ls()
# Removendo por vetor das posi��es encontradas
rm(list = ls()[c(1:2, 4:6, 8:10)])

# Renomeando vari�veis segundo os arquivos "LEIAME", pois o s�tio do TSE
# lamentavelmente n�o � amig�vel o suficiente para fazer um simples arquivo
# com o nome das vari�veis. Os nomes foram colocados em mai�scula como em cada 
# arquivo LEIAME.
# ----------------
# Cheguei a tentar utilizar um leitor autom�tico de pdf, mas n�o tive tempo de
# elaborar melhor a fun��o.
# ----------------

colnames(bd_resultados) <- c("DATA_GERACAO",
                             "HORA_GERACAO",
                             "ANO_ELEICAO", 
                             "NUM_TURNO",
                             "DESCRICAO_ELEICAO",
                             "SIGLA_UF",
                             "SIGLA_UE",
                             "CODIGO_MUNICIPIO",
                             "NOME_MUNICIPIO",
                             "NUMERO_ZONA",
                             "CODIGO_CARGO",
                             "NUMERO_CAND", 
                             "SEQUENCIAL_CANDIDATO",
                             "NOME_CANDIDATO",
                             "NOME_URNA_CANDIDATO",
                             "DESCRICAO_CARGO",
                             "COD_SIT_CAND_SUPERIOR",
                             "DESC_SIT_CAND_SUPERIOR",
                             "CODIGO_SIT_CANDIDATO",
                             "DESC_SIT_CANDIDATO",
                             "CODIGO_SIT_CAND_TOT",
                             "DESC_SIT_CAND_TOT",
                             "NUMERO_PARTIDO",
                             "SIGLA_PARTIDO",
                             "NOME_PARTIDO",
                             "SEQUENCIAL_LEGENDA",
                             "NOME_COLIGACAO",
                             "COMPOSICAO_LEGENDA",
                             "TOTAL_VOTOS",
                             "TRANSITO")

colnames(bd_candidatos) <- c("DATA_GERACAO",
                             "HORA_GERACAO",
                             "ANO_ELEICAO",
                             "NUM_TURNO",
                             "DESCRICAO_ELEICAO",
                             "SIGLA_UF",
                             "SIGLA_UE",
                             "DESCRICAO_UE",
                             "CODIGO_CARGO",
                             "DESC_CARGO",
                             "NOME_CANDIDATO",
                             "SEQUENCIAL_CANDIDATO",
                             "NUMERO_CANDIDATO",
                             "CPF_CAND",
                             "NOME_URNA_CANDIDATO",
                             "COD_SITUACAO_CANDIDATURA",
                             "DES_SITUACAO_CANDIDATURA",
                             "NUMERO_PARTIDO",
                             "SIGLA_PARTIDO",
                             "NOME_PARTIDO",
                             "CODIGO_LEGENDA",
                             "SIGLA_LEGENDA",
                             "COMPOSICAO_LEGENDA",
                             "NOME_LEGENDA",
                             "CODIGO_OCUPACAO",
                             "DESCRICAO_OCUPACAO",
                             "DATA_NASCIMENTO",
                             "NUM_TITULO_ELEITORAL_CANDIDATO",
                             "IDADE_DATA_ELEICAO",
                             "CODIGO_SEXO",
                             "DESCRICAO_SEXO",
                             "COD_GRAU_INSTRUCAO",
                             "DESCRICAO_GRAU_INSTRUCAO",
                             "CODIGO_ESTADO_CIVIL",
                             "DESCRICAO_ESTADO_CIVIL",
                             "COD_COR_RACA",
                             "DESC_COR_RACA",
                             "CODIGO_NACIONALIDADE",
                             "DESCRICAO_NACIONALIDADE",
                             "SIGLA_UF_NASCIMENTO",
                             "CODIGO_MUNICIPIO_NASCIMENTO",
                             "NOME_MUNICIPIO_NASCIMENTO",
                             "DESPESA_MAX_CAMPANHA",
                             "COD_SIT_TOT_TURNO",
                             "DESC_SIT_TOT_TURNO",
                             "E-MAIL")


#------- PARTE 2 - DATA FRAME RESULTADOS -------#

# Verificando vari�veis no banco
glimpse(bd_resultados)

# Utilizando pacote dplyr para editar banco de dados
bd_resultados <- bd_resultados %>%
# Filtrando prefeitos; CODIGO_CARGO de prefeito � igual a 11
	filter(CODIGO_CARGO == 11) %>%
# Selecionando vari�veis de interesse
	select(SIGLA_UF, CODIGO_MUNICIPIO, NUMERO_PARTIDO, NUMERO_CAND, TOTAL_VOTOS) %>%
# Renomeando vari�veis de interesse
  	rename(uf = SIGLA_UF,
		 cod_munic = CODIGO_MUNICIPIO, 
		 partido = NUMERO_PARTIDO, 
		 num_cand = NUMERO_CAND, 
		 voto = TOTAL_VOTOS)
# Verificando se recorte est� correto
head(bd_resultados)

#------- PARTE 3 - DATA FRAME CANDIDATOS -------#

# Verificando vari�veis no banco
glimpse(bd_candidatos)

# Utilizando pacote dplyr para editar banco de dados
bd_candidatos <- bd_candidatos %>%
# Filtrando prefeitos; CODIGO_CARGO de prefeito � igual a 11
	filter(CODIGO_CARGO == 11) %>%
# Selecionando vari�veis de interesse
	select(SIGLA_UF, NUMERO_PARTIDO, NUMERO_CANDIDATO, DESCRICAO_OCUPACAO, DESCRICAO_SEXO, DESCRICAO_GRAU_INSTRUCAO) %>%
# Renomeando vari�veis de interesse
  	rename(uf = SIGLA_UF,
		 partido = NUMERO_PARTIDO, 
		 num_cand = NUMERO_CANDIDATO, 
		 ocup = DESCRICAO_OCUPACAO,
		 sexo = DESCRICAO_SEXO,
		 educ = DESCRICAO_GRAU_INSTRUCAO)

# Verificando se recorte est� correto
head(bd_candidatos)

#------- PARTE 4 - AGREGANDO E COMBINANDO POR MUNIC�PIO -------#

# Obtendo soma do total de votos, agrupando por munic�pio
bd_resultado_mun <- bd_resultados %>%
	group_by(cod_munic) %>%
	summarise(total_votos_mun = sum(voto))

# Combinando os data frames. O data frame final n�o foi sobrescrito porque
# o nome original do banco utilizado era "bd_resultados", e n�o "resultado"
resultado <- bd_resultados %>%
	left_join(bd_resultado_mun, by = "cod_munic")
# Podemos verificar que o total de votos ("total_votos") foi efetivamente
# combinado � esquerda, mantendo resultados iguais para os mesmos munic�pios,
# como previa a fun��o.
head(resultado)

# Produzindo vari�vel de propor��o de votos dos candidatos, ignorando os votos
# na legenda do partido para fins did�ticos
resultado <- resultado %>%
	mutate(prop_mun = voto/total_votos_mun)
head(resultado)

#------- PARTE 5 - AGREGANDO E COMBINANDO POR CANDIDATO -------#

# Embora estejamos recriando as mesmas vari�veis, essa etapa seria �til
# se estiv�ssemos trabalhando com elei��es onde um candidato pode ser 
# votado por mais de um munic�pio (estaduais ou federais), j� que
# nesses casos o total de votos por munic�pio � diferente do total de 
# votos do candidato quando ele recebe vota��o em mais de um munic�pio.
# H� OUTRO PROBLEMA IMPORTANTE! Os n�meros de candidatos coincidem entre os 
# munic�pios, o que na pr�tica faz com que somemos votos por PARTIDO e UF,
# e n�o CANDIDATO e UF. Isso seria resolvido incluindo "cod_munic" no lugar de
# "uf" (que passa a ser desnecess�ria, j� que h� chave �nica para cada munic�pio)
# no agrupamento. Entretanto, se f�ssemos fazer para elei��es de outros n�veis
# (estadual/federal), a� o agrupamento por UF faria sentido j� que esperar�amos
# um n�mero �nico de candidato por UF para essas elei��es.
# FEITAS ESSAS CONSIDERA��ES, FAREI ESSA SUBSTITUI��O (de "uf" por "cod_munic"),
# A PARTIR DA MINHA INTERPRETA��O DO RESULTADO REQUERIDO PELO EXERC�CIO.

# Total de votos por UF e N�mero do Candidato
resultado_cand <- resultado %>%
	group_by(cod_munic, num_cand) %>%
	summarise(total_votos_cand = sum(voto))
head(resultado_cand)

resultado <- resultado %>%
	right_join(resultado_cand, by = c("cod_munic", "num_cand"))
head(resultado)
# Verificamos que, como esperado, "total_votos_cand", o total por munic�pio,
# � igual a "voto", o total por candidato. Se estiv�ssemos em elei��es 
# estaduais ou federais, ver�amos que a soma seria diferente para cada UF.
# Se inclu�ssemos (e n�o substitu�ssimos) "uf" nas vari�veis a agrupar em
# "resultado_cand", ter�amos o mesmo resultado, mas se deix�ssemos apenas
# "uf" e "num_cand", ter�amos a soma dos votos de todos os candidatos com
# o mesmo n�mero (portanto, do mesmo partido) por UF.

# Calculando o total de votos do candidato no munic�pio em rela��o ao total
# de votos do candidato.

resultado <- resultado %>%
	mutate(prop_cand = voto/total_votos_cand)
head(resultado)
# A propor��o sempre ser� de 100%, exceto nos casos nos quais o(a) candidato(a)
# n�o recebeu nenhum voto sequer, nos quais o R interpreta o resultado como
# "not a number" ("NaN"), j� que normalmente n�o se divide por 0.

#------- PARTE 6 - COMBINANDO RESULTADOS E CANDIDATURAS -------#

head(resultado)
head(bd_candidatos)
# Vari�veis em comum: uf, partido e num_cand
# Combinando bancos de dados por vari�veis em comum
resultado <- resultado %>%
	right_join(bd_candidatos, by = c("uf", "partido", "num_cand"))
head(resultado)

#------- PARTE 7 - TREINANDO TABELAS DE RESULTADOS -------#

# Obtendo total de votos para cada partido
votos_por_partido <- resultado %>%
	group_by(partido) %>%
	summarise(total_partido = sum(voto))
head(votos_por_partido)

# Obtendo total de votos por ocupa��o de candidatos(as)
votos_por_ocupacao <- resultado %>%
	group_by(ocup) %>%
	summarise(total_ocupacao = sum(voto))
head(votos_por_ocupacao)

# Obtendo total de votos por sexo de candidatos(as)
votos_por_sexo <- resultado %>%
	group_by(sexo) %>%
	summarise(total_sexo = sum(voto))
head(votos_por_sexo)

# Obtendo total de votos por grau de escolaridade de candidatos(as)
votos_por_educ <- resultado %>%
	group_by(educ) %>%
	summarise(total_educ = sum(voto))
head(votos_por_educ)

#------- FIM -------#
q()