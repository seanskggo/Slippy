#!/usr/bin/env python3

######################################################
# Constants
######################################################

######################################################
# Constants
######################################################

PREFIX = '(\$|[0-9]+|\/.*\/)'
COMMAND_REGEX = f'^(({PREFIX},)?({PREFIX})?[pqdsaic].*g?)?(#.*)?$'

######################################################
# Argument Parser Class
######################################################

import sys
import re
import os

class ArgsParser():
    def __init__(self, arg_list):

        if len(arg_list) < 1: throw_usage_error()

        self.replace_file_with_output = False
        self.print_input_lines = True
        self.sed_command = None
        self.files = []
        self.is_stdin = False
        self.first_file = None

        if '-i' in arg_list:
            arg_list.pop(0)
            self.replace_file_with_output = True

        if '-n' in arg_list:
            arg_list.pop(0)
            self.print_input_lines = False

        if '-f' in arg_list:
            arg_list.pop(0)
            file = arg_list.pop(0)
            self.sed_command = get_commands_from_file(file)
        else:
            commands = arg_list.pop(0)
            self.sed_command = commands

        self.sed_command = re.sub(' ', '', self.sed_command)
        self.sed_command = re.sub('#.*;', ';', self.sed_command)
        self.sed_command = re.sub('#.*', '', self.sed_command)
        self.sed_command = re.sub('\n', ';', self.sed_command)
        self.first_file = arg_list[0] if arg_list else None
        self.files = get_input_from_files(arg_list)
        if not self.files and len(arg_list) == 0:
            self.is_stdin = True

    def should_replace_file_with_output(self):
        return self.replace_file_with_output

    def should_print_input_lines(self): 
        return self.print_input_lines

    def get_sed_command(self):
        return self.sed_command

    def get_file_inputs(self):
        return self.files

    def get_next_line(self):
        if self.is_stdin:
            line = sys.stdin.readline()
            return line if line else None
        if self.files: return self.files.pop(0)
        else:  return ''

    def get_first_filename(self):
        return self.first_file

######################################################
# Helper Functions
######################################################

def throw_usage_error():
    print("usage: slippy [-i] [-n] [-f <script-file> | <sed-command>] [<files>...]", file=sys.stderr)
    sys.exit(1)

def throw_command_error(index):
    print(f"slippy: file commands.slippy line {index + 1}: invalid command", file=sys.stderr)
    sys.exit(1)

def throw_generic_error():
    print("slippy: error", file=sys.stderr)
    sys.exit(1)

def get_input_from_files(files):
    input = []
    for file in files:
        with open(file, 'r') as f:
            for line in f:
                input.append(line)
    return input

def get_commands_from_file(file):
    if not os.path.isfile(file): throw_generic_error()
    commands = ''
    with open(file, 'r') as f: 
        for index, command in enumerate(f):
            if not re.search(COMMAND_REGEX, re.sub(' ', '', command)):
                throw_command_error(index)
            commands = commands + ';' + command 
        commands = commands.strip(';')
    return commands