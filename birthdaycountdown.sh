#!/bin/sh
echo "Welcome $USER"
echo "Enter STOP into month to exit"
echo "Enter Birth month(Int) (1 = January..12 = December)"
read birthmonth


while [ $birthmonth != "STOP" ]
do
	echo "Enter Birth day(Int)"
	read birthday
	offset=0
	if [ $# -gt 0 ]
	then
		offset=$1
		offset=$((offset*24*60*60))
		if [ $offset -gt 1296000 ]
		then
			offset=1296000
		fi
	fi
	#Get current Date and apply offset if it exists, then extract the month and day
	epochTime=$(date +%s)
	currentTime=$((epochTime+offset))
	month=$(date -d @$currentTime +%m)
	day=$(date -d @$currentTime +%d)
	year=$(date -d @$currentTime +%Y)

	if [ $month -eq 10 -a $day -eq 31 ]
	then
		echo "Happy Halloween"
	elif [ $month -eq 12 -a $day -eq 25 ]
	then
		echo "Merry Christmas"
	elif [ $month -eq 3 -a $day -eq 17 ]
	then
		echo "Happy St. Patrick's Day"
	elif [ $month -eq 7 -a $day -eq 1 ]
	then
		echo "Happy Canada Day"
	fi

	if [ $month -eq $birthmonth -a $day -eq $birthday ]
	then
		echo "Happy Birthday"
	else
		if [ $birthmonth -gt $month ] || [ $birthmonth -eq $month -a $birthday -gt $day ]
		then
			secondsTill=$(date -d "$year-$birthmonth-$birthday" +%s)
			daysTill=$(((secondsTill-currentTime)/60/60/24))
			echo "$daysTill day(s) till your next birthday"
		else
			year=$((year+1))
			secondsTill=$(date -d "$year-$birthmonth-$birthday" +%s)
			daysTill=$(((secondsTill-currentTime)/60/60/24))
			echo "$daysTill day(s) till your next birthday"
		fi
	fi
	echo "Enter STOP into month to exit"
	echo "Enter Birth month(Int) (1 = January..12 = December)"
	read birthmonth

done

exit 0