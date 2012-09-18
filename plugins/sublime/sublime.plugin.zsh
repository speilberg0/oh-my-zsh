# Sublime Text 2 Aliases
#unamestr = 'uname'

if [[ $('uname') == 'Linux' ]]; then
	alias st='/usr/bin/sublime_text&'
elif  [[ $('uname') == 'Darwin' ]]; then
	alias st='/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl'
elif  [[ $('uname') == *CYGWIN_NT* ]]; then
	function st() {
		sublime_text "`cygpath -aw $@`" &!;
	}
fi
alias stt='st .'
