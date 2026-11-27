# shellcheck shell=bash
# Tab completions: system-wide and mise-installed

# System bash completions
if [[ -r /etc/bash_completion ]]; then
  # shellcheck source=/dev/null
  source /etc/bash_completion
fi

if [[ -r /etc/profile.d/bash_completion.sh ]]; then
  # shellcheck source=/dev/null
  source /etc/profile.d/bash_completion.sh
fi

# bash-completion installed by mise (conda:bash-completion)
_bash_completion="${MISE_DATA_DIR:-${HOME}/.local/share/mise}/installs/conda-bash-completion/latest/share/bash-completion/bash_completion"
if [[ -r "$_bash_completion" ]] && ! declare -F _completion_loader &>/dev/null; then
  # shellcheck source=/dev/null
  source "$_bash_completion"
fi
unset _bash_completion

# gh CLI completions (includes gh copilot)
if command -v gh &>/dev/null && ! complete -p gh &>/dev/null; then
  eval "$(gh completion -s bash)"
fi

# kubectl completions (also covers the k alias defined in .aliases)
if command -v kubectl &>/dev/null; then
  if ! declare -F __start_kubectl &>/dev/null; then
    # shellcheck source=/dev/null
    source <(kubectl completion bash)
  fi
  complete -o default -F __start_kubectl k
fi

# terraform completions
if command -v terraform &>/dev/null; then
  complete -C terraform terraform
fi
