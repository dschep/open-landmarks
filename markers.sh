#!/bin/bash

set -e

mkdir -p wikidata_icons

for wikidata_id in $(jq '.[].wikidata' landmarks.json  -r); do
    ls wikidata_icons/$wikidata_id.png && continue
    curl -L -o image "https://hub.toolforge.org/$wikidata_id?p=image&w=800"
    convert image image.jpg
    rsvg-convert -o marker.png marker.svg
    mv marker.png wikidata_icons/$wikidata_id.png
    sleep 1 # avoid ratelimits :/
done
