#!/bin/bash
export bash_log_is_loaded=true

START_TOR_AT_BOOT_SRC_PATH=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")

function load_functions() {

  # shellcheck disable=SC1091
  source "$START_TOR_AT_BOOT_SRC_PATH/bash_logger.sh"

}
load_functions

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
