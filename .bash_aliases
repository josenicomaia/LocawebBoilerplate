open_php_config() {
    PHP_VERSION=$(. php -r "echo sprintf('%d.%d', PHP_MAJOR_VERSION, PHP_MINOR_VERSION);")
    PHP_INTERFACE=$1

    vi ~/php/$PHP_VERSION/$PHP_INTERFACE/php.ini
}

# Editar configurações do PHP
alias pcli='open_php_config cli'
alias pcgi='open_php_config cgi'

# Git
alias gbr='git branch'
alias gst='git status'
alias gch='git checkout'
alias gco='git commit'

# Bash
alias l='ls -lprth'
alias t='tail -100f'

function ccd() {
    cd $(dirname $(readlink -e $1))
}

# Paliativo Locaweb
alias php='. php'
alias composer='php ~/bin/composer'