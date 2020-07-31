#!/bin/bash

# AHTFinder.sh
# 
# Made using Xcode :O
# Created by Maxim Coppieters on 29/07/20.
# Copyright 2020 Maxim Coppieters. All rights reserved.

# Some prerequisite variables
hwModel=$( sysctl hw.model | awk '{ print $2 }' )
boardID=$( ioreg -l | awk -F\" '/board-id/ { print $4 }' )
baseURL='http://download.info.apple.com/Apple_Hardware_Test'
selfDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cpuTemp=$( ${selfDir}/osx-cpu-temp )
ver="Version: 01.01"

printInfo () {
	printf -- '%s\n' "Current CPU temp:        ${cpuTemp}" \
		"Detected Hardware Model: ${hwModel}" \
		"Detected Board ID:       ${boardID}"
}

writeHeader () {
clear
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "@                          Apple Hardware Test Finder                          @"
echo "@                                                                              @"
echo "@                                $ver                                @"
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo
}

die () {
tput setaf 1
printf -- '[ERROR]: %s!n' "$(*)" >&2
tput sgr
case "$(1)" in
	(-x|--exit) exit 1 ;;
	(''|*) return 1 ;;
esac
}

unknownBoard () {
die "Your board ID has no linked download code. It might not be added yet."
#echo "err"
}

leaveScript() {
  printf -- '%s\n' ""
  printf -- '%s\n' "Thank you for using my script! Have a great day!"
  exit "${1:-0}"
}

parseDownloadCode () {
local downloadCode=${1}
writeHeader
#parseDownloadCode "${1:?No download code provided}"
printInfo
echo
echo "Your download code is: ${downloadCode}"
echo "Your download link is:"
echo "${baseURL}/${downloadCode}.dmg"
echo
while true; do
	read -p "Would you like to open this link in your default browser? " lnk
	case $lnk in
		[Yy]* ) 
			open "${baseURL}/${downloadCode}.dmg"
			break
			;;
		[Nn]* )
			echo
			echo "Click while holding [CTRL] to open the link."
			break
			;;
		* ) echo "Please enter Y or N";;
	esac
done
echo
leaveScript
}

parseMultiCodes () {
  printInfo
  echo
  echo "Multiple download codes have been found for this board ID."
  echo "Please choose one of them and report if one of them do not work."
  echo "This way, we can keep the best one. Thank you!"
  echo "Available download links are:"
  for code in "${@}"; do
    printf -- '%s\n' "${baseURL}/${code}.dmg"
  done
  echo
  echo "Click while holding CTRL to open the link."
}

mainCheckPart2 () {
writeHeader
case "$hwModel" in
	(iMac4,1)
		if [[ "${boardID}" == "3A103" ]]; then
			parseDownloadCode "018-2392-A"
		else
			unknownBoard
		fi
	;;
	(iMac5,1)
		if [[ "${boardID}" == "Mac-F4228EC8" ]]; then
			parseDownloadCode "018-2534-A"
		elif [[ "${boardID}" == "Mac-F42786A9" ]]; then
			parseDownloadCode "018-2533-A"
		else
			unknownBoard
		fi
	;;
	(iMac5,2)
		if [[ "${boardID}" == "Mac-F4218EC8" ]]; then
			parseMultiCodes 018-2535-A 018-2418-A 018-3254-A	
		else
			unknownBoard
		fi
	;;
	(iMac6,1)
		if [[ "${boardID}" == "Mac-F4218FC8" ]]; then
			parseDownloadCode "018-2579-A"
		else
			unknownBoard
		fi
	;;
	(iMac7,1)
		if [[ "${boardID}" == "Mac-F42386C8" ]]; then
			parseMultiCodes 018-2845-A 018-3169-A 018-3254-A
		elif [[ "${boardID}" == "Mac-F4238CC8" ]]; then
			parseMultiCodes 018-3169-A 018-3254-A 018-3169-A
		else
			unknownBoard
		fi
	;;
	(iMac8,1)
		if [[ "${boardID}" == "Mac-F226BEC8" ]]; then
			parseDownloadCode "022-3936-A"
		elif [[ "${boardID}" == "Mac-F227BEC8" ]]; then
			parseDownloadCode "022-3937-A"
		else
			unknownBoard
		fi
	;;
	(iMac9,1)
		if [[ "${boardID}" == "Mac-F2218EA9" ]]; then
			parseDownloadCode "022-4297-A"
		elif [[ "${boardID}" == "Mac-F2218EC8" ]]; then
			parseDownloadCode "022-4293-A"
		elif [[ "${boardID}" == "Mac-F2218FC8" ]]; then
			parseDownloadCode "022-4294-A"
		else
			unknownBoard
		fi
	;;
	(iMac10,1)
		if [[ "${boardID}" == "Mac-F2268CC8" ]]; then
			parseMultiCodes 022-4451-A 022-4647-A
		elif [[ "${boardID}" == "Mac-F2268DC8" ]]; then
			parseMultiCodes 022-4452-A 022-4644-A
		else
			unknownBoard
		fi
	;;
	(iMac11,2)
		if [[ "${boardID}" == "Mac-F2238AC8" ]]; then
			parseDownloadCode "022-4703-A"
		else
			unknownBoard
		fi
	;;
	(iMac11,3)
		if [[ "${boardID}" == "Mac-F2238BAE" ]]; then
			parseDownloadCode "022-4776-A"
		else
			unknownBoard
		fi
	;;
	(iMac12,1)
		if [[ "${boardID}" == "Mac-942B5BF58194151B" ]]; then
			parseMultiCodes 022-5090-A 022-5344-A 022-5348-A 022-6031-A
		else
			unknownBoard
		fi
	;;
	(iMac12,2)
		if [[ "${boardID}" == "Mac-942B59F58194171B" ]]; then
			parseMultiCodes 022-5091-A 022-5348-A
		else
			unknownBoard
		fi
	;;
	(iMac13,1)
		if [[ "${boardID}" == "Mac-00BE6ED71E35EB86" ]]; then
			parseDownloadCode "022-6031-A"
		else
			unknownBoard
		fi
	;;
	(iMac13,2)
		if [[ "${boardID}" == "Mac-FC02E91DDD3FA6A4" ]]; then
			parseDownloadCode "022-6031-A"
		else
			unknownBoard
		fi
	;;	
	(Macmini1,1)
		if [[ "${boardID}" == "3A102" ]]; then
			parseDownloadCode "018-2342-A"
		else
			unknownBoard
		fi
	;;
	(Macmini2,1)
		if [[ "${boardID}" == "Mac-F4208EAA" ]]; then
			parseMultiCodes 018-2886-A 018-3169-A 018-3254-A
		else
			unknownBoard
		fi
	;;
	(Macmini3,1)
		if [[ "${boardID}" == "Mac-F22C86C8" ]]; then
			parseDownloadCode "022-4292-A"
		else
			unknownBoard
		fi
	;;
	(Macmini4,1)
		if [[ "${boardID}" == "Mac-F2208EC8" ]]; then
			while true; do
				read -p "Do you have a server model? Server models have no optical drive. " serv
				case $serv in
					[Yy]* ) 
						parseDownloadCode "022-4739-A"
						break
						;;
					[Nn]* )
						parseDownloadCode "022-4706-A"
						break
						;;
					* ) echo "Please enter Y or N";;
				esac
			done
		else
			unknownBoard
		fi
	;;
	(Macmini5,1)
		if [[ "${boardID}" == "Mac-8ED6AF5B48C039E1" ]]; then
			parseDownloadCode "022-5207-A"
		else
			unknownBoard
		fi
	;;
	(Macmini5,2)
		if [[ "${boardID}" == "Mac-4BC72D62AD45599E" ]]; then
			parseDownloadCode "022-5207-A"
		else
			unknownBoard
		fi
	;;
	(Macmini6,1)
		if [[ "${boardID}" == "Mac-031AEE4D24BFF0B1" ]]; then
			parseDownloadCode "022-6031-A"
		else
			unknownBoard
		fi
	;;
	(Macmini6,2)
		if [[ "${boardID}" == "Mac-F65AE981FFA204ED" ]]; then
			parseDownloadCode "022-6031-A"
		else
			unknownBoard
		fi
	;;
	(MacPro1,1)
		if [[ "${boardID}" == "Mac-F4208DC8" ]]; then
			parseMultiCodes 018-2769-A 018-2418-A 018-3254-A
		else
			unknownBoard
		fi
	;;
	(MacPro2,1)
		if [[ "${boardID}" == "Mac-F4208DA9" ]]; then
			parseMultiCodes 018-2667-A 018-3169-A 018-3254-A
		
		else
			unknownBoard
		fi
	;;
	(MacPro3,1)
		if [[ "${boardID}" == "Mac-F42C88C8" ]]; then
			parseMultiCodes 018-3273-A 022-3843-A 022-4020-A
		else
			unknownBoard
		fi
	;;
	(MacPro4,1)
		if [[ "${boardID}" == "Mac-F221BEC8" ]]; then
			parseMultiCodes 022-5348-A 022-4149-A
		else
			unknownBoard
		fi
	;;
	(MacPro5,1)
		if [[ "${boardID}" == "Mac-F221BEC8" ]]; then
			parseMultiCodes 022-4831-A 022-5348-A
		else
			unknownBoard
		fi
	;;
	(MacBook2,1)
		if [[ "${boardID}" == "Mac-F4208CA9" ]]; then
			parseDownloadCode "018-2590-A"
		elif [[ "${boardID}" == "Mac-F4208CAA" ]]; then
			parseDownloadCode "018-2766-A"
		else
			unknownBoard
		fi
	;;
	(MacBook3,1)
		if [[ "${boardID}" == "Mac-F22788C8" ]]; then
			parseMultiCodes 018-3085-A 018-3254-A 018-3169-A
		else
			unknownBoard
		fi
	;;
	(MacBook4,1)
		if [[ "${boardID}" == "Mac-F22788A9" ]]; then
			parseDownloadCode "022-3862-A"
		else
			unknownBoard
		fi
	;;
	(MacBook5,1)
		if [[ "${boardID}" == "Mac-F42D89A9" ]]; then
			parseDownloadCode "022-4216-A"
		elif [[ "${boardID}" == "Mac-F42D89C8" ]]; then
			parseDownloadCode "022-4037-A"
		else
			unknownBoard
		fi
	;;
	(MacBook5,2)
		if [[ "${boardID}" == "Mac-F22788AA" ]]; then
			parseDownloadCode "022-4299-A"
		else
			unknownBoard
		fi
	;;
	(MacBook6,1)
		if [[ "${boardID}" == "Mac-F22C8AC8" ]]; then
			parseMultiCodes 022-4453-A 022-5348-A
		else
			unknownBoard
		fi
	;;
	(MacBook7,1)
		if [[ "${boardID}" == "Mac-F22C89C8" ]]; then
			parseMultiCodes 022-4705-A 022-5348-A
		else
			unknownBoard
		fi
	;;
	(MacBookPro1,1)
		if [[ "${boardID}" == "3A106" ]]; then
			parseDownloadCode "018-2398-A"
		elif [[ "${boardID}" == "3A107" ]]; then
			parseDownloadCode "018-2405-A"
		else
			unknownBoard
		fi
	;;
	(MacBookPro2,1)
		if [[ "${boardID}" == "Mac-F42189C8" ]]; then
			parseDownloadCode "018-2592-A"
		else
			unknownBoard
		fi
	;;
	(MacBookPro2,2)
		if [[ "${boardID}" == "Mac-F42187C8" ]]; then
			parseDownloadCode "018-2591-A"
		else
			unknownBoard
		fi
	;;
	(MacBookPro3,1)
		if [[ "${boardID}" == "Mac-F42388C8" ]]; then
			parseMultiCodes 018-2833-A 018-3169-A 018-3254-A
		elif [[ "${boardID}" == "Mac-F4238BC8" ]]; then
			parseMultiCodes 018-2770-A 018-3169-A 018-3254-A
		else
			unknownBoard
		fi
	;;
	(MacBookPro4,1)
		if [[ "${boardID}" == "Mac-F42C86C8" ]]; then
			parseDownloadCode "022-3832-A"
		elif [[ "${boardID}" == "Mac-F42C89C8" ]]; then
			parseDownloadCode "022-3833-A"
		else
			unknownBoard
		fi
	;;
	(MacBookPro5,1)
		if [[ "${boardID}" == "Mac-F42D86A9" ]]; then
			parseDownloadCode "022-4266-A"
		elif [[ "${boardID}" == "Mac-F42D86C8" ]]; then
			parseDownloadCode "022-4048-A"
		else
			unknownBoard
		fi
	;;
	(MacBookPro5,2)
		if [[ "${boardID}" == "Mac-F2268EC8" ]]; then
			parseDownloadCode "022-4217-A"
		else
			unknownBoard
		fi
	;;
	(MacBookPro5,3)
		if [[ "${boardID}" == "Mac-F22587C8" ]]; then
			parseDownloadCode "022-4343-A"
		else
			unknownBoard
		fi
	;;
	(MacBookPro5,4)
		if [[ "${boardID}" == "Mac-F22587A1" ]]; then
			parseDownloadCode "022-4344-A"
		else
			unknownBoard
		fi
	;;
	(MacBookPro5,5)
		if [[ "${boardID}" == "Mac-F2268AC8" ]]; then
			parseDownloadCode "022-4339-A"
		else
			unknownBoard
		fi
	;;
	(MacBookPro6,1)
		if [[ "${boardID}" == "Mac-F22589C8" ]]; then
			parseDownloadCode "022-4596-A"
		else
			unknownBoard
		fi
	;;
	(MacBookPro6,2)
		if [[ "${boardID}" == "Mac-F22586C8" ]]; then
			parseDownloadCode "022-4597-A"
		else
			unknownBoard
		fi
	;;
	(MacBookPro7,1)
		if [[ "${boardID}" == "Mac-F222BEC8" ]]; then
			parseDownloadCode "022-4653-A"
		else
			unknownBoard
		fi
	;;
	(MacBookPro8,1)
		if [[ "${boardID}" == "Mac-94245B3640C91C81" ]]; then
			parseMultiCodes 022-5052-A 022-5348-A
		else
			unknownBoard
		fi
	;;
	(MacBookPro8,2)
		if [[ "${boardID}" == "Mac-94245A3940C91C80" ]]; then
			parseMultiCodes 022-5053-A 022-5348-A
		else
			unknownBoard
		fi
	;;
	(MacBookPro8,3)
		if [[ "${boardID}" == "Mac-942459F5819B171B" ]]; then
			parseMultiCodes 022-5054-A 022-5348-A
		else
			unknownBoard
		fi
	;;
	(MacBookPro9,1)
		if [[ "${boardID}" == "Mac-4B7AC7E43945597E" ]]; then
			parseMultiCodes 022-5879-A 022-6031-A
		else
			unknownBoard
		fi
	;;
	(MacBookPro9,2)
		if [[ "${boardID}" == "Mac-6F01561E16C75D06" ]]; then
			parseMultiCodes 022-5879-A 022-6031-A
		elif [[ "${boardID}" == "Mac-7DF2A3B5E5D671ED" ]]; then
			parseDownloadCode "022-6031-A"
		else
			unknownBoard
		fi
	;;
	(MacBookPro10,1)
		if [[ "${boardID}" == "Mac-C3EC7CD22292981F" ]]; then
			parseMultiCodes 022-5882-A 022-6031-A
		else
			unknownBoard
		fi
	;;
	(MacBookPro10,2)
		if [[ "${boardID}" == "Mac-AFD8A9D944EA4843" ]]; then
			parseDownloadCode "022-6031-A"
		else
			unknownBoard
		fi
	;;
	(MacBookAir1,1)
		if [[ "${boardID}" == "Mac-F42C8CC8" ]]; then
			parseDownloadCode "018-3259-A"
		else
			unknownBoard
		fi
	;;
	(MacBookAir2,1)
		if [[ "${boardID}" == "Mac-F42D88C8" ]]; then
			parseDownloadCode "022-4114-A"
		else
			unknownBoard
		fi
	;;
	(MacBookAir3,1)
		if [[ "${boardID}" == "Mac-942452F5819B1C1B" ]]; then
			parseDownloadCode "022-4704-A"
		else
			unknownBoard
		fi
	;;
	(MacBookAir3,2)
		if [[ "${boardID}" == "Mac-942C5DF58193131B" ]]; then
			parseDownloadCode "022-4267-A"
		else
			unknownBoard
		fi
	;;
	(MacBookAir4,1)
		if [[ "${boardID}" == "Mac-C08A6BB70A942AC2" ]]; then
			parseDownloadCode "022-5205-A"
		else
			unknownBoard
		fi
	;;
	(MacBookAir4,2)
		if [[ "${boardID}" == "Mac-742912EFDBEE19B3" ]]; then
			parseDownloadCode "022-5205-A"
		else
			unknownBoard
		fi
	;;
	(MacBookAir5,1)
		if [[ "${boardID}" == "Mac-66F35F19FE2A0D05" ]]; then
			parseMultiCodes 022-5745-A 022-6031-A
		else
			unknownBoard
		fi
	;;
	(MacBookAir5,2)
		if [[ "${boardID}" == "Mac-2E6FAB96566FE58C" ]]; then
			parseMultiCodes 022-5745-A  022-6031-A
		else
			unknownBoard
		fi
	;;
	(Xserve1,1)
		if [[ "${boardID}" == "Mac-F4208AC8" ]]; then
			parseDownloadCode "018-3282-A"
		else
			unknownBoard
		fi
	;;
	(Xserve2,1)
		if [[ "${boardID}" == "Mac-F42289C8" ]]; then
			parseDownloadCode "018-3282-A"
		else
			unknownBoard
		fi
	;;
	(''|*)
      printf -- '%s\n' "We could not find a suitable download link." >&2
      printf -- '%s\n' "You might have a computer that does not support AHT" >&2
    ;;
  esac
}

# The main check and comparison
mainCheck () {
writeHeader
printInfo
echo
while true; do
	read -rp "Would you like to determine the AHT download link? " yn
	case $yn in
		([Yy]*) mainCheckPart2; break;;
		([Nn]*) leaveScript 0;;
		(*) echo "Please enter Y or N"
	esac
done
}

#Just show HW model and BoardID
justInfo () {
writeHeader
printInfo
leaveScript
}

# Step by step guide on using the modern Apple Diagnostics
getHelp () {
clear
echo "            Step by step guide on using the modern Apple Diagnostics            "
echo
echo "If your Mac was made after June 2013, it no longer has AHT. Running the"
echo "diagnostics is a little different"
echo
echo "STEP 1: SHUT DOWN"
echo "Completely shut down your computer"
echo
echo "STEP 2: STARTING DIAGNOSTICS"
echo "Power on your Mac and immediately hold down the 'D' key. If this does not work,"
echo "shut down again and try again holding the ALT/OPTION and 'D' keys. You should"
echo "see 'Starting Internet Recovery' or 'Diagnosing your computer'. Once you see"
echo "one of those, you can release the key and let the diagnostic tool run."
echo
echo "Done :]"
leaveScript
}

writeHeader
echo "Please Read!"
echo "This script determines the AHT version for Macs with AHT. These Macs were"
echo "introduced before June 2013."
echo "If your Mac was made before June 2013, this script should work and you can"
echo "continue"
echo "Another Note: Some Mac models could not be tested properly and have not been"
echo "implemented into the script. This is mostly the PowerMac, PowerBook,"
echo "iBook and some early versions of other models. You can find the download codes"
echo "for those in the README.md file on GitHub."
echo
read -s -n 1 -p "Press [ANY KEY] to continue..."
writeHeader
PS3='Choose an option: '
options=("Determine machine and links" "Just show me my Mac" "Help me diagnosing a newer Mac" "Quit")
COLUMNS=12
select opt in "${options[@]}"; do
	case $opt in
		"Determine machine and links")
			mainCheck
			break
			;;
		"Just show me my Mac")
			justInfo
			break
			;;
		"Help me diagnosing a newer Mac")
			echo "Get help"
			getHelp
			break
			;;
		"Quit")
			leaveScript
			;;
		*) echo "$REPLY is not a valid option. Please try again.";;
	esac
done
