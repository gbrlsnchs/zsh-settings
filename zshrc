export TERM="xterm-256color"

LIGHT_HOUR=6
DARK_HOUR=18
CUR_THEME="light"

update_theme() {
    TERMINALRC=/tmp/terminalrc
    NOW=$(date +%H)

    if [[ $NOW -lt $LIGHT_HOUR || $NOW -ge $DARK_HOUR ]]; then
        CUR_THEME="dark"
    fi

    if [[ ! -f $TERMINALRC ]]; then
        echo $CUR_THEME > $TERMINALRC
    fi

    # for XFCE
    if [[ $XDG_CURRENT_DESKTOP == "XFCE" ]]; then
        if [[ $(cat $TERMINALRC) != $CUR_THEME ]]; then
            THEME_DIR=$HOME/.theme
            MSG="Changing theme..."

            if [[ $THEME_FLAG == "dark" ]]; then
                MSG="${MSG} 🌙"
            else
                MSG="${MSG} 🌞"
            fi

            echo $MSG

            cp $THEME_DIR/terminalrc-$CUR_THEME $HOME/.config/xfce4/terminal/terminalrc
            xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image \
                --set $THEME_DIR/solarized-mountains-$CUR_THEME.png
            echo $CUR_THEME > $TERMINALRC
        fi
    fi

    # TODO: Gnome
}

update_theme

# POWERLEVEL9K_COLOR_SCHEME=$THEME_FLAG
POWERLEVEL9K_MODE="awesome-fontconfig"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(vi_mode background_jobs dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status ram load command_execution_time)
POWERLEVEL9K_DIR_PATH_SEPARATOR="%F{black} $(echo '\uE0B1') %F{black}"
POWERLEVEL9K_DIR_OMIT_FIRST_CHARACTER=true

# Genymotion
export GENYMOTION_DIR="$HOME/.genymotion"
export PATH="$GENYMOTION_DIR:$PATH"
GENYMOTION_COMPL=$GENYMOTION_DIR/completion/zsh

fpath+=(~/.zsh/completion $GENYMOTION_COMPL $fpath)
fpath+=~/.zfunc
autoload -Uz compinit && compinit -i

# Docker
# source $HOME/.dvm/dvm.sh

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Rust & Cargo
# [[ -s $HOME/.rsvm/rsvm.sh ]] && . $HOME/.rsvm/rsvm.sh # This loads RSVM
# export PATH="$HOME/.cargo/bin:$PATH"
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

# Go
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
export GOPATH=$GOPATH:$HOME

# Python & pip
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export LD_LIBRARY_PATH="$(for dir in $PYENV_ROOT/versions/*; do echo -n $dir/lib:; done)$LD_LIBRARY_PATH"
eval "$(pyenv init -)"

# Node & NPM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[[ -r $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion

# [[ -r $DVM_DIR/bash_completion ]] && . $DVM_DIR/bash_completion

# Java
[ -s "$HOME/.jabba/jabba.sh" ] && source "$HOME/.jabba/jabba.sh"

# Erlang
. $HOME/kerl/$(ls $HOME/kerl)/activate

# Elixir
[[ -s "$HOME/.kiex/scripts/kiex" ]] && source "$HOME/.kiex/scripts/kiex"

# Yarn
export PATH="$PATH:`yarn global bin`"

export VIMRC="$HOME/.vimrc"
export NVIMRC="$HOME/.config/nvim/init.vim"

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git vi-mode zsh-completions)

source ~/.local/share/fonts/*.sh
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="vim ~/.zshrc"
alias vi="vim"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias cd="cd"
# alias pjson="python3 -m json.tool"

_gen_fzf_default_opts() {
    local base03="234"
    local base02="235"
    local base01="240"
    local base00="241"
    local base0="244"
    local base1="245"
    local base2="254"
    local base3="230"
    local yellow="136"
    local orange="166"
    local red="160"
    local magenta="125"
    local violet="61"
    local blue="33"
    local cyan="37"
    local green="64"

    # Comment and uncomment below for the light theme.

    if [[ $CUR_THEME == "dark" ]]; then
        # Solarized Dark color scheme for fzf
        export FZF_DEFAULT_OPTS="
        --color fg:-1,bg:-1,hl:$blue,fg+:$base2,bg+:$base02,hl+:$blue
        --color info:$yellow,prompt:$yellow,pointer:$base3,marker:$base3,spinner:$yellow
        "
    else
        # Solarized Light color scheme for fzf
        export FZF_DEFAULT_OPTS="
        --color fg:-1,bg:-1,hl:$blue,fg+:$base02,bg+:$base2,hl+:$blue
        --color info:$yellow,prompt:$yellow,pointer:$base03,marker:$base03,spinner:$yellow
        "
    fi

    FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --no-mouse"
}

_gen_fzf_default_opts

_fzf_default() {
    export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!{.git/*,node_modules/*,*.map}"'
}

_fzf_default

find_tags() {
    git tag -l --sort=v:refname "$1*$2"
}

config_vim() {
    PY_VER=$(python -c 'import platform; print(platform.python_version())')
    PY_VER_SHORT=$(echo $PY_VER | awk -F"." '{print $1"."$2}')
    PY3_VER=$(python3 -c 'import platform; print(platform.python_version())')
    PY3_VER_SHORT=$(echo $PY3_VER | awk -F"." '{print $1"."$2}')

    if [[ $1 == 'local' ]]; then
        echo 'Installing Vim locally...'
        TARGET=$HOME
    else
        echo 'Installing Vim in "/usr"'
        TARGET=/usr
    fi

    vi_cv_path_pythonpath=$HOME/.pyenv/shims/python vi_cv_path_python3path=$HOME/.pyenv/shims/python3 ./configure --prefix=$TARGET \
        --with-features=huge \
        --enable-multibyte \
        --enable-pythoninterp=yes \
        --enable-python3interp=yes \
        --with-python-config-dir=$HOME/.pyenv/versions/$PY_VER/lib/python$PY_VER_SHORT/config \
        --with-python3-config-dir=$HOME/.pyenv/versions/$PY3_VER/lib/python$PY3_VER_SHORT/config-$(echo $PY3_VER_SHORT)m-x86_64-linux-gnu \
        --enable-cscope \
        --with-x \
        --with-compiledby='gbrlsnchs'
}

which_branch() {
    git branch | rg '^\*' | cut -d' ' -f 2
}

copy_branch() {
    which_branch | xsel --clipboard
}

copy_pwd() {
    pwd | xsel -i
}

goto_pwd() {
    cd $(xsel -o)
}

install_vim_deps() {
    sudo apt-get install libx11-dev libxtst-dev libxt-dev libsm-dev libxpm-dev
}

install_docker_compose_completion() {
    mkdir -p ~/.zsh/completion
    curl -L https://raw.githubusercontent.com/docker/compose/master/contrib/completion/zsh/_docker-compose > ~/.zsh/completion/_docker-compose
    exec $SHELL -l
}

croyale_mapper() {
    export CROYALE_MODE=$1
}

croyale_pick() {
    TARGET_Y=685
    if [[ $1 == 1 ]]; then
        TARGET_X=583
    elif [[ $1 == 2 ]]; then
        TARGET_X=660
    elif [[ $1 == 3 ]]; then
        TARGET_X=733
    elif [[ $1 == 4 ]]; then
        TARGET_X=809
    fi

    eval $(xdotool getmouselocation --shell)
    xdotool mousemove $TARGET_X $TARGET_Y click 1
    xdotool mousemove $X $Y
}

bindkey '^P' up-line-or-search
bindkey '^N' down-line-or-search
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
# bindkey '^?' backward-delete-char
# bindkey '^h' backward-delete-char
# bindkey '^w' backward-kill-word
bindkey '^r' fzf-history-widget

export KEYTIMEOUT=1
