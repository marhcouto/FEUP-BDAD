# **UML to Relational Schema**


## EX1
 - Marca (nome, país, numPontos)
 - Carro (numCarro, peso, potência, velocidadeMax, nomeMarca->Marca)
 - Piloto (id, nome, morada, dataNasc, nacionalidade, numPontos, numCarro->Carro)
 - Desistência (piloto->Piloto, corrida->Corrida, numVolta, motivo)
 - Participação (piloto->Piloto, corrida->Corrida, posiçãoGrelha, classFinal)
 - Corrida (id, nome, data, numVoltas, idCircuito->Circuito)
 - Circuito (id, nome, local, país, perímetro)


## EX2
 - Cliente (NIF, nome, morada, localidade)
 - Jardim (id, nome, morada, localidade, área)
 - ClienteJardim (NIF->Cliente, jardim->Jardim, proprietário)
 - Planta (nomeComum, nomeCientífico)
 - Info (planta->Planta, jardim->Jardim, área, numPlantas)
 - Praga (nome)
 - PlantaPraga (praga->Praga, planta->Planta)
 - Tratamento (nome)
 - Época (id, dataInício, dataFim)
 - ÉpocaPragaTratamento (tratamento->Tratamento, praga->Praga, época->Época)
 - 
## EX3
 - Cliente (id, título, nome, morada, codPostal, localidade, telefone)
 - Conta (numConta, saldo, tipoConta->TipoConta)
 - ClienteConta (conta->Conta, cliente->Cliente, ordem)
 - TipoConta (nome)
 - Movimento (id, data, montante, origem->Conta, destino->Conta,             - tipoMovimento->TipoMovimento)
 - TipoMovimento (nome)

## EX4
 - Entrevista (dataHora, dataContacto, pessoa->Pessoa)
 - Pessoa (id, nome, dataNascimento, estadoCivil, limMinRemun)
 - Emprego (id, descrição, remuneração-base, empresa->Empresa, área->Área)
 - PessoaEmprego (pessoa->Pessoa, emprego->Emprego, classificação)
 - Área (nome)
 - Ordem (pessoa->Pessoa, área->Área, ordem)
 - Habilitação (nome)
 - Competência (nome)
 - CompetênciaEmprego (competência->Competência, emprego->Emprego)
 - HabilitaçãoEmprego (habilitação->Habilitação, emprego->Emprego)
 - PessoaHabilitação (habilitação->Habilitação, pessoa->Pessoa)
 - PessoaCompetência (competência->Competência, pessoa->Pessoa)
 - Empresa (id, nome, morada, telefone)
