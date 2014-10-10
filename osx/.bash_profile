#.bash_profile

alias cddesktop='cd ~/Desktop/'
alias cddownload='cd ~/Downloads/'
alias cdgit='cd ~/git/'
alias editprofile='nano ~/.bash_profile'                                # edit bash profile
alias update="sudo softwareupdate -i -a; brew update; brew upgrade"     # update mac and homebrew
alias now='date +"%d.%m.%Y %T"'                                         # print now as dd.mm.yyyy hh:mm:ss
alias fping='ping -c 20 -i 0.1 -s 2048'                                 # make 20 pings with 2048 bytes
alias myip='curl ip.appspot.com'                                        # Public facing IP Address
alias netCons='lsof -i'                                                 # Show all open TCP/IP sockets
alias flushDNS='dscacheutil -flushcache'                                # Flush out the DNS Cache
alias openPorts='sudo lsof -i | grep LISTEN'                            # All listening connections
alias localip="ifconfig en0 inet | grep 'inet ' | awk ' { print $2 } '" # show local ip address
alias awhois="whois -h whois-servers.net"
alias finder_s='defaults write com.apple.Finder AppleShowAllFiles TRUE; killAll Finder'
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'
alias sudolast='sudo !!'
alias swift='xcrun swift'
alias elasticsearchx='elasticsearch --config=/usr/local/opt/elasticsearch/config/elasticsearch.yml'

dash () {
  open dash://$1
}

savebashprofile () {
  cp ~/.bash_profile ~/git/archive/bash_profile.log
  brew list --versions > ~/git/archive/brew_list.log
  ls -al /Applications/ > ~/git/archive/applications.log
  pkgutil --packages > ~/git/archive/pkgutil.log
  history > ~/git/archive/history.log
  npm list -g > ~/git/archive/npm_list.log
  ls -al /usr/local/bin/ > ~/git/archive/bin.log
  ls -al /usr/bin/ >> ~/git/archive/bin.log
  rls ~/Golang/src 3 ld > ~/git/archive/gosrc.log
  history | cut -c 8- | grep "go get " > ~/git/archive/goget.log
  #npm ll -g shows more info about installed node packages
}

rls () {
  if [ "$1" == "" ]; then
    dir="."
    echo "set dir to ."
  else
    dir="$1"
  fi
  if [ "$2" == "" ]; then
    depth="1"
    echo "set depth to 1"
  else
    depth="$2"
  fi
  if [ "$3" == "" ]; then
    mode="ald"
    echo "set mode to ald"
  else
    mode="$3"
  fi
  find $dir -maxdepth $depth -type d -exec ls -$mode "{}" \;
}

searchwithline () {
  cat -n $1 | grep "$2"
}

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

autoview () {
  if [ -f $1 ] ; then
    case $1 in
      *.md)   mdp $1     ;;
      *.js)   nano $1    ;;
      *.php)  nano $1    ;;
      *.html) nano $1    ;;
      *)     echo "'$1' cannot be viewed by autoview" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

autocompile () {
  if [ -f $1 ] ; then
    case $1 in
      *.js)     node $1 ;;
      *.lua)    lua $1 ;;
      *.pl)     perl $1 ;;
      *.php)    php $1 ;;
      *.py)     python $1 ;;
      *.rb)     ruby $1 ;;
      *.sh)     bash $1 ;;
      *.go)     go run $1 ;;
      *.swift)  xcrun swift $1 ;;
      *.cbl)    cobc -V && cobc -free -x $1 -o $1.capp && ./$1.capp && rm ./$1.capp ;;
      *.c)      compilec $1 ;;
      *.java)   compilejava $1 ;;
      *.nim)    /usr/local/Cellar/nimrod/0.9.2/libexec/bin/nimrod compile --run $1 ;;
      *)        echo "'$1' cannot be run via autocompile()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

compilec () {
  enc[4]="UTF-8"       # UTF-8
  enc[10]="UTF-16"     # UTF-16
  enc[5]="ISO-8859-1"  # ISO Latin 1
  enc[9]="ISO-8859-2"  # ISO Latin 2
  enc[30]="MacRoman"   # Mac OS Roman
  enc[12]="CP1252"     # Windows Latin 1
  enc[3]="EUC-JP"      # Japanese (EUC)
  enc[8]="SHIFT_JIS"   # Japanese (Shift JIS)
  enc[1]="ASCII"       # ASCII

  compname=`echo "$1" | sed 's/\(.*\)\..*/\1/'`
  clang "$1" -o "$compname" $3
  status=$?
  if [ $status -eq 0 ]
  then
    echo $compname
    exit 0
  elif [ $status -eq 127 ]
  then
  echo -e "\nTo run code in this language, you need to have compilers installed. These are bundled with Xcode which can be downloaded through the Mac App Store or Apple's developer site. \n\nIf you are using Xcode 4.3 or later, you need to open Xcode preferences, select the Downloads pane, and choose to install 'Command Line Tools'. This may require an Apple developer account, which is free."
  fi
  exit $status
}

compilejava () {
  enc[4]="UTF8"       # UTF-8
  enc[10]="UTF16"     # UTF-16
  enc[5]="ISO8859-1"  # ISO Latin 1
  enc[9]="ISO8859-2"  # ISO Latin 2
  enc[30]="MacRoman"  # Mac OS Roman
  enc[12]="CP1252"    # Windows Latin 1
  enc[3]="EUCJIS"     # Japanese (EUC)
  enc[8]="SJIS"       # Japanese (Shift JIS)
  enc[1]="ASCII"      # ASCII

  rm -rf "$4"/java-compiled
  mkdir "$4"/java-compiled
  javac "$1" -d "$4"/java-compiled -encoding ${enc[$2]} $3
  status=$?

  if [ $status -ne 0 ]
  then
    exit $status
  fi

  currentDir="$PWD"
  cd "$4"/java-compiled/
  files=`ls -1 *.class`
  status=$?
  if [ $status -ne 0 ]
  then
    exit 1
  fi

  # Copy the created files to current directory
  cd "$currentDir"
  for file in $files
  do
    mv -f "$4"/java-compiled/$file "$file"
  done
  
  # If javac only produced 1 file, output the name of that file without extension
  count=`echo "$files" | wc -l`
  if [ $count -eq 1 ]
  then
    for file in $files
    do
      length=${#file}
      first=`expr $length - 6`
      classname=`echo "$file" | cut -c 1-"$first"`
      echo $classname
      exit 0
    done
  fi

  # Otherwise output the name of the input file without extension (this should be the same as the class name)
  file="$1"
  length=${#file}
  first=`expr $length - 5`
  classname=`echo "$file" | cut -c 1-"$first"`
  echo $classname
  exit 0
}

spotlight () {
  mdfind "kMDItemDisplayName == '$@'wc";
}

ii() {
  echo -e "\nYou are logged on ${RED}$HOST"
  echo -e "\nAdditionnal information:$NC " ; uname -a
  echo -e "\n${RED}Users logged on:$NC " ; w -h
  echo -e "\n${RED}Current date :$NC " ; date
  echo -e "\n${RED}Machine stats :$NC " ; uptime
  echo -e "\n${RED}Current network location :$NC " ; scselect
  echo -e "\n${RED}Public facing IP Address :$NC " ;myip
  #echo -e "\n${RED}DNS Configuration:$NC " ; scutil --dns
  echo
}

[[ -s ~/.bashrc ]] && source ~/.bashrc

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

export GOPATH="~/Golang/"
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export CLICOLOR=1
export LSCOLORS=dxfxcxdxbxegedabagacad
export HISTSIZE=900000
export PATH=/usr/local/bin:$PATH
export HISTCONTROL="ignoreboth"
export LS_OPTIONS='--color=auto'
export NVM_DIR=~/.nvm

shopt -s histappend
source "`brew --prefix`/etc/grc.bashrc"


bold=$(tput bold)
underline=$(tput sgr 0 1)
reset=$(tput sgr0)
purple=$(tput setaf 171)
red=$(tput setaf 1)
green=$(tput setaf 76)
tan=$(tput setaf 3)
blue=$(tput setaf 38)
NM="\[\033[0;38m\]"  #means no background and white lines
HI="\[\033[0;37m\]"  #change this for letter colors
HII="\[\033[0;31m\]" #change this for letter colors
SI="\[\033[0;33m\]"  #this is for the current directory
IN="\[\033[0m\]"
#eval `gdircolors`


#export PS1=" \t \w$ "
export PS1="$NM$HI\!:\# $SI\t $HII\w $NM$ $IN"

if [ "$TERM" != "dumb" ]; then
    export LS_OPTIONS='--color=auto'
    eval `gdircolors ~/.dir_colors`
fi
