# shellcheck shell=bash
# History: flush the in-memory history buffer to disk before each prompt.
# Must be sourced after prompt.bash and tools.bash so that PROMPT_COMMAND is
# already populated by starship / direnv before we prepend history -a.

PROMPT_COMMAND="history -a${PROMPT_COMMAND:+;$PROMPT_COMMAND}"
