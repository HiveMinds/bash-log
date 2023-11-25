#!/usr/bin/env bash
# Run with:
# examples/01_basic_example.sh

# example: 01 - basic example
# shellcheck disable=SC1091
source "$(dirname "$(realpath "${BASH_SOURCE[0]}")")"/../src/file_logging.sh # include the script
LOG_LEVEL_ALL                                                                # set log level to all
FATAL "fatal level"
ERROR "error level"
WARN "warning level"
NOTICE "notice level"
INFO "info level"
DEBUG "debug level"
TRACE "trace level"
