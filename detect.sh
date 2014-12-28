#This is released under the MIT License
#See the LICENSE.md file for more information.

#!/bin/bash
clear
if [ “$(uname)”  == “Linux” ]; then 
	echo OS: Linux
	
	temp="$(egrep -h ^DISTRIB_ID= /etc/*-release | awk '{ print substr($0,12)}')"
	if [[ "$temp" = "Ubuntu" ]]; then
		echo Distro: Ubuntu
		echo Version: "$(egrep -h ^VERSION= /etc/*-release | awk '{print substr($0,9)}')" 
		echo Codename: "$(egrep -h ^DISTRIB_CODENAME= /etc/*-release | awk '{print substr($0, 18)}')"

		echo

		echo CPU: "$(egrep -h ^model\ name /proc/cpuinfo | awk '{print substr($0, 14)}')"
		echo Architecture: $(uname -m)
		echo Number of CPU cores:  "$(egrep -h ^cpu\ cores /proc/cpuinfo | awk '{print $4 }')"
 
		echo 
	
		echo RAM Size: "$(egrep -h ^MemTotal: /proc/meminfo | awk '{ size = $2 / 1024 ; print size  "MB" }')"
	
		echo 

		echo Storage Devices:
		df 

		echo 
		echo Networking Status:
		temp=($(ifconfig | grep "^[^ ]" | awk '{print $1}'))

		for i in "${temp[@]}"
		do :
			echo -e '\t' Interface: $i:
			if [ "$(ifconfig | grep -A 7 $i | grep 'inet addr:' | awk '{print $2}' | awk -F":" '{print $2}')" != "" ]; then
				echo -e '\t\t' IPV4 Address: "$(ifconfig | grep -A 7 $i | grep 'inet addr:' | awk '{print $2}' | awk -F":" '{print $2}')"
			else 
				echo -e '\t\t' IPV4 Address: None.
			fi
			if [ "$(ifconfig | grep -A 7 $i | grep 'inet6 addr:' | awk '{print $3}')" != "" ]; then
				echo -e '\t\t' IPV6 Address: "$(ifconfig | grep -A 7 $i | grep 'inet6 addr:' | awk '{print $3 }')"
			else 
				echo -e '\t\t' IPV6 Address: None.
			fi

		done
		echo 
		if [ "$(wget --spider -S www.google.com 2>&1 | grep '200 OK')" != "" ]; then
				echo Appears to have internet connectivity.
			else
				echo -e '\t' Appears that there is no internet connection.
			fi
	fi

	
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
