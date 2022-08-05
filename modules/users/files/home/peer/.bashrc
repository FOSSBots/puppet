case $- in
    *i*) ;;
      *) return;;
esac
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s checkwinsize

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# env vars
export EDITOR=`which vim`

# Aliases
alias ccze="ccze -mansi" # -m ansi disables ncurses - a much easier experience
alias si="sudo -i"

# Aliases (as functions)
ctailf () {
  tail -f $1 | ccze -mansi
}

# PS1
ps1_prompt() {
    local ps1_exit=$?
    if [ $ps1_exit -eq 0 ]; then
        ps1_status=""
    else
        ps1_status=`echo -e "$(tput bold)\033[38;5;14m$ps1_exit$(tput sgr0)"`
    fi
    export PS1="\[\033[38;5;11m\]\u\[$(tput sgr0)\]@\[$(tput sgr0)\]\[\033[38;5;9m\]\H\[$(tput sgr0)\]:\[$(tput sgr0)\]\[\033[38;5;6m\][\w]\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;10m\]\$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')\[$(tput sgr0)\]\$ps1_status\n\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;10m\]\\$\[$(tput sgr0)\] \[$(tput sgr0)\]"
}
PROMPT_COMMAND="ps1_prompt"
