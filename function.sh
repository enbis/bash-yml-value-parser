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
                retval=$(iteration $count_lines $1)
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
    iof=$(($1+1))
    number_of_lines=$(cat $2 | wc -l)

    for (( i=$iof; i<=$number_of_lines; i++))
    do  
        line=$(sed "${i}q;d" $2)
        if [[ $line != [[:blank:]]* ]]; then
            break
        else
            echo $line
        fi
    done
}

$*