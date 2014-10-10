#!/bin/bash
clear
if [ “$(uname)”  == “Linux” ]; then 
	echo OS = Linux
	
	
	
elif [ “$(uname)” == “Darwin” ]; then
	echo OS: Mac OS X
	echo Version: "$(sw_vers -productVersion)"
	version="$(sw_vers -productVersion)"
	
	if [[ "$version" = "10.0"* ]] ; then
		echo CodeName: Cheetah
	elif [[ $version = "10.10"* ]]; then
		echo CodeName: Yosemite
	elif [[ $version == "10.1"* ]]; then
		echo CodeName: Puma
	elif [[ $version == "10.2"* ]]; then
		echo CodeName: Jaguar
	elif [[ $version == "10.3"* ]]; then
		echo CodeName: Panther
	elif [[ $version == "10.4"* ]]; then
		echo CodeName: Tiger
	elif [[ $version == "10.5"* ]]; then 
		echo CodeName: Leopard
	elif [[ $version == "10.6"* ]]; then 
		echo CodeName: Snow Leopard
	elif [[ $version == "10.7"* ]]; then
		echo CodeName: Lion
	elif [[ $version == "10.8"* ]]; then
		echo CodeName: Mountain Lion
	elif [[ $version == "10.9"* ]]; then
		echo CodeName: Mavericks
	fi
	
	echo 
	
	echo CPU: $(sysctl -n machdep.cpu.brand_string)
	echo Architecture: $(uname -pm)
	echo Number of CPU cores: $(sysctl -n hw.ncpu) 
	echo Number of Physical Cores: $(sysctl -n hw.physicalcpu)
	
	echo 
	
	echo RAM Size: $(sysctl -n hw.memsize | awk '{ size = $1 / 1024 / 1024 ; print size  "MB" }')
	
	echo 
	
	echo Storage Devices: 
	diskutil list
elif [[ “$(uname)”  == "CYGWIN"* ]]; then
	echo OS: Windows with a CYGWIN shell.
elif [ “$(uname)” == “FreeBSD” ]; then 
	echo OS: FreeBSD
elif [ “$(uname)” == “NetBSD” ]; then 	
	echo OS: NetBSD
elif [ “$(uname)” == “GNU” ]; then
	echo OS: GNU
fi

echo 
