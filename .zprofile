export TERMINAL=kitty
export EDITOR=nvim
export VISUAL=nvim
export BROWSER=qutebrowser
export GPG_TTY=$(tty)

# taskwarrior and timewarrior
TASKCONFIG_DIR="$HOME/private/nxtcld/task_config"
export TASKDATA="$TASKCONFIG_DIR/taskwarrior"
export TASKRC="$TASKDATA/.taskrc"
export TIMEWARRIORDB="$TASKCONFIG_DIR/timewarrior"

# zettelkasten
export ZK_NOTEBOOK_DIR="$HOME/private/nxtcld/zk/notebook/"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# gcloud authentication for kubectl
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# AITASTIC processor development different config
export KAFKA_PROCESSOR_CONFIG_PATH="config/config_dev.ini"

# neovim session data
export XDG_STATE_HOME="$HOME/.local/state/"
