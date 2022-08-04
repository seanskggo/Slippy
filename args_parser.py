#!/usr/bin/env python3

######################################################
# Argument Parser Class
######################################################

import sys
import re

class ArgsParser():
    def __init__(self, arg_list):
        if len(arg_list) < 1:
            print("usage: slippy [-i] [-n] [-f <script-file> | <sed-command>] [<files>...]", file=sys.stderr)
            sys.exit(1)

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
            code = 0
            try:
                commands = ''
                with open(file, 'r') as f: 
                    PREFIX = '(\$|[0-9]+|\/.*\/)'
                    for index, command in enumerate(f):
                        if not re.search(f'^(({PREFIX},)?({PREFIX})?[pqdsaic].*g?)?(#.*)?$', re.sub(' ', '', command)):
                            code = 1
                            sys.exit(1)
                        commands = commands + ';' + command 
                    commands = commands.strip(';')
            except:
                if code == 1:
                    print(f"slippy: file commands.slippy line {index + 1}: invalid command", file=sys.stderr)
                else:
                    print("slippy: error", file=sys.stderr)
                sys.exit(1)
            self.sed_command = commands
        else:
            commands = arg_list.pop(0)
            self.sed_command = commands

        self.sed_command = re.sub(' ', '', self.sed_command)
        self.sed_command = re.sub('#.*;', ';', self.sed_command)
        self.sed_command = re.sub('#.*', '', self.sed_command)
        self.sed_command = re.sub('\n', ';', self.sed_command)
        self.first_file = arg_list[0] if arg_list else None

        input = []
        for file in arg_list:
            with open(file, 'r') as f:
                for line in f:
                    input.append(line)
        self.files = input
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
        else:
            if self.files:
                return self.files.pop(0)
            else: 
                return ''

    def get_first_filename(self):
        return self.first_file