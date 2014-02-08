# bds zsh theme
# inspired by https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/minimal.zsh-theme

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[white]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}●%{$reset_color%}]%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN="]%{$reset_color%} "

PROMPT='%2~ $(git_prompt_info)%%%b '
