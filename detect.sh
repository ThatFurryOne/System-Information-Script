#!/bin/bash
clear

if [ “$(uname)” == “Darwin” ]
then
	echo Mac
elif [ “$(uname)” == “Linux” ]
then
	echo Linux
fi