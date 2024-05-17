# `amp`

[![test](https://github.com/hyperspace-labs/amp/actions/workflows/test.yml/badge.svg)](https://github.com/hyperspace-labs/amp/actions/workflows/test.yml) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A standard library for VHDL - ___amplified___.

This project is tested using the IEEE standard for VHDL 93, 02, and 08.

### Install

Run the following Orbit command:
```
orbit install amp:1.0.0 --url "https://github.com/hyperspace-labs/amp/archive/refs/tags/1.0.0.zip"
```

Add the following line to your Orbit.toml:
```
amp = "1.0.0"
```

## Packages

Common functionality is grouped together within packages. However, if designs are frequently requiring many of `amp`'s packages, then the `prelude` package is available to import most functionality under a single package.

Name | Description | Included in `prelude`?
-- | -- | --
`types` | Improved type names and additional types | ✔ 
`cast` | Convenient conversions between types | ✔ 
`manip` | Bit manipulation operations | ✔ 
`math` | Compile-time arithmetic functions |
`dim` | Functions for interpreting linear vectors in multi-dimensional space | 

## Project Goals

This package strives to meet the following objectives:
- __minimal__: Implement the minimum set of functions necessary for any project, and wrap existing built-in functions when it makes sense
- __general-purpose__: Be generic enough for practicality in all applications
- __interoperable__: Be able to be used among varying standards (93, 08, etc.) without breaking existing built-in functionalities


## How to Use

After installing and adding `amp` to your project's Orbit.toml file, use the package wherever necessary:

Filename: my_design.vhd
``` vhdl
library ieee;
use ieee.std_logic_1164.all;

library amp;
use amp.prelude.all;

entity my_design is
-- ...
```