# Bash Initialization Script

## Supported Environments

* Azure Cloud Shell
* Windows Subsystem for Linux (WSL)
* Generic Bash

## Installation

Execute this command to install:

```Shell
curl -sS https://raw.githubusercontent.com/pacroy/bash-init/master/init.sh | bash - && source ~/alias.sh
```

### Behind Proxy

Use this command to setup proxy before:

```Shell
export HTTPS_PROXY=http://user:pass@proxy.addr:port
```

Use this command to unset proxy after:

```Shell
unset HTTPS_PROXY
```
