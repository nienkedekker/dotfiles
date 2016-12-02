export EDITOR=vim
export VISUAL=vim
export PATH="$PATH:$HOME/.rvm/bin"

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

export NVM_DIR="/Users/Justyna/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

export ANDROID_HOME=/usr/local/opt/android-sdk

source `brew --prefix`/etc/profile.d/z.sh

fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit

# Colorize man pages
man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

# Extract archives
extract ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

rejson() { redis-cli -h dm "$@" | json_pp }
alias redis-match='redis-cli -h dm --scan --pattern' # pattern: 'escache/dupa*'

bindkey "^B" backward-kill-word
bindkey '^G' insert-last-word
bindkey "^W" foreward-word
bindkey "^V" backward-word
# bindkey "^N" down-history
# bindkey "^P" up-history
# bindkey "^U" backward-kill-line
# bindkey "^A" beginning-of-line
# bindkey "^E" end-of-line
# bindkey "^Y" yank

alias '..'='cd ..'
alias '...'='cd ../..'
alias mkdir="mkdir -p"
mkdirc() { mkdir -p "$1" && cd "$1"; }

alias cp="cp -vi"
alias mv="mv -vi"
alias rm="rm -v"
alias ls="ls -GF"
alias la="ls -GFA"
alias f='find . -iname'
alias ps='ps aux'
alias todo='$HOME/dotfiles/todoist'
alias j='z'
alias -g H='| head'
alias -g T='| tail'
alias -g be='bundle exec'
# alias -g r='rails'
alias ds='docker-machine env && eval $(docker-machine env)'
alias servethis='python -m SimpleHTTPServer'
alias watchthemstyles='sass --watch style.scss:style.css'
alias lint="npm run lint"
alias cask="brew cask"
alias svim="vim -u NONE"
# netstat -nlp tcp | ag 8000

dockerbash () {
  docker exec -it $1 bash
}
yolo () {
  echo "DROP DATABASE oddshot;" | mysql -h dm -u root
  ./migrate.sh
  ./mock_data_sql_scripts/load_mock_data.sh
}
kurwa () {
  docker-machine start
  j dev
  ds && docker-compose up -d
  j web
}
alias ga='git add'
alias gaa="git add --all && echo '------> change branch'"
alias gb="git branch"
alias gc!='git commit -v --amend'
alias gc="git commit -v"
alias gco='git checkout'
alias gcp="git cherry-pick"
alias gd="git diff"
alias gdc='git diff --cached'
alias gdn='git diff --name-only'
# alias glg="git log --graph --color=always --format='%C(auto)%h%d %s %C(blue)~%an, %cr'"
alias glg="git log --oneline --graph --color"
alias gm='git merge'
alias gpl="git pull"
alias gplr="git pull --rebase"
alias gpsh="git push"
alias grb='git rebase'
alias grh='git reset HEAD'
alias gs="git show"
alias gsh='git stash'
alias 'gsh popf'='git checkout -- .'
alias gshl='git stash list'
alias gst="git status"
alias gum='git reset --hard ORIG_HEAD'
alias gsup='git submodule update'
