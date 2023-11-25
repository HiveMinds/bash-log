#!/usr/bin/env bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

# Load the script under test
load ../src/file_logging.sh

@test "Log messages at default log levels" {
  LOG_LEVEL_ALL # set log level to all, otherwise, NOTICE, INFO, DEBUG, TRACE will not be logged.

  local log_output=$(FATAL "fatal level")
  echo "log_output=$log_output"
  local substring="[FATAL ][test_Log_messages_at_default_log_levels:12 ] fatal level"
  # Assert log output contains substring.
  [[ "$log_output" == *"$substring"* ]]

  local log_output=$(ERROR "error level")
  echo "log_output=$log_output"
  local substring="[ERROR ][test_Log_messages_at_default_log_levels:18 ] error level"
  # Assert log output contains substring.
  [[ "$log_output" == *"$substring"* ]]

  local log_output=$(WARN "warn level")
  echo "log_output=$log_output"
  local substring="[WARN  ][test_Log_messages_at_default_log_levels:24 ] warn level"
  # Assert log output contains substring.
  [[ "$log_output" == *"$substring"* ]]

  local log_output=$(NOTICE "notice level")
  echo "log_output=$log_output"
  local substring="[NOTICE][test_Log_messages_at_default_log_levels:30 ] notice level"
  # Assert log output contains substring.
  [[ "$log_output" == *"$substring"* ]]

  local log_output=$(INFO "info level")
  echo "log_output=$log_output"
  local substring="[INFO  ][test_Log_messages_at_default_log_levels:36 ] info level"
  # Assert log output contains substring.
  [[ "$log_output" == *"$substring"* ]]

  local log_output=$(DEBUG "debug level")
  echo "log_output=$log_output"
  local substring="[DEBUG ][test_Log_messages_at_default_log_levels:42 ] debug level"
  # Assert log output contains substring.
  [[ "$log_output" == *"$substring"* ]]

  local log_output=$(TRACE "trace level")
  echo "log_output=$log_output"
  local substring="[TRACE ][test_Log_messages_at_default_log_levels:48 ] trace level"
  # Assert log output contains substring.
  [[ "$log_output" == *"$substring"* ]]
}
