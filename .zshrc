export ZSH="$HOME/.oh-my-zsh"

plugins=(
	git
	zsh-autosuggestions
	fzf-tab
	fzf
  # zsh-vi-mode
)

source $ZSH/oh-my-zsh.sh

source ~/.cache/wal/colors.sh

bindkey -v
export KEYTIMEOUT=1
export EDITOR='nvim'
export MAKEFLAGS='-j 12'
export MANPAGER='nvim +Man!'
export PROMPT="%F{$color1}%n:%F{$color3}%~
ζ%{$reset_color%} "

alias nv=nvim

source ~/vulkan/1.4.328.1/setup-env.sh
