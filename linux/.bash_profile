#############################################################################

export PS1='\[\033[01;31m\]\u\[\033[01;33m\]@\[\033[01;36m\]\h \[\033[01;33m\]\w \[\033[01;35m\]\$ \[\033[00m\]'
umask 022

#############################################################################

eval "`dircolors`"

#############################################################################

alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -lA'
alias ..='cd ..'
alias ...='cd ../..'
alias s='ssh -l root'
alias update='apt-get update; apt-get upgrade'
alias fping='ping -c 20 -i 0.1 -s 2048'
alias now='date +"%d.%m.%Y %T"'
alias sudolast='sudo !!'
alias installed='dpkg --get-selections | grep -v deinstall'
alias savebashprofile='installed > /root/installed.log; php /root/savebashprofile.php'
alias editprofile='nano /root/.bash_profile'

autounzip () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1     ;;
      *.tar.gz)    tar xzf $1     ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar e $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xf $1      ;;
      *.tbz2)      tar xjf $1     ;;
      *.tgz)       tar xzf $1     ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)     echo "'$1' cannot be extracted via autounzip" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

#############################################################################

export HISTFILESIZE=99999999
export HISTSIZE=99999999
export HISTCONTROL="ignoreboth"

export LS_OPTIONS='--color=auto -h'

#############################################################################

