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

  -- Computes the index for accessing a point in a 1-dimensional space for a linear
  -- vector.
  --
  -- Assumes the space is X.
  function index_1d(x: usize) return usize;

  -- Computes the index for accessing a point in a 2-dimensional space for a linear
  -- vector.
  -- 
  -- Assumes the space is X * Y.
  function index_2d(x: usize; y: usize; x_len: psize) return usize;

  -- Computes the index for accessing a point in a 3-dimensional space for a linear
  -- vector.
  --
  -- Assumes the space is X * Y * Z.
  function index_3d(x: usize; y: usize; z: usize; x_len: psize; y_len: psize) return usize;

  -- function get_1d(v_1d: logics; x: usize) return logic;

  -- function get_2d(v_2d: logics; x_len: usize; x: usize; y: usize) return logic;

  -- Returns the 1-dimensional subspace of len(`v_x`) at index `y` of the 2-dimensional
  -- space `v_yx`.
  function get_2d1d(v_yx: logics; v_x: logics; y: usize; offset: usize := 0) return logics;

  -- Returns the 2-dimensional space after storing the 1-dimensional value `v_x`
  -- at index `y` of the 2-dimensional space `v_yx`.
  function set_2d1d(v_yx: logics; v_x: logics; y: usize; offset: usize := 0) return logics;



  -- refactor below --

  -- This function accesses a point from 1-dimensional space.
  function get1d(arr: logics; x: usize) return logic;

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

  function get_2d1d(v_yx: logics; v_x: logics; y: usize; offset: usize := 0) return logics is
    variable shift: usize := offset + v_yx'low;
    variable x_len: usize := v_x'length;
  begin
    if v_yx'ascending = true then
      return v_yx((y*x_len)+shift to ((y+1)*x_len)-1+shift);
    else
      return v_yx(((y+1)*x_len)-1+shift downto (y*x_len)+shift);
    end if;
  end function;


  function set_2d1d(v_yx: logics; v_x: logics; y: usize; offset: usize := 0) return logics is
    variable x_len: usize := v_x'length;
    variable inner_v_yx: logics(v_yx'range) := v_yx;
    variable shift: usize := offset + v_yx'low;
  begin
    if inner_v_yx'ascending = true then
      inner_v_yx((y*x_len)+shift to ((y+1)*x_len)-1+shift) := v_x;
    else 
      inner_v_yx(((y+1)*x_len)-1+shift downto (y*x_len)+shift) := v_x;
    end if;
    return inner_v_yx;
  end function;

  function index_1d(x: usize) return usize is
  begin
    return x;
  end function;


  function index_2d(x: usize; y: usize; x_len: psize) return usize is
  begin
    return (x_len * y) + x;
  end function;


  function index_3d(x: usize; y: usize; z: usize; x_len: psize; y_len: psize) return usize is
  begin
    return (x_len * y_len * z) + (x_len * y) + x;
  end function;


  -- function index_2d1d(y: usize; x_len: usize; offset: usize := 0) return voids is
  --   variable shift: usize := offset;
  --   variable sect: voids(((y+1)*x_len)-1+shift downto (y*x_len)+shift);
  -- begin
  --   return sect;
  -- end function;
  -- begin
  --   if arr'ascending = true then
  --     return arr((x_max * y) + shift to (x_max * (y + 1)) - 1 + shift);
  --   end if;
  --   return arr((x_max * (y + 1)) - 1 + shift downto (x_max * y) + shift);
  -- end function;

  -- everything below to be refactored --

  function get1d(arr: logics; x: usize) return logic is
  begin
    return arr(x);
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