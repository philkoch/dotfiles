export TERMINAL=kitty
export EDITOR=nvim
export VISUAL=nvim
export BROWSER=firefox

export GPG_TTY=$(tty)

# taskwarrior / timewarrior
export TASKCONFIG_DIR="$HOME/nextcloud/task_config"
export TASKDATA="$TASKCONFIG_DIR/taskwarrior"
export TASKRC="$TASKDATA/.taskrc"
export TIMEWARRIORDB="$TASKCONFIG_DIR/timewarrior"

# zettelkasten
export ZK_NOTEBOOK_DIR="$HOME/nextcloud/zk/notebook/"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv &> /dev/null; then
    eval "$(pyenv init -)"


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/phil/Tools/google-cloud-sdk/path.zsh.inc' ]; then 
    . '/home/phil/Tools/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/phil/Tools/google-cloud-sdk/completion.zsh.inc' ]; then 
    . '/home/phil/Tools/google-cloud-sdk/completion.zsh.inc'; fi
    #
# gcloud authentication for kubectl
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# AITASTIC processor dev config
export KAFKA_PROCESSOR_CONFIG_PATH="config/config_dev.ini"

# use SSH-Agent to store private-key passwords in KeePassXC
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"
export SSH_ASKPASS='/usr/bin/lxqt-openssh-askpass'
export SSH_ASKPASS_REQUIRE=prefer

# default screenshot directory for hyprshot
export HYPRSHOT_DIR="$HOME/Pictures/screenshots"
