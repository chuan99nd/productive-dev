# Begin configuration
export FZF_DEFAULT_OPTS='--layout=reverse --border --multi --ansi --exit-0'
function ghq-list-then-look
{
  local selected=$(ghq list -p \
    | fzf --height 90% --preview='find {} -depth 1 -type f | grep -i -e "readme.[(md)|(mkd)|(markdown)]" | head -1 | xargs head -$LINES')

  if [ -n "${selected}" ]; then
    clear
    cd "${selected}"
    nvim "${selected}"
  fi
}

export PATH="$PATH:/opt/nvim-linux64/bin"
# End configuration
