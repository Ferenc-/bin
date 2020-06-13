#!/usr/bin/env python3

import os
import re

from termcolor import cprint

def get_content(file_name):
    with open(file_name) as file:
        content = file.read()
        content.replace("\n", "")
        content.replace("\t", "")
        content.replace("\v", "")
        content.replace("\r", "")
        content.replace("  ", " ")
        content.replace("   ", " ")
        content.replace("    ", " ")
        return re.split(r'[.?!;]', content)

directory_to_be_checked = os.getcwd()
files_to_be_checked = os.listdir(directory_to_be_checked)

file_contents = [(i, get_content(i)) for i in files_to_be_checked]

for index, file in enumerate(file_contents):
    cprint(f'____ Checking {file[0]} ____', 'green')
    for other_file in file_contents[index+1:]:
        cprint(f'____________ Comparing it with file {other_file[0]} ____________', 'green')
        for sentence in file[1]:
            lower_sentence = sentence.lower().strip()
            if not lower_sentence:
                continue
            for other_sentence in other_file[1]:
                other_lower_sentence = other_sentence.lower().strip()
                if not other_lower_sentence:
                    continue
                if (lower_sentence in other_lower_sentence or
                        other_lower_sentence in lower_sentence):
                    cprint('____________ These two sentences are similar:____________', 'red', attrs=['bold'])
                    cprint(f'____{file[0]}:____', 'blue')
                    cprint(f'\t\t"{sentence}"\n')
                    cprint(f'_____{other_file[0]}:____', 'magenta')
                    cprint(f'\t\t"{other_sentence}"\n\n')

