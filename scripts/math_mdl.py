# Project: Nanoamp
# Script: math_mdl.py
#
# Software models to generate inputs and expected outputs for the VHDL 
# equivalent functions. The scripts produces the VHDL code to copy/paste
# into the VHDL testbench to check against the VHDL function outputs using
# assertions.

import math


def clog2(k: int):
    if k == 0 or k == 1:
        return k
    return int(math.ceil(math.log2(k)))


def flog2p1(k: int):
    if k == 0 or k == 1:
        return 1
    return int(math.floor(math.log2(k)+1))


def pow2(k: int):
    return 2**k


def pow2m1(k: int):
    return 2**k-1


def is_pow2(k: int):
    # zero is not a power of 2
    if k == 0:
        return False
    return math.log2(k).is_integer()


def write_const(name: str, solns) -> str:
    words = ''
    for s in solns:
        words += str(s).lower() + ', '
    return 'constant ' + name + ': usizes := (' + words[:len(words)-2] + ');'


def write_assert(fn_name: str, var_name: str) -> str:
    words = 'assert ' + var_name + '(i) = ' + fn_name + '(k) report "MATH.' + fn_name.upper() + ': incorrect result k = " & usize\'image(k) & ", got: " & usize\'image(' + fn_name + '(k)) & ", expected: " & usize\'image(' + var_name + '(i)) severity failure;'
    return words


inputs = []

values = [0, 1, 2, 3, 4, 5, 6, 7, 8, 12, 13, 15, 16]

print('cutoff:', len(values))

soln_clog2 = []
soln_flog2p1 = []
soln_pow2 = []
soln_is_pow2 = []
soln_pow2m1 = []

for i in values:
    inputs += [i]
    soln_clog2 += [clog2(i)]
    soln_flog2p1 += [flog2p1(i)]
    soln_pow2 += [pow2(i)]
    soln_pow2m1 += [pow2m1(i)]
    soln_is_pow2 += [is_pow2(i)]
    pass

values2 = [45, 46, 47, 63, 64]

for i in values2:
    inputs += [i]
    soln_clog2 += [clog2(i)]
    soln_flog2p1 += [flog2p1(i)]
    soln_is_pow2 += [is_pow2(i)]
    pass

# write test case vectors
print(write_const('k_input', inputs))
print(write_const('soln_clog2', soln_clog2))
print(write_const('soln_flog2p1', soln_flog2p1))
print(write_const('soln_pow2', soln_pow2))
print(write_const('soln_pow2m1', soln_pow2m1))
print(write_const('soln_is_pow2', soln_is_pow2))

# write assertion statements
print(write_assert('clog2', 'soln_clog2'))
print(write_assert('flog2p1', 'soln_flog2p1'))
print(write_assert('pow2', 'soln_pow2'))
print(write_assert('pow2m1', 'soln_pow2m1'))
print(write_assert('is_pow2', 'soln_is_pow2'))

