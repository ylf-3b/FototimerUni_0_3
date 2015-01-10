#!/bin/ash
# ISO level switch with gphoto2, controlled over serial/usb device Arduino
# Version for FototimerUni0.1x
# change directory
# edit this part in case of other localisation
echo "change to /root/fototimer"
cd /mnt/sda1/fototimer/scripts

# clear variables
oldISO=0
ISOlvl=0
ISOstep=0
ISOcurrentSet=0

# let's go ...
echo "wait ... (communicate with photocamera)"
echo "try to show abilities:"
gphoto2 -a

# get current ISO step
echo "get current ISO speed"
ISOcurrentSet="$(./getiso.sh)"
echo "current:$ISOcurrentSet"

# set ISO settings for testing
echo "set ISO speed to 1600"
gphoto2 --set-config iso=1600

# get new ISO step
echo "get new ISO speed"
ISOstep="$(./getiso.sh)"
echo "now:$ISOstep"

# set default ISO settings back to current
echo "set ISO speed back to $ISOcurrentSet"
gphoto2 --set-config iso=$ISOcurrentSet

# config serial communication
echo "init seriel communication"
stty -F /dev/ttyATH0 ispeed 9600 ospeed 9600 -ignpar cs8 -cstopb -echo -hupcl

# get current ISO step again and tell arduino
echo "get current ISO speed and tell arduino"
ISOstep="$(./getiso.sh)"
ISOcode="$(./encodeisolevel.sh $ISOstep)"
echo "current:$ISOstep"
echo "ISO$ISOcode" > /dev/ttyATH0
oldISO=$ISOstep


# last message before
echo "start ISO level remote control"

while read line 
	do
		
	case "$line" in
		ISO) ISOstep="$(./getiso.sh)" # for the high ligthning error on gedit"
		   ISOcode="$(./encodeisolevel.sh $ISOstep)"
		   echo "get ISO: $ISOstep"
		   echo "ISO$ISOcode" > /dev/ttyATH0
		   oldISO=$ISOstep
		;;
		
		0) ISOlvl="$(./setiso.sh '50' $oldISO)"
		   echo "ISO$(./encodeisolevel.sh $ISOlvl)" > /dev/ttyATH0
		   echo "set ISO:50"
		   oldISO=$ISOlvl
		;;		
		1) ISOlvl="$(./setiso.sh '100' $oldISO)"
		   echo "ISO$(./encodeisolevel.sh $ISOlvl)" > /dev/ttyATH0
		   echo "set ISO:100"
		   oldISO=$ISOlvl
		;;

		4) ISOlvl="$(./setiso.sh '200' $oldISO)"
		   echo "ISO$(./encodeisolevel.sh $ISOlvl)" > /dev/ttyATH0
		   echo "set ISO:200"
		   oldISO=$ISOlvl
		;;

		7) ISOlvl="$(./setiso.sh 400 $oldISO)"
		   echo "ISO$(./encodeisolevel.sh $ISOlvl)" > /dev/ttyATH0
		   echo "set ISO:400"
		   oldISO=$ISOlvl
		;;

		A) ISOlvl="$(./setiso.sh 800 $oldISO)"
		   echo "ISO$(./encodeisolevel.sh $ISOlvl)" > /dev/ttyATH0
		   echo "set ISO:800"
		   oldISO=$ISOlvl
		;;

		D) ISOlvl="$(./setiso.sh 1600 $oldISO)"
		   echo "ISO$(./encodeisolevel.sh $ISOlvl)" > /dev/ttyATH0
		   echo "set ISO:1600"
		   oldISO=$ISOlvl
		;;

		E) ISOlvl="$(./setiso.sh 3200 $oldISO)"
		   echo "ISO$(./encodeisolevel.sh $ISOlvl)" > /dev/ttyATH0
		   echo "set ISO:3200"
		   oldISO=$ISOlvl
		;;
		
		"FototimerYun serial communication started") echo -e "\033[32mcommunication with Fototimer estabilshed\033[0m"
		   ISOcode="$(./encodeisolevel.sh $ISOstep)"
		   echo "$ISOcode" > /dev/ttyATH0
		   oldISO=$ISOstep						
		   echo "current ISO: $ISOstep"
		;;
		
		Debug:*) echo -e "\033[34m$line\033[0m"
		;;
		
		Log:*) echo "$line" >> /mnt/sda1/fototimer/log/framelog.txt
		;;
		
		poweroff) echo "power off ..."
		reboot
		break
		;;

		*) echo -e "\033[31mreceived and ignored unknown command: \033[1m»$line«\033[0m"
		;;
	esac
done < /dev/ttyATH0


# message
echo "ISO level remote control stoped"
# ... til the end
echo "Good bye!"
