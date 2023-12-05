#!/usr/bin/env bash

SCRIPT_PATH=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")

# Remove the submodules if they were still in the repo.
git rm --cached "$SCRIPT_PATH/test/libs/bats"
git rm --cached "$SCRIPT_PATH/test/libs/bats-support"
git rm --cached "$SCRIPT_PATH/test/libs/bats-assert"

# Remove and re-create the submodule directory.
rm -r "$SCRIPT_PATH/test/libs"
mkdir -p "$SCRIPT_PATH/test/libs"

# Remove and create a directory for the dependencies.
rm -r dependencies
mkdir -p dependencies

# (Re) add the BATS submodules to this repository.
git submodule add --force https://github.com/sstephenson/bats "$SCRIPT_PATH/test/libs/bats"
git submodule add --force https://github.com/ztombol/bats-support "$SCRIPT_PATH/test/libs/bats-support"
git submodule add --force https://github.com/ztombol/bats-assert "$SCRIPT_PATH/test/libs/bats-assert"
git submodule update --remote --recursive

# Remove the submodules from the index.
git rm -r -f --cached "$SCRIPT_PATH/test/libs/bats"
git rm -r -f --cached "$SCRIPT_PATH/dependencies"
