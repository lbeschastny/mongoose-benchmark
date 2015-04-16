#!/bin/bash

function init {
  rm -rf ./node_modules
  npm install --silent &> /dev/null
}

function node_10 {
  n 0.10.30
}

function node_12 {
  n 0.12.0
}

function mongoose_3 {
  npm i mongoose@3.8 --silent &> /dev/null
}

function mongoose_4 {
  npm i mongoose@4 --silent &> /dev/null
}

function run {
  npm start --silent
}

node_10
init
mongoose_3
run
mongoose_4
run
node_12
init
mongoose_3
run
mongoose_4
run
