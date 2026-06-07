# devpod-ssh

A lightweight shell function that seamlessly chains `devpod up` and `devpod ssh`. It boots your DevPod workspace silently in the background and uses a smart-polling loop to drop you into your interactive SSH session the exact millisecond the container is ready.

## Features
* **Silent Boot:** Suppresses DevPod's verbose startup logs so your terminal stays clean.
* **Smart Polling:** Doesn't rely on arbitrary `sleep` timers. It rapidly pings the container's SSH daemon and connects instantly when available.
* **Universal Context:** Uses DevPod's native SSH wrapper (`devpod ssh .`), meaning this single command works automatically in *any* DevPod project directory without requiring manual SSH config changes.
* **IDE Agnostic:** Bypasses local IDE launches (`--ide none`) so you strictly get the terminal connection.

## Installation

You can install the function directly to your `~/.bashrc` (or `~/.zshrc`) by running this quick install script in your terminal:

```bash
./install-devpod-ssh.sh
```

## Usage

Navigate to any local directory containing a DevContainer setup (or where you want to launch a default workspace) and simply run:

```bash
devpod-ssh
```

The script will handle the backgrounding, waiting, and connecting automatically.

## Requirements
- DevPod CLI (devpod) installed and accessible in your $PATH.
- Standard Unix tools (bash/zsh, grep, sleep).
