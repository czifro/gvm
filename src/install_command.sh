go_version=${args[go_version]}
go_bin=${go_bin_dir}/go${go_version}
go_sdk=${go_sdk_dir}/go${go_version}

if [[ -d $go_sdk ]]; then
  echo "Go v${go_version} already installed"
  exit 0
fi

if [[ ! -f $go_bin ]]; then
  echo "Installing Go v${go_version}"
  go install golang.org/dl/go${go_version}@latest
fi

echo "Downloading Go v${go_version} SDK"
eval "go${go_version} download"

eval "go${go_version} version"

echo "Use 'gvm use ${go_version}' to set as default"