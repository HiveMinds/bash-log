# Bash-Log Tool

Based on the idea of [b-log](https://github.com/idelsink/b-log).
Which is based on the idea of [log.sh](https://github.com/livibetter-backup/log.sh).

Call this dependency from another bash script to have a decent logger with
minimal boiler plate code in the other repo.

Instructions on how to use the logger can be found [here](examples/Usage.md).
The instructions below explain how to include this dependency in other repos.

## Install this bash dependency in other repo

- In your other repo, include a file named: `.gitmodules` that includes:

```sh
[submodule "dependencies/bash-log"]
 path = dependencies/bash-log
 url = https://github.com/hiveminds/bash-log
```

- Create a file named `install_dependencies.sh` with content:

```sh
# Remove the submodules if they were still in the repo.
git rm --cached dependencies/bash-log/bash-log

# Remove and create a directory for the dependencies.
rm -r dependencies
mkdir -p dependencies

# (Re) add the BATS submodules to this repository.
git submodule add --force https://github.com/HiveMinds/bash-log dependencies/bash-log

# Update all submodules
git submodule update --remote --recursive
```

- Install the submodule with:

```sh
chmod +x install-dependencies.sh
./install-dependencies.sh
```

## Call this bash dependency from other repo

After including this dependency you can use the functions in this module like:

```sh
#!/bin/bash

# Load the installer dependency.
source dependencies/bash-log/src/main.sh
# set log level to all, otherwise, NOTICE, INFO, DEBUG, TRACE won't be logged.
LOG_LEVEL_ALL

# You can make it log to file using:
B_LOG --file log/multiple-outputs.txt --file-prefix-enable --file-suffix-enable

# You can silence the console logging with (by default it is true):
#B_LOG --stdout false # disable logging over stdout

FATAL   "fatal level"
ERROR   "error level"
WARN    "warning level"
NOTICE  "notice level"
INFO    "info level"
DEBUG   "debug level"
TRACE   "trace level"
```

That outputs:

![Example 01](./examples/01_basic_example.png "Example 01 output")

and creates a file with that log at: `log/multiple-outputs.txt`

## Testing

Put your unit test files (with extension .bats) in folder: `/test/`

### Prerequisites

(Re)-install the required submodules with:

```sh
chmod +x install-dependencies.sh
./install-dependencies.sh
```

Install:

```sh
sudo gem install bats
sudo apt install bats -y
sudo gem install bashcov
sudo apt install shfmt -y
pre-commit install
pre-commit autoupdate
```

### Pre-commit

Run pre-commit with:

```sh
pre-commit run --all
```

### Tests

Run the tests with:

```sh
bats test
```

If you want to run particular tests, you could use the `test.sh` file:

```sh
chmod +x test.sh
./test.sh
```

### Code coverage

```sh
bashcov bats test
```

## How to help

- Include bash code coverage in GitLab CI.
- Add [additional](https://pre-commit.com/hooks.html) (relevant) pre-commit hooks.
- Develop Bash documentation checks
  [here](https://github.com/TruCol/checkstyle-for-bash), and add them to this
  pre-commit.
