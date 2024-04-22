# git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
# echo 'source ~/.powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.powerlevel10k/powerlevel10k.zsh-theme
source ~/.p10k.zsh

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# setopt correct
setopt appendhistory
setopt autocd

bindkey '^H' backward-kill-word

alias cp="cp -i"
alias df="df -h"
alias free="free -m"

source "/usr/share/fzf/key-bindings.zsh"
source "/usr/share/fzf/completion.zsh"

function ranger {
  local IFS=$'\t\n'
  local tempfile="$(mktemp -t tmp.XXXXXX)"
  local ranger_cmd=(
      command
      ranger
      --cmd="map Q chain shell echo %d > "$tempfile"; quitall"
  )
  
  ${ranger_cmd[@]} "$@"
  if [[ -f "$tempfile" ]] && [[ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]]; then
      cd -- "$(cat "$tempfile")" || return
  fi
  command rm -f -- "$tempfile" 2>/dev/null
}

bindkey -s "^E" 'ranger^M'

alias nv=nvim
alias nf=neofetch
