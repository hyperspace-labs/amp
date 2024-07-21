# `amp`

[![Test](https://github.com/hyperspace-labs/amp/actions/workflows/test.yml/badge.svg)](https://github.com/hyperspace-labs/amp/actions/workflows/test.yml) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Amp is a library that provide a layer of convenience and additional functionality to the existing IEEE library for VHDL.

This project is tested using the IEEE library implementations for VHDL 93, 02, and 08.

## Install

Run the following Orbit command:
```
orbit install --url https://github.com/hyperspace-labs/amp/archive/refs/tags/1.0.0.zip
```

Add the following line to your Orbit.toml:
``` toml
amp = "1.0.0"
```

## Details

Amp groups common functionality together in packages. A special prelude package exists called `amp` as means to gather the set of commonly used and most basic types and functions. Keeping the prelude package a relatively lean set of items allows advantages in reduced complexity and size of the prelude, while allowing to be more easily assimilated into other projects. If not using the prelude package, a user must explicitly specify each package that is otherwise included in the prelude.

The following packages are currently available:

Name | Description | Included in `amp` prelude?
-- | -- | --
`types` | Improved type names and additional types | ✔ 
`cast` | Convenient conversions between types | ✔ 
`manip` | Bit manipulation operations | ✔ 
`math` | Compile-time arithmetic functions |
`dims` | Functions for interpreting linear vectors in multi-dimensional space | 

## Project Goals

This package strives to meet the following objectives:
- __minimal__: Implement the minimum set of functions necessary for any project, and wrap existing built-in functions when it makes sense
- __general-purpose__: Be generic enough for practicality in all applications
- __interoperable__: Be able to be used among varying standards (93, 08, etc.) without breaking existing built-in functionalities


## Usage

After installing Amp and adding it as a dependency in your local project's Orbit.toml file, use the package wherever necessary:

``` vhdl
library ieee;
use ieee.std_logic_1164.all;

library micro;
use micro.amp.all;

entity my_design is
-- ...
```

> __Note__: You may still need to reference ieee packages when using Amp because of how Amp's packages define subtypes and do not redefine ieee functions.