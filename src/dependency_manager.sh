#!/bin/bash

function get_dependency_or_parent_path() {
  local calling_repo_root_path="$1"

  # Get the repository name from the repo root path last dir.
  local repo_name
  repo_name=$(basename "$(dirname "$calling_repo_root_path")")

  local dependency_or_parent_path

  # The path of this repo ends in /<repo_name>. If it follows:
  # /dependencies/<repo_name>, then it is a dependency of
  #another module.
  if [[ "$calling_repo_root_path" == *"/dependencies/$repo_name" ]]; then
    # This module is a dependency of another module.
    dependency_or_parent_path=".."
  else
    dependency_or_parent_path="dependencies"
  fi
  echo "$dependency_or_parent_path"
}

function load_required_dependency() {
  local calling_repo_root_path="$1"
  local dependency_name="$2"

  local dependency_or_parent_path
  dependency_or_parent_path="$(get_dependency_or_parent_path "$calling_repo_root_path")"
  echo "dependency_or_parent_path=$dependency_or_parent_path"
  echo "calling_repo_root_path=$calling_repo_root_path"
  local dependency_dir="$calling_repo_root_path/$dependency_or_parent_path/$dependency_name"
  if [ ! -d "$dependency_dir" ]; then
    echo "ERROR: $dependency_dir is not found in required dependencies."
    exit 1
  fi
  source "$dependency_dir/src/main.sh"
}

function load_parent_dependency() {
  local calling_repo_root_path="$1"
  local parent_dep="$2"

  local dependency_or_parent_path
  dependency_or_parent_path="$(get_dependency_or_parent_path "$calling_repo_root_path")"

  local parent_dep_dir="$calling_repo_root_path/../$parent_dep"
  # Check if the parent repo above the dependency dir is the parent dependency.
  if [ ! -d "$parent_dep_dir" ]; then
    # Must load the dependency as any other fellow dependency if it is not
    # a parent dependency.
    load_required_dependency "$calling_repo_root_path" "$parent_dep"
  else
    if [ ! -d "$parent_dep_dir/src" ]; then
      echo "ERROR: $parent_dep_dir/src is not found in parent dependencies."
      exit 1
    fi
    # Load the parent dependency.
    # shellcheck disable=SC1090
    source "$parent_dep_dir/src/main.sh"
  fi
}
