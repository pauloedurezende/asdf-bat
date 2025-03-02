#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/sharkdp/bat"
TOOL_NAME="bat"
TOOL_TEST="bat --version"

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

curl_opts=(-fsSL)

if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/v.*' | cut -d/ -f3- |
		sed 's/^v//'
}

list_all_versions() {
	list_github_tags
}

get_platform() {
	local platform=""

	case "$(uname -s)" in
	Darwin)
		platform="apple-darwin"
		;;
	Linux)
		platform="unknown-linux-gnu"
		;;
	*)
		fail "Platform '$(uname -s)' not supported!"
		;;
	esac

	echo "$platform"
}

get_arch() {
	local arch=""

	case "$(uname -m)" in
	x86_64 | amd64)
		arch="x86_64"
		;;
	aarch64 | arm64)
		arch="aarch64"
		;;
	*)
		fail "Architecture '$(uname -m)' not supported!"
		;;
	esac

	echo "$arch"
}

download_release() {
	local version="$1"
	local filename="$2"
	local platform
	local arch

	platform=$(get_platform)
	arch=$(get_arch)

	local url="${GH_REPO}/releases/download/v${version}/${TOOL_NAME}-v${version}-${arch}-${platform}.tar.gz"

	echo "* Downloading $TOOL_NAME release $version..."
	curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="$3"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	(
		mkdir -p "$install_path/bin"
		cp -r "$ASDF_DOWNLOAD_PATH/bat" "$install_path/bin/"
		chmod +x "$install_path/bin/bat"

		# Copy man pages if they exist
		if [ -d "$ASDF_DOWNLOAD_PATH/man" ]; then
			mkdir -p "$install_path/share/man/man1"
			cp -r "$ASDF_DOWNLOAD_PATH/man"/* "$install_path/share/man/man1/"
		fi

		# Copy completions if they exist
		if [ -d "$ASDF_DOWNLOAD_PATH/autocomplete" ]; then
			mkdir -p "$install_path/completions"
			cp -r "$ASDF_DOWNLOAD_PATH/autocomplete"/* "$install_path/completions/"
		fi

		local tool_cmd
		tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
		test -x "$install_path/bin/$tool_cmd" || fail "Expected $install_path/bin/$tool_cmd to be executable."

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}
