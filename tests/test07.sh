#!/bin/dash

######################################################################
# Test Script No. 7
# Subset 2
# 
# Testing commands:
# => i & c command
#
# ASSUMES ALL RELEVANT SLIPPY FILES ARE IN PATH
#
# TESTS MAY NOT ALL PASS AS THIS SUBSET IS INCOMPLETE
######################################################################

######################################################################
# User Slippy Response File
######################################################################

test_commands () {

    mkdir temp && cp slippy args_parser.py sed_parser.py temp && cd temp || exit

    # i command tests
    seq 1 50        | ./slippy '7i hello'               # normal i command test
    seq 1 50        | ./slippy '7ihello'                # no space i command test
    seq 1 50        | ./slippy '/4/i hello'             # regex i command test
    seq 1 50        | ./slippy '4,7i hello'             # range i command test
    seq 1 50        | ./slippy '/4/,/.7/i hello'        # regex range i command test
    seq 1 50        | ./slippy '2i hello;20q'           # multiple command i command test
    seq 1 50        | ./slippy '/.8/i hello;/.9/q'      # multiple regex command i command test

    # c command tests
    seq 1 50        | ./slippy '7c hello'               # normal c command test
    seq 1 50        | ./slippy '7chello'                # no space c command test
    seq 1 50        | ./slippy '/4/c hello'             # regex c command test
    seq 1 50        | ./slippy '4,7c hello'             # range c command test
    seq 1 50        | ./slippy '/4/,/.7/c hello'        # regex range c command test
    seq 1 50        | ./slippy '2c hello;20q'           # multiple command c command test
    seq 1 50        | ./slippy '/.8/c hello;/.9/q'      # multiple regex command c command test

    cd .. && rm -rf temp

}

######################################################################
# Expected Slippy Response File
######################################################################

make_answers () {

    mkdir temp && cd temp || exit

    # i command tests
    seq 1 50        | 2041 slippy '7i hello'               # normal i command test
    seq 1 50        | 2041 slippy '7ihello'                # no space i command test
    seq 1 50        | 2041 slippy '/4/i hello'             # regex i command test
    seq 1 50        | 2041 slippy '4,7i hello'             # range i command test
    seq 1 50        | 2041 slippy '/4/,/.7/i hello'        # regex range i command test
    seq 1 50        | 2041 slippy '2i hello;20q'           # multiple command i command test
    seq 1 50        | 2041 slippy '/.8/i hello;/.9/q'      # multiple regex command i command test

    # c command tests
    seq 1 50        | 2041 slippy '7c hello'               # normal c command test
    seq 1 50        | 2041 slippy '7chello'                # no space c command test
    seq 1 50        | 2041 slippy '/4/c hello'             # regex c command test
    seq 1 50        | 2041 slippy '4,7c hello'             # range c command test
    seq 1 50        | 2041 slippy '/4/,/.7/c hello'        # regex range c command test
    seq 1 50        | 2041 slippy '2c hello;20q'           # multiple command c command test
    seq 1 50        | 2041 slippy '/.8/c hello;/.9/q'      # multiple regex command c command test

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