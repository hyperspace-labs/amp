-- Project: amp
-- Package: types
--
-- This package contains shorthand notations for the default datatypes as well
-- extensions for common datatypes such as bytes.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package types is

  -- The 8-bit signed integer type.
  subtype i8 is integer range -128 to 127;
  -- The 16-bit signed integer type.
  subtype i16 is integer range -32768 to 32767;
  -- The 32-bit signed integer type.
  subtype i32 is integer range -2147483648 to 2147483647;

  -- The 8-bit unsigned integer type.
  subtype u8 is natural range 0 to 255;
  -- The 16-bit unsigned integer type.
  subtype u16 is natural range 0 to 65535;
  -- The 32-bit unsigned integer type.
  subtype u32 is natural range 0 to 2147483647;

  -- The 8-bit positive integer type.
  subtype p8 is positive range 1 to 256;
  -- The 16-bit positive integer type.
  subtype p16 is positive range 1 to 65536;
  -- The 32-bit positive integer type.
  subtype p32 is positive range 1 to 2147483647;

  -- The compiler-sized signed integer type.
  subtype isize is integer;
  -- The compiler-sized unsigned integer type.
  subtype usize is natural;
  -- The compiler-sized positive integer type.
  subtype psize is positive;

  -- The boolean type.
  subtype bool is boolean;

  -- A character type.
  subtype char is character;

  -- Another naming notation for compiler-sized signed integer type.
  subtype int is integer;

  -- A fixed-size array of `char` element types.
  subtype str is string;

  -- A fixed-size array of `bit` element types.
  subtype bits is bit_vector;

  -- An unresolved logic type.
  subtype logic is std_ulogic;
  -- A fixed-size array of `logic` element types.
  subtype logics is std_ulogic_vector;

  -- A resolved logic type.
  subtype rlogic is std_logic;
  -- A fixed-size array of `rlogic` element types.
  subtype rlogics is std_logic_vector;

  -- The unsigned logic type.
  subtype usign is unsigned;
  -- The signed logic type.
  subtype isign is signed;

  -- A fixed-size array of `bool` element types.
  type bools is array(natural range<>) of bool;

  -- A fixed-size array of `i8` element types.
  type i8s is array(natural range<>) of i8;
  -- A fixed-size array of `i16` element types.
  type i16s is array(natural range<>) of i16;
  -- A fixed-size array of `i32` element types.
  type i32s is array(natural range<>) of i32;

  -- A fixed-size array of `u8` element types.
  type u8s is array(natural range<>) of u8;
  -- A fixed-size array of `u16` element types.
  type u16s is array(natural range<>) of u16;
  -- A fixed-size array of `u32` element types.
  type u32s is array(natural range<>) of u32;

  -- A fixed-size array of `isize` element types.
  type isizes is array(natural range<>) of isize;
  -- A fixed-size array of `usize` element types.
  type usizes is array(natural range<>) of usize;
  -- A fixed-size array of `psize` element types.
  type psizes is array(natural range<>) of psize;

  -- An unresolved fixed logic vector of length 8.
  subtype byte is logics(7 downto 0);

  -- A resolved fixed logic vector of length 8.
  subtype rbyte is rlogics(7 downto 0);

  -- A fixed-size array of `byte` element types.
  type bytes is array(natural range<>) of byte;

  -- A fixed-size array of `rbyte` element types.
  type rbytes is array(natural range<>) of rbyte;

  -- A severity level type.
  subtype sevel is severity_level;

end package;