# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
export PATH="$HOME/bin:$HOME/.composer/vendor/bin:$HOME/.gems/bin:$PATH"
export GEM_HOME="/home/$USER/.gems"
