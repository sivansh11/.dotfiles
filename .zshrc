export ZSH="$HOME/.oh-my-zsh"

plugins=(
	git
	zsh-autosuggestions
	fzf-tab
	fzf
  # zsh-vi-mode
)

source $ZSH/oh-my-zsh.sh

# source ~/.cache/wal/colors.sh
source ~/.cache/noctalia/zsh-colors.sh

bindkey -v
export KEYTIMEOUT=1
export EDITOR='nvim'
export MAKEFLAGS='-j 8'
export MANPAGER='nvim +Man!'
export PROMPT="${COLOR_PRIMARY}%n:${COLOR_ACCENT}%~
ζ%f "

alias nv=nvim

source ~/vulkan/1.4.328.1/setup-env.sh
export PICO_SDK_PATH=/home/sivansh/dev/pico-sdk
export RISCV=/opt/riscv
export PATH=$RISCV/bin:$PATH
export PATH="/home/sivansh/dev/llama.cpp/build/bin/":$PATH
export PATH="/home/sivansh/.cargo/bin/":$PATH

eval "$(zoxide init zsh)"
alias jrnl=/home/sivansh/scripts/jrnl

# source /usr/share/nvm/init-nvm.sh

if [ -e /home/sivansh/.nix-profile/etc/profile.d/nix.sh ]; then . /home/sivansh/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

reload_noctalia_colors() {
    if [ -f ~/.cache/noctalia/zsh-colors.sh ]; then
        source ~/.cache/noctalia/zsh-colors.sh
        # Force the command line to redraw with the new colors
        zle reset-prompt 2>/dev/null
    fi
}

TRAPUSR1() {
    reload_noctalia_colors
}
