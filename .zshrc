export ZSH="$HOME/.oh-my-zsh"

plugins=(
	git
	zsh-autosuggestions
	fzf-tab
	fzf
)

source $ZSH/oh-my-zsh.sh

source ~/.cache/wal/colors.sh

export EDITOR='nvim'
export MAKEFLAGS='-j 12'
export MANPAGER='nvim +Man!'
export PROMPT="%F{$color1}%n:%F{$color3}%~
ζ$reset_color "

alias nv=nvim
