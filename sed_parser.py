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

    def get_commands(self):
        return self.commands

######################################################
# Command Fomatter
# - Given a sed command, returns an object with details
######################################################

def format_command(cmd):

    def throw_error():
        print("slippy: command line: invalid command", file=sys.stderr)
        exit(1)

    def return_command_object(cmd, val):
        if val == '':
            return { "command": cmd, "value": val, "is_regex": False }
        if is_cmd_a_regex(val):
            return { "command": cmd, "value": val,"is_regex": True }
        else:
            try: 
                return { "command": cmd, "value": int(val), "is_regex": False }
            except:
                throw_error()

    def is_cmd_a_regex(cmd):
        if len(cmd) >= 2 and cmd[0] == '/' and cmd[-1] == '/':
            return True
        else:
            return False

    def return_sub_object(cmd, val):
        vals = val.split('/')
        if not (len(vals) == 4 and vals[0] == '' and vals[-1] == ''):
            throw_error()
        return { "command": cmd, "src": vals[1], "dest": vals[2] }

    if cmd == '': 
        return { "command": '', "value": '', "is_regex": False }
    elif cmd[-1] == 'p':
        return return_command_object('p', cmd[:-1])
    elif cmd[-1] == 'q':
        return return_command_object('q', cmd[:-1])
    elif cmd[-1] == 'd':
        return return_command_object('d', cmd[:-1])
    elif cmd[0] == 's':
        return return_sub_object('s', cmd[1:])
    else:
        throw_error()
    