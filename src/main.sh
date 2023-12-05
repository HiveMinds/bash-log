#!/bin/bash

function load_dependencies() {
  local calling_repo_root_path="$1"
  local dependency_or_parent_path
  # The path of this repo ends in /bash-create-onion-domains. If it follows:
  # /dependencies/bash-create-onion-domains, then it is a dependency of
  #another module.
  echo "calling_repo_root_path=$calling_repo_root_path"
  if [[ "$calling_repo_root_path" == *"/dependencies/bash-create-onion-domains" ]]; then
    # This module is a dependency of another module.
    dependency_or_parent_path=".."
  else
    dependency_or_parent_path="dependencies"
  fi
  echo "dependency_or_parent_path=$dependency_or_parent_path"
  load_REQUIRED_DEPS "$calling_repo_root_path" "$dependency_or_parent_path"
  load_PARENT_DEPS "$calling_repo_root_path" "$dependency_or_parent_path"
}

function load_required_dependency() {
  local calling_repo_root_path="$1"
  local dependency_or_parent_path="$2"
  local dependency_name="$3"

  local dependency_dir="$calling_repo_root_path/$dependency_or_parent_path/$dependency_name"
  if [ ! -d "$dependency_dir" ]; then
    echo "ERROR: $dependency_dir is not found in required dependencies."
    exit 1
  fi
  source "$dependency_dir/src/main.sh"
}

function load_PARENT_DEPS() {
  local calling_repo_root_path="$1"
  local dependency_or_parent_path="$2"
  local parent_dep="$3"

  local parent_dep_dir="$calling_repo_root_path/../$parent_dep"
  echo "parent_dep_dir=$parent_dep_dir"
  # Check if the parent repo above the dependency dir is the parent dependency.
  if [ ! -d "$calling_repo_root_path/../$parent_dep" ]; then
    # Must load the dependency as any other fellow dependency if it is not
    # a parent dependency.
    load_required_dependency "$dependency_or_parent_path" "$required_dependency"
  else
    # Load the parent dependency.
    # shellcheck disable=SC1090
    source "$calling_repo_root_path/../$parent_dep/src/main.sh"
  fi
}

START_TOR_AT_BOOT_SRC_PATH=$(dirname "$(readlink -f "$0")")
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
