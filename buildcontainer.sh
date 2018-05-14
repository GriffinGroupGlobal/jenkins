#!/bin/bash


if [ ! -f ./build_data_copy.yml ]; then
   cp build_data.yml build_data_copy.yml
fi

echo "##### Creating build data ..." > ./build.log
docker container run --rm -v $(pwd):/data g3dev/jinja2cli basic-security.j2.groovy build_data_copy.yml > basic-security.groovy 2>./build.log

echo "##### Building jenkins container ..." >> ./build.log
docker build -t g3dev/jenkins . >>./build.log 2>&1
