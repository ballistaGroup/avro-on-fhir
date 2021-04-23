# avro-on-fhir

AVRO models for the [4.0.1 version of FHIR][fhir-spec]
The AVRO schema is generated from the [FHIR JSON schema][fhir-json-schema].

## Developing

### Prerequisites

- wget
- unzip
- json-to-avro-schema
- gradle

### Build

The `generate.sh` script downloads the schema from HL7 and applies a [small patch](./fhir.schema.json.patch) 
because the generator requires the root json schema to have an `$id`.

Our [json-to-avro-schema][json-to-avro-schema] tool is used to generate the AVRO schema.
You must set the `$J2A_INSTALL_DIR` environment variable before running the script.

```console
$ export J2A_INSTALL_DIR=/path/to/json-to-avro-schema-installation/
$ ./generate.sh
Archive:  fhir.schema.json.zip
  inflating: fhir.schema.json        
patching file fhir.schema.json
transpiling...
input loaded
parsed
success
AVRO schema written to src/main/avro/fhir.avsc
$
$ # this step will not complete successfully until the bugs are worked out of json-to-avro-schema
$ # but the gradle build has been tested with a sample schema
$ # it's here to make it easy to test changes to the transpiler
$ gradle build

> Task :generateAvroJava FAILED
FAILURE: Build failed with an exception.
```

## Roadmap

Once `json-to-avro-schema` is capable of correctly transpiling the JSON schema to AVRO schema:

- Create build process that
  * [ ] generates the `fhir.avsc` file
  * [ ] Generates the Java files
  * [ ] Compiles them into a `jar`
  * [ ] Publishes the artifact


<!-- References -->
[fhir-spec]: http://hl7.org/fhir/index.html
[fhir-json-schema]: http://hl7.org/fhir/fhir.schema.json.zip
[json-to-avro-schema]: https://github.com/carreragroup/json-to-avro-schema