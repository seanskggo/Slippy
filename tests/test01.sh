#!/bin/dash

######################################################################
# Test Script No. 1
# Subset 0 
# 
# Testing commands:
# => d & s command
#
# ASSUMES ALL RELEVANT FILES FRO SLIPPY ARE IN PATH
######################################################################

######################################################################
# User Slippy Response File
######################################################################

test_commands () {

    mkdir temp && cp slippy args_parser.py sed_parser.py temp && cd temp || exit

    seq 1 10    | ./slippy 'hd'         # error check 
    seq 1 10    | ./slippy '*d'         # error check 
    seq 1 10    | ./slippy '^d'         # error check 

    echo "test" | ./slippy 'd'          # normal case
    echo ""     | ./slippy 'd'          # empty case
    seq 1 10    | ./slippy 'd'          # sequence 
    seq 1 10    | ./slippy '4d'         # sequence end at 4th line
    seq 1 20    | ./slippy '/2./d'      # sequence with regex quit at 20
    seq 1 100   | ./slippy '/^.+5$/d'   # complex regex
    seq 1 20    | ./slippy '/%%%/d'     # invalid regex

    echo "test" | ./slippy 'd'          # normal case
    echo ""     | ./slippy 'd'          # empty case
    seq 1 10    | ./slippy 'd'          # sequence 
    seq 1 10    | ./slippy '4d'         # sequence print additional 4th line
    seq 1 20    | ./slippy '/2./d'      # sequence print additional for 20s
    seq 1 100   | ./slippy '/^.+5$/d'   # complex regex
    seq 1 20    | ./slippy '/%%%/d'     # invalid regex

    cd .. && rm -rf temp

}

######################################################################
# Expected Slippy Response File
######################################################################

make_answers () {

    mkdir temp && cd temp || exit

    seq 1 10    | 2041 slippy 'hd'         # error check 
    seq 1 10    | 2041 slippy '*d'         # error check 
    seq 1 10    | 2041 slippy '^d'         # error check 

    echo "test" | 2041 slippy 'd'          # normal case
    echo ""     | 2041 slippy 'd'          # empty case
    seq 1 10    | 2041 slippy 'd'          # sequence 
    seq 1 10    | 2041 slippy '4d'         # sequence end at 4th line
    seq 1 20    | 2041 slippy '/2./d'      # sequence with regex quit at 20
    seq 1 100   | 2041 slippy '/^.+5$/d'   # complex regex
    seq 1 20    | 2041 slippy '/%%%/d'     # invalid regex

    echo "test" | 2041 slippy 'd'          # normal case
    echo ""     | 2041 slippy 'd'          # empty case
    seq 1 10    | 2041 slippy 'd'          # sequence 
    seq 1 10    | 2041 slippy '4d'         # sequence print additional 4th line
    seq 1 20    | 2041 slippy '/2./d'      # sequence print additional for 20s
    seq 1 100   | 2041 slippy '/^.+5$/d'   # complex regex
    seq 1 20    | 2041 slippy '/%%%/d'     # invalid regex

    cd .. && rm -rf temp

}

######################################################################
# Outcome
######################################################################

test_commands > a 2>&1
make_answers > b 2>&1

if [ -z "$(diff a b)" ]
then 
    echo "PASSED"
else
    echo "FAILED"
    echo "--------------- ANSWER ---------------"
    cat a
    echo "-------------- EXPECTED --------------"
    cat b
    echo "--------------------------------------"
fi

rm a b