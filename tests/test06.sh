#!/bin/dash

######################################################################
# Test Script No. 6
# Subset 2
# 
# Testing commands:
# => -i option & a command
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

    # -i option tests
    seq 1 5 > input.slippy
    ./slippy -i /[24]/d input.slippy                    # normal -i test
    ./slippy -i /[24]/d nonexistent.slippy              # non-existent file -i test
    seq 1 50 > input.slippy
    ./slippy -i '3p' input.slippy                       # sequential modification -i test
    ./slippy -i '3d' input.slippy                       # sequential modification -i test
    ./slippy -i '3s/1//' input.slippy                   # sequential modification -i test
    ./slippy -i '7q' input.slippy                       # sequential modification -i test
    rm input.slippy && touch input.slippy               # empty file test

    # a command tests
    seq 1 50        | ./slippy '7a hello'               # normal a command test
    seq 1 50        | ./slippy '7ahello'                # no space a command test
    seq 1 50        | ./slippy '/4/a hello'             # regex a command test
    seq 1 50        | ./slippy '4,7a hello'             # range a command test
    seq 1 50        | ./slippy '/4/,/.7/a hello'        # regex range a command test
    seq 1 50        | ./slippy '2a hello;20q'           # multiple command a command test
    seq 1 50        | ./slippy '/.8/a hello;/.9/q'        # multiple regex command a command test

    cd .. && rm -rf temp

}

######################################################################
# Expected Slippy Response File
######################################################################

make_answers () {

    mkdir temp && cd temp || exit

    seq 1 5 > input.slippy
    2041 slippy -i /[24]/d input.slippy                    # normal -i test
    2041 slippy -i /[24]/d nonexistent.slippy              # non-existent file -i test
    seq 1 50 > input.slippy
    2041 slippy -i '3p' input.slippy                       # sequential modification -i test
    2041 slippy -i '3d' input.slippy                       # sequential modification -i test
    2041 slippy -i '3s/1//' input.slippy                   # sequential modification -i test
    2041 slippy -i '7q' input.slippy                       # sequential modification -i test
    rm input.slippy && touch input.slippy               # empty file test

    # a command tests
    seq 1 50        | 2041 slippy '7a hello'               # normal a command test
    seq 1 50        | 2041 slippy '7ahello'                # no space a command test
    seq 1 50        | 2041 slippy '/4/a hello'             # regex a command test
    seq 1 50        | 2041 slippy '4,7a hello'             # range a command test
    seq 1 50        | 2041 slippy '/4/,/.7/a hello'        # regex range a command test
    seq 1 50        | 2041 slippy '2a hello;20q'           # multiple command a command test
    seq 1 50        | 2041 slippy '/.8/a hello;/.9/q'        # multiple regex command a command test

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