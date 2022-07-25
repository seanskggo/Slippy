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
            exit(1)

        self.replace_file_with_output = False
        self.print_input_lines = True
        self.sed_command = None
        self.files = []

        if '-i' in arg_list:
            arg_list.pop(0)
            self.replace_file_with_output = True

        if '-n' in arg_list:
            arg_list.pop(0)
            self.print_input_lines = False

        if '-f' in arg_list:
            arg_list.pop(0)
            file = arg_list.pop(0)
            try:
                with open(file, 'r') as f:
                    command = f.read()
            except:
                print("slippy: error", file=sys.stderr)
                sys.exit(1)
            self.sed_command = command
        else:
            command = arg_list.pop(0)
            self.sed_command = command

        self.sed_command = re.sub(' ', '', self.sed_command)
        self.sed_command = re.sub('#.*;', ';', self.sed_command)
        self.sed_command = re.sub('#.*', '', self.sed_command)
        self.files = arg_list

    def should_replace_file_with_output(self):
        return self.replace_file_with_output

    def should_print_input_lines(self): 
        return self.print_input_lines

    def get_sed_command(self):
        return self.sed_command

    def get_files(self):
        return self.files