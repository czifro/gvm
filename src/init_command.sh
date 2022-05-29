if [[ $EUID != 0 ]]; then
  cmd="$0 $action"
  echo "Root required, running: sudo $cmd"
  sudo $cmd
  exit $?
fi

go_dir=$(cd $(dirname $(which go))/.. && pwd)
real_go_dir=${go_dir}
cur_go_version=$(go version | cut -d ' ' -f3 | sed 's/go//')

while [[ -L ${real_go_dir} ]]; do
  real_go_dir=$(ls -l ${real_go_dir} | cut -d '>' -f 2 | sed "s/ //")
done

if [[ ${real_go_dir} =~ ${go_sdk_dir}/* ]]; then
  echo "Detected using Go SDKs, running 'gvm use ${cur_go_version}'"
  $0 use ${cur_go_version}
  if [[ $? != 0 ]]; then
    exit $?
  fi
  sudo rm ${go_dir}
  ln -s ${go_cur_sdk} ${go_dir}
  echo "Go environment is now compatible with 'gvm'"
  exit
fi

if [[ ! -d ${go_sdk_dir} ]]; then
  mkdir ${go_sdk_dir}
fi

sudo mv ${go_dir} ${go_sdk_dir}/go${cur_go_version}
$0 use ${cur_go_version}
if [[ $? != 0 ]]; then
  exit $?
fi
sudo ln -s ${go_cur_sdk} ${go_dir}
echo "Go environment is now compatible with 'gvm'"

