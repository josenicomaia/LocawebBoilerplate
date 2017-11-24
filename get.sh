#!/bin/bash

# Pegar o PATH do script (https://stackoverflow.com/a/246128/6465636)
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

git clone https://github.com/josenicomaia/LocawebBoilerplate.git LocawebBoilerplate
$DIR/LocawebBoilerplate/locaweb.sh registrar
$DIR/LocawebBoilerplate/locaweb.sh ajuda