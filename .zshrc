export ZSH="$HOME/.oh-my-zsh"
# ZSH_THEME="juanghurtado"
plugins=(
	git
	zsh-autosuggestions
	fzf-tab
	fzf
)
source $ZSH/oh-my-zsh.sh

# Color shortcuts
RED=$fg[red]
YELLOW=$fg[yellow]
GREEN=$fg[green]
WHITE=$fg[white]
BLUE=$fg[blue]
RED_BOLD=$fg_bold[red]
YELLOW_BOLD=$fg_bold[yellow]
GREEN_BOLD=$fg_bold[green]
WHITE_BOLD=$fg_bold[white]
BLUE_BOLD=$fg_bold[blue]
RESET_COLOR=$reset_color

# Format for git_prompt_info()
ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""

# Format for parse_git_dirty()
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$RED%}(*)"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# Format for git_prompt_status()
ZSH_THEME_GIT_PROMPT_UNMERGED=" %{$RED%}unmerged"
ZSH_THEME_GIT_PROMPT_DELETED=" %{$RED%}deleted"
ZSH_THEME_GIT_PROMPT_RENAMED=" %{$YELLOW%}renamed"
ZSH_THEME_GIT_PROMPT_MODIFIED=" %{$YELLOW%}modified"
ZSH_THEME_GIT_PROMPT_ADDED=" %{$GREEN%}added"
ZSH_THEME_GIT_PROMPT_UNTRACKED=" %{$WHITE%}untracked"

# Format for git_prompt_ahead()
ZSH_THEME_GIT_PROMPT_AHEAD=" %{$RED%}(!)"

# Format for git_prompt_long_sha() and git_prompt_short_sha()
ZSH_THEME_GIT_PROMPT_SHA_BEFORE=" %{$WHITE%}[%{$YELLOW%}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$WHITE%}]"

# ๛ ζ ༄ ༓ ჻ ፠ ༔
# Prompt format

PROMPT='%{$GREEN_BOLD%}%n:%{$YELLOW%}%~%u$(parse_git_dirty)$(git_prompt_ahead)%{$RESET_COLOR%}
%{$YELLOW%}ζ%{$RESET_COLOR%} '
RPROMPT='%{$GREEN_BOLD%}$(git_current_branch)$(git_prompt_short_sha)$(git_prompt_status)%{$RESET_COLOR%}'

alias nv=nvim
alias hx=helix
alias gf2=~/git/gf/gf2

export MAKEFLAGS='-j 12'
export MANPAGER='nvim +Man!'
export PICO_SDK_PATH='/home/sivansh/pico-sdk/'
export PATH="/home/sivansh/git/llama.cpp/build/bin:$PATH"
export PATH=~/.npm-global/bin:$PATH
export PATH=/home/sivansh/git/neovide/target/release:$PATH

source /home/sivansh/vulkan/1.3.296.0/setup-env.sh
# export EMSDK_QUIET=1
# source "/home/sivansh/git/emsdk/emsdk_env.sh"

PROMPT="%F{149}%n:%F{3}%~
ζ%F{reset} "

eval "$(zoxide init zsh)"

# Created by `pipx` on 2025-05-25 06:49:12
export PATH="$PATH:/home/sivansh/.local/bin"
