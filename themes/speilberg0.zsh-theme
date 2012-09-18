# speilberg0.zsh-theme
# Author Jesse Robertson
# https://github.com/speilberg0
# based upon:
#   af-magic.zsh-theme by Andy Fleming

# colorset
SP_FG_LBLUE=$FG[075]
SP_FG_BLUE=$FG[032]
SP_FG_LGREEN=$FG[155]
SP_FG_LRED=$FG[205]
SP_FG_LORANGE=$FG[215]
SP_FG_LYELLOW=$FG[228]
SP_FG_LPURPLE=$FG[105]
SP_FG_WHITE=$FG[255]
SP_FG_LGRAY=$FG[109]
SP_FG_GRAY=$FG[066]
SP_FG_DGRAY=$FG[237]

GIT_STATUS_RED=$FG[160]
GIT_STATUS_GREEN=$SP_FG_LGREEN
GIT_STATUS_ORANGE=$SP_FG_LORANGE
GIT_STATUS_YELLOW=$FG[220]

SP_BG_LBLUE=$BG[075]
SP_BG_LGREEN=$BG[155]
SP_BG_LRED=$BG[205]
SP_BG_LORANGE=$BG[215]
SP_BG_LYELLOW=$BG[228]
SP_BG_WHITE=$BG[255]
SP_BG_LGRAY=$BG[109]
SP_BG_GRAY=$BG[066]
SP_BG_DGRAY=$BG[237]

ZSH_THEME_GIT_PROMPT_PREFIX="$SP_FG_DGRAY$SP_BG_LBLUE⮀$SP_FG_DGRAY ⭠ "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}$SP_BG_LBLUE $SP_FG_LBLUE$SP_BG_DGRAY⮀ "
ZSH_THEME_GIT_PROMPT_DIRTY="$SP_FG_LORANGE ±"
ZSH_THEME_GIT_PROMPT_CLEAN="$SP_FG_LGREEN √%{$reset_color%}"

ZSH_THEME_GIT_STATUS_BEFORE="$SP_FG_DGRAY("
ZSH_THEME_GIT_STATUS_AFTER="$SP_FG_DGRAY)"

ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$GIT_STATUS_RED%}?"
ZSH_THEME_GIT_PROMPT_ADDED="%{$GIT_STATUS_GREEN%}+"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$GIT_STATUS_ORANGE%}∂"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$GIT_STATUS_YELLOW%}→"
ZSH_THEME_GIT_PROMPT_DELETED="%{$GIT_STATUS_RED%}×"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$GIT_STATUS_GREEN%}═"

ZSH_THEME_GIT_PROMPT_SHA_BEFORE="$SP_FG_LYELLOW⮂$SP_BG_LYELLOW$SP_FG_DGRAY "
ZSH_THEME_GIT_PROMPT_SHA_AFTER=" (HEAD) "



# D = date (YYYY-MM-DD), T = 24h time (HH:MM:SS)
D="${(%):- %D{%Y-%m-%e ⮀ %T ⮀}"
T="${(%):-⮂ %n@%m }"
# get filler dashes for middle
((TERMWIDTH = ${COLUMNS} - ${#D} - ${#T} - 1 ))
# get bar from script output
# BAR=`~/.oh-my-zsh/bar.py $TERMWIDTH`
BAR="${$(printf "%${TERMWIDTH}s" "")// /-}"

test() {
    D="${(%):- %D{%Y-%m-%e ⮀ %T ⮀}"
    T="${(%):-⮂ %n@%m }"
    E=""
    if [ -n "$_OLD_VIRTUAL_PS1" ] ; then
        E="(`basename \"$VIRTUAL_ENV\"`)"
    fi
    # get filler dashes for middle
    ((TERMWIDTH = ${COLUMNS} - ${#E} - ${#D} - ${#T} - 1 ))
    # get bar from script output
    # BAR=`~/.oh-my-zsh/bar.py $TERMWIDTH`
    echo "${$(printf "%${TERMWIDTH}s" "")// /-}"
}


PROMPT='%{$SP_BG_DGRAY%}%{$SP_FG_LYELLOW%} %D{%Y-%m-%e} %{$SP_FG_DGRAY%}%{$SP_BG_LYELLOW%}⮀ %D{%T} %{$reset_color%}%{$SP_FG_LYELLOW%}⮀%{$reset_color%}$FG[237]$(test)%{$reset_color%}$SP_FG_DGRAY⮂%{$SP_BG_DGRAY$SP_FG_LRED%} %n@%m %{$reset_color%}
$SP_FG_BLUE$SP_BG_DGRAY%~ $(git_prompt_info)$SP_FG_LPURPLE%(!.#.»)%{$reset_color%}$SP_FG_DGRAY⮀%{$reset_color%} '
PROMPT2='%{$SP_FG_LRED%}\ %{$reset_color%}'

RPROMPT='$SP_FG_DGRAY⮂$SP_BG_DGRAY$SP_FG_LRED↲ $(git_prompt_short_sha)%{$reset_color%}'
