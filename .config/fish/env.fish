set -gx HOMEBREW_REPOSITORY "$HOMEBREW_PREFIX";
set -gx HOMEBREW_PREFIX "/opt/homebrew";
set -gx HOMEBREW_CELLAR "$HOMEBREW_PREFIX/Cellar";
set -qx PATH; or set PATH ''; set -gx PATH "$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin" $PATH;
set -qx MANPATH; or set MANPATH ''; set -gx MANPATH "$HOMEBREW_PREFIX/share/man" $MANPATH;
set -qx INFOPATH; or set INFOPATH ''; set -gx INFOPATH "$HOMEBREW_PREFIX/share/info" $INFOPATH;
set -gx TERM xterm-256color
# theme
set -gx theme_color_scheme terminal-dark
set -gx fish_prompt_pwd_dir_length 1
set -gx theme_display_user yes
set -gx theme_hide_hostname no
set -gx theme_hostname always
set -gx GHQ_ROOT "$HOME/Projects"
set -gx FZF_DEFAULT_OPTS "--tac --layout=reverse --info=inline --border --margin=2 --padding=1 --bind='ctrl-y:execute-silent(echo {+} | pbcopy)'"
set -gx FZF_DEFAULT_COMMAND 'ls -a'
set -gx FZF__PREVIEW__COMMAND 'bat --style=numbers --color=always --line-range :500 {}'
set -gx FZF__DIR__PREVIEW__COMMAND 'tree -aC -I "$TREE__GLOBAL_IGNORE" {} | head -700'
set -gx TREE__GLOBAL_IGNORE ".git|node_modules|.history|webpack|.next|.idea|.gradle|.vscode|.Trash"set -gx FZF__SMART__PREVIEW__COMMAND "[ -d {} ] && $FZF__DIR__PREVIEW__COMMAND || $FZF__PREVIEW__COMMAND"

set -gx PROJECTS_DIR $GHQ_ROOT/github.com/AnudeepChPaul
set -gx EDITOR "nvim"