#!/usr/bin/env python3

######################################################
# Sed Command Parser Class
######################################################

import sys

class SedParser():
    def __init__(self, sed):

        # Split sed command into chunks
        self.commands = sed.split(';')

        self.commands = list(map(format_command, self.commands))

        # if len(arg_list) < 1:
        #     print("slippy: command line: invalid command")
        #     exit(1)

    def get_commands(self):
        return self.commands

######################################################
# Command Fomatter
# - Given a sed command, returns an object with details
######################################################

def format_command(cmd):

    valid_postfix = ['q', 'p', 'd']
    valid_prefix = ['s']

    # Case 1: p
    if cmd[-1] == 'p':
        return 'p'
    elif cmd[-1] == 'q':
        return 'q'  
    elif cmd[-1] == 'd':
        return 'd'
    elif cmd[0] == 's':
        return 's'
    else:
        print("slippy: command line: invalid command", file=sys.stderr)
        exit(1)
    