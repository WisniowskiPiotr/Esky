#!/bin/bash
base_path="$HOME/bin/Esky"
towns_start="Towns_Start.txt"
towns_end="Towns_End.txt"
dates="Dates.txt"
price_limit=$1

#ot="OneWay"
ot="RoundTrip"

sc="economy"
pa=1
py=0
pc=0
pi=0

while read from           
do           
  from=$(echo $from | sed "s/ - .*//" )
	while read dest           
	do           
		dest=$(echo $dest | sed "s/ - .*//" )
		while read date        
		do           
			date_from=$(echo $date | sed "s/ - .*$//" )       
			date_dest=$(echo $date | sed "s/^.* - //" )

			tmp_file=$base_path/Esky_$from-$dest-$date_from-$date_dest.html

			if [ $ot = "RoundTrip" ]; then
				basic_query="https://www.esky.pl/flights/select/?ot=$ot&sc=$sc&tr[0][d]=($from)&tr[1][d]=($dest)&tr[0][a]=($dest)&tr[1][a]=($from)&tr[0][dd]=$date_from&tr[1][dd]=$date_dest&pa=$pa&py=$py&pc=$pc&pi=$pi"
			else
				basic_query="https://www.esky.pl/flights/select/?ot=$ot&sc=$sc&tr[0][d]=($from)&tr[0][a]=($dest)&tr[0][dd]=$date_from&pa=$pa&py=$py&pc=$pc&pi=$pi"
			fi

			rm -f -r $tmp_file
			phantomjs $base_path/save_page.js $basic_query >> $tmp_file
			

			price1=$(grep -i 'flight-details' $tmp_file | ./Get_tag.sh span amount 1 )
			price2=$(grep -i 'flight-details' $tmp_file | ./Get_tag.sh span amount 2 )
			price=$((price1+price2))
			echo "Searching on Esky $ot $from to $dest on $date_from - $date_dest - $price"
			#echo $price
			#if [ $price -le $price_limit ]; then
			#	echo "Found on Esky ---------------------------- price $price"
			#fi
		
		done <$base_path/$dates
	done <$base_path/$towns_end
done <$base_path/$towns_start 



