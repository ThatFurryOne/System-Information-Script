#This is released under the MIT License
#See the "License" file for more information.

#!/bin/bash
clear
#uname is the OS type variable.
if [ “$(uname)”  == “Linux” ]; then 
	#OS is Linux based:
	echo OS: Linux
	
	#Checks for the distro type - Distrib_ID or Name in the /etc/*-release info
	if [[ "$(egrep -h ^DISTRIB_ID= /etc/*-release | awk '{ print substr($0,12)}')" = "Ubuntu" ]]; then
		#Ubuntu distro information
		echo Distro: Ubuntu
		echo Version: "$(egrep -h ^VERSION= /etc/*-release | awk '{print substr($0,9)}')" 
		echo Codename: "$(egrep -h ^DISTRIB_CODENAME= /etc/*-release | awk '{print substr($0, 18)}')"
		
		echo
		
		#CPU information - uname -m may not always work?
		echo CPU: "$(egrep -h ^model\ name /proc/cpuinfo | awk '{print substr($0, 14)}')"
		echo Architecture: $(uname -m)
		echo Number of CPU cores:  "$(egrep -h ^cpu\ cores /proc/cpuinfo | awk '{print $4 }')"
 
		echo 
		
		#RAM information - Needs more work
		echo RAM Size: "$(egrep -h ^MemTotal: /proc/meminfo | awk '{ size = $2 / 1024 ; print size  "MB" }')"
	
		echo 
		
		#Uses the df command currently without any specific formatting
		echo Storage Devices:
		df -h

		echo 
		
		#Networking - "echo -e '\t'" is the tab for formatting.
		#Does use awk/grep a lot - may be better ways of doing this. 
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
		
		#Test for internet connectivity via wget and google.com - again more than one way of doing this.
		if [ "$(wget --spider -S www.google.com 2>&1 | grep '200 OK')" != "" ]; then
				echo Appears to have internet connectivity.
			else
				echo -e '\t' Appears that there is no internet connection.
		fi
	elif [ "$(egrep -h ^NAME= /etc/*-release | awk '{ print substr($0,6)}')" = "openSUSE" ]; then
		#openSUSE
		echo Distro: OpenSUSE
		echo Version: "$(egrep -h ^VERSION= /etc/*-release | awk '{print substr($0,9)}')"
		echo Fullname: "$(egrep -h ^PRETTY_NAME= /etc/*-release | awk '{print substr($0, 13)}')"
		
		echo
		
		#CPU information - uname -m may not always work?
		echo CPU: "$(egrep -h ^model\ name /proc/cpuinfo | awk '{print substr($0, 14)}')"
		echo Architecture: $(uname -m)
		echo Number of CPU cores: $(nproc) #due to cpuinfo layout nproc is used - number of proccesing cores
 
		echo 
		
		#RAM information - Needs more work
		echo RAM Size: "$(egrep -h ^MemTotal: /proc/meminfo | awk '{ size = $2 / 1024 ; print size  "MB" }')"
	
		echo 
		
		#Uses the df command currently without any specific formatting
		echo Storage Devices:
		df -h

		echo 
		
		#Networking - "echo -e '\t'" is the tab for formatting.
		#Does use awk/grep a lot - may be better ways of doing this. 
		#ifconfig doesn't have a direct path in OpenSUSE.
		echo Networking Status:
		temp=($(/sbin/ifconfig | grep "^[^ ]" | awk '{print $1}'))

		for i in "${temp[@]}"
		do :
			echo -e '\t' Interface: $i:
			if [ "$(/sbin/ifconfig | grep -A 7 $i | grep 'inet addr:' | awk '{print $2}' | awk -F":" '{print $2}')" != "" ]; then
				echo -e '\t\t' IPV4 Address: "$(/sbin/ifconfig | grep -A 7 $i | grep 'inet addr:' | awk '{print $2}' | awk -F":" '{print $2}')"
			else 
				echo -e '\t\t' IPV4 Address: None.
			fi
			if [ "$(/sbin/ifconfig | grep -A 7 $i | grep 'inet6 addr:' | awk '{print $3}')" != "" ]; then
				echo -e '\t\t' IPV6 Address: "$(/sbin/ifconfig | grep -A 7 $i | grep 'inet6 addr:' | awk '{print $3 }')"
			else 
				echo -e '\t\t' IPV6 Address: None.
			fi

		done

		echo
		
		#Test for internet connectivity via wget and google.com - again more than one way of doing this.
		if [ "$(wget --spider -S www.google.com 2>&1 | grep '200 OK')" != "" ]; then
				echo Appears to have internet connectivity.
			else
				echo -e '\t' Appears that there is no internet connection.
		fi
	fi

	
elif [ “$(uname)” == “Darwin” ]; then
	#Apple/OS X
	echo OS: Mac OS X
	echo Version: "$(sw_vers -productVersion)"
	version="$(sw_vers -productVersion)"
	#Gets the codename - Unknown if this works for all of them.
	if [[ "$version" = "10.0"* ]] ; then
		echo CodeName: Cheetah
	elif [[ $version = "10.10"* ]]; then #Verified
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
	
	#CPU information
	echo CPU: $(sysctl -n machdep.cpu.brand_string)
	echo Architecture: $(uname -pm)
	echo Number of CPU cores: $(sysctl -n hw.ncpu) 
	echo Number of Physical Cores: $(sysctl -n hw.physicalcpu)
	
	echo 
	
	#Ram Size
	echo RAM Size: $(sysctl -n hw.memsize | awk '{ size = $1 / 1024 / 1024 ; print size  "MB" }')
	
	echo 
	
	#Storage
	echo Storage Devices: 
	diskutil list
elif [[ “$(uname)”  == "CYGWIN"* ]]; then
	#Windows
	echo OS: Windows with a CYGWIN shell.
elif [ “$(uname)” == “FreeBSD” ]; then 
	#FreedBSD
	echo OS: FreeBSD
elif [ “$(uname)” == “NetBSD” ]; then 	
	#netBSD
	echo OS: NetBSD
elif [ “$(uname)” == “GNU” ]; then
	#GNU - This can also mean Linux or a variant operating system.
	echo OS: GNU
fi

echo 
