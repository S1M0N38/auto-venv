#!/bin/zsh

# Script by Austin Riba (https://github.com/Fingel)
# https://www.pedaldrivenprogramming.com/2018/09/simple-virtualenv-auto-activation-zsh/

VENV_HOME="${WORKON_HOME:-$HOME/.virtualenvs}"

function _virtualenv_auto_activate() {
    if [[ -f ".venv" ]]; then
        _VENV_PATH=$VENV_HOME/$(cat .venv)

        # Check to see if already activated to avoid redundant activating
        if [[ "$VIRTUAL_ENV" != $_VENV_PATH ]]; then
            source $_VENV_PATH/bin/activate
        fi
    fi
}

function venvconnect() {
    if [[ -n $VIRTUAL_ENV ]]; then
        echo $(basename $VIRTUAL_ENV) > .venv
    else
        echo "Activate a virtualenv first"
    fi
}

chpwd_functions+=(_virtualenv_auto_activate)
precmd_functions=(_virtualenv_auto_activate $precmd_functions)

