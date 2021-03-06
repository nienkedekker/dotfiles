### Bindings
bindkey -e
bindkey "^B" backward-kill-word
bindkey '^G' insert-last-word
bindkey "^W" forward-word
bindkey "^P" up-line-or-history
bindkey "^N" down-line-or-history

### Aliases
alias -g H='| head'
alias -g T='| tail'
alias -g cat="ccat"
alias ls="ls -GF"
alias ll='ls -lh'
alias la='ls -lha'
alias '..'='cd ..'
alias '...'='cd ../..'
alias j='z'
alias f="fd"
alias cask="brew cask"
alias open_ports='lsof -i -P | ag listen'
whats_on_port() { lsof -i :$1 }
alias progress='watch progress -q'
alias watch_them_styles='sass --watch style.scss:style.css'
alias serve_this='python -m http.server'
alias static='watch_them_styles & serve_this & open http://localhost:8000'
alias ip='ipconfig getifaddr en0'
alias 'tmux ls'='tmux list-sessions'
alias y='yarn'
alias ys='yarn start'
alias yt='NODE_ENV=test yarn test'
alias yti='NODE_ENV=test mocha --debug-brk --inspect --recursive'
alias sl='yarn stylelint'
alias el='eslint'
alias gpshh='git push && open $(git remote get-url origin)'
alias touhc='touch' # please
alias '?'='howdoi'

tx() { # attach to a session with name of current directory or create one
  dir=${PWD##*/}
  tmux -CC a -t ${dir} || tmux -CC new -s ${dir}
}
youtube_mp3() {
  youtube-dl --extract-audio -i --audio-format mp3 "$@"
}
kill_them_all() {
  ps aux | ag "$@" | awk '{print $2}' | xargs kill
}
burn_them_all() {
  ps aux | ag "$@" | awk '{print $2}' | xargs kill -9
}
man() { # colorful man pages
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    PAGER="${commands[less]:-$PAGER}" \
    _NROFF_U=1 \
    PATH="$HOME/bin:$PATH" \
    man "$@"
}
fix_postgres() {
  rm /usr/local/var/postgres/postmaster.pid
  brew services restart postgresql
}
fix_rubygems() { gem update --system }

### ZSH setup stuff
autoload -U promptinit compinit
promptinit; compinit;
prompt pure

setopt MENU_COMPLETE # auto select first autocompl
setopt append_history inc_append_history share_history histignorealldups # shared hist between sessions
unsetopt beep # turn off fucking bell when tabbing
zstyle ':completion:*' menu select # highlight tabbing
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*' # case insensitive compl
zmodload zsh/complist && bindkey -M menuselect '^[[Z' reverse-menu-complete # shift tab to reverse compl selection

export EDITOR=vim
export NVM_LAZY_LOAD=true && source ~/dotfiles/zsh-nvm/zsh-nvm.plugin.zsh
source ~/dotfiles/vanilla-git-aliases/vanilla-git-aliases.zsh
source `brew --prefix`/etc/profile.d/z.sh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

jj() { # "jump" to directory of a project and start tmux session
  j "$@" && tx
}
