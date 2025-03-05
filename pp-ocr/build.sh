#!/bin/bash

rm -rf build; mkdir build; cd build; cmake ../src/; make -j4; cd ..
