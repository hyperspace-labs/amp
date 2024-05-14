# `amp`

[![test](https://github.com/hyperspace-labs/amp/actions/workflows/test.yml/badge.svg)](https://github.com/hyperspace-labs/amp/actions/workflows/test.yml) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A standard library for VHDL - ___amplified___.

This package is tested with the IEEE standard for VHDL 93, 02, and 08.

## Packages

Common functionality is grouped together within packages. However, if designs are frequently requiring many of `amp`'s packages, then using the `prelude` package will import all functionality from the packages enabled under the __Prelude__ column in the following table.

Name | Description | Included in `prelude`?
-- | -- | --
`types` | Improved type names and additional types | ✔
`manip` | Bit manipulation operations | ✔ 
`math` | Compile-time arithmetic functions | ✔ 
`dim` | Functions for interpreting linear vectors in multi-dimensional space | ✔
`cast` | Convenient conversions between types | ✔

## Project Goals

This package strives to meet the following objectives:
- __minimal__: Implement the minimum set of functions that necessary for any project, and wrap existing built-in functions when it makes sense
- __general-purpose__: Be generic enough for practicality in all applications
- __interoperable__: Be able to be used among varying standards (93, 08, etc.) with breaking existing built-in functionalities