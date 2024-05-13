-- Project: amp
-- Package: dim
--
-- This package contains functions for performing operations in a dimensional
-- space on linear (1D) arrays.

library ieee;
use ieee.std_logic_1164.all;

library work;
use work.types.all;
use work.cast.all;

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

  -- Returns a subspace of len(`v_slice`) at index `i` of the entire space `v_array`.
  -- 
  -- This function can be interpreted as returning the (n-1)-dimensional slice from a 
  -- n-dimensional array.
  function get_slice(v_array: logics; v_slice: logics; i: usize; offset: usize := 0) return logics;

  -- Returns the entire space `v_array` after storing the subspace `v_slice` at
  -- index `i` of the entire space `v_array`.
  --
  -- This function can be interpreted as returning the n-dimensional array after
  -- modifying the (n-1)-dimensional slice at index `i` with the value of `v_slice`.
  function set_slice(v_array: logics; v_slice: logics; i: usize; offset: usize := 0) return logics;

  -- refactor below --

  -- This function accesses a point from 1-dimensional space.
  function get1d(arr: logics; x: usize) return logic;

  -- This function accesses a point from 2-dimensional space.
  function get2d(arr: logics; x: usize; y: usize; x_max: usize) return logic;

  -- This function accesses a point from 3-dimensional space.
  function get3d(arr: logics; x: usize; y: usize; z: usize; x_max: usize; y_max: usize) return logic;

end package;


package body dim is

  function get_slice(v_array: logics; v_slice: logics; i: usize; offset: usize := 0) return logics is
    variable shift: usize := offset + v_array'low;
    variable len_slice: usize := v_slice'length;
  begin
    if v_array'ascending = true then
      return v_array((i*len_slice)+shift to ((i+1)*len_slice)-1+shift);
    else
      report to_str(v_array);
      return v_array(((i+1)*len_slice)-1+shift downto (i*len_slice)+shift);
    end if;
  end function;


  function set_slice(v_array: logics; v_slice: logics; i: usize; offset: usize := 0) return logics is
    variable shift: usize := offset + v_array'low;
    variable len_slice: usize := v_slice'length;
    variable inner_v_array: logics(v_array'range) := v_array;
  begin
    if inner_v_array'ascending = true then
      inner_v_array((i*len_slice)+shift to ((i+1)*len_slice)-1+shift) := v_slice;
    else 
      inner_v_array(((i+1)*len_slice)-1+shift downto (i*len_slice)+shift) := v_slice;
    end if;
    return inner_v_array;
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

end package body;
