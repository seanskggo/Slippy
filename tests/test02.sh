#!/bin/dash

######################################################################
# Test Script No. 2
# Subset 0 
# 
# Testing commands:
# => -n option
#
# ASSUMES ALL RELEVANT FILES FRO SLIPPY ARE IN PATH
######################################################################

######################################################################
# User Slippy Response File
######################################################################

test_commands () {

    mkdir temp && cp slippy args_parser.py sed_parser.py temp && cd temp || exit

    echo "test"             | ./slippy -n 'p'               # normal case (p)
    seq 1 10                | ./slippy -n 'p'               # sequence   
    seq 1 10                | ./slippy -n '*p'              # error - invalid command
    seq 1 50                | ./slippy -n '5p'              # no print with print on line 5
    seq 1 50                | ./slippy -n '/2.$/p'          # no print with regex
    seq 1 50                | ./slippy -n '/%%%/p'          # no print with invalid regex
    echo "ab\ncd\nef\ng\nh" | ./slippy -n '/2.$/p'          # no print with regex of string list (no match)
    echo "ab\ncd\nef\ng\nh" | ./slippy -n '/e+/p'           # no print with regex of string list (match)

    echo "test"             | ./slippy -n 'q'               # normal case (q)
    seq 1 10                | ./slippy -n 'q'               # sequence   
    seq 1 10                | ./slippy -n '*q'              # error - invalid command
    seq 1 50                | ./slippy -n '5q'              # no print with print on line 5
    seq 1 50                | ./slippy -n '/2.$/q'          # no print with regex
    seq 1 50                | ./slippy -n '/%%%/q'          # no print with invalid regex
    echo "ab\ncd\nef\ng\nh" | ./slippy -n '/2.$/q'          # no print with regex of string list (no match)
    echo "ab\ncd\nef\ng\nh" | ./slippy -n '/e+/q'           # no print with regex of string list (match)

    echo "test"             | ./slippy -n 's/1/3/'          # normal case (s)
    seq 1 10                | ./slippy -n 's/1/3/'          # sequence   
    seq 1 10                | ./slippy -n '*s/1/3/'         # error - invalid command
    seq 1 50                | ./slippy -n '5s/1/3/g'        # no print with print on line 5
    seq 1 50                | ./slippy -n '/2.$/s/1/3/g'    # no print with regex
    seq 1 50                | ./slippy -n '/%%%/s/1/3/'     # no print with invalid regex
    echo "ab\ncd\nef\ng\nh" | ./slippy -n '/2.$/s/1/3/'     # no print with regex of string list (no match)
    echo "ab\ncd\nef\ng\nh" | ./slippy -n '/e+/s/1/3/'      # no print with regex of string list (match)

    echo "test"             | ./slippy -n 'd'               # normal case (d)
    seq 1 10                | ./slippy -n 'd'               # sequence   
    seq 1 10                | ./slippy -n '*d'              # error - invalid command
    seq 1 50                | ./slippy -n '5d'              # no print with print on line 5
    seq 1 50                | ./slippy -n '/2.$/d'          # no print with regex
    seq 1 50                | ./slippy -n '/%%%/d'          # no print with invalid regex
    echo "ab\ncd\nef\ng\nh" | ./slippy -n '/2.$/d'          # no print with regex of string list (no match)
    echo "ab\ncd\nef\ng\nh" | ./slippy -n '/e+/d'           # no print with regex of string list (match)

    # Various postfix error case for s
    echo "test"             | ./slippy -n 's///'            # invalid source regex
    seq 1 10                | ./slippy -n 's'               # sequence   
    seq 1 10                | ./slippy -n '*s'              # error - invalid command
    seq 1 50                | ./slippy -n '5s'              # no print with print on line 5
    seq 1 50                | ./slippy -n '/2.$/s'          # no print with regex
    seq 1 50                | ./slippy -n '/%%%/s'          # no print with invalid regex
    echo "ab\ncd\nef\ng\nh" | ./slippy -n '/2.$/s'          # no print with regex of string list (no match)
    echo "ab\ncd\nef\ng\nh" | ./slippy -n '/e+/s'           # no print with regex of string list (match)

    cd .. && rm -rf temp

}

######################################################################
# Expected Slippy Response File
######################################################################

make_answers () {

    mkdir temp && cd temp || exit

    echo "test"             | 2041 slippy -n 'p'               # normal case (p)
    seq 1 10                | 2041 slippy -n 'p'               # sequence   
    seq 1 10                | 2041 slippy -n '*p'              # error - invalid command
    seq 1 50                | 2041 slippy -n '5p'              # no print with print on line 5
    seq 1 50                | 2041 slippy -n '/2.$/p'          # no print with regex
    seq 1 50                | 2041 slippy -n '/%%%/p'          # no print with invalid regex
    echo "ab\ncd\nef\ng\nh" | 2041 slippy -n '/2.$/p'          # no print with regex of string list (no match)
    echo "ab\ncd\nef\ng\nh" | 2041 slippy -n '/e+/p'           # no print with regex of string list (match)

    echo "test"             | 2041 slippy -n 'q'               # normal case (q)
    seq 1 10                | 2041 slippy -n 'q'               # sequence   
    seq 1 10                | 2041 slippy -n '*q'              # error - invalid command
    seq 1 50                | 2041 slippy -n '5q'              # no print with print on line 5
    seq 1 50                | 2041 slippy -n '/2.$/q'          # no print with regex
    seq 1 50                | 2041 slippy -n '/%%%/q'          # no print with invalid regex
    echo "ab\ncd\nef\ng\nh" | 2041 slippy -n '/2.$/q'          # no print with regex of string list (no match)
    echo "ab\ncd\nef\ng\nh" | 2041 slippy -n '/e+/q'           # no print with regex of string list (match)

    echo "test"             | 2041 slippy -n 's/1/3/'          # normal case (s)
    seq 1 10                | 2041 slippy -n 's/1/3/'          # sequence   
    seq 1 10                | 2041 slippy -n '*s/1/3/'         # error - invalid command
    seq 1 50                | 2041 slippy -n '5s/1/3/g'        # no print with print on line 5
    seq 1 50                | 2041 slippy -n '/2.$/s/1/3/g'    # no print with regex
    seq 1 50                | 2041 slippy -n '/%%%/s/1/3/'     # no print with invalid regex
    echo "ab\ncd\nef\ng\nh" | 2041 slippy -n '/2.$/s/1/3/'     # no print with regex of string list (no match)
    echo "ab\ncd\nef\ng\nh" | 2041 slippy -n '/e+/s/1/3/'      # no print with regex of string list (match)

    echo "test"             | 2041 slippy -n 'd'               # normal case (d)
    seq 1 10                | 2041 slippy -n 'd'               # sequence   
    seq 1 10                | 2041 slippy -n '*d'              # error - invalid command
    seq 1 50                | 2041 slippy -n '5d'              # no print with print on line 5
    seq 1 50                | 2041 slippy -n '/2.$/d'          # no print with regex
    seq 1 50                | 2041 slippy -n '/%%%/d'          # no print with invalid regex
    echo "ab\ncd\nef\ng\nh" | 2041 slippy -n '/2.$/d'          # no print with regex of string list (no match)
    echo "ab\ncd\nef\ng\nh" | 2041 slippy -n '/e+/d'           # no print with regex of string list (match)

    # Various postfix error case for s
    echo "test"             | 2041 slippy -n 's///'            # invalid source regex
    seq 1 10                | 2041 slippy -n 's'               # sequence   
    seq 1 10                | 2041 slippy -n '*s'              # error - invalid command
    seq 1 50                | 2041 slippy -n '5s'              # no print with print on line 5
    seq 1 50                | 2041 slippy -n '/2.$/s'          # no print with regex
    seq 1 50                | 2041 slippy -n '/%%%/s'          # no print with invalid regex
    echo "ab\ncd\nef\ng\nh" | 2041 slippy -n '/2.$/s'          # no print with regex of string list (no match)
    echo "ab\ncd\nef\ng\nh" | 2041 slippy -n '/e+/s'           # no print with regex of string list (match)

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