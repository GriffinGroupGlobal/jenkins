#!/bin/bash

DEVOPSPSWD=devops
FORCEBUILD=0

if [ $# == 2 ]; then
    if [ "$1" = "-f" ]; then
       # I don't care which order the args are in as long as there are two, the force and password
       FORCEBUILD=1
       DEVOPSPSWD=$2
    else
       FORCEBUILD=1
       DEVOPSPSWD=$1
    fi
elif [ $# == 1 ]; then
    if [ "$1" = "-f" ]; then
       FORCEBUILD=1
    else
       # if changing the password, force the build
       FORCEBUILD=1
       DEVOPSPSWD=$1
    fi
fi

#echo "##### Initializing build data ..." > ./build.log
if [ $FORCEBUILD -eq 1 ] || [ ! -f ./build_data_copy.yml ]; then
   sed "s/<redacted>/$DEVOPSPSWD/g" ../data/build_data.yml > build_data_copy.yml
fi

if [ ! -f ./Dockerfile ]; then
   cp ../templates/Dockerfile.jenkinsinit.j2 ./Dockerfile.jenkinsinit.j2
   docker container run --rm -v "$(pwd)":/data g3dev/jinja2cli ./Dockerfile.jenkinsinit.j2 build_data_copy.yml > Dockerfile 2>./build.log
fi

#echo "##### Creating build data ..." >> ./build.log
#docker container run --rm -v "$(pwd)":/data g3dev/jinja2cli ../templates/basic-security.j2.groovy build_data_copy.yml > basic-security.groovy 2>./build.log

#echo "##### Building jenkins initialization container ..." >> ./build.log
# docker build -t g3dev/jenkinsinit . >>./build.log 2>&1

if [ $? -eq 0 ]; then
   echo "Success"
else
   echo "$(<./build.log)"
fi