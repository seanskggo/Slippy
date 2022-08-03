#!/bin/dash

######################################################################
# Test Script No. 4
# Subset 1
# 
# Testing commands:
# => -f option & input files
#
# ASSUMES ALL RELEVANT SLIPPY FILES ARE IN PATH
######################################################################

######################################################################
# User Slippy Response File
######################################################################

test_commands () {

    mkdir temp && cp slippy args_parser.py sed_parser.py temp && cd temp || exit

    # -f option tests
    echo "3p" > commands.slippy
    seq 1 5                 | ./slippy -f commands.slippy        # normal -f test 
    echo "3,7p" > commands.slippy
    seq 1 50                | ./slippy -f commands.slippy        # range -f test 
    echo "3p;10q" > commands.slippy
    seq 1 50                | ./slippy -f commands.slippy        # multiple commands -f test 
    echo -e "\n3p" > commands.slippy
    seq 1 50                | ./slippy -f commands.slippy        # new line first -f test 
    echo "%%#%%^%" > commands.slippy
    seq 1 50                | ./slippy -f commands.slippy        # invalid -f test 
    echo -e "\n\n\n\n" > commands.slippy
    seq 1 50                | ./slippy -f commands.slippy        # new line only -f test 
    echo "3p" >> commands.slippy
    echo "/4/p" >> commands.slippy
    echo "30q" >> commands.slippy
    seq 1 50                | ./slippy -f commands.slippy        # multiple line -f test 
    echo "3p ## comment" > commands.slippy
    seq 1 50                | ./slippy -f commands.slippy        # comments -f test 
    echo "/../s/3//" > commands.slippy
    seq 1 50                | ./slippy -f commands.slippy        # regex -f test 

    # Input files test
    seq 1 50 > input.slippy
    ./slippy '3p' input.slippy                                   # normal input test 
    rm input.slippy && touch input.slippy
    ./slippy '3p' input.slippy                                   # empty input test 
    seq 1 50 > input.slippy
    seq 1 10 | ./slippy '/3/p' input.slippy                      # test pipe and input simultaneously  
    seq 1 50 > input.slippy
    ./slippy '/^..$/p' input.slippy                              # regex input test
    seq 1 50 > input.slippy
    ./slippy '%%^$' input.slippy                                 # invalid command test

    cd .. && rm -rf temp

}

######################################################################
# Expected Slippy Response File
######################################################################

make_answers () {

    mkdir temp && cd temp || exit

    # -f option tests
    echo "3p" > commands.slippy
    seq 1 5                 | 2041 slippy -f commands.slippy        # normal -f test 
    echo "3,7p" > commands.slippy
    seq 1 50                | 2041 slippy -f commands.slippy        # range -f test 
    echo "3p;10q" > commands.slippy
    seq 1 50                | 2041 slippy -f commands.slippy        # multiple commands -f test 
    echo -e "\n3p" > commands.slippy
    seq 1 50                | 2041 slippy -f commands.slippy        # new line first -f test 
    echo "%%#%%^%" > commands.slippy
    seq 1 50                | 2041 slippy -f commands.slippy        # invalid -f test 
    echo -e "\n\n\n\n" > commands.slippy
    seq 1 50                | 2041 slippy -f commands.slippy        # new line only -f test 
    echo "3p" >> commands.slippy
    echo "/4/p" >> commands.slippy
    echo "30q" >> commands.slippy
    seq 1 50                | 2041 slippy -f commands.slippy        # multiple line -f test 
    echo "3p ## comment" > commands.slippy
    seq 1 50                | 2041 slippy -f commands.slippy        # comments -f test 
    echo "/../s/3//" > commands.slippy
    seq 1 50                | 2041 slippy -f commands.slippy        # regex -f test 

    # Input files test
    seq 1 50 > input.slippy
    2041 slippy '3p' input.slippy                                   # normal input test 
    rm input.slippy && touch input.slippy
    2041 slippy '3p' input.slippy                                   # empty input test 
    seq 1 50 > input.slippy
    seq 1 10 | 2041 slippy '/3/p' input.slippy                      # test pipe and input simultaneously  
    seq 1 50 > input.slippy
    2041 slippy '/^..$/p' input.slippy                              # regex input test
    seq 1 50 > input.slippy
    2041 slippy '%%^$' input.slippy                                 # invalid command test

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
    # echo "--------------- ANSWER ---------------"
    # cat a
    # echo "-------------- EXPECTED --------------"
    # cat b
    # echo "--------------------------------------"
fi

rm a b