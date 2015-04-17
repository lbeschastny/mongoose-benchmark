#!/bin/bash

function install {
  npm install $@ --silent &> /dev/null
}

function init {
  rm -rf ~/.npm
  rm -rf ./node_modules
  n $1
  install
}

function run {
  install mongoose@$1
  npm start --silent
  echo ""
}

function run_all {
  init $@
  run 3.8
  run 4.0
}

run_all 0.10.30
run_all 0.12.0
