for i in $(seq 0 9)
do 
    if [ -f tests/test0"$i".sh ]
    then
        echo "------- TEST $i -------"
        sh tests/test0"$i".sh
    fi
done