#!/bin/bash
initialVal=0
gotomachine=""
for i in $(seq 1 15); do
    if (($i == 1)); then
        machine=$(printf "ckuruppu@novagpvm%02d.fnal.gov" $i)
        value=$(ssh ${machine} '(last -a | grep -i still | wc -l)')
        printf "\n The users on first machine is: %d" $value
        initialVal=$value
    fi
    if (($i != 3)); then
        machine=$(printf "ckuruppu@novagpvm%02d.fnal.gov" $i)
        value=$(ssh ${machine} '(last -a | grep -i still | wc -l)')
        printf "\n %s has users %d" $machine $value
        #echo $value
        if (($value <= $initialVal)); then
            initialVal=$value
            gotomachine=$machine
        fi
    fi
done
printf "\n The lowest number is: %d in machine: %s \n" $initialVal $gotomachine
ssh $gotomachine
