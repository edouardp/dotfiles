eval $(/usr/libexec/path_helper -s)

export PATH=/usr/local/opt/pyenv/libexec:$PATH

# Load bash prompt
#
. ~/.dotfiles/prompt.bash

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced


# Hack for pyenv axctivate
eval "$(pyenv init -)"

# Bash Conmpletion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# Aliases
alias ll="ls -lv"
alias la='ll -A'           #  Show hidden files.


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
