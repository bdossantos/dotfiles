# shellcheck shell=bash
# SSH agent: auto-start if not running, then add keys

_ssh_agent_file="${HOME}/.ssh-agent"
_ssh_agent_running=false

# Load existing agent environment if the cache file is present
if [[ -r "${_ssh_agent_file}" ]]; then
  eval "$(<"${_ssh_agent_file}")" >/dev/null
fi

# Start a new agent when the cached socket or PID is stale
if [[ -n "${SSH_AGENT_PID}" ]] && [[ -n "${SSH_AUTH_SOCK}" ]] \
  && [[ -S "${SSH_AUTH_SOCK}" ]] \
  && kill -0 "${SSH_AGENT_PID}" &>/dev/null; then
  ssh-add -l &>/dev/null
  _ssh_add_exit=$?
  # 0 = keys loaded, 1 = agent reachable with no keys, 2+ = agent error
  case "${_ssh_add_exit}" in
    0 | 1) _ssh_agent_running=true ;;
  esac
fi

if [[ "${_ssh_agent_running}" == false ]]; then
  (
    umask 066
    ssh-agent >"${_ssh_agent_file}"
  )
  eval "$(<"${_ssh_agent_file}")" >/dev/null
  ssh-add -l &>/dev/null
  _ssh_add_exit=$?
fi

# Add keys (interactive; no-op when keys are already loaded)
if [[ "${_ssh_add_exit}" -eq 1 ]]; then
  trap '' SIGINT
  ssh-add -t 8h
  trap - SIGINT
fi

unset _ssh_add_exit
unset _ssh_agent_running
unset _ssh_agent_file
