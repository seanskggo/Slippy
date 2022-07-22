#!/usr/bin/env python3

######################################################
# Argument Parser Class
######################################################

class ArgsParser():
    def __init__(self, arg_list):

        if len(arg_list) < 1:
            print("usage: slippy [-i] [-n] [-f <script-file> | <sed-command>] [<files>...]")
            exit(1)

        self.replace_file_with_output = False
        self.print_input_lines = True
        self.sed_command = None
        self.files = []

        # If -i is enabled
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
                print("slippy: error")
                exit(1)
            self.sed_command = command
        else:
            command = arg_list.pop(0)
            self.sed_command = command

        self.files = arg_list

    def getyaboi(self):
        print(self.replace_file_with_output)
        print(self.print_input_lines)
        print(self.sed_command)
        print(self.files)