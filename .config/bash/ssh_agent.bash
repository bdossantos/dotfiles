# shellcheck shell=bash
# SSH agent: auto-start if not running, then add keys

_ssh_agent_file="${HOME}/.ssh-agent"

# Load existing agent environment if the cache file is present
if [[ -r "${_ssh_agent_file}" ]]; then
  eval "$(<"${_ssh_agent_file}")" >/dev/null
fi

# Start a new agent when the PID is missing or the process is dead
if [[ -z "${SSH_AGENT_PID}" ]] || ! kill -0 "${SSH_AGENT_PID}" &>/dev/null; then
  (
    umask 066
    ssh-agent >"${_ssh_agent_file}"
  )
  eval "$(<"${_ssh_agent_file}")" >/dev/null
fi

# Add keys (interactive; no-op when keys are already loaded)
if ! ssh-add -l &>/dev/null; then
  trap '' SIGINT
  ssh-add -t 8h
  trap - SIGINT
fi

unset _ssh_agent_file
