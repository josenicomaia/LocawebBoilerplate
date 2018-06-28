# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
export GOROOT="/home/$USER/go"
export GOPATH="/home/$USER/.go"
export PATH="$HOME/bin:$HOME/.composer/vendor/bin:$GOROOT/bin:$GOPATH/bin:$HOME/.gems/bin:$PATH"
export GEM_HOME="/home/$USER/.gems"
