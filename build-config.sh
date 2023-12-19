#!/bin/bash

MODULES_TO_SKIP=(
    "ververica-connector-cloudhbase-shaded"
    "ververica-connector-jdbc-common"
    "ververica-connector-hadoop-shaded"
    "ververica-connector-test"
    "ververica-connector-planner"
    "ververica-connector-planner-common"
    "ververica-connector-planner-delegate"
    "ververica-connector-planner-loader"
    "ververica-connector-db2"
)

FLINK_DIR="../flink"
FLINK_FORMATS_DIR="$FLINK_DIR/flink-formats"

# shellcheck disable=SC2010
# We use `grep -v "tests.jar"` here to exclude test JARs
function getFormatJarPathInFlink() {
    identifier=$1
    case $identifier in
    avro)
        ls $FLINK_FORMATS_DIR/flink-sql-avro/target/flink-sql-avro*.jar | grep -v "tests.jar"
        ;;
    avro-confluent | debezium-avro-confluent)
        ls $FLINK_FORMATS_DIR/flink-sql-avro-confluent-registry/target/flink-sql-avro-confluent-registry*.jar | grep -v "tests.jar"
        ;;
    csv)
        ls $FLINK_FORMATS_DIR/flink-csv/target/flink-csv*-sql-jar.jar | grep -v "tests.jar"
        ;;
    json | canal-json | debezium-json | maxwell-json)
        ls $FLINK_FORMATS_DIR/flink-json/target/flink-json*-sql-jar.jar | grep -v "tests.jar"
        ;;
    orc)
        ls $FLINK_FORMATS_DIR/flink-sql-orc/target/flink-sql-orc*.jar | grep -v "tests.jar"
        ;;
    parquet)
        ls $FLINK_FORMATS_DIR/flink-sql-parquet/target/flink-sql-parquet*.jar | grep -v "tests.jar"
        ;;
    raw)
        echo ""
        ;;
    *)
        exitWithError "Unrecognized format \"$identifier\"" 1
        ;;
    esac
}

# shellcheck disable=SC2010
# We use `grep -v "tests.jar"` here to exclude test JARs
function getFormatJarPathInTarget() {
    identifier=$1
    jar_path_in_flink=$(getFormatJarPathInFlink "$identifier")
    case $identifier in
    avro)
        echo avro/"$(basename "$jar_path_in_flink")"
        ;;
    avro-confluent | debezium-avro-confluent)
        echo avro-confluent/"$(basename "$jar_path_in_flink")"
        ;;
    csv)
        echo csv/"$(basename "$jar_path_in_flink")"
        ;;
    json | canal-json | debezium-json | maxwell-json)
        echo json/"$(basename "$jar_path_in_flink")"
        ;;
    orc)
        echo orc/"$(basename "$jar_path_in_flink")"
        ;;
    parquet)
        echo parquet/"$(basename "$jar_path_in_flink")"
        ;;
    raw)
        echo ""
        ;;
    *)
        exitWithError "Unrecognized format \"$identifier\"" 1
        ;;
    esac
}

#------------------------------------------------ Helper functions ---------------------------------------------------

function exitWithError() {
    local error_message=$1
    local error_number=$2
    printf '\n\nERROR: %s\nAborting execution.\n' "$error_message"
    exit "$error_number"
}

function checkReturnValue() {
    return_value=$?
    if [[ "$return_value" != 0 ]]; then
        exitWithError "Error occurred while processing. Check output above for more details." 1
    fi
}

function checkSkipModule() {
    for skip in "${MODULES_TO_SKIP[@]}"; do
        if [[ $1 == "$skip" ]]; then
            return 1
        fi
    done
    return 0
}

function getIdentifierInMetaFilename() {
    sed -nE 's/^(catalog|connector|format)-meta-(.*)\.yaml$/\2/p' <<<"$1"
}