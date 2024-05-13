# `amp`

A standard library for VHDL - ___amplified___.

## Packages

Name | Description
-- | --
`types` | Improved type names and additional types
`manip` | Bit manipulation operations
`math` | Compile-time arithmetic functions
`dim` | Functions for interpreting linear vectors in multi-dimensional space
`cast` | Convenient conversions between types

## Project Goals

This package strives to meet the following objectives:
- __minimal__: Implement the minimum set of functions that necessary for any project, and wrap existing built-in functions when it makes sense
- __general-purpose__: Be generic enough for practicality in all applications
- __interoperable__: Be able to be used among varying standards (93, 08, etc.) with breaking existing built-in functionalities