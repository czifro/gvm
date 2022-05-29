go_version=${args[go_version]}
go_bin=${go_bin_dir}/go${go_version}
go_sdk=${go_sdk_dir}/go${go_version}

if [[ ! -d $go_sdk ]] || [[ ! -f $go_bin ]]; then
  echo "Go v${go_version} not installed, run 'gvm install ${go_version}'"
  exit 0
fi

if [[ -f ${go_cur_sdk} ]]; then
  rm ${go_cur_sdk}
fi

rm ${go_cur_sdk} 2> /dev/null || true
ln -s ${go_sdk} ${go_cur_sdk}