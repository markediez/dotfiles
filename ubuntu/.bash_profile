BASH_COMMON=$(cat ~/.dotfiles/config.json | jq '.repoDir' -r)
BASH_COMMON="${ZSH_COMMON}/common/.bash_profile"
source $BASH_COMMON
