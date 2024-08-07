# Amp

[![Test](https://github.com/hyperspace-labs/amp/actions/workflows/test.yml/badge.svg)](https://github.com/hyperspace-labs/amp/actions/workflows/test.yml) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Amp is a set of VHDL packages that provide nicer types and missing functionality to the existing standard libraries for VHDL.

Amp is tested using the IEEE library implementations for VHDL 93, 02, and 08.

## Install

Run the following Orbit command:
```
orbit install --url https://github.com/hyperspace-labs/amp/archive/refs/tags/1.0.0.zip
```

Add the following line to your Orbit.toml:
``` toml
amp = "1"
```

## Details

Amp separates functionality into different VHDL packages. However, to reduce redundantly importing the same set of packages for every design unit, Amp has a special prelude package called `amp`, which contains the same contents as the packages it covers. By using the prelude package, users typically only need to import this package and then they are good to go. If not using the prelude package, a user must explicitly import each package.

The following packages can be found in Amp:

Package | Description | Included in `amp` prelude?
-- | -- | --
`types` | Standard type renaming and additional types | ✔ 
`cast` | Conversions between standard types | ✔ 
`manip` | Bit manipulation operations on linear vectors | ✔ 
`math` | Compile-time mathematical functions for counting bits |
`dims` | Functions for interpreting linear vectors in multidimensional space | 

## Project Goals

This package strives to meet the following objectives:
- __minimal__: Implement the minimum set of functions necessary for any project, and wrap existing built-in functions when it makes sense
- __general-purpose__: Be generic enough for practicality in all applications
- __interoperable__: Be able to be used among varying standards (93, 08, etc.) without breaking existing built-in functionalities

## Usage

> __Note__: The set of VHDL packages found under Amp should be mapped to the `nano` library.

After installing Amp and adding it as a dependency in your local ip's Orbit.toml file, use the package for your next design unit:

``` vhdl
library ieee;
use ieee.std_logic_1164.all;

library nano;
use nano.amp.all;

entity my_design is
-- ...
```

> __Note__: You may still need to reference relevant IEEE packages when using Amp because of how Amp's packages define subtypes and do not redefine IEEE functions.
> 