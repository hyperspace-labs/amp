-- Project: amp
-- Package: manip
--
-- This package contains functions for common bit manipulations on linear
-- vectors.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.types.all;

package manip is

  -- This function shifts a logic vector logically to the left while inserting 
  -- zeros from the right. It is a zero-fill left-shift.
  function shift_ll(v: logics; amt: usize) return logics;

  -- This function shifts a logic vector logically to the right while inserting 
  -- zeros from the left. It is a zero-fill right-shift.
  function shift_rl(v: logics; amt: usize) return logics;

  -- This function shifts a logic vector to the left while inserting zeros from
  -- the right. It is a zero-fill left-shift.
  --
  -- When the logic vector's range is ascending, then this operation performs
  -- sticky right-shift with the MSB being inserted from the right.
  function shift_la(v: logics; amt: usize) return logics;

  -- This function shift a logic vector to the right while inserting the MSB
  -- from the left. It is a sticky right-shift.
  --
  -- When the logic vector's range is ascending, then this operation performs
  -- zero-fill right-shift with 0's being inserted into the LSB position.
  function shift_ra(v: logics; amt: usize) return logics;

  -- This function performs a circular rotation of a logic vector's elements.
  -- Elements are pushed off from the right side and are reinserted back to the 
  -- left side.
  function rotate_r(v: logics; amt: usize) return logics;

  -- This function performs a circular rotation of a logic vector's elements.
  -- Elements are pushed off from the left side and are reinserted back to the
  -- right side.
  function rotate_l(v: logics; amt: usize) return logics;

  -- This function performs a zero-extension to the logic vector by a specifying
  -- the total number of bits for the resulting vector.
  --
  -- Additional bits are filled with '0'. It is an error for the number of bits
  -- n < len(x).
  function extend_z(x: logics; n: usize) return logics;

  -- This function performs a sign-extension to the logic vector by a specifying
  -- the total number of bits for the resulting vector. 
  --
  -- Additional bits are filled with the MSB. It is an error for the amount of
  -- bits n < len(x).
  function extend_s(x: logics; n: usize) return logics;
  

  -- Flip functions
  -- function compl(v: logics) return logics;

  -- Extension functions
  -- function uresize
  -- function iresize

end package;


package body manip is

  function shift_ll(v: logics; amt: usize) return logics is
    variable result: logics(v'range);
  begin
    if v'length = 1 and amt > 0 then
      return "0";
    end if;

    result := v;
    -- shift left logical 'amt' times
    for i in 1 to amt loop
      -- provided with 'to'
      if v'ascending = true then
        result := result(v'left+1 to v'right) & "0";
      -- provided with 'downto'
      else 
        result := result(v'left-1 downto v'right) & "0";
      end if;
    end loop;

    return result;
  end function;


  function shift_rl(v: logics; amt: usize) return logics is
    variable result: logics(v'range);
  begin
    if v'length = 1 and amt > 0 then
      return "0";
    end if;

    result := v;
    -- shift right logical 'amt' times
    for i in 1 to amt loop
      -- provided with 'to'
      if v'ascending = true then
        result := "0" & result(v'left to v'right-1);
      -- provided with 'downto'
      else 
        result := "0" & result(v'left downto v'right+1);
      end if;
    end loop;

    return result;
  end function;


  function shift_la(v: logics; amt: usize) return logics is
    variable result: logics(v'range);
  begin
    if v'length = 1 and amt > 0 then
      if v'ascending = true then
        return v;
      else
        return "0";
      end if;
    end if;

    result := v;
    -- shift right logical 'amt' times
    for i in 1 to amt loop
      -- provided with 'to'
      if v'ascending = true then
        -- replace MSB with itself
        result := result(v'left+1 to v'right) & result(v'right to v'right);
      -- provided with 'downto'
      else 
        result := result(v'left-1 downto v'right) & "0";
      end if;
    end loop;

    return result;
  end function;


  function shift_ra(v: logics; amt: usize) return logics is
    variable result: logics(v'range);
  begin
    if v'length = 1 and amt > 0 then
      if v'ascending = true then
        return "0";
      else
        return v;
      end if;
    end if;

    result := v;
    -- shift right logical 'amt' times
    for i in 1 to amt loop
      -- provided with 'to'
      if v'ascending = true then
        result := "0" & result(v'left to v'right-1);
      -- provided with 'downto'
      else 
        -- replace MSB with itself
        result := result(v'left downto v'left) & result(v'left downto v'right+1);
      end if;
    end loop;

    return result;
  end function;


  function rotate_r(v: logics; amt: usize) return logics is
    variable result: logics(v'range);
  begin
    result := v;

    for i in 1 to amt loop
      if v'ascending = true then
        result := result(v'right to v'right) & result(v'left to v'right-1);
      else
        result := result(v'right downto v'right) & result(v'left downto v'right+1);
      end if;
    end loop;

    return result;
  end function;


  function rotate_l(v: logics; amt: usize) return logics is
    variable result: logics(v'range);
  begin
    result := v;

    for i in 1 to amt loop
      if v'ascending = true then
        result := result(v'left+1 to v'right) & result(v'left to v'left);
      else
        result := result(v'left-1 downto v'right) & result(v'left downto v'left);
      end if;
    end loop;

    return result;
  end function;


  function extend_z(x: logics; n: usize) return logics is
    variable tmp: logics(0 downto 0);
  begin
    if n < x'length then
      assert false report "MANIP.EXTEND_Z: vector truncated" severity warning;
    end if;
    if x'ascending = false then
      return logics(resize(usign(x), n));
    else
      if n < x'length then
        return x(x'low to x'low + n - 1);
      else
        tmp(0) := '0';
        return x & logics(resize(usign(tmp), n - x'length));
      end if;
    end if;
  end function;


  function extend_s(x: logics; n: usize) return logics is
    variable tmp: logics(0 downto 0);
  begin
    if n < x'length then
      assert false report "MANIP.EXTEND_S: vector truncated" severity warning;
    end if;
    if x'ascending = false then
      return logics(resize(isign(x), n));
    else 
      if n < x'length then
        return x(x'low to x'low + n - 1);
      else 
        tmp(0) := x(x'high);
        return x & logics(resize(isign(tmp), n - x'length));
      end if;
    end if;
  end function;

end package body;