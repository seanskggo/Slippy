#!/bin/dash

######################################################################
# Test Script No. 3
# Subset 1
# 
# Testing commands:
# => s command & addresses & comments & white spaces
#
# ASSUMES ALL RELEVANT FILES FRO SLIPPY ARE IN PATH
######################################################################

######################################################################
# User Slippy Response File
######################################################################

test_commands () {

    mkdir temp && cp slippy args_parser.py sed_parser.py temp && cd temp || exit

    # Special delimiter tests
    seq 1 10                | ./slippy 's/1/3/'             # normal delimiter   
    seq 1 50                | ./slippy '5s/1/3/g'           # normal line 5 substitute
    seq 1 50                | ./slippy 's/1/3/g'            # global substitute
    seq 1 50                | ./slippy '/1./s/1/3/g'        # global regex substitute
    seq 1 10                | ./slippy 's+1+3+'             # special delimiter   
    seq 1 50                | ./slippy '5s_1_3_g'           # special delimiter with line 5 substitute
    seq 1 50                | ./slippy 's*1*3*g'            # special global substitute
    seq 1 50                | ./slippy '/1./s^1^3^g'        # special global regex substitute
    seq 1 10                | ./slippy 's13'             # no delimiter   

    # Address tests


    # Comments and white space tests


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