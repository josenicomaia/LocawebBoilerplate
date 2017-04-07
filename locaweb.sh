#!/bin/bash

# Pegar o PATH do script (http://stackoverflow.com/a/4774063/6465636)
pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null

ajuda() {
    echo "Ajuda"
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
    instalar_config_bash
    instalar_config_php
    trocar_php $1
    ssh_keygen
    composer
}

instalar_config_bash() {
    echo "Instalando arquivos de configuracao do Bash"
    cp $SCRIPTPATH/.bash_logout $HOME/.bash_logout
    cp $SCRIPTPATH/.bash_profile $HOME/.bash_profile
    cp $SCRIPTPATH/.bashrc $HOME/.bashrc
    source ~/.bash_profile
}

instalar_config_php() {
    ENV_PHP=production
    echo "Instalando arquivos de configuracao do PHP"
    mkdir -p $HOME/bin
    cp $SCRIPTPATH/bin/php*.sh $HOME/bin
    
    mkdir -p $HOME/php
    cd $SCRIPTPATH/php
    
    for VERSAO_PHP in *; do
        if [ -d "${VERSAO_PHP}" ]; then
            for TIPO in "cgi" "cli" "fpm"; do
                if [ -d "${VERSAO_PHP}/${TIPO}" ]; then
                    if [ ! -d "$HOME/php/${VERSAO_PHP}/${TIPO}" ]; then
                        mkdir -p $HOME/php/${VERSAO_PHP}/${TIPO}
                    fi

                    sed "s/LOCAWEB_USER/$USER/g" ${VERSAO_PHP}/${TIPO}/php.ini-$ENV_PHP > $HOME/php/${VERSAO_PHP}/${TIPO}/php.ini
                fi
            done

        fi
    done

    cd - > /dev/null
}

trocar_php() {
    echo "Trocando versao do PHP"
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
        instalar $2
    ;;
    
    php)
        trocar_php $2
    ;;
esac
