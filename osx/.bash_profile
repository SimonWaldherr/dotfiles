#.bash_profile

alias ..='cd ..'
alias apt-get='brew'
alias apps='echo $PATH | tr ":" "\n" | xargs ls'
alias arptsv='sudo arp-scan -l | grep "\t"'
alias as='colourify as'
alias bu='brew update && brew upgrade --all && brew cleanup'
alias cd..='cd ..'
alias cddesktop='cd ~/Desktop/'
alias cddownload='cd ~/Downloads/'
alias cdgit='cd ~/git/'
alias colourify='/usr/local/bin/grc -es --colour=auto'
alias configure='colourify ./configure'
alias df='colourify df'
alias diff='colourify diff'
alias dig='colourify dig'
alias dus='df -h'
alias editprofile='vi ~/.bash_profile'
alias egrep='egrep --color=auto'
alias elasticsearchx='elasticsearch --config="/usr/local/opt/elasticsearch/config/elasticsearch.yml"'
alias fgrep='fgrep --color=auto'
alias finder_s='defaults write com.apple.Finder AppleShowAllFiles TRUE; killAll Finder'
alias flushDNS='dscacheutil -flushcache'
alias follow='tail -f'
alias fping='ping -c 20 -i 0.1 -s 2048'
alias g++='colourify g++'
alias gas='colourify gas'
alias gcc='colourify gcc'
alias get='wget -q -O-'
alias godev='~/git/GOLANG/bin/go'
alias godevfmt='~/git/GOLANG/bin/gofmt'
alias gg='go get -u -t'
alias grep='grep --color=auto'
alias head='colourify head'
alias header='curl -I'
alias int='netstat -i'
alias kvml='source /usr/local/bin/kvm.sh'
alias l.='ls -d .* --color=auto'
alias ld='colourify ld'
alias ll='ls -al'
alias localip='ifconfig en0 inet | grep "inet " | awk " { print  } "'
alias lr='ls -R | grep ":$" | sed -e "s/:$//" -e "s/[^-][^\/]*\//--/g" -e "s/^/   /" -e "s/-/|/" | less'
alias make='colourify make'
alias makemine='sudo chown simonwaldherr'
alias mount='colourify mount'
alias mtr='colourify mtr'
alias myip='curl ip.appspot.com'
alias netCons='lsof -i'
alias netstat='colourify netstat'
alias now='date +"%d.%m.%Y %T"'
alias openPorts='sudo lsof -i | grep LISTEN'
alias path='echo -e ${PATH//:/\\n}'
alias ping='colourify ping'
alias ps='colourify ps'
alias psroot='ps aux|grep "root"'
alias psme='ps aux|grep $(whoami)'
alias rwget='wget -rkpN -e robots=off --no-parent'
alias sbc='compgen -A function -abck | grep'
alias sbootoff='sudo nvram boot-args=""'
alias sbooton='sudo nvram boot-args="-x -v"'
alias sbootverbose='sudo nvram boot-args="-v"'
alias sha1='openssl sha1'
alias snnmap='sudo nmap -sn'
alias sudolast='sudo !!'
alias swift='xcrun swift'
alias tail='colourify tail'
alias traceroute='colourify /usr/sbin/traceroute'
alias trim='sed -e "s/^[[:space:]]*//g" -e "s/[[:space:]]*$//g"'
alias x='exit'
alias pe='path-extractor'

kotlin () {
  if [ "$1" == "build" ]; then
    kotlinc-jvm $2 -include-runtime -d $2.jar
  else
    kotlin build $2
    java -jar $2.jar
    rm $2.jar
  fi
}

appsdupp () {
  apps | awk '{CMD[$1]++;count++;}END { for (a in CMD)print CMD[a] " " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl | grep -v "1   "
}

mostused () {
  history | trim | sed 's/bu/brew update/' | sed 's/hgrep/history|grep/' | sed 's/godev/go/' | sed 's/rls/find/' | sed 's/gg/go get/' | sed 's/"//' | sed 's/fping/ping/' | sed 's/apps/echo | tr | xargs /' | sed 's/sudo /sudo | /' | sed 's/xargs /xargs | /' | sed 's/^ +//' | tr "|" "\n" | trim | awk '{CMD[$1]++;count++;}END { for (a in CMD)print CMD[a] " " a;}' | grep -v "./" | egrep --invert-match "^[0-9]+ .?$" | column -c3 -s " " -t | sort -nr | nl |  head -n50
}

gomultitest () {
  env GOOS=darwin GOARCH=amd64 CGO_ENABLED=0 /Users/simonwaldherr/git/GOLANG/bin/go test $1
  env GOOS=darwin GOARCH=amd64 CGO_ENABLED=1 /Users/simonwaldherr/git/GOLANG/bin/go test $1
  env GOOS=darwin GOARCH=386 CGO_ENABLED=0 /Users/simonwaldherr/git/GOLANG/bin/go test $1
  env GOOS=darwin GOARCH=386 CGO_ENABLED=1 /Users/simonwaldherr/git/GOLANG/bin/go test $1
}

hgrep () { 
  history | tail -r | sed -e 's/^[0-9 ]*//' | awk '!a[$0]++' | tail -r | grep "$1" 
}

mkacd () { 
  mkdir "$1"; cd "$1" 
}

wgetgrep () { 
  wget -q -O- "$1" | grep "$2" 
}

sman () { 
  man -k "$1" | tail -n +0 
}

jssize () { 
  uglifyjs | gzip -9f | wc -c 
}

listTCP () {
  lsof -i | grep " TCP " | sed -E "s/^([^ ]+).+(\([A-Z_]+\))$/\1 \2/" | awk '!a[$0]++'
}

dash () { 
  open dash://$1 
}

word () { 
  grep '\$1\>' /usr/share/dict/words 
}

searchwithline () { 
  cat -n $1 | grep "$2" 
}

scraper () { 
  for i in $(wget -q -O- "$1" | tr "(" "\n" | tr "<" "\n" | tr ">" "\n" | tr " " "\n" | tr "\"" "\n" | tr "?" "\n" | grep "http" | grep "\.$2" | sed -E "s/.+http([^\)>]+)\.$2\.*/http\1.$2/" | grep "http" | awk '!a[$0]++') ; do wget -bq $i && echo $i ; done 
}

pman () { 
  man "$1" -t | open -f -a Preview 
}

supdate () {
  softwareupdate -i -a &
  bgp1=$!
  brew update && brew upgrade --all && brew cleanup &
  bgp2=$!
  wait $bgp1
  wait $bgp2
}

ccc () {
  compname=`echo "$1" | sed 's/\(.*\)\..*/\1/'`
  clangname="_clang"
  clangname=$compname$clangname
  gccname="_gcc"
  gccname=$compname$gccname
  clang $1 -o $clangname
  gcc $1 -DG=1 -DP=4 -DV=8 -D_BSD_SOURCE -o $gccname -lm
}

savebashprofile () {
  cp ~/.vimrc ~/git/Todo/osx_settings/vimrc.log
  cp ~/.bash_profile ~/git/Todo/osx_settings/bash_profile.log
  brew list --versions > ~/git/Todo/osx_settings/brew_list.log
  rm /Applications/.DS_Store
  ls -al /Applications/ > ~/git/Todo/osx_settings/applications.log
  tlmgr info --only-installed > ~/git/Todo/osx_settings/tex_installed.log
  pkgutil --packages > ~/git/Todo/osx_settings/pkgutil.log
  cpan -l > ~/git/Todo/osx_settings/cpan.log
  history >> ~/git/Todo/osx_settings/history.log
  cat ~/git/Todo/osx_settings/history.log | tail -r | sed -e 's/^[0-9 ]*//' | awk '!a[$0]++' | tail -r > ~/git/Todo/osx_settings/history.log.tmp
  mv ~/git/Todo/osx_settings/history.log.tmp ~/git/Todo/osx_settings/history.log
  npm list -g > ~/git/Todo/osx_settings/npm_list.log
  ls -al /usr/local/bin/ > ~/git/Todo/osx_settings/bin.log
  ls -al /usr/bin/ >> ~/git/Todo/osx_settings/bin.log
  ls -al ~/Golang/bin >> ~/git/Todo/osx_settings/bin.log
  ls -al ~/git/GOLANG/bin >> ~/git/Todo/osx_settings/bin.log
  rls ~/Golang/src 3 ld > ~/git/Todo/osx_settings/gosrc.log
  cat ~/git/Todo/osx_settings/history.log | grep "^go get " > ~/git/Todo/osx_settings/goget.log
  cat ~/git/Todo/osx_settings/history.log | grep "^gg " >> ~/git/Todo/osx_settings/goget.log
  Rscript ~/git/Todo/osx_settings/Rpackages.r
  mostused > ~/git/Todo/osx_settings/mostused.log
  apps > ~/git/Todo/osx_settings/apps.log
  alias > ~/git/Todo/osx_settings/alias.log
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
      *.rs)	rustc $1 ;;
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
  echo -e "\n${RED}Current date:$NC " ; date
  echo -e "\n${RED}Machine stats:$NC " ; uptime
  echo -e "\n${RED}Current network location:$NC " ; scselect
  echo -e "\n${RED}Public facing IP Address:$NC " ; myip
  #echo -e "\n${RED}DNS Configuration:$NC " ; scutil --dns
  echo -e "\n${RED}CONNECTIONS:$NC " ; netstat | grep "ESTABLISHED"
  echo -e "\n${RED}ARP:$NC " ; arp -ax
  echo
}

[[ -s ~/.bashrc ]] && source ~/.bashrc

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

export GO15VENDOREXPERIMENT=1
export GOPATH="/Users/simonwaldherr/Golang"
export PATH=$PATH:/usr/local/opt/go/libexec/bin:$GOPATH/bin:/Users/simonwaldherr/git/GOLANG/bin:/Users/simonwaldherr/bin
export CLICOLOR=1
export LSCOLORS=dxfxcxdxbxegedabagacad
export HISTSIZE=
export HISTFILESIZE=
export PATH=/usr/local/bin:$PATH
export HISTCONTROL="ignoreboth"
export LS_OPTIONS='--color=auto'
export NVM_DIR=~/.nvm
export DYLD_LIBRARY_PATH=$PWD/libgit2/install/lib
export SHELL_SESSION_HISTORY=1

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
export PATH=/usr/local/sbin:$PATH
export GOROOT_BOOTSTRAP=/usr/local/Cellar/go/1.4.2/libexec

archey
export PATH=$PATH:"${pwd}"
