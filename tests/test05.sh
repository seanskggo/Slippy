#!/bin/dash

######################################################################
# Test Script No. 5
# Subset 1
# 
# Testing commands:
# => multiple commands
#
# ASSUMES ALL RELEVANT SLIPPY FILES ARE IN PATH
######################################################################

######################################################################
# User Slippy Response File
######################################################################

test_commands () {

    mkdir temp && cp slippy args_parser.py sed_parser.py temp && cd temp || exit

    echo "test" | ./slippy 'q'

    cd .. && rm -rf temp

}

######################################################################
# Expected Slippy Response File
######################################################################

make_answers () {

    mkdir temp && cd temp || exit

    echo "test" | 2041 slippy 'q'

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