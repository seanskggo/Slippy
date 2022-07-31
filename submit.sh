mkdir temp_submit
cp slippy tests/* args_parser.py sed_parser.py  temp_submit
cd temp_submit
give cs2041 ass2_slippy slippy test??.sh args_parser.py sed_parser.py 
cd ..
rm -rf temp_submit
