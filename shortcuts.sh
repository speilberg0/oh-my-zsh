alias ls="ls --color=auto"
alias gl="git log --graph --pretty=format:'%C(214)%h%Creset -%C(075)%d%Creset %s %C(155)(%cr) %C(39)<%an>%Creset' --abbrev-commit --date=short"
alias www="cd /c/wamp/www/"
alias xcode="cd /x/code"
alias server="start http://localhost:8000 && python -m SimpleHTTPServer"
alias serverstack="compass watch & coffee -wc -o js src/ & python -m SimpleHTTPServer & start http://localhost:8000 &"
alias subl_packages='cd /c/Users/speilberg0/AppData/Roaming/Sublime\ Text\ 2/Packages'
alias php="/c/wamp/bin/php/php5.3.13/php"

# overload vanilla cd to remember last directory for shell relaunch
function cd() {
	builtin cd "$@";
	echo "$PWD" > ~/.cwd;
}

alias cwd='cd "$(cat ~/.cwd)"'
alias apt-cyg='apt-cyg -m http://cygwin.mirrors.pair.com/'
alias apt-cygports='apt-cyg -m ftp://sourceware.org/pub/cygwinports/'
