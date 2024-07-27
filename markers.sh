#!/bin/bash

set -e

rm -rf wikidata_icons
mkdir wikidata_icons

for wikidata_id in $(jq '.[].wikidata' landmarks.json  -r); do
    echo $wikidata_id
    curl -L -o image "https://hub.toolforge.org/$wikidata_id?p=image&w=800"
    file image
    convert image image.jpg || continue
    inkscape --export-type=png marker.svg
    mv marker.png wikidata_icons/$wikidata_id.png
    echo
    echo
    echo
    sleep 5
done
