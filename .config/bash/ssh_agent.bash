# shellcheck shell=bash
# SSH agent: auto-start if not running, then add keys

_ssh_agent_file="${HOME}/.ssh-agent"
_ssh_agent_running=true

# Load existing agent environment if the cache file is present
if [[ -r "${_ssh_agent_file}" ]]; then
  eval "$(<"${_ssh_agent_file}")" >/dev/null
fi

# Start a new agent when the cached socket or PID is stale
if [[ -z "${SSH_AGENT_PID}" ]] || [[ -z "${SSH_AUTH_SOCK}" ]] \
  || [[ ! -S "${SSH_AUTH_SOCK}" ]] \
  || ! kill -0 "${SSH_AGENT_PID}" &>/dev/null; then
  _ssh_agent_running=false
else
  ssh-add -l &>/dev/null
  _ssh_add_exit=$?
  case "${_ssh_add_exit}" in
    0 | 1) ;;
    *) _ssh_agent_running=false ;;
  esac
fi

if [[ "${_ssh_agent_running}" == false ]]; then
  (
    umask 066
    ssh-agent >"${_ssh_agent_file}"
  )
  eval "$(<"${_ssh_agent_file}")" >/dev/null
fi

# Add keys (interactive; no-op when keys are already loaded)
ssh-add -l &>/dev/null
_ssh_add_exit=$?
if [[ "${_ssh_add_exit}" -eq 1 ]]; then
  trap '' SIGINT
  ssh-add -t 8h
  trap - SIGINT
fi

unset _ssh_add_exit
unset _ssh_agent_running
unset _ssh_agent_file
