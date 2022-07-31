#!/usr/bin/env python3

######################################################
# Sed Command Parser Class
######################################################

import sys
import re

# Possible prefix regex
PREFIX = '(\$|[0-9]+|\/.*\/)'

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

def format_command(sed):

    def format_sed(sed, cmd, delimiter='/'):
        pre, cmd, post = get_pre_and_postfix(sed, cmd, delimiter)
        return {
            "prefix": categorise_prefix(pre),
            "command": cmd,
            "postfix": categorise_suffix(post, delimiter)
        }

    if sed == '': 
        return format_sed(sed, '')
    elif re.search(f'^({PREFIX},)?({PREFIX})?p$', sed):
        return format_sed(sed, 'p')
    elif re.search(f'^({PREFIX},)?({PREFIX})?q$', sed):
        return format_sed(sed, 'q')
    elif re.search(f'^({PREFIX},)?({PREFIX})?d$', sed):
        return format_sed(sed, 'd')
    elif re.search(f'^({PREFIX},)?({PREFIX})?s.*g?$', sed):
        d = re.search('s(\S).*g?$', sed).group(1)
        d = replace_delimiter(d)
        if not re.search(f'^({PREFIX},)?({PREFIX})?s{d}.+{d}.*{d}g?$', sed):
            throw_error()
        return format_sed(sed, 's', d)
    else:
        throw_error()
    
######################################################
# Helpers
######################################################

def replace_delimiter(d):
    if d in ['?', '.', '*', '^', '$', '+', '|', '{', '}', '\\']:
        return f'\{d}'
    return d

# Throw slippy error and exit
def throw_error():
    print("slippy: command line: invalid command", file=sys.stderr)
    sys.exit(1)

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
def get_pre_and_postfix(sed, cmd, d):
    d = replace_delimiter(d)
    prefix = re.search(f'^(({PREFIX},)?({PREFIX})?){cmd}', sed)
    postfix = re.search(f'{cmd}({d}.+{d}.*{d}g?)$', sed)
    return (
        prefix.group(1) if prefix else '', 
        cmd, 
        postfix.group(1) if postfix else ''
    )

# Given an affix, categorise it into either a number or a regex
# and return the filtered result in an object
def categorise_prefix(affix):
    def get_prefix(affix):
        if not is_convertible_to_int(affix):
            if affix == '$':
                return { "affix": '$', "is_regex": False }
            aff = re.sub(f'\/(.*)\/', '\g<1>', affix)
            return { "affix": aff, "is_regex": True }
        elif int(affix) > 0:
            return { "affix": int(affix), "is_regex": False }
        else:
            throw_error()
    if re.search(f'^{PREFIX},{PREFIX}$', affix):
        start = re.search(f'^({PREFIX}),', affix).group(1)
        end = re.search(f',({PREFIX})$', affix).group(1)
        return {
            "is_range": True,
            "start": get_prefix(start),
            "end": get_prefix(end)
        }
    else:
        return {
            "is_range": False,
            "start": get_prefix(affix)
        }

# Given an affix, categorise it into either a number or a regex
# and return the filtered result in an object
def categorise_suffix(affix, d):
    if not is_convertible_to_int(affix):
        if affix == '$':
            return { "affix": '$', "is_regex": False }
        aff = re.sub(f'{d}(.*){d}', '\g<1>', affix).split(d[-1])
        return { "affix": aff, "is_regex": True }
    elif int(affix) > 0:
        return { "affix": int(affix), "is_regex": False }
    else:
        throw_error()