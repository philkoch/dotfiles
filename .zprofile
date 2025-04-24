export TERMINAL=kitty
export EDITOR=nvim
export VISUAL=nvim
export BROWSER=firefox
export GPG_TTY=$(tty)

# taskwarrior and timewarrior
export TASKCONFIG_DIR="$HOME/nextcloud/task_config"
export TASKDATA="$TASKCONFIG_DIR/taskwarrior"
export TASKRC="$TASKDATA/.taskrc"
export TIMEWARRIORDB="$TASKCONFIG_DIR/timewarrior"

# zettelkasten
export ZK_NOTEBOOK_DIR="$HOME/nextcloud/zk/notebook/"

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

# use SSH-Agent to store private-key passwords in KWallet
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"
export SSH_ASKPASS='/usr/bin/lxqt-openssh-askpass'
export SSH_ASKPASS_REQUIRE=prefer

# add local/bin/ to path (required for pipx installs like poetry)
export PATH="/home/phil/.local/bin:$PATH"


# default screenshot directory for hyprshot
export HYPRSHOT_DIR="$HOME/Pictures/screenshots"

# start hyprland via uwsm
if uwsm check may-start; then
	exec uwsm start hyprland.desktop
fi

