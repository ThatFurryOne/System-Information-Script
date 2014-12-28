#For contributors
##What is the project aim?
This project has the aim of supplying users with useful information about the computersuch as operating system version and hardware information.

##How can you help?
By adding in code that can help with the aim of the project or by filling in gaps of knowledge regarding the system information.

##Requirements:
- Code needs to be commented and in a similar style.
- Tab size is 4 spaces.
- Output needs to match the styling or be similar.

##The output styling:
The output styling needs to be ordered and remove remove unnescary information, this may require awk/grep knowledge.

###Example output
This is Ubuntu in a Virtual Machine:

```
OS: Linux
Distro: Ubuntu
Version: "14.10 (Utopic Unicorn)"
Codename: utopic

CPU: Intel(R) Core(TM) i7-2675QM CPU @ 2.20GHz
Architecture: x86_64
Number of CPU cores: 1

RAM Size: 993.516MB

Storage Devices:
Filesystem     1K-blocks      Used Available Use% Mounted on
/dev/sda1        7092728   5108680   1600716  77% /
none                   4         0         4   0% /sys/fs/cgroup
udev              497572         4    497568   1% /dev
tmpfs             101736       832    100904   1% /run
none                5120         4      5116   1% /run/lock
none              508680        76    508604   1% /run/shm
none              102400        40    102360   1% /run/user
VM_transfer    292103400 164968920 127134480  57% /media/sf_VM_transfer
VM_transfer    292103400 164968920 127134480  57% /home/ubuntu/Desktop/host

Networking Status:
	 Interface: eth0:
		 IPV4 Address: 10.0.2.15
		 IPV6 Address: fe80::a00:27ff:feb9:ff10/64
	 Interface: lo:
		 IPV4 Address: 127.0.0.1
		 IPV6 Address: ::1/128

Appears to have internet connectivity.
```
