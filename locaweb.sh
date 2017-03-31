#!/bin/bash

# Pegar o PATH do script (http://stackoverflow.com/a/4774063/6465636)
pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null

ajuda() {
    
}

composer() {
    echo "Instalando composer"
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    php composer-setup.php
    php -r "unlink('composer-setup.php');"
    mv composer.phar $HOME/bin/composer
}

ssh_keygen() {
    echo "Gerando chaves RSA"
    ssh-keygen -t rsa -f $HOME/.ssh/id_rsa -N ""
    cat $HOME/.ssh/id_rsa.pub
}

instalar() {
    composer
    ssh_keygen
    instalar_config_bash
    instalar_config_php
    trocar_php $1
}

instalar_config_bash() {
    echo "Instalando arquivos de configuração do Bash"
    cp $SCRIPTPATH/.bash_logout $HOME/.bash_logout
    cp $SCRIPTPATH/.bash_profile $HOME/.bash_profile
    cp $SCRIPTPATH/.bashrc $HOME/.bashrc
}

instalar_config_php() {
    ENV_PHP=production
    echo "Instalando arquivos de configuração do PHP"
    cd $SCRIPTPATH/php
    
    for TIPO_VERSAO_CONFIG_PHP_DIR in *; do
        if [ -d "${TIPO_VERSAO_CONFIG_PHP_DIR}" ]; then
            sed "s/LOCAWEB_USER/$USER/g" ${TIPO_VERSAO_CONFIG_PHP_DIR}/php.ini-$ENV_PHP > $HOME/php/${TIPO_VERSAO_CONFIG_PHP_DIR}/php.ini
        fi
    done
    
    cd -
}

trocar_php() {
    echo "Trocando versão do PHP"
    if [ -f $file ]; then
        rm $HOME/bin/php
    fi
    
    ln -s $HOME/bin/php$1.sh /home/$USER/bin/php
    sed "s/LOCAWEB_USER/$USER/g" $SCRIPTPATH/php/$1/.htaccess > $HOME/public_html/.htaccess
}

case "$1" in
    ajuda)
        ajuda
    ;;
    
    composer)
        composer
    ;;
    
    config)
        instalar_config_bash
        instalar_config_php
    ;;
    
    keygen)
        ssh_keygen
    ;;
    
    instalar)
        instalar $1
    ;;
    
    php)
        trocar_php $1
    ;;
esac
