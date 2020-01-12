#!/bin/bash

exportsvg2pdftex () {
	# usage : $(exportsvg2pdftex svgpath)
    local svgpath=$1
    local pardir=$(dirname $svgpath)
    local fname=$(basename $svgpath)
    fname="${fname%.*}"
    local pdfpath="$pardir//$fname.pdf"
    local svgpath="$pardir//$fname.svg"

    inkscape \
    -z -C \
    --export-pdf="$pdfpath" \
    --export-latex \
    --export-pdf-version=1.5 \
    "$svgpath"
}



if [ $# -eq 0 ]
then
        echo "Missing options!"
        echo "(run $(basename $0) -h for help)"
        exit 1
fi

if [ $# -eq 1 ]
then
        echo "Only argument provided!"
        echo "Assuming use as $(basename $0) -s $1"
        echo "(run $(basename $0) -h for help)"
        PASSED=$1
        if [[ -d $PASSED ]]; then
            echo "$PASSED is a not a file"
            exit 1
        fi
        echo "converting $PASSED to pdf and pdf_tex"
        $(exportsvg2pdftex $PASSED)
fi

PASSED=$2


while getopts "has" OPTION; do
        case $OPTION in

                a)
                        if [[ -f $PASSED ]]; then
	                        echo "$PASSED is not a directory"
                            exit 1
                        fi
                        for f in $PASSED/*.svg; do
                            echo "converting $f to pdf and pdf_tex"
                            $(exportsvg2pdftex $f);
                        done
                        ;;
                h)
                        echo "Usage:"
                        echo "$(basename $0) [-options] argument"
                        echo "$(basename $0) -h for help"
                        echo ""
                        echo "   -a dirname         to convert all .svg files in the provided directory"
                        echo "   -s filename.svg    to convert the provided svg file"
                        echo "   -h                 help (this output)"
                        exit 0
                        ;;
                s)
                        if [[ -d $PASSED ]]; then
	                        echo "$PASSED is a not a file"
                            exit 1
                        fi
                        echo "converting $PASSED to pdf and pdf_tex"
                        $(exportsvg2pdftex $PASSED)
                        ;;
        esac
done


# if [ $ECHO = "true" ]
# then
#         echo "Hello world";
# fi