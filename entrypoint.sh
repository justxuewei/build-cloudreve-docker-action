#!/bin/bash

echo ">>>>>> clone Cloudreve from git <<<<<<"
git clone --recurse-submodules https://github.com/cloudreve/Cloudreve.git
cd Cloudreve
echo ">>>>>> build frontend <<<<<<"
cd assets
yarn install
yarn run build
echo ">>>>>> build backend <<<<<<"
cd ..
go get github.com/rakyll/statik
statik -src=assets/build/ -include=*.html,*.js,*.json,*.css,*.png,*.svg,*.ico -f
export COMMIT_SHA=$(git rev-parse --short HEAD)
export VERSION=$(git describe --tags)
go build -a -o cloudreve -ldflags " -X 'github.com/HFO4/cloudreve/pkg/conf.BackendVersion=$VERSION' -X 'github.com/HFO4/cloudreve/pkg/conf.LastCommit=$COMMIT_SHA'"
