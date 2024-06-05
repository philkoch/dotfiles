# Taken from: https://www.youtube.com/watch?v=ud7YxC33Z3w
#
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Dowload Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in PowerLevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in snippets from Oh My ZSH
# names come from here https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins

zinit wait lucid for \
  OMZP::git \
  OMZP::kubectl \
  OMZP::poetry \
  OMZP::sudo \
  OMZP::command-not-found \
  OMZP::colored-man-pages \
  OMZP::ssh-agent


# Load completions
autoload -U compinit && compinit

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Vim keybindings
bindkey -v
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward


# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
# erases duplicates in history-file
HISTDUP=erase
setopt appendhistory
setopt sharehistory
# don't store in history if first char is space
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# Completion Styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# disable default menu to not interfere with fzf-tab
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls $realpath'

zstyle ':omz:plugins:ssh-agent' lazy yes

# load aliases and token-env-variables
zinit snippet ~/.zsh_aliases
zinit snippet ~/.zsh_tokens
# update path for gcloud
# # The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/phil/Tools/google-cloud-sdk/path.zsh.inc' ]; then
    . '/home/phil/Tools/google-cloud-sdk/path.zsh.inc';
fi

# # The next line enables shell command completion for gcloud.
if [ -f '/home/phil/Tools/google-cloud-sdk/completion.zsh.inc' ]; then
    . '/home/phil/Tools/google-cloud-sdk/completion.zsh.inc';
fi

eval "$(fzf --zsh)"

# Add in syntax-highlighting, completions and autosuggestions
zinit wait lucid for \
    atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
        zsh-users/zsh-syntax-highlighting \
        zsh-users/zsh-completions \
        zsh-users/zsh-autosuggestions \
        Aloxaf/fzf-tab
