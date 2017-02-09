#!/bin/bash
#tag=$1
tag=$1 #'span' # $1
info=$2 #'amount' # $2
read line #'adad1<span class="amount">148</span>adad2<span class="amount">128</span>adad3' # $4
nr=$3 #1 # $3

echo $line |
  sed "s|<$tag[a-zA-Z0-9 _%=+\"-]*$info[a-zA-Z0-9 _%=+\"-]*>|\n|i$nr" |
  sed -n '2p' |
  sed "s|</$tag[a-zA-Z0-9 _%=+\"-]*>.*$||i" 
