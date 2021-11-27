# Helper functions
source ${HOME}/.zfunctions

# Add brew stuff to PATH
eval "$(/opt/homebrew/bin/brew shellenv)"

# Add extra paths to $PATH
local EXTRA_PATHS=(
    "/Users/tatsukenji/Library/Python/3.8/bin"
)
addPath ${EXTRA_PATHS[@]}

# Add virtual env wrapper
VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source `which virtualenvwrapper.sh`
