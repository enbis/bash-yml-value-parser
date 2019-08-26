#!/bin/bash

_get_config_value() {
    case $2 in
        *"."*)
            dotprocess $1 $2;;
        *)
            process $1 $2;;
    esac
}

dotprocess()
{
    extract=false
    first="$(cut -d'.' -f1 <<<"$2")"
    second="$(cut -d'.' -f2 <<<"$2")"
    res=$(process $1 $first)
    
    export IFS=" "
    
    for word in $res; do
        if $extract; then 
            echo $word
            break
        fi
        if [[ "$word" == $second* ]]; then
            extract=true
        fi
        
    done

}

process()
{
    count_lines="0"
    IFS=''
    cat $1 | while read line; do
        count_lines=$(($count_lines+1))
        if [[ $line == $2* ]] && [[ $line != [[:blank:]]* ]]; then
            
            IFS=": " read -ra ADDR <<< $line

            if test -z ${ADDR[1]}; then
                echo $count_lines 
                retval=$(iteration $count_lines)
                echo $retval
            else 
                echo ${ADDR[1]}
            fi

            break
        fi
    done
}

iteration()
{
    i=0
    eof=0
    number_of_lines=$(cat config_2.yml | wc -l)
    
    echo $number_of_lines
    for i in `seq 1 $number_of_lines` 
    do
        echo $i
        if [[ $i -gt $1 ]]; then
            line=$(sed "${i}q;d" config_2.yml)
            echo $line
            if [[ $line = *\t* ]]; then
                array[$i]=$line
                i=$(($i+1))
            fi
        fi
    done
    echo ${array[@]}
}

$*