# Locaweb Boilerplate

*Configure sua hospedagem compartilhada da Locaweb em um tiro*

## Detalhes
Este projeto tem o objetivo auxiliar a configuração inicial básica em sua hospedagem compartilhada da Locaweb.
As configurações do PHP ficam todas na pasta `~/php` de acordo com cada versão disponível.

### Opções
* Arquivos de configuração Bash padrões
* Arquivos de configuração PHP padrões com alterações para funcionar na Locaweb
* Trocar versão do PHP
* Geração do par de chaves RSA
* Instalação do Composer

## Como Usar
#### Clonar o repositório
`git clone https://github.com/josenicomaia/LocawebBoilerplate.git`

#### Instalar tudo
`./LocawebBoilerplate/locaweb.sh instalar <versao_desejada_php>`

Obs.: Executar esse comando é o mesmo que executar `config`, `php`, `keygen` e `composer`.

## Outras opções
#### Instalar o composer
`./LocawebBoilerplate/locaweb.sh composer`

#### Instalar os arquivos de configuração PHP e Bash
`./LocawebBoilerplate/locaweb.sh config`

#### Gerar o par de chaves RSA
`./LocawebBoilerplate/locaweb.sh keygen`

#### Modificar versão do PHP
`./LocawebBoilerplate/locaweb.sh php <versao_desejada_php>`

Obs.: Para executar esse comando é necessário que `config` já tenha sido instalado.
