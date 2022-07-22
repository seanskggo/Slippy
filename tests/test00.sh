#!/bin/dash

######################################################################
# Test Script No. 0
# Subset 0 
# 
# Testing commands:
# - q - quit command
######################################################################

######################################################################
# User Slippy Response File
######################################################################

test_commands () {

    mkdir temp && cd temp || exit

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
    diff a b 
fi

rm a b