#!/usr/bin/env python3

######################################################
# Constants
######################################################

PREFIX = '(\$|[0-9]+|\/.*\/)'
RANGE_PREFIX = f'({PREFIX},)?({PREFIX})?'

# Regexes for commands
P_COMMAND_REGEX = f'^{RANGE_PREFIX}p$'
Q_COMMAND_REGEX = f'^{RANGE_PREFIX}q$'
D_COMMAND_REGEX = f'^{RANGE_PREFIX}d$'
A_COMMAND_REGEX = f'^{RANGE_PREFIX}a.+$'
I_COMMAND_REGEX = f'^{RANGE_PREFIX}i.+$'
C_COMMAND_REGEX = f'^{RANGE_PREFIX}c.+$'
S_COMMAND_REGEX = f'^{RANGE_PREFIX}s.+g?$'

######################################################
# Sed Command Parser Class
#
# This class is responsible for parsing the sed 
# command and returning a dictionary consisting of 
# easily usable components for slippy.
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

def format_command(sed):

    # Format raw sed command
    def format_sed(sed, cmd, delimiter='/'):
        pre, cmd, post = get_pre_and_postfix(sed, cmd, delimiter)
        suffix = categorise_suffix(post, delimiter)
        if cmd in ['a', 'i', 'c']:
            suffix = re.search(f'^{RANGE_PREFIX}{cmd}(.+)$', sed).group(5).strip()
        return {
            "prefix": categorise_prefix(pre),
            "command": cmd,
            "postfix": suffix
        }

    # Validate s command postfix
    if re.search(S_COMMAND_REGEX, sed):
        d = replace_delimiter(re.search('s(\S).*g?$', sed).group(1))
        if not re.search(f'^{RANGE_PREFIX}s{d}.+{d}.*{d}g?$', sed):
            throw_error()

    # Handle cases
    if sed == '': return format_sed(sed, '')
    elif re.search(P_COMMAND_REGEX, sed): return format_sed(sed, 'p')
    elif re.search(Q_COMMAND_REGEX, sed): return format_sed(sed, 'q')
    elif re.search(D_COMMAND_REGEX, sed): return format_sed(sed, 'd')
    elif re.search(A_COMMAND_REGEX, sed): return format_sed(sed, 'a')
    elif re.search(I_COMMAND_REGEX, sed): return format_sed(sed, 'i')
    elif re.search(C_COMMAND_REGEX, sed): return format_sed(sed, 'c')
    elif re.search(S_COMMAND_REGEX, sed): return format_sed(sed, 's', d)
    else: throw_error()
    
######################################################
# Helper Functions
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
    try: int(num)
    except: return False
    return True

# Return filtered affix
def get_filtered_affix(affix, mod_affix):
    if not is_convertible_to_int(affix):
        if affix == '$': return { "affix": '$', "is_regex": False }
        else: return { "affix": mod_affix, "is_regex": True }
    elif int(affix) > 0:
        return { "affix": int(affix), "is_regex": False }
    throw_error()

# Given a command regex of form <prefix>command<postfix>, 
# return a tuple of three elements of (prefix, command, postfix)
# e.g. 2s/a// => (2, s, '/a//')
def get_pre_and_postfix(sed, cmd, d):
    d = replace_delimiter(d)
    prefix = re.search(f'^({RANGE_PREFIX}){cmd}', sed)
    postfix = re.search(f'{cmd}({d}.+{d}.*{d}g?)$', sed)
    
    return (
        prefix.group(1) if prefix else '', 
        cmd, 
        postfix.group(1) if postfix else ''
    )

# Given an prefix, categorise it into either a number or a regex
# and return the filtered result in an object
def categorise_prefix(affix):

    def get_prefix(affix):
        mod_affix = re.sub(f'\/(.*)\/', '\g<1>', affix)
        return get_filtered_affix(affix, mod_affix)

    if re.search(f'^{PREFIX},{PREFIX}$', affix):
        start = re.search(f'^({PREFIX}),', affix).group(1)
        end = re.search(f',({PREFIX})$', affix).group(1)
        return {
            "is_range": True,
            "start": get_prefix(start),
            "end": get_prefix(end)
        }

    return {
        "is_range": False,
        "start": get_prefix(affix)
    }

# Given a suffix, categorise it into either a number or a regex
# and return the filtered result in an object
def categorise_suffix(affix, d):
    mod_affix = re.sub(f'{d}(.*){d}', '\g<1>', affix).split(d[-1])
    return get_filtered_affix(affix, mod_affix)