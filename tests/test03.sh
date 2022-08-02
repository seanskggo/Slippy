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
    seq 1 10                | ./slippy 's/1/3/'                     # normal delimiter   
    seq 1 50                | ./slippy '5s/1/3/g'                   # normal line 5 substitute
    seq 1 50                | ./slippy 's/1/3/g'                    # global substitute
    seq 1 50                | ./slippy '/1./s/1/3/g'                # global regex substitute
    seq 1 10                | ./slippy 's+1+3+'                     # special delimiter   
    seq 1 50                | ./slippy '5s_1_3_g'                   # special delimiter with line 5 substitute
    seq 1 50                | ./slippy 's*1*3*g'                    # special global substitute
    seq 1 50                | ./slippy '/1./s^1^3^g'                # special global regex substitute
    seq 1 10                | ./slippy 's13'                        # no delimiter   

    # Address tests
    seq 1 10                | ./slippy '3p'                         # p case normal address test
    seq 1 10                | ./slippy '$p'                         # p case $ address test
    seq 1 10                | ./slippy '%p'                         # p case invalid test
    seq 1 10                | ./slippy '2,5p'                       # p case multiple address test
    seq 1 10                | ./slippy '&,5p'                       # p case multiple invalid address test (first)
    seq 1 10                | ./slippy '1,&p'                       # p case multiple invalid address test (last)
    seq 1 10                | ./slippy '$,5p'                       # p case multiple dollar address test (first)
    seq 1 10                | ./slippy '5,$p'                       # p case multiple dollar address test (last)

    seq 1 10                | ./slippy '3d'                         # d case normal address test
    seq 1 10                | ./slippy '$d'                         # d case $ address test
    seq 1 10                | ./slippy '%d'                         # d case invalid test
    seq 1 10                | ./slippy '2,5d'                       # d case multiple address test
    seq 1 10                | ./slippy '&,5d'                       # d case multiple invalid address test (first)
    seq 1 10                | ./slippy '1,&d'                       # d case multiple invalid address test (last)
    seq 1 10                | ./slippy '$,5d'                       # d case multiple dollar address test (first)
    seq 1 10                | ./slippy '5,$d'                       # d case multiple dollar address test (last)

    seq 1 10                | ./slippy '3s/2//'                     # s case normal address test
    seq 1 10                | ./slippy '$s/2//'                     # s case $ address test
    seq 1 10                | ./slippy '%s/2//'                     # s case invalid test
    seq 1 10                | ./slippy '2,5s/2//'                   # s case multiple address test
    seq 1 10                | ./slippy '&,5s/2//'                   # s case multiple invalid address test (first)
    seq 1 10                | ./slippy '1,&s/2//'                   # s case multiple invalid address test (last)
    seq 1 10                | ./slippy '$,5s/2//'                   # s case multiple dollar address test (first)
    seq 1 10                | ./slippy '5,$s/2//'                   # s case multiple dollar address test (last)

    # q command does not allow multiple addresses
    seq 1 10                | ./slippy '$q'                         # q case dollar 
    seq 1 10                | ./slippy '1,2q'                       # q case multiple 
    seq 1 10                | ./slippy '1,$q'                       # q case multiple dollar

    # Comments and white space tests
    seq 1 10                | ./slippy '3p #comment'                # p case comment
    seq 1 10                | ./slippy '3q #comment'                # q case comment
    seq 1 10                | ./slippy '3d #comment'                # d case comment
    seq 1 10                | ./slippy '3s/1// #comment'            # s case comment
    seq 1 10                | ./slippy '3p #comment#comment2'       # p case multiple comments
    seq 1 10                | ./slippy '3q #comment#comment2'       # q case multiple comments
    seq 1 10                | ./slippy '3d #comment#comment2'       # d case multiple comments
    seq 1 10                | ./slippy '3s/1// #comment#comment2'   # s case multiple comments
    seq 1 10                | ./slippy '3    p     #   comment'     # p case spaces
    seq 1 10                | ./slippy '3    q     #   comment'     # q case spaces
    seq 1 10                | ./slippy '3    d     #   comment'     # d case spaces
    seq 1 10                | ./slippy '3s/1//     #   comment'     # s case spaces

    cd .. && rm -rf temp

}

######################################################################
# Expected Slippy Response File
######################################################################

make_answers () {

    mkdir temp && cd temp || exit

    # Special delimiter tests
    seq 1 10                | 2041 slippy 's/1/3/'                     # normal delimiter   
    seq 1 50                | 2041 slippy '5s/1/3/g'                   # normal line 5 substitute
    seq 1 50                | 2041 slippy 's/1/3/g'                    # global substitute
    seq 1 50                | 2041 slippy '/1./s/1/3/g'                # global regex substitute
    seq 1 10                | 2041 slippy 's+1+3+'                     # special delimiter   
    seq 1 50                | 2041 slippy '5s_1_3_g'                   # special delimiter with line 5 substitute
    seq 1 50                | 2041 slippy 's*1*3*g'                    # special global substitute
    seq 1 50                | 2041 slippy '/1./s^1^3^g'                # special global regex substitute
    seq 1 10                | 2041 slippy 's13'                        # no delimiter   

    # Address tests
    seq 1 10                | 2041 slippy '3p'                         # p case normal address test
    seq 1 10                | 2041 slippy '$p'                         # p case $ address test
    seq 1 10                | 2041 slippy '%p'                         # p case invalid test
    seq 1 10                | 2041 slippy '2,5p'                       # p case multiple address test
    seq 1 10                | 2041 slippy '&,5p'                       # p case multiple invalid address test (first)
    seq 1 10                | 2041 slippy '1,&p'                       # p case multiple invalid address test (last)
    seq 1 10                | 2041 slippy '$,5p'                       # p case multiple dollar address test (first)
    seq 1 10                | 2041 slippy '5,$p'                       # p case multiple dollar address test (last)

    seq 1 10                | 2041 slippy '3d'                         # d case normal address test
    seq 1 10                | 2041 slippy '$d'                         # d case $ address test
    seq 1 10                | 2041 slippy '%d'                         # d case invalid test
    seq 1 10                | 2041 slippy '2,5d'                       # d case multiple address test
    seq 1 10                | 2041 slippy '&,5d'                       # d case multiple invalid address test (first)
    seq 1 10                | 2041 slippy '1,&d'                       # d case multiple invalid address test (last)
    seq 1 10                | 2041 slippy '$,5d'                       # d case multiple dollar address test (first)
    seq 1 10                | 2041 slippy '5,$d'                       # d case multiple dollar address test (last)

    seq 1 10                | 2041 slippy '3s/2//'                     # s case normal address test
    seq 1 10                | 2041 slippy '$s/2//'                     # s case $ address test
    seq 1 10                | 2041 slippy '%s/2//'                     # s case invalid test
    seq 1 10                | 2041 slippy '2,5s/2//'                   # s case multiple address test
    seq 1 10                | 2041 slippy '&,5s/2//'                   # s case multiple invalid address test (first)
    seq 1 10                | 2041 slippy '1,&s/2//'                   # s case multiple invalid address test (last)
    seq 1 10                | 2041 slippy '$,5s/2//'                   # s case multiple dollar address test (first)
    seq 1 10                | 2041 slippy '5,$s/2//'                   # s case multiple dollar address test (last)

    # q command does not allow2041 ultiple addresses
    seq 1 10                | 2041 slippy '$q'                         # q case dollar 
    seq 1 10                | 2041 slippy '1,2q'                       # q case multiple 
    seq 1 10                | 2041 slippy '1,$q'                       # q case multiple dollar

    # Comments and white space2041 ests
    seq 1 10                | 2041 slippy '3p #comment'                # p case comment
    seq 1 10                | 2041 slippy '3q #comment'                # q case comment
    seq 1 10                | 2041 slippy '3d #comment'                # d case comment
    seq 1 10                | 2041 slippy '3s/1// #comment'            # s case comment
    seq 1 10                | 2041 slippy '3p #comment#comment2'       # p case multiple comments
    seq 1 10                | 2041 slippy '3q #comment#comment2'       # q case multiple comments
    seq 1 10                | 2041 slippy '3d #comment#comment2'       # d case multiple comments
    seq 1 10                | 2041 slippy '3s/1// #comment#comment2'   # s case multiple comments
    seq 1 10                | 2041 slippy '3    p     #   comment'     # p case spaces
    seq 1 10                | 2041 slippy '3    q     #   comment'     # q case spaces
    seq 1 10                | 2041 slippy '3    d     #   comment'     # d case spaces
    seq 1 10                | 2041 slippy '3s/1//     #   comment'     # s case spaces

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