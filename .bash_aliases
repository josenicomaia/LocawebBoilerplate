open_php_config() {
    PHP_VERSION=$(. php -r "echo sprintf('%d.%d', PHP_MAJOR_VERSION, PHP_MINOR_VERSION);")
    PHP_INTERFACE=$1

    vi ~/php/$PHP_VERSION/$PHP_INTERFACE/php.ini
}

alias pcli='open_php_config cli'
alias pcgi='open_php_config cgi'

