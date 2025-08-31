<div align="center">

# asdf-bat [![Build](https://github.com/pauloedurezende/asdf-bat/actions/workflows/build.yml/badge.svg)](https://github.com/pauloedurezende/asdf-bat/actions/workflows/build.yml) [![Lint](https://github.com/pauloedurezende/asdf-bat/actions/workflows/lint.yml/badge.svg)](https://github.com/pauloedurezende/asdf-bat/actions/workflows/lint.yml)

[bat](https://github.com/sharkdp/bat) plugin for the [asdf version manager](https://asdf-vm.com).

A cat clone with syntax highlighting and Git integration.

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- **Rust** (rustc and cargo) - Required for compiling bat from source code
- `bash`, `curl`, `tar`, `git` and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html)

**Note:** This plugin compiles bat from source code, which may take a few minutes depending on your system. Make sure you have Rust installed before using this plugin.

# Install

Plugin:

```shell
asdf plugin add bat
# or
asdf plugin add bat https://github.com/pauloedurezende/asdf-bat.git
```

bat:

```shell
# Show all installable versions
asdf list-all bat

# Install specific version
asdf install bat latest

# Show installed versions
asdf list bat

# Set a version globally (in your home ~/.tool-versions file)
asdf set -u bat latest

# Now bat commands are available
bat --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/pauloedurezende/asdf-bat/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Paulo Eduardo Rezende](https://github.com/pauloedurezende/)
