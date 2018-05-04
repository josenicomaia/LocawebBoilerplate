#!/bin/bash

# Pegar o PATH do script (https://stackoverflow.com/a/246128/6465636)
SOURCE="${BASH_SOURCE[0]}"

while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done

DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

ajuda() {
    echo "Uso: locaweb <comando> [pametros...]"
    echo ""
    echo "Comandos:"
    echo "  php <versao> [env=production|development]:   Faz o ambiente utilizar a versão desejada do PHP."
    echo "    Versoes suportadas:"
    [ -s /usr/bin/php52 ] && echo "     - 5.2"
    [ -s /usr/bin/php53 ] && echo "     - 5.3"
    [ -s /usr/bin/php54 ] && echo "     - 5.4"
    [ -s /usr/bin/php55 ] && echo "     - 5.5"
    [ -s /usr/bin/php56 ] && echo "     - 5.6"
    [ -s /usr/bin/php7 ]  && echo "     - 7.0"
    [ -s /usr/bin/php71 ] && echo "     - 7.1"
    echo "  composer:                                    Instala o composer."
    echo "  ssh:                                         Gera um par de chaves para o SSH utilizando RSA."
    echo "  registrar:                                   Registra o script do LocawebBoilerplate como locaweb."
    echo "  bash:                                        Instala as configurações padroes do bash (baseado no ubuntu)."
}

registrar() {
    if [ ! -d $HOME/bin ]; then
        mkdir -p $HOME/bin
    fi

    echo "Registrando LocawebBoilerplate..."
    ln -s $DIR/locaweb.sh /home/$USER/bin/lw

    echo "Registrado."
}

instalar_composer() {
    echo "Baixando composer..."
    command php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"

    echo "Instalando composer..."
    command php composer-setup.php

    if [ $? -eq 0 ]; then
        echo "Registrando composer..."
        mv composer.phar $HOME/bin/composer

        echo "Registrado."
    fi

    echo "Apagando instalador..."
    command php -r "unlink('composer-setup.php');"
}

gerar_chaves_ssh() {
    if [ ! -s $HOME/.ssh/id_rsa ]; then
        echo "Gerando par de chaves do SSH..."
        ssh-keygen -t rsa -f $HOME/.ssh/id_rsa -N ""

        echo "Chave publica:"
        cat $HOME/.ssh/id_rsa.pub
    else
        echo "Já existe um par de chaves gerado."

        echo "Chave publica:"
        cat $HOME/.ssh/id_rsa.pub
    fi
}

instalar_config_bash() {
    echo "Instalando arquivos de configuracao do Bash..."
    cp $DIR/.bash_logout $HOME/.bash_logout
    cp $DIR/.bash_profile $HOME/.bash_profile
    cp $DIR/.bashrc $HOME/.bashrc
    cp $DIR/.bash_aliases $HOME/.bash_aliases

    echo "Carregando configuracoes..."
    source $HOME/.bash_profile

    echo "Carregado."
}

php() {
    PHP_VERSION=$1
    PHP_ENV=${2:-production}

    echo "Versão selecionada do PHP: $PHP_VERSION"
    instalar_config_php $PHP_VERSION $PHP_ENV

    if [ -d $DIR/php/$PHP_VERSION ]; then
        if [ -f $HOME/bin/php ]; then
            rm $HOME/bin/php
        fi

        echo "Registrando versao do PHP para linha de comando..."
        cp $DIR/php/$PHP_VERSION/cli/php$PHP_VERSION.sh $HOME/bin/php
        chmod +x $HOME/bin/php
        cp $DIR/php/$PHP_VERSION/cli/phpize$PHP_VERSION.sh $HOME/bin/phpize
        chmod +x $HOME/bin/phpize
        cp $DIR/php/$PHP_VERSION/cli/php$PHP_VERSION-config.sh $HOME/bin/php-config
        chmod +x $HOME/bin/php-config

        echo "Registrando versao do PHP para WEB..."
        sed "s/LOCAWEB_USER/$USER/g" $DIR/php/$PHP_VERSION/.htaccess > $HOME/public_html/.htaccess

        echo ""
        command php -v
    else
        echo "Configurações não encontradas!"
    fi
}

instalar_config_php() {
    PHP_VERSION=$1
    PHP_ENV=${2:-production}

    if [ ! -d $HOME/php/$PHP_VERSION ]; then
        echo "Instalando arquivos de configuracao do PHP..."

        if [ ! -d $HOME/tmp ]; then
            mkdir -p $HOME/tmp
            chmod 777 $HOME/tmp
        fi

        echo "Copiando configurações do CGI..."
        mkdir -p $HOME/php/$PHP_VERSION/cgi
        sed "s/LOCAWEB_USER/$USER/g" $DIR/php/$PHP_VERSION/cgi/php.ini-$PHP_ENV > $HOME/php/$PHP_VERSION/cgi/php.ini

        echo "Copiando configurações do CLI..."
        mkdir -p $HOME/php/$PHP_VERSION/cli
        sed "s/LOCAWEB_USER/$USER/g" $DIR/php/$PHP_VERSION/cli/php.ini-$PHP_ENV > $HOME/php/$PHP_VERSION/cli/php.ini
    fi
}

case "$1" in
    ajuda)
        ajuda
    ;;

    php)
        php $2 $3
    ;;

    composer)
        instalar_composer
    ;;

    ssh)
        gerar_chaves_ssh
    ;;

    registrar)
        registrar
    ;;

    bash)
        instalar_config_bash
    ;;
esac
