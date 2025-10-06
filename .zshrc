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
# Load zinit
source "${ZINIT_HOME}/zinit.zsh"


# Add in PowerLevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in snippets from Oh My ZSH - https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins
# Add in syntax-highlighting, completions and autosuggestions
# Improve vim mode, enable motions like `di"` - See <https://github.com/softmoth/zsh-vim-mode>
zinit wait lucid for \
  OMZP::git \
  OMZP::kubectl \
  OMZP::poetry \
  OMZP::sudo \
  OMZP::command-not-found \
  OMZP::colored-man-pages \
  zsh-users/zsh-syntax-highlighting \
  zsh-users/zsh-completions \
  zsh-users/zsh-autosuggestions \
  Aloxaf/fzf-tab \

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
setopt appendhistory sharehistory hist_ignore_space \
       hist_ignore_all_dups hist_save_no_dups hist_find_no_dups

# Completion Styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# disable default menu to not interfere with fzf-tab
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls $realpath'

# Kanagawa colortheme for Pure Prompt
# zstyle :prompt:pure:git:arrow color "#7FB4CA"       # Cyan für Git-Pfeile
# zstyle :prompt:pure:git:branch color "#957FB8"      # Magenta für Git-Branch
# zstyle :prompt:pure:path color "#7E9CD8"           # Blau für den Pfad
# zstyle :prompt:pure:prompt:error color "#C34043"   # Rot für Fehler
# zstyle :prompt:pure:prompt:success color "#98BB6C" # Grün für Erfolg
# zstyle :prompt:pure:prompt:continuation color "#DCA561" # Gelb für Fortsetzung
# zstyle :prompt:pure:suspended_jobs color "#C34043" # Rot für pausierte Jobs
# zstyle :prompt:pure:user color "#DCD7BA"           # Helle Vordergrundfarbe für User
# zstyle :prompt:pure:user:root color "#FFA066"      # Orange für Root-User

# load local_env first to overwrite directories on different hosts
[[ -f "${HOME}/.local_env" ]] && source "${HOME}/.local_env";

# load aliases and token-env-variables
[[ -f "${HOME}/.zsh_tokens" ]] && source "${HOME}/.zsh_tokens"
[[ -f "${HOME}/.zsh_aliases" ]] && source "${HOME}/.zsh_aliases";


# run FZF-zsh integration after zsh-vim-mode
zinit light softmoth/zsh-vim-mode
source <(fzf --zsh)
