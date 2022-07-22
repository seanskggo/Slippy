#!/usr/bin/env python3

######################################################
# Sed Command Parser Class
######################################################

class SedParser():
    def __init__(self, sed):
        self.valid_postfix = ['q', 'p', 'd']
        self.valid_prefix = ['s']

        # Split sed command into chunks
        commands = sed.split(';')

        # if len(arg_list) < 1:
        #     print("slippy: command line: invalid command")
        #     exit(1)

