#!/bin/bash

VERSAO_PHP=5.5
ENV_PHP=production

if [ -f $file ]; then
    rm /home/$USER/bin/php
fi

ln -s /home/$USER/bin/php$VERSAO_PHP.sh /home/$USER/bin/php
cd php/$VERSAO_PHP
sed "s/LOCAWEB_USER/$USER/g" .htaccess > /home/$USER/public_html/.htaccess

for TIPO_VERSAO_CONFIG_PHP_DIR in *; do
    if [ -d "${TIPO_VERSAO_CONFIG_PHP_DIR}" ]; then
        sed "s/LOCAWEB_USER/$USER/g" ${TIPO_VERSAO_CONFIG_PHP_DIR}/php.ini-$ENV_PHP > ${TIPO_VERSAO_CONFIG_PHP_DIR}/php.ini
    fi
done

cd -