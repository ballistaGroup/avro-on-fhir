# avro-on-fhir

AVRO models for the [4.0.1 version of FHIR][fhir-spec].  
The AVRO schema is generated from the [FHIR JSON schema][fhir-json-schema].

## Developing

Unless we start adding logical types, there's not a lot of development to be done here.  
This project really just glues together a few different code generators.

### Prerequisites

- make
- wget
- unzip
- java (tested on openjdk 15.x)
- json-to-avro-schema
- gradle

### Build

```console
export J2A_INSTALL_DIR=/path/to/json-to-avro-schema/directory
make
```

The makefile downloads the schema from HL7 and applies a [small patch](./fhir.schema.json.patch) 
because the generator requires the root json schema to have an `$id`.

Our [json-to-avro-schema][json-to-avro-schema] tool is used to generate the AVRO schema.
You must set the `$J2A_INSTALL_DIR` environment variable before running the makefile.

The generated schema is output to `src/main/avro/fhir.avsc` for the gradle avro plugin to pick up.

At this time, the `gradle build` step will fail to generate the Java files.
Once [json-to-avro-schema] is generating correct AVRO schemas, this will complete successfully and generate a jar.

#### Make Targets

- `make`: downloads the schema archive, unpacks it, patches it, generates the avro, and runs `gradle build`
- `make all`: same as `make`
- `make mostlyclean`: removes all files generated by running `make`, except the downloaded schema archive
- `make clean`: removes all files generated by running `make`

#### Windows

Windows uses a different gradle wrapper script.
To build on a Windows device, either use WSL or set the `GRADLE` variable when running `make`.

```shell
GRADLE=./gradlew.bat make
```

## Roadmap

The majority of the development that needs to occur is in the [json-to-avro-schema][json-to-avro-schema] tool.  
Once it is capable of correctly transpiling the JSON schema to AVRO schema, 
we just need to add a CI action to build and publish the resulting `jar` and `fhir.avsc` file.

<!-- References -->
[fhir-spec]: http://hl7.org/fhir/index.html
[fhir-json-schema]: http://hl7.org/fhir/fhir.schema.json.zip
[json-to-avro-schema]: https://github.com/carreragroup/json-to-avro-schema