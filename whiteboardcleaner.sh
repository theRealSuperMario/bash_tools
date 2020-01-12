#!/bin/bash


prepend_fname () {
	# usage : new_path=$(append_fname path prefix)
    # example : 
    #       new_path=$(prepend_fname $1 "test")
    #       echo $new_path
	local path=$1
	local prefix=$2
	local pardir=$(dirname $path)
	local fname=$(basename $path)
	local new_fname="$prefix$fname"
	local new_path="$pardir//$new_fname"
	echo "$new_path"
}

out=$(prepend_fname $1 "cleaned")

convert "$1" -morphology Convolve DoG:15,100,0 -negate -normalize -blur 0x1 -channel RBG -level 60%,91%,0.1 "$out"
