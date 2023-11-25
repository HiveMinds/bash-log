#!/bin/bash

# Get the path towards this src dir.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck disable=SC1091
source "$SCRIPT_DIR/cli_logging.sh"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/file_logging.sh"

# You can set the log level using:
# LOG_LEVEL_ALL # set log level to all, otherwise, NOTICE, INFO, DEBUG, TRACE will not be logged.

# You can make it log to file using:
# B_LOG --file multiple-outputs.txt --file-prefix-enable --file-suffix-enable

FATAL "fatal level"
ERROR "error level"
WARN "warning level"
NOTICE "notice level"
INFO "info level"
DEBUG "debug level"
TRACE "trace level"
