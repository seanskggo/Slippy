#!/bin/dash

######################################################################
# Test Script No. 5
# Subset 1
# 
# Testing commands:
# => multiple commands
#
# ASSUMES ALL RELEVANT SLIPPY FILES ARE IN PATH
#
# TEST MAY NOT ALL PASS AS THIS FEATURE WAS NOT COMPLETED
######################################################################

######################################################################
# User Slippy Response File
######################################################################

test_commands () {

    mkdir temp && cp slippy args_parser.py sed_parser.py temp && cd temp || exit

    seq 1 50                        | ./slippy '3p;9q'                  # normal test
    echo "3p" > commands.slippy
    echo "6p" >> commands.slippy
    seq 1 50                        | ./slippy -f commands.slippy       # test with input file 
    seq 1 50                        | ./slippy '%%%;3p'                 # invalid test (front)
    seq 1 50                        | ./slippy '3p;%%%'                 # invalid test (back)
    seq 1 50                        | ./slippy '/3/,/4/p;s/3//'         # range test (front)
    seq 1 50                        | ./slippy 's/3//;/3/,/4/p;'        # range test (back)
    seq 1 50                        | ./slippy '3,10s/3//;/3/,/4/p;'    # range test (all)
    seq 1 50                        | ./slippy '3p;5p;3d;s//4/'         # chaining
    seq 1 50                        | ./slippy '3p;   5p  ;  3 d   '    # test with spacing
    seq 1 50                        | ./slippy '3p;5p;3d;'              # test with trailing ;
    seq 1 50                        | ./slippy '3p;   5p  ;  3 d   ;'   # test with spacing and trailing ; 
    seq 1 50                        | ./slippy ';3p;   5p  ;  3 d'      # test with spacing and leading ;
    seq 1 50                        | ./slippy ';3p;5p;3d;'             # test with trailing and leading ;
    seq 1 50                        | ./slippy '; 3  p ; 5 p ; 3d;'     # test with trailing and leading ; with spacing
    seq 1 50                        | ./slippy '3p;5p;3d # comment'     # test with trailing and leading ;

    cd .. && rm -rf temp

}

######################################################################
# Expected Slippy Response File
######################################################################

make_answers () {

    mkdir temp && cd temp || exit

    seq 1 50                        | 2041 slippy '3p;9q'                  # normal test
    echo "3p" > commands.slippy
    echo "6p" >> commands.slippy
    seq 1 50                        | 2041 slippy -f commands.slippy       # test with input file 
    seq 1 50                        | 2041 slippy '%%%;3p'                 # invalid test (front)
    seq 1 50                        | 2041 slippy '3p;%%%'                 # invalid test (back)
    seq 1 50                        | 2041 slippy '/3/,/4/p;s/3//'         # range test (front)
    seq 1 50                        | 2041 slippy 's/3//;/3/,/4/p;'        # range test (back)
    seq 1 50                        | 2041 slippy '3,10s/3//;/3/,/4/p;'    # range test (all)
    seq 1 50                        | 2041 slippy '3p;5p;3d;s//4/'         # chaining
    seq 1 50                        | 2041 slippy '3p;   5p  ;  3 d   '    # test with spacing
    seq 1 50                        | 2041 slippy '3p;5p;3d;'              # test with trailing ;
    seq 1 50                        | 2041 slippy '3p;   5p  ;  3 d   ;'   # test with spacing and trailing ; 
    seq 1 50                        | 2041 slippy ';3p;   5p  ;  3 d'      # test with spacing and leading ;
    seq 1 50                        | 2041 slippy ';3p;5p;3d;'             # test with trailing and leading ;
    seq 1 50                        | 2041 slippy '; 3  p ; 5 p ; 3d;'     # test with trailing and leading ; with spacing
    seq 1 50                        | 2041 slippy '3p;5p;3d # comment'     # test with trailing and leading ;
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