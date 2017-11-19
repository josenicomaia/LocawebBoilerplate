#!/bin/bash

# Pegar o PATH do script (http://stackoverflow.com/a/4774063/6465636)
pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null

git clone https://github.com/josenicomaia/LocawebBoilerplate.git LocawebBoilerplate
$SCRIPTPATH/LocawebBoilerplate/locaweb.sh registrar
$SCRIPTPATH/LocawebBoilerplate/locaweb.sh ajuda