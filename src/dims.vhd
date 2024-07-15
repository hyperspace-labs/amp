-- Project: amp
-- Package: dims
--
-- This package contains functions for performing operations in a dimensional
-- space on linear (1D) arrays.

library ieee;
use ieee.std_logic_1164.all;

library work;
use work.types.all;

package dims is

  -- Returns a subspace of len(`v_slice`) at index `i` of the entire space `v_array`.
  -- 
  -- This function can be interpreted as returning the 1-dimensional slice from a 
  -- 2-dimensional array.
  function get_slice(constant v_array: logics; constant v_slice: logics; constant i: usize; constant offset: usize := 0) return logics;

  -- Returns the entire space `v_array` after storing the subspace `v_slice` at
  -- index `i` of the entire space `v_array`.
  --
  -- This function can be interpreted as returning the n-dimensional array after
  -- modifying the 1-dimensional slice at index `i` with the value of `v_slice`.
  function set_slice(constant v_array: logics; constant v_slice: logics; constant i: usize; constant offset: usize := 0) return logics;

  -- Returns a subspace of the len(`v_slice`) at the location determined by the higher dimension `axes` and
  -- `coordinates` of the entire space `v_array`.
  --
  -- This function can be interpreted as returning the (n-1)-dimensional slice from an n-dimensional
  -- array.
  function get_slice(constant v_array: logics; constant v_slice: logics; constant axes: psizes; constant coordinates: usizes; constant offset: usize := 0) return logics;
  
  -- Returns the entire space `v_array` after storing the subspace `v_slice` at the location
  -- determined by the higher dimension `axes` and `coordinates` in the entire space `v_array`.
  --
  -- This function can be interpreted as returning the n-dimensional array after
  -- modifying the 1-dimensional slice at the location defined by the `axes` and `coordinates`
  -- with the value of `v_slice`.
  function set_slice(constant v_array: logics; constant v_slice: logics; constant axes: psizes; constant coordinates: usizes; constant offset: usize := 0) return logics;

  -- Returns the index to a point in the multi-dimensional space defined by lengths defined
  -- in `axes` and by positions defined in `coordinates`.
  --
  -- Each element in the corresponding lists should be ordered from highest
  -- dimensions to lowest dimension. For example, for a 3-dimensional space
  -- defined by X, Y, and Z, the order is (Z, Y, X).
  function index_space(constant axes: psizes; constant coordinates: usizes) return usize;

end package;


package body dims is

  function get_slice(constant v_array: logics; constant v_slice: logics; constant i: usize; constant offset: usize := 0) return logics is
    variable shift: usize := offset + v_array'low;
    variable len_slice: usize := v_slice'length;
  begin
    if v_array'ascending = true then
      return v_array((i*len_slice)+shift to ((i+1)*len_slice)-1+shift);
    else
      return v_array(((i+1)*len_slice)-1+shift downto (i*len_slice)+shift);
    end if;
  end function;


  function set_slice(constant v_array: logics; constant v_slice: logics; constant i: usize; constant offset: usize := 0) return logics is
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


  function get_slice(constant v_array: logics; constant v_slice: logics; constant axes: psizes; constant coordinates: usizes; constant offset: usize := 0) return logics is
    variable shift: usize := offset + v_array'low;
    variable len_slice: usize := v_slice'length;
    variable i: usize := index_space(axes, coordinates);
  begin
    if v_array'ascending = true then
      return v_array((i*len_slice)+shift to ((i+1)*len_slice)-1+shift);
    else
      return v_array(((i+1)*len_slice)-1+shift downto (i*len_slice)+shift);
    end if;
  end function;


  function set_slice(constant v_array: logics; constant v_slice: logics; constant axes: psizes; constant coordinates: usizes; constant offset: usize := 0) return logics is
    variable shift: usize := offset + v_array'low;
    variable len_slice: usize := v_slice'length;
    variable inner_v_array: logics(v_array'range) := v_array;
    variable i: usize := index_space(axes, coordinates);
  begin
    if v_array'ascending = true then
      inner_v_array((i*len_slice)+shift to ((i+1)*len_slice)-1+shift) := v_slice;
    else
      inner_v_array(((i+1)*len_slice)-1+shift downto (i*len_slice)+shift) := v_slice;
    end if;
    return inner_v_array; 
  end function;


  function index_space(constant axes: psizes; constant coordinates: usizes) return usize is 
    variable result: usize := 0;
    variable jump: usize := 1;
    variable len: usize := axes'length;
  begin
    if axes'length /= coordinates'length then
      report "DIM.INDEX_SPACE: vector sizes for axes and coordinates do not match" severity warning;
    end if;
    result := jump * coordinates(len-1);
    if coordinates(len-1) >= axes(len-1) then
      report "DIM.INDEX_SPACE: coordinate at dimension " & int'image(len) & " is out of bounds" severity warning;
    end if;
    for k in len-2 downto 0 loop
      jump := jump * axes(k+1);
      result := result + (jump * coordinates(k));
      if coordinates(k) >= axes(k) then
        report "DIM.INDEX_SPACE: coordinate at dimension " & int'image(k+1) & " is out of bounds" severity warning;
      end if;
    end loop;
    if result > jump * axes(0) then
      report "DIM.INDEX_SPACE: coordinate out of bounds" severity warning;
    end if;
    return result;
  end function;

end package body;
