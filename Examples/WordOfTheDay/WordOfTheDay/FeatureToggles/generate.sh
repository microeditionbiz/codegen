script_path=$(dirname "$0")
codegen -i ${script_path}/FirebaseConfiguration/remoteConfig.json -t ${script_path}/FirebaseConfiguration/firebaseConfiguration.stencil -o ${script_path}/FeatureToggles.generated.swift --override