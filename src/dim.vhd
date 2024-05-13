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

  function index_sub(axes: psizes; indices: usizes) return usize;

  function index_sub(axis: psize; index: usize) return usize;

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

end package;


package body dim is

  function get_slice(v_array: logics; v_slice: logics; i: usize; offset: usize := 0) return logics is
    variable shift: usize := offset + v_array'low;
    variable len_slice: usize := v_slice'length;
  begin
    if v_array'ascending = true then
      return v_array((i*len_slice)+shift to ((i+1)*len_slice)-1+shift);
    else
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


  function index_sub(axes: psizes; indices: usizes) return usize is 
    variable result: usize := 0;
    variable jump: usize := 1;
    variable len: usize := axes'length;
  begin
    if axes'length /= indices'length then
      report "DIM.INDEX_SUB: vectors for slice lengths and indices do not match" severity warning;
    end if;
    result := jump * indices(len-1);
    if indices(len-1) >= axes(len-1) then
      report "DIM.INDEX_SUB: index at dimension " & int'image(len) & " is out of bounds" severity warning;
    end if;
    for k in len-2 downto 0 loop
      jump := jump * axes(k+1);
      result := result + (jump * indices(k));
      if indices(k) >= axes(k) then
        report "DIM.INDEX_SUB: index at dimension " & int'image(k+1) & " is out of bounds" severity warning;
      end if;
    end loop;
    if result > jump * axes(0) then
      report "DIM.INDEX_SUB: index out of bounds" severity warning;
    end if;
    return result;
  end function;


  function index_sub(axis: psize; index: usize) return usize is
  begin
    if index > axis then
      report "DIM.INDEX_SUB: index out of bounds" severity warning;
    end if;
    return index;
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

end package body;
