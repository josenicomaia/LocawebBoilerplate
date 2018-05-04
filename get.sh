#!/bin/bash
php -r "copy('https://github.com/josenicomaia/LocawebBoilerplate/archive/master.zip', 'LocawebBoilerplate-master.zip');"
unzip LocawebBoilerplate-master.zip
mv LocawebBoilerplate-master LocawebBoilerplate
rm LocawebBoilerplate-master.zip
locaweb.sh registrar
locaweb.sh ajuda
