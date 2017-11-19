#!/bin/bash

# Pegar o PATH do script (http://stackoverflow.com/a/4774063/6465636)
pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null

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
    ln -s $SCRIPTPATH/locaweb.sh /home/$USER/bin/locaweb

    echo "Registrado."
}

instalar_composer() {
    echo "Baixando composer..."
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"

    echo "Instalando composer..."
    php composer-setup.php
    php -r "unlink('composer-setup.php');"

    echo "Registrando composer..."
    mv composer.phar $HOME/bin/composer

    echo "Registrado."
}

gerar_chaves_ssh() {
    if [ -s $HOME/.ssh/id_rsa ]; then
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
    cp $SCRIPTPATH/.bash_logout $HOME/.bash_logout
    cp $SCRIPTPATH/.bash_profile $HOME/.bash_profile
    cp $SCRIPTPATH/.bashrc $HOME/.bashrc

    echo "Carregando configuracoes..."
    source ~/.bash_profile

    echo "Carregado."
}

php() {
    PHP_VERSION=$1
    PHP_ENV=${2:-production}

    instalar_config_php $PHP_VERSION $PHP_ENV

    if [ -f $HOME/bin/php ]; then
        rm $HOME/bin/php
    fi

    echo "Registrando versao do PHP para linha de comando..."
    cp $SCRIPTPATH/php/$PHP_VERSION/php$PHP_VERSION.sh $HOME/bin/php

    echo "Registrando versao do PHP para WEB..."
    sed "s/LOCAWEB_USER/$USER/g" $SCRIPTPATH/php/$PHP_VERSION/.htaccess > $HOME/public_html/.htaccess
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
        cp $SCRIPTPATH/php/$PHP_VERSION/cgi/php.ini-$PHP_ENV $HOME/php/$PHP_VERSION/cgi/php.ini

        echo "Copiando configurações do CLI..."
        mkdir -p $HOME/php/$PHP_VERSION/cli
        sed "s/LOCAWEB_USER/$USER/g" $SCRIPTPATH/$PHP_VERSION/cli/php.ini-$PHP_ENV > $HOME/php/$PHP_VERSION/cli/php.ini
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
