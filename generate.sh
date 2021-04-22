#! /bin/bash

json_schema=fhir.schema.json
json_schema_archive=$json_schema.zip

if [ ! -f $json_schema_archive ]; then
    echo "json schema archive not found"
    echo "hang on, we're downloading it..."
    wget http://hl7.org/fhir/fhir.schema.json.zip
fi

unzip -o fhir.schema.json.zip
patch $json_schema $json_schema.patch

if test -z $J2A_INSTALL_DIR
then
    echo "\$J2A_INSTALL_DIR not set!"
    exit 1
else
    echo "transpiling..."
    output=fhir.avsc
    java -jar $J2A_INSTALL_DIR/json-to-avro-schema-assembly-0.1.jar $json_schema > $output
    echo "AVRO schema written to $output"
fi