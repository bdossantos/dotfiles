# Inspired by https://github.com/aelindeman/xelabash

# set up the prompt
_bds_set_default_prompt() {
  PS1_LAST_EXIT="$?"
  PS1_PREFIX=''
  PS1_INNER='\[\e[1m\]\w\[\e[0m\]'
  PS1_SUFFIX=' \$ '
}

# display git branch and repo state asterisk after path, if inside of a repository
_bds_add_git_to_prompt() {
  git_prompt=''
  git_prompt_branch=''
  git_prompt_status_count=''

  if [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = 'true' ] || [ "$(git rev-parse --is-inside-git-dir 2>/dev/null)" = 'true' ]; then
    git_prompt_branch="$(git rev-parse --abbrev-ref HEAD)"

    [ -z "$git_prompt_branch" ] && git_prompt_branch='(no branch)'

    if [ "$(git rev-parse --is-inside-git-dir 2>/dev/null)" != 'true' ]; then
      git_prompt_status_count="$(git status --porcelain | wc -l)"
    fi
  elif [ "$(git rev-parse --is-bare-repository 2>/dev/null)" = 'true' ]; then
    git_prompt_branch='(bare repo)'
  fi

  if [ -n "$git_prompt_branch" ]; then
    if [ "${git_prompt_status_count:-0}" -gt 0 ]; then
      git_prompt="\[\e[1;33m\]${git_prompt_branch}*\[\e[0m\]"
    else
      git_prompt="\[\e[36m\]${git_prompt_branch}\[\e[0m\]"
    fi

    PS1_INNER="${PS1_INNER:-} ${git_prompt}"
  fi
}

# append kubernetes context name and namespace
_bds_add_kube_to_prompt() {
  kube_context="$(kubectl config view -o=jsonpath='{.current-context}')"
  kube_namespace="$(kubectl config view -o=jsonpath="{.contexts[?(@.name==\"${kube_context}\")].context.namespace}")"

  if [ -n "$kube_namespace" ]; then
    kube_prompt="${kube_context}:${kube_namespace}"
  else
    kube_prompt="${kube_context}"
  fi

  PS1_INNER="${PS1_INNER:-} \[\e[34m\]${kube_prompt}\[\e[0m\]"
}

# make the prompt suffix red if the previous command failed
_bds_add_exit_code_to_prompt() {
  [ "$PS1_LAST_EXIT" -ne 0 ] && PS1_SUFFIX="\[\e[31m\]${PS1_SUFFIX}\[\e[0m\]"
}

# prepend user@hostname to prompt, if connected via ssh
_bds_add_ssh_to_prompt() {
  if [ -n "$SSH_CONNECTION" ]; then
    PS1_PREFIX='\[\e]0;\u@\h \w\a\]'
    PS1_INNER="\[\e[2m\]\u@\h\[\e[0m\] ${PS1_INNER}"
  fi
}

# set the prompt
_bds() {
  _bds_set_default_prompt
  _bds_add_exit_code_to_prompt
  _bds_add_ssh_to_prompt

  command -v git >/dev/null 2>&1 && _bds_add_git_to_prompt
  #command -v kubectl &>/dev/null && _bds_add_kube_to_prompt
  export PS1="${PS1_PREFIX:-}${PS1_INNER:-}${PS1_SUFFIX:-}"
  history -a
}

PROMPT_COMMAND="_bds${PROMPT_COMMAND:+; $PROMPT_COMMAND}"
