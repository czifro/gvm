installed_go_sdks=($(ls ${go_sdk_dir} | grep go | grep -v current | sed 's/go//' | xargs))
cur_go_version=$(ls -l ${go_cur_sdk} | cut -d '>' -f 2 | sed "s| *${go_sdk_dir}/go||")

echo "Installed Go SDKs:"
for g in ${installed_go_sdks[@]}; do
  if [[ $g == ${cur_go_version} ]]; then
    echo "  - $g *"
  else
    echo "  - $g"
  fi
done