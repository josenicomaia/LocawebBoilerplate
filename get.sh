#!/bin/bash
php71 -r "copy('https://github.com/josenicomaia/LocawebBoilerplate/archive/master.zip', 'LocawebBoilerplate-master.zip');" ¨ && \
    unzip LocawebBoilerplate-master.zip && \
    mv LocawebBoilerplate-master LocawebBoilerplate && \
    rm LocawebBoilerplate-master.zip && \
    . LocawebBoilerplate/locaweb.sh registrar && \
    . LocawebBoilerplate/locaweb.sh ajuda
