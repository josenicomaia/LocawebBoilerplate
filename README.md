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

### Versões PHP disponíveis no script
* 5.2
* 5.3
* 5.4
* 5.5
* 5.6
* 7.0

## Instalar LocawebBoilerplate
`curl -s "https://raw.githubusercontent.com/josenicomaia/LocawebBoilerplate/master/get.sh" | bash`

#### Modificar versão do PHP
`locaweb php <versao>`

#### Instalar o composer
`locaweb composer`

#### Gerar o par de chaves RSA
`locaweb ssh`

#### Instalar os arquivos de configuração do Bash (beseado no ubuntu)
`locaweb bash`