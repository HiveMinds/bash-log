#!/bin/bash

# Get the path towards this src dir.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck disable=SC1091
source "$SCRIPT_DIR/bash_logger.sh"

# You can set the log level using:
#LOG_LEVEL_ALL # set log level to all, otherwise, NOTICE, INFO, DEBUG, TRACE will not be logged.

# You can make it log to file using:
#B_LOG --file log/multiple-outputs.txt --file-prefix-enable --file-suffix-enable

# You can silence the console logging with (by default it is true):
#B_LOG --stdout false # disable logging over stdout

# Example log messages.
# FATAL "fatal level"
# ERROR "error level"
# WARN "warning level"
# NOTICE "notice level"
# INFO "info level"
# DEBUG "debug level"
# TRACE "trace level"
