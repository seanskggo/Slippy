#!/bin/dash

######################################################################
# Test Script No. 0
# Subset 0 
# 
# Testing commands:
# => q & p command
#
# ASSUMES ALL RELEVANT FILES FRO SLIPPY ARE IN PATH
######################################################################

######################################################################
# User Slippy Response File
######################################################################

test_commands () {

    mkdir temp && cp slippy args_parser.py sed_parser.py temp && cd temp || exit

    seq 1 10    | ./slippy 'hq'         # error check 
    seq 1 10    | ./slippy '*q'         # error check 
    seq 1 10    | ./slippy '^q'         # error check 

    echo "test" | ./slippy 'q'          # normal case
    echo ""     | ./slippy 'q'          # empty case
    seq 1 10    | ./slippy 'q'          # sequence 
    seq 1 10    | ./slippy '4q'         # sequence end at 4th line
    seq 1 20    | ./slippy '/2./q'      # sequence with regex quit at 20
    seq 1 100   | ./slippy '/^.+5$/q'   # complex regex
    seq 1 20    | ./slippy '/%%%/q'     # invalid regex

    echo "test" | ./slippy 'p'          # normal case
    echo ""     | ./slippy 'p'          # empty case
    seq 1 10    | ./slippy 'p'          # sequence 
    seq 1 10    | ./slippy '4p'         # sequence print additional 4th line
    seq 1 20    | ./slippy '/2./p'      # sequence print additional for 20s
    seq 1 100   | ./slippy '/^.+5$/p'   # complex regex
    seq 1 20    | ./slippy '/%%%/p'     # invalid regex

    cd .. && rm -rf temp

}

######################################################################
# Expected Slippy Response File
######################################################################

make_answers () {

    mkdir temp && cd temp || exit

    seq 1 10    | 2041 slippy 'hq'          # error check 
    seq 1 10    | 2041 slippy '*q'          # error check 
    seq 1 10    | 2041 slippy '^q'          # error check 

    echo "test" | 2041 slippy 'q'           # normal case
    echo ""     | 2041 slippy 'q'           # empty case
    seq 1 10    | 2041 slippy 'q'           # sequence 
    seq 1 10    | 2041 slippy '4q'          # sequence end at 4th line
    seq 1 20    | 2041 slippy '/2./q'       # sequence with regex quit at 20
    seq 1 100   | 2041 slippy '/^.+5$/q'    # complex regex
    seq 1 20    | 2041 slippy '/%%%/q'      # invalid regex

    echo "test" | 2041 slippy 'p'           # normal case
    echo ""     | 2041 slippy 'p'           # empty case
    seq 1 10    | 2041 slippy 'p'           # sequence 
    seq 1 10    | 2041 slippy '4p'          # sequence print additional 4th line
    seq 1 20    | 2041 slippy '/2./p'       # sequence print additional for 20s
    seq 1 100   | 2041 slippy '/^.+5$/p'    # complex regex
    seq 1 20    | 2041 slippy '/%%%/p'      # invalid regex   

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