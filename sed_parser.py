#!/usr/bin/env python3

######################################################
# Sed Command Parser Class
######################################################

import sys
import re

class SedParser():
    def __init__(self, sed):

        # Split sed command into chunks
        self.commands = sed.split(';')
        self.commands = list(map(format_command, self.commands))

    def get_commands(self):
        return self.commands

######################################################
# Command Fomatter
# => Given a sed command, returns an object with details
######################################################

def format_command(cmd):

    def return_command_object(cmd, val):
        if not is_convertible_to_int(val):
            return { "command": cmd, "value": val.strip('/'), "is_regex": True }
        elif int(val) > 0:
            return { "command": cmd, "value": int(val), "is_regex": False }
        else:
            throw_error()

    def return_sub_object(cmd, val):
        vals = val.split('/')
        if not (len(vals) == 4 and vals[0] == '' and vals[-1] == ''):
            throw_error()
        if vals[1] == '' and vals[2] == '':
            throw_error()
        return { "command": cmd, "value": 1, "is_regex": False, "src": vals[1], "dest": vals[2] }

    if cmd == '': 
        return { "command": '', "value": '', "is_regex": False }
    elif re.search('^(|[0-9]+|\/.+\/)p', cmd):
        pre, cmd, post = get_pre_and_postfix(cmd, 'p')
        return return_command_object(cmd, pre)
    elif re.search('^(|[0-9]+|\/.+\/)q', cmd):
        pre, cmd, post = get_pre_and_postfix(cmd, 'q')
        return return_command_object(cmd, pre)
    elif re.search('^(|[0-9]+|\/.+\/)d', cmd):
        pre, cmd, post = get_pre_and_postfix(cmd, 'd')
        return return_command_object(cmd, pre)
    elif re.search('^(|[0-9]+|\/.+\/)s\/.+\/\/', cmd):
        pre, cmd, post = get_pre_and_postfix(cmd, 's')
        return return_sub_object('s', cmd[1:])
    else:
        throw_error()
    
######################################################
# Helpers
######################################################

# Throw slippy error and exit
def throw_error():
    print("slippy: command line: invalid command", file=sys.stderr)
    exit(1)

# Check if string is convertible to int
def is_convertible_to_int(num):
    try:
        int(num)
    except ValueError:
        return False
    return True

# Given a command regex of form <prefix>command<postfix>, 
# return a tuple of three elements of (prefix, command, postfix)
# e.g. 2s/a// => (2, s, '/a//')
def get_pre_and_postfix(sed, cmd):
    prefix = re.search(f'^(|[0-9]+|\/.+\/){cmd}', sed)
    postfix = re.search('\/.+\/\/$', sed)
    return (
        prefix.group(1) if prefix else '', 
        cmd, 
        postfix.group() if postfix else ''
    )