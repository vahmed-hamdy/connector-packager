#!/bin/bash

imageNameAndTag=$1
buildCmd="mvn clean install package"

eval $buildCmd

docker build . -t $imageNameAndTag