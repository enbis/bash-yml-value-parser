#!/bin/bash

_get_config_value() {

    case $1 in
        *"."*)
            echo "contains dot";;
        *)
            elaboration $1;;
    esac
}

elaboration()
{
    count_lines="0"
    cat config_2.yml | while read line; do
        #v="$(echo $line | tr --delete :)"
        count_lines=$(($count_lines+1))
        if [[ "$line" == $1* ]]; then
            read ADDR1 ADDR2 <<< $(IFS=":"; echo $line)
            if test -z $ADDR2; then
                retval=$(iteration $count_lines)
                echo $retval
            else 
                echo ${ADDR2}
            fi
            break
        fi
    done
}

iteration()
{
    counter="0"
    i=0
    eof=0
    cat config_2.yml | while read -r line; do
        counter=$(($counter+1))
        if [[ $counter -gt $1 ]]; then
            if [[ $line = *-* ]]; then
                array[$i]=$line
                i=$(($i+1))
            else
                echo ${array[@]}
            fi
        fi
    done  
}

$*