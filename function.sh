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
    number_of_lines=$(cat config_2.yml | wc -l)
    for i in $(seq 1 $number_of_lines)
    do
        counter=$(($counter+1))
        if [[ $counter -gt $1 ]]; then
            line=$(sed "${counter}q;d" config_2.yml)
            if [[ $line = *\t* ]]; then
                array[$i]=$line
                i=$(($i+1))
            fi
        fi
    done
    echo ${array[@]}
}

$*