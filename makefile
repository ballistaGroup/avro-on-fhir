GRADLE ?= ./gradlew
JAVA ?= java

all: build/libs/avro-on-fhir-1.0-SNAPSHOT.jar

build/libs/avro-on-fhir-1.0-SNAPSHOT.jar: src/main/avro/fhir.avsc
	$(GRADLE) build

src/main/avro/fhir.avsc: fhir.schema.json
	$(JAVA) -jar ${J2A_INSTALL_DIR}/json-to-avro-schema-assembly-0.1.jar $< > $@

fhir.schema.json: fhir.schema.json.zip
	unzip -o $<
	patch $@ fhir.schema.json.patch

fhir.schema.json.zip:
	wget http://hl7.org/fhir/fhir.schema.json.zip

.PHONY: mostlyclean
mostlyclean:
	$(GRADLE) clean
	$(RM) src/main/avro/fhir.avsc
	$(RM) fhir.schema.json

.PHONY: clean
clean: mostlyclean
	$(RM) fhir.schema.json.zip
