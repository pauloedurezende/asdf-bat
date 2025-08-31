# Contributing

## Prerequisites

Before testing locally, make sure you have:

- **Rust** (rustc and cargo) installed - Required for compiling bat from source
- **asdf** installed and configured
- Basic development tools: `bash`, `curl`, `tar`, `git`

## Testing Locally

```shell
asdf plugin test bat /Users/pauloeduardorezende/workspace/asdf-bat --asdf-tool-version 0.25.0 "bat --version"
```

**Note:** The test will compile bat from source code, which may take several minutes.

Tests are automatically run in GitHub Actions on push and PR.
