#!/bin/bash

ip addr | grep "2:" -A 3 | grep "inet " | awk '{print $2}' | sed 's/\/.*$//'
