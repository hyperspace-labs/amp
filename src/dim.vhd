-- Project: amp
-- Package: dim
--
-- This package contains functions for performing operations in a dimensional
-- space on linear (1D) arrays.

library ieee;
use ieee.std_logic_1164.all;

library work;
use work.types.all;

package dim is

  -- This function accesses a point from 1-dimensional space.
  function get1d(arr: logics; x: usize) return logic;

  -- Stores a point in 1-dimensional space.
  -- procedure set1d(signal arr: inout logics; value: logic; x: usize);
  function index1d(x: usize; x_max: usize) return usize;

  -- This function accesses a point from 2-dimensional space.
  function get2d(arr: logics; x: usize; y: usize; x_max: usize) return logic;

  -- This function accesses a point from 3-dimensional space.
  function get3d(arr: logics; x: usize; y: usize; z: usize; x_max: usize; y_max: usize) return logic;

  -- This function accesses the `y`th 1-dimensional line from an array ordered 
  -- as a 2-dimensional space, where each line is `x_max` long.
  function get2d1d(arr: logics; y: usize; x_max: usize) return logics;

  -- This function accesses the `z`th 2-dimensional grid from an array ordered
  -- as a 3-dimensional space, where each grid is `x_max` * `y_max` large.
  function get3d2d(arr: logics; z: usize; x_max: usize; y_max: usize) return logics;

end package;


package body dim is


  function get1d(arr: logics; x: usize) return logic is
  begin
    return arr(x);
  end function;


  function index1d(x: usize; x_max: usize) return usize is
  begin
    return x;
  end function;


  function get2d(arr: logics; x: usize; y: usize; x_max: usize) return logic is
  begin
    return arr((x_max * y) + x);
  end function;


  function get3d(arr: logics; x: usize; y: usize; z: usize; x_max: usize; y_max: usize) return logic is
  begin
    return arr((x_max * y_max * z) + (x_max * y) + x);
  end function;


  function get2d1d(arr: logics; y: usize; x_max: usize) return logics is 
    variable shift: usize := arr'low;
  begin
    if arr'ascending = true then
      return arr((x_max * y) + shift to (x_max * (y + 1)) - 1 + shift);
    end if;
    return arr((x_max * (y + 1)) - 1 + shift downto (x_max * y) + shift);
  end function;

  function get3d2d(arr: logics; z: usize; x_max: usize; y_max: usize) return logics is
    variable shift: usize := arr'low;
  begin
    if arr'ascending = true then
      return arr((x_max * y_max * z) + shift to (x_max * y_max * (z + 1)) - 1 + shift);
    end if;
    return arr((x_max * y_max * (z + 1)) - 1 + shift downto (x_max * y_max * z) + shift);
  end function;


--   function get_slice(vec: logics; i: nat; len: pve; offset: nat := 0) return logics is
--     variable shift    : natural := offset + vec'low;
-- begin
--     if vec'ascending = true then
--         return vec((i*len)+shift to ((i+1)*len)-1+shift);
--     end if;
--     return vec(((i+1)*len)-1+shift downto (i*len)+shift);
-- end function;


-- function set_slice(vec: logics; i: nat; slice: logics; offset: nat := 0) return logics is
--     variable len       : natural := slice'length;
--     variable inner_vec : logics(vec'range) := vec;
--     variable shift    : natural := offset + vec'low;
-- begin
--     if inner_vec'ascending = true then
--         inner_vec((i*len)+shift to ((i+1)*len)-1+shift) := slice;
--     else 
--         inner_vec(((i+1)*len)-1+shift downto (i*len)+shift) := slice;
--     end if;
--     return inner_vec;
-- end function;

end package body;