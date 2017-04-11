# FLS6307 - Introdução à Programação e Ferramentas Computacionais para as Ciências Sociais
# Prof. Dr. Leonardo Barone
# Desafio 1

### nome <- "Cassio Santos Pinto de Oliveira"
### programa <- "Mestrado em Ciência Política"
### n_usp <- 6912700
### data_entrega: "13/04/2017"


# Instalando pacotes que serão utilizados (no caso, o TidyR já contém todas as
# bibliotecas necessárias)
install.packages("tidyr")
# Chamando as bibliotecas
library(data.table)
library(dplyr)
library(readr)

# Removendo objetos que porventura estejam na memória
rm(list=ls())

# Criando e selecionando diretório de trabalho
wordir <- "C:\\Users\\Cassio\\Dropbox\\Mestrado\\Disciplinas\\Introdução à Programação e Ferramentas Computacionais para as Ciências Sociais\\Desafio 1"
setwd(wordir)


#------- PARTE 1 - ABRINDO OS DADOS -------#

# Criando objetos com endereços de arquivos (copiados do site do TSE) a serem
# baixados, cf. Tutorial 4
arq1 <- "http://agencia.tse.jus.br/estatistica/sead/odsele/votacao_candidato_munzona/votacao_candidato_munzona_2016.zip"
arq2 <- "http://agencia.tse.jus.br/estatistica/sead/odsele/consulta_cand/consulta_cand_2016.zip"
# Baixando arquivos temporários em formato .zip
download.file(arq1, "temp1.zip", quiet = T)
download.file(arq2, "temp2.zip", quiet = T)
# Descompactando arquivos
unzip("temp1.zip")
# Renomeando arquivo "LEIAME", para identificá-lo e evitar que este seja
# substituído ao fazer a segunda descompactação
file.rename(list.files(, pattern = "LEIAME.pdf"), "LEIAME_resultados.pdf")
unzip("temp2.zip")
# Renomeando arquivo "LEIAME" dos candidatos
file.rename(list.files(, pattern = "LEIAME.pdf"), "LEIAME_candidatos.pdf")
# Apagando arquivos compactados
file.remove("temp1.zip")
file.remove("temp2.zip")

# Criando bancos de dados de votação e candidatura e checando cada um para
# verificar se as variáveis são as mesmas
# Não criamos loop porque estamos lidando apenas com três bancos

bd_resultados_RS <- read.table("votacao_candidato_munzona_2016_RS.txt", sep=";", head=F)
head(bd_resultados_RS)
bd_resultados_PR <- read.table("votacao_candidato_munzona_2016_PR.txt", sep=";", head=F)
head(bd_resultados_PR)
bd_resultados_SC <- read.table("votacao_candidato_munzona_2016_SC.txt", sep=";", head=F)
head(bd_resultados_SC)
# Segunda checagem - igualdade de variáveis
all.equal(dim(bd_resultados_RS)[2], dim(bd_resultados_PR)[2], 
						dim(bd_resultados_SC)[2])

bd_candidatos_RS <- read.table("consulta_cand_2016_RS.txt", sep=";", head=F)
head(bd_candidatos_RS)
bd_candidatos_PR <- read.table("consulta_cand_2016_PR.txt", sep=";", head=F)
head(bd_candidatos_PR)
bd_candidatos_SC <- read.table("consulta_cand_2016_SC.txt", sep=";", head=F)
head(bd_candidatos_SC)
dim(bd_candidatos_RS) == dim(bd_candidatos_PR) == dim(bd_candidatos_SC)
# Segunda checagem - igualdade de variáveis
all.equal(dim(bd_candidatos_RS)[2], dim(bd_candidatos_PR)[2], 
						dim(bd_candidatos_SC)[2])


# Certificado que as variáveis são as mesmas, unimos os bancos de dados
bd_resultados <- bind_rows(bd_resultados_RS, bd_resultados_PR, bd_resultados_SC)
bd_candidatos <- bind_rows(bd_candidatos_RS, bd_candidatos_PR, bd_candidatos_SC)

# Removendo objetos obsoletos
# Determinando posições na lista
ls()
# Removendo por vetor das posições encontradas
rm(list = ls()[c(1:2, 4:6, 8:10)])

# Renomeando variáveis segundo os arquivos "LEIAME", pois o sítio do TSE
# lamentavelmente não é amigável o suficiente para fazer um simples arquivo
# com o nome das variáveis. Os nomes foram colocados em maiúscula como em cada 
# arquivo LEIAME.
# ----------------
# Cheguei a tentar utilizar um leitor automático de pdf, mas não tive tempo de
# elaborar melhor a função.
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

# Verificando variáveis no banco
glimpse(bd_resultados)

# Utilizando pacote dplyr para editar banco de dados
bd_resultados <- bd_resultados %>%
# Filtrando prefeitos; CODIGO_CARGO de prefeito é igual a 11
	filter(CODIGO_CARGO == 11) %>%
# Selecionando variáveis de interesse
	select(SIGLA_UF, CODIGO_MUNICIPIO, NUMERO_PARTIDO, NUMERO_CAND, TOTAL_VOTOS) %>%
# Renomeando variáveis de interesse
  	rename(uf = SIGLA_UF,
		 cod_munic = CODIGO_MUNICIPIO, 
		 partido = NUMERO_PARTIDO, 
		 num_cand = NUMERO_CAND, 
		 voto = TOTAL_VOTOS)
# Verificando se recorte está correto
head(bd_resultados)

#------- PARTE 3 - DATA FRAME CANDIDATOS -------#

# Verificando variáveis no banco
glimpse(bd_candidatos)

# Utilizando pacote dplyr para editar banco de dados
bd_candidatos <- bd_candidatos %>%
# Filtrando prefeitos; CODIGO_CARGO de prefeito é igual a 11
	filter(CODIGO_CARGO == 11) %>%
# Selecionando variáveis de interesse
	select(SIGLA_UF, NUMERO_PARTIDO, NUMERO_CANDIDATO, DESCRICAO_OCUPACAO, DESCRICAO_SEXO, DESCRICAO_GRAU_INSTRUCAO) %>%
# Renomeando variáveis de interesse
  	rename(uf = SIGLA_UF,
		 partido = NUMERO_PARTIDO, 
		 num_cand = NUMERO_CANDIDATO, 
		 ocup = DESCRICAO_OCUPACAO,
		 sexo = DESCRICAO_SEXO,
		 educ = DESCRICAO_GRAU_INSTRUCAO)

# Verificando se recorte está correto
head(bd_candidatos)

#------- PARTE 4 - AGREGANDO E COMBINANDO POR MUNICÍPIO -------#

# Obtendo soma do total de votos, agrupando por município
bd_resultado_mun <- bd_resultados %>%
	group_by(cod_munic) %>%
	summarise(total_votos_mun = sum(voto))

# Combinando os data frames. O data frame final não foi sobrescrito porque
# o nome original do banco utilizado era "bd_resultados", e não "resultado"
resultado <- bd_resultados %>%
	left_join(bd_resultado_mun, by = "cod_munic")
# Podemos verificar que o total de votos ("total_votos") foi efetivamente
# combinado à esquerda, mantendo resultados iguais para os mesmos municípios,
# como previa a função.
head(resultado)

# Produzindo variável de proporção de votos dos candidatos, ignorando os votos
# na legenda do partido para fins didáticos
resultado <- resultado %>%
	mutate(prop_mun = voto/total_votos_mun)
head(resultado)

#------- PARTE 5 - AGREGANDO E COMBINANDO POR CANDIDATO -------#

# Embora estejamos recriando as mesmas variáveis, essa etapa seria útil
# se estivéssemos trabalhando com eleições onde um candidato pode ser 
# votado por mais de um município (estaduais ou federais), já que
# nesses casos o total de votos por município é diferente do total de 
# votos do candidato quando ele recebe votação em mais de um município.
# HÁ OUTRO PROBLEMA IMPORTANTE! Os números de candidatos coincidem entre os 
# municípios, o que na prática faz com que somemos votos por PARTIDO e UF,
# e não CANDIDATO e UF. Isso seria resolvido incluindo "cod_munic" no lugar de
# "uf" (que passa a ser desnecessária, já que há chave única para cada município)
# no agrupamento. Entretanto, se fôssemos fazer para eleições de outros níveis
# (estadual/federal), aí o agrupamento por UF faria sentido já que esperaríamos
# um número único de candidato por UF para essas eleições.
# FEITAS ESSAS CONSIDERAÇÕES, FAREI ESSA SUBSTITUIÇÃO (de "uf" por "cod_munic"),
# A PARTIR DA MINHA INTERPRETAÇÃO DO RESULTADO REQUERIDO PELO EXERCÍCIO.

# Total de votos por UF e Número do Candidato
resultado_cand <- resultado %>%
	group_by(cod_munic, num_cand) %>%
	summarise(total_votos_cand = sum(voto))
head(resultado_cand)

resultado <- resultado %>%
	right_join(resultado_cand, by = c("cod_munic", "num_cand"))
head(resultado)
# Verificamos que, como esperado, "total_votos_cand", o total por município,
# é igual a "voto", o total por candidato. Se estivéssemos em eleições 
# estaduais ou federais, veríamos que a soma seria diferente para cada UF.
# Se incluíssemos (e não substituíssimos) "uf" nas variáveis a agrupar em
# "resultado_cand", teríamos o mesmo resultado, mas se deixássemos apenas
# "uf" e "num_cand", teríamos a soma dos votos de todos os candidatos com
# o mesmo número (portanto, do mesmo partido) por UF.

# Calculando o total de votos do candidato no município em relação ao total
# de votos do candidato.

resultado <- resultado %>%
	mutate(prop_cand = voto/total_votos_cand)
head(resultado)
# A proporção sempre será de 100%, exceto nos casos nos quais o(a) candidato(a)
# não recebeu nenhum voto sequer, nos quais o R interpreta o resultado como
# "not a number" ("NaN"), já que normalmente não se divide por 0.

#------- PARTE 6 - COMBINANDO RESULTADOS E CANDIDATURAS -------#

head(resultado)
head(bd_candidatos)
# Variáveis em comum: uf, partido e num_cand
# Combinando bancos de dados por variáveis em comum
resultado <- resultado %>%
	right_join(bd_candidatos, by = c("uf", "partido", "num_cand"))
head(resultado)

#------- PARTE 7 - TREINANDO TABELAS DE RESULTADOS -------#

# Obtendo total de votos para cada partido
votos_por_partido <- resultado %>%
	group_by(partido) %>%
	summarise(total_partido = sum(voto))
head(votos_por_partido)

# Obtendo total de votos por ocupação de candidatos(as)
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