# Project: amp
# Script: prelude.py
#
# Reads the existing VHDL files and copy/pastes the existing
# functions and types into a single package called 'prelude'.

import os

SRC_DIR = './src'

FILE_ORDER = [
    ('types.vhd', True),
    ('cast.vhd', True),
    ('manip.vhd', True),
    ('math.vhd', False),
    ('dim.vhd', False),
]

pkg_headers = []
pkg_bodies = []
 
for (path, should_inc) in FILE_ORDER:
    pkg_filepath = SRC_DIR + '/' + path
    
    if should_inc == False:
        print('info: Excluding package ' + pkg_filepath + '...')
        continue
    
    print('info: Copying package ' + pkg_filepath + '...')
    # read each file and locate its package header and body (if exists)
    with open(pkg_filepath, 'r') as fd:
        data = fd.read()
        KEY = '\npackage'
        i_header_start = data.lower().find(KEY)
        i_keep = data[i_header_start + len(KEY):].find('\n')
        i_header_end = data.lower().find('\nend package;')

        pkg_headers += [data[i_header_start + len(KEY) + i_keep:i_header_end]]

        KEY = '\npackage body'
        i_body_start = data.lower().find(KEY)
        # skip package body if it does not exist
        if i_body_start == -1:
            continue

        i_keep = data[i_body_start + len(KEY):].find('\n')
        i_body_end = data.lower().find('\nend package body;')

        pkg_bodies += [data[i_body_start + len(KEY) + i_keep:i_body_end]]
        pass
        pass
    pass


HEADER = '''\
-- Project: amp
-- Package: prelude
--
-- This package brings the separate VHDL packages under a single package
-- for more convenient importing. This package is auto-generated; DO NOT EDIT.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
'''

PACKAGE_DECL = 'package prelude is'
for header in pkg_headers:
    PACKAGE_DECL += header[:-1]
PACKAGE_DECL += '\n\nend package;'

PACKAGE_BODY = 'package body prelude is'
for body in pkg_bodies:
    PACKAGE_BODY += body
PACKAGE_BODY += '\n\nend package body;'

prelude_data = HEADER + '\n' + PACKAGE_DECL + '\n\n' + PACKAGE_BODY

prelude_filepath = SRC_DIR + '/' + 'prelude.vhd'

rc = 0

if os.path.exists(prelude_filepath) == True:
    exiting_data = ''
    with open(prelude_filepath, 'r') as fd:
        exiting_data = fd.read()
    if exiting_data != prelude_data:
        print('info: Prelude package is out of sync; rewriting file...')
        rc = 101
    else:
        print('info: Prelude package is already up to date.')
    pass

with open(prelude_filepath, 'w') as fd:
    fd.write(HEADER)
    fd.write('\n')
    fd.write(PACKAGE_DECL)
    fd.write('\n\n')
    fd.write(PACKAGE_BODY)
    pass

print('info: Prelude package written to:', prelude_filepath)
exit(rc)