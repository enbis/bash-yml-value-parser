#!/bin/bash

_get_config_value() {
    # IFS=':' 
    # value=$(cat config_2.yml | grep $1)

    # echo $value

    # IFS=':' read -r -a array <<< "$value"

    # res="$(echo -e "${array[1]}" | tr -d '[:space:]')"

    # echo ${res}
    count_lines="0"

    cat config_2.yml | while read line; do
        #v="$(echo $line | tr --delete :)"
        echo "$line"
        count_lines=$(($count_lines+1))
        if [[ "$line" == $1* ]]; then
            # IFS=':' read -r -a array <<< "$line"
            # res="$(echo -e "${array[1]}" | tr -d '[:space:]')"
            read ADDR1 ADDR2 <<< $(IFS=":"; echo $line)
            echo ${ADDR1}
            echo ${ADDR2}
            if test -z $ADDR2; then
                iteration "$count_lines"
            else 
                echo ${ADDR2}
                echo $count_lines
            fi
            break
        fi
    done

    # if [ -z "${res}"]
    # then
    #     res=()
    #     top=false
    #     cat config_2.yml | while read line; do
    #         echo $line
    #         if [[ $line = $1 ]] 
    #         then
    #             echo "trovato"
    #             $top=true 
    #             continue
    #         fi
    #         if [[ "$top"=true ]] 
    #         then
    #             res+=$line
    #             echo $line
    #         fi
    #     done
    #     echo ${res}
    # else
	#     echo ${res}
    # fi
}

iteration()
{   
    echo "iteration from line $1"
}

$*