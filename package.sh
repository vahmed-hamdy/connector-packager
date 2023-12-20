#!/bin/bash
. ./build-config.sh
buildCmd="mvn clean install package"

eval $buildCmd
IMAGE_BUILDING_TARGET="$(pwd)"/image-building-target/opt
CONNECTORS_TARGET="$IMAGE_BUILDING_TARGET"/connectors
rm -rf  "$IMAGE_BUILDING_TARGET"
echo "Creating image building target at $IMAGE_BUILDING_TARGET"
mkdir -p "$IMAGE_BUILDING_TARGET"
mkdir -p "$CONNECTORS_TARGET"

for module_path in connector-*; do
    module_name=$(basename "$module_path")
    meta_filepath=$(basename "$module_name"/*.yaml)
    meta_filename=$(basename "$meta_filepath")
    identifier=$(getIdentifierInMetaFilename "$meta_filename")
    mkdir -p  "$CONNECTORS_TARGET"/"$identifier"

    cp "$module_path"/target/flink-sql*.jar "$CONNECTORS_TARGET"/"$identifier"
    cp "$module_path"/"$meta_filepath" "$CONNECTORS_TARGET"/"$identifier"
done
