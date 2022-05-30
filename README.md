# gvm
A simple Golang version manager

## Getting Started

Note: Tested on MacOS only. Other Unix-based systems are assumed to work.

This tool assumes Go is already installed. It is based on Go's system for installing multiple versions of Go: https://go.dev/doc/manage-install . To get started:

```shell
# Add <repo-path>/bin to PATH
$ gvm --version
0.1.0
# We need to convert the existing Go environment
# into an environment compatible with gvm
$ gvm init
Root required, running: sudo bin/gvm init
Password:
Go environment is now compatible with 'gvm'
$ gvm list
Installed Go SDKs:
  - 1.18 *
```

## How it works

When Go is used to install other versions of Go, it uses the following directories:

- `~/go/bin`
- `~/sdk`

Running `go install golang.org/dl/go<version>@latest` will install a binary in `~/go/bin`. This binary is used as an installer for the SDK at the specified version, by running `~/go/bin/go<version> download`, the SDK is downloaded and extracted to `~/sdk/go<version>`.

Tapping into this, we can build a wrapper around this to easily install multiple versions of Go. Introducing symlink files help abstract this so that tools that depend on `go` command can still function even though the version of Go is changing underneath them.

This is what `gvm` does. When you run `gvm init`, it will copy your Go installation to `~/sdk` and rename the Go directory to `go<version>`. A symlink is created at `~/sdk/gocurrent` that points to `~/sdk/go<version>`. The original Go installation path, typically `/usr/local/go`, becomes a symlink that points to `~/sdk/gocurrent`. This preserves the path of the Go binary that is registered in `PATH`. From this point forward, when switching versions of Go, `gvm` will only be updating `~/sdk/gocurrent`.

Note: `gvm init` uses `which go` to find where Go is installed. If the path is a symlink, `gvm init` will traverse the symlink (and nested symlinks) to the real path of the Go installation and perform the init process. The top-level symlink will be preserved and redirect to `~/sdk/gocurrent`.

## Alternatives

- [stefanmaric/g](https://github.com/stefanmaric/g)

More listed here: [alts](https://github.com/stefanmaric/g#the-alternatives-and-why-i-prefer-g)
