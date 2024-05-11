-- Project: amp
-- Package: math
--
-- This package contains helpful compile-time mathematical equations for 
-- counting bits.

library ieee;
use ieee.std_logic_1164.all;

package math is    
    -- This function computes the logarithmic (base 2) for `num` and takes the 
    -- ceiling of the result. It effectively determines the minimum number of 
    -- bits required to represent `num` possible values of a space.
    --
    -- Equation: ceil(log2(num))
    function clog2(num: natural) return natural;

    -- This function determines the minimum number of bits required to represent 
    -- the `num` as a decimal number in standard binary representation.
    --
    -- Equation: floor(log2(num) + 1)
    function flog2p1(num: natural) return natural;

    -- This function computes 2 raised to the `num` power.
    -- 
    -- It effectively determines the maximum number of possible values of a
    -- space represented in binary for a vector with `num` width.
    function pow2(num: natural) return natural;

    -- This function computes 2 raised to the `num` minus 1 power.
    -- 
    -- It effectively determines the maximum number represented in binary for a 
    -- vector with `num` width.
    function pow2m1(num: natural) return natural;

    -- This function checks if `num` is a power of 2.
    function is_pow2(num: natural) return boolean;

end package;


package body math is

  function clog2(num: natural) return natural is
    variable count: positive := 1;
    variable total: positive := 1;
  begin
    if num = 0 or num = 1 then
      return num;
    end if;
    -- Count number of powers of 2 until matching or exceeding the number.
    loop 
      total := total * 2;
      if total >= num then
        exit;
      end if;
      count := count + 1;
    end loop;

    return count;
  end function;


  function flog2p1(num: natural) return natural is
    variable count: positive := 1;
    variable total: positive := 1;
  begin
    if num = 1 or num = 2 then
      return num;
    end if;
    -- Count the number of powers of 2 until exceeding the number.
    loop 
      total := total * 2;
      if total > num then
        exit;
      end if;
      count := count + 1;
    end loop;

    return count;
  end function;


  function pow2(num: natural) return natural is
  begin
    if num = 0 then
      return 1;
    else
      return 2 ** num;
    end if;
  end function;


  function pow2m1(num: natural) return natural is 
  begin
    if num = 0 then
      return 1-1;
    else
      return (2 ** num) - 1;
    end if;
  end function;


  function is_pow2(num: natural) return boolean is
    variable temp: natural;
  begin
    temp := num;
    while temp > 2 loop 
      if temp rem 2 /= 0 and temp > 2 then
        return false;
      end if;
      temp := temp / 2;
    end loop;
    return true;
  end function;

end package body;