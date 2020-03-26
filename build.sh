#!/bin/bash

localdir=${PWD##*/}  

docker build -t veggiebenz/$localdir:v1 .

mkdir -p ./code
