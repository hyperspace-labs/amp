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
  function shift_left_logic(x: logics; k: usize) return logics;

  -- This function shifts a logic vector logically to the right while inserting 
  -- zeros from the left. It is a zero-fill right-shift.
  function shift_right_logic(x: logics; k: usize) return logics;

  -- This function shifts a logic vector to the left while inserting zeros from
  -- the right. It is a zero-fill left-shift.
  --
  -- When the logic vector's range is ascending, then this operation performs
  -- sticky right-shift with the MSB being inserted from the right.
  function shift_left_arith(x: logics; k: usize) return logics;

  -- This function shift a logic vector to the right while inserting the MSB
  -- from the left. It is a sticky right-shift.
  --
  -- When the logic vector's range is ascending, then this operation performs
  -- zero-fill right-shift with 0's being inserted into the LSB position.
  function shift_right_arith(x: logics; k: usize) return logics;

  -- This function performs a circular rotation of a logic vector's elements.
  -- Elements are pushed off from the right side and are reinserted back to the 
  -- left side.
  function rotate_right(x: logics; k: usize) return logics;

  -- This function performs a circular rotation of a logic vector's elements.
  -- Elements are pushed off from the left side and are reinserted back to the
  -- right side.
  function rotate_left(x: logics; k: usize) return logics;

  -- This function performs a zero-extension to the logic vector by a specifying
  -- the total number of bits for the resulting vector.
  --
  -- Additional bits are filled with '0'. It is an error for the number of bits
  -- n < len(x).
  function zero_extend(x: logics; n: usize) return logics;

  -- This function performs a sign-extension to the logic vector by a specifying
  -- the total number of bits for the resulting vector. 
  --
  -- Additional bits are filled with the MSB. It is an error for the amount of
  -- bits n < len(x).
  function sign_extend(x: logics; n: usize) return logics;

end package;


package body manip is

  function shift_left_logic(x: logics; k: usize) return logics is
  begin
    return logics(usign(x) sll k);
  end function;


  function shift_right_logic(x: logics; k: usize) return logics is
  begin
    return logics(usign(x) srl k);
  end function;


  function shift_left_arith(x: logics; k: usize) return logics is
    variable result: logics(x'range);
  begin
    if x'length = 1 and k > 0 then
      if x'ascending = true then
        return x;
      else
        return "0";
      end if;
    end if;

    result := x;
    -- shift right logical 'k' times
    for i in 1 to k loop
      -- provided with 'to'
      if x'ascending = true then
        -- replace MSB with itself
        result := result(x'left+1 to x'right) & result(x'right to x'right);
      -- provided with 'downto'
      else 
        result := result(x'left-1 downto x'right) & "0";
      end if;
    end loop;

    return result;
  end function;


  function shift_right_arith(x: logics; k: usize) return logics is
    variable result: logics(x'range);
  begin
    if x'length = 1 and k > 0 then
      if x'ascending = true then
        return "0";
      else
        return x;
      end if;
    end if;

    result := x;
    -- shift right logical 'k' times
    for i in 1 to k loop
      -- provided with 'to'
      if x'ascending = true then
        result := "0" & result(x'left to x'right-1);
      -- provided with 'downto'
      else 
        -- replace MSB with itself
        result := result(x'left downto x'left) & result(x'left downto x'right+1);
      end if;
    end loop;

    return result;
  end function;


  function rotate_right(x: logics; k: usize) return logics is
    variable result: logics(x'range);
  begin
    result := x;

    for i in 1 to k loop
      if x'ascending = true then
        result := result(x'right to x'right) & result(x'left to x'right-1);
      else
        result := result(x'right downto x'right) & result(x'left downto x'right+1);
      end if;
    end loop;

    return result;
  end function;


  function rotate_left(x: logics; k: usize) return logics is
    variable result: logics(x'range);
  begin
    result := x;

    for i in 1 to k loop
      if x'ascending = true then
        result := result(x'left+1 to x'right) & result(x'left to x'left);
      else
        result := result(x'left-1 downto x'right) & result(x'left downto x'left);
      end if;
    end loop;

    return result;
  end function;


  function zero_extend(x: logics; n: usize) return logics is
    variable tmp: logics(0 downto 0);
  begin
    if n < x'length then
      assert false report "MANIP.zero_extend: vector truncated" severity warning;
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


  function sign_extend(x: logics; n: usize) return logics is
    variable tmp: logics(0 downto 0);
  begin
    if n < x'length then
      assert false report "MANIP.sign_extend: vector truncated" severity warning;
    end if;
    if x'ascending = false then
      return logics(resize(isign(x), n));
    else 
      if n < x'length then
        -- replace the MSB with the MSB of the untruncated vector
        tmp(0) := x(x'high);
        return x(x'low to x'low + n - 2) & tmp(0);
      else 
        tmp(0) := x(x'high);
        return x & logics(resize(isign(tmp), n - x'length));
      end if;
    end if;
  end function;

end package body;