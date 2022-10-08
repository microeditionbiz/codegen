script_path=$(dirname "$0")
codegen -i ${script_path}/remote-config.json -t ${script_path}/template.stencil -o ${script_path}/../FeatureToggles.generated.swift --override