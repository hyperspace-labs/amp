library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.types.all;

package std93 is

  -- Shift operators
  function "sll"(arr: logics; amount: usize) return logics;
  function "srl"(arr: logics; amount: usize) return logics;
  function "sla"(arr: logics; amount: usize) return logics;
  function "sra"(arr: logics; amount: usize) return logics;

  -- Rotation operators
  function "ror"(arr: logics; amount: usize) return logics;
  function "rol"(arr: logics; amount: usize) return logics;

  -- Extension functions
  -- function zero_extend(arr: logics; amount: usize) return logics;
  -- function sign_extend(arr: logics; amount: usize) return logics;
  -- function uresize
  -- function iresize

end package;

package body std93 is

  -- Unresolved logic operators.

  -- Shift-left-logical
  --
  -- This function shifts a logic vector to the left while inserting zeros from
  -- the right. It is a zero-fill left-shift.
  function "sll"(arr: logics; amount: usize) return logics is
    variable result: logics(arr'range);
  begin
    if arr'length = 1 and amount > 0 then
      return "0";
    end if;

    result := arr;
    -- shift left logical 'amount' times
    for i in 1 to amount loop
      -- provided with 'to'
      if arr'ascending = true then
        result := result(arr'left+1 to arr'right) & "0";
      -- provided with 'downto'
      else 
        result := result(arr'left-1 downto arr'right) & "0";
      end if;
    end loop;

    return result;
  end function;


  -- Shift-right-logical
  --
  -- This function shifts a logic vector to the right while inserting zeros from
  -- the left. It is a zero-fill right-shift.
  function "srl"(arr: logics; amount: usize) return logics is
    variable result: logics(arr'range);
  begin
    if arr'length = 1 and amount > 0 then
      return "0";
    end if;

    result := arr;
    -- shift right logical 'amount' times
    for i in 1 to amount loop
      -- provided with 'to'
      if arr'ascending = true then
        result := "0" & result(arr'left to arr'right-1);
      -- provided with 'downto'
      else 
        result := "0" & result(arr'left downto arr'right+1);
      end if;
    end loop;

    return result;
  end function;


  -- Shift-left-arithmetic
  --
  -- This function shifts a logic vector to the left while inserting zeros from
  -- the right. It is a zero-fill left-shift.
  --
  -- When the logic vector's range is ascending, then this operation performs
  -- sticky right-shift with the MSB being inserted from the right.
  function "sla"(arr: logics; amount: usize) return logics is
    variable result: logics(arr'range);
  begin
    if arr'length = 1 and amount > 0 then
      if arr'ascending = true then
        return arr;
      else
        return "0";
      end if;
    end if;

    result := arr;
    -- shift right logical 'amount' times
    for i in 1 to amount loop
      -- provided with 'to'
      if arr'ascending = true then
        -- replace MSB with itself
        result := result(arr'left+1 to arr'right) & result(arr'right to arr'right);
      -- provided with 'downto'
      else 
        result := result(arr'left-1 downto arr'right) & "0";
      end if;
    end loop;

    return result;
  end function;


  -- Shift-right-arithmetic
  --
  -- This function shift a logic vector to the right while inserting the MSB
  -- from the left. It is a sticky right-shift.
  --
  -- When the logic vector's range is ascending, then this operation performs
  -- zero-fill right-shift with 0's being inserted into the LSB position.
  function "sra"(arr: logics; amount: usize) return logics is
    variable result: logics(arr'range);
  begin
    if arr'length = 1 and amount > 0 then
      if arr'ascending = true then
        return "0";
      else
        return arr;
      end if;
    end if;

    result := arr;
    -- shift right logical 'amount' times
    for i in 1 to amount loop
      -- provided with 'to'
      if arr'ascending = true then
        result := "0" & result(arr'left to arr'right-1);
      -- provided with 'downto'
      else 
        -- replace MSB with itself
        result := result(arr'left downto arr'left) & result(arr'left downto arr'right+1);
      end if;
    end loop;

    return result;
  end function;


  -- Rotate-right
  --
  -- This function performs a circular rotation of a logic vector's elements.
  -- Elements are pushed off from the right side and are reinserted back to the 
  -- left side.
  function "ror"(arr: logics; amount: usize) return logics is
    variable result: logics(arr'range);
  begin
    result := arr;

    for i in 1 to amount loop
      if arr'ascending = true then
        result := result(arr'right to arr'right) & result(arr'left to arr'right-1);
      else
        result := result(arr'right downto arr'right) & result(arr'left downto arr'right+1);
      end if;
    end loop;

    return result;
  end function;


  -- Rotate-left
  --
  -- This function performs a circular rotation of a logic vector's elements.
  -- Elements are pushed off from the left side and are reinserted back to the
  -- right side.
  function "rol"(arr: logics; amount: usize) return logics is
    variable result: logics(arr'range);
  begin
    result := arr;

    for i in 1 to amount loop
      if arr'ascending = true then
        result := result(arr'left+1 to arr'right) & result(arr'left to arr'left);
      else
        result := result(arr'left-1 downto arr'right) & result(arr'left downto arr'left);
      end if;
    end loop;

    return result;
  end function;

end package body;