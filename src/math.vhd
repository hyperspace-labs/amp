-- Project: amp
-- Package: math
--
-- This package contains helpful compile-time mathematical equations for 
-- counting bits.

library ieee;
use ieee.std_logic_1164.all;

library work;
use work.types.all;

package math is    

  -- This function computes the logarithmic (base 2) for `k` and takes the 
  -- ceiling of the result. It effectively determines the minimum number of 
  -- bits required to enumerate `k` possible values of a space.
  --
  -- Equation: ceil(log2(k))
  function clog2(k: usize) return usize;

  -- This function determines the minimum number of bits required to represent 
  -- the `k` as a decimal number in standard binary representation.
  --
  -- Equation: floor(log2(k) + 1)
  function flog2p1(k: usize) return usize;

  -- This function computes 2 raised to the `k` power. It effectively 
  -- determines the maximum number of values available for `k` bits.
  --
  -- Equation: 2**k
  function pow2(k: usize) return usize;

  -- This function computes 2 raised to the `k` minus 1 power. It effectively 
  -- determines the maximum unsigned number represented in base 2 for `k` bits.
  --
  -- Equation: (2**k)-1
  function pow2m1(k: usize) return usize;

  -- This function checks if `k` is a power of 2.
  --
  -- A number is a power of 2 when its binary represetnation has exactly 1 bit 
  -- set to 1.
  function is_pow2(k: usize) return bool;

  -- Computes the minimum number of bits required to enumerate `k` possible
  -- values in a set.
  --
  -- Internally, this function uses `clog2(...)`.
  function length_bits_enum(k: usize) return usize;

  -- Computes the minimum number of bits required to represent the decimal
  -- number `k` in a base 2 numbering system.
  --
  -- Internally, this function uses `flog2p1(...)`.
  function length_bits_repr(k: usize) return usize;

  -- Computes the index of the highest bit position that is set for the given
  -- integer represented in base 2. This function assumes zero-based indices.
  --
  -- Internally, this function uses `flog2p1(...)` and then subtracts 1.
  function highest_bit_set(k: usize) return usize;

end package;


package body math is

  function clog2(k: usize) return usize is
    variable count: psize := 1;
    variable total: psize := 1;
  begin
    if k = 0 or k = 1 then
      return k;
    end if;
    -- Count number of powers of 2 until matching or exceeding the number.
    loop 
      total := total * 2;
      if total >= k then
        exit;
      end if;
      count := count + 1;
    end loop;

    return count;
  end function;


  function flog2p1(k: usize) return usize is
    variable count: psize := 1;
    variable total: psize := 1;
  begin
    if k = 1 or k = 2 then
      return k;
    end if;
    -- Count the number of powers of 2 until exceeding the number.
    loop 
      total := total * 2;
      if total > k then
        exit;
      end if;
      count := count + 1;
    end loop;

    return count;
  end function;


  function pow2(k: usize) return usize is
  begin
    if k = 0 then
      return 1;
    else
      return 2 ** k;
    end if;
  end function;


  function pow2m1(k: usize) return usize is 
  begin
    if k = 0 then
      return 1-1;
    else
      return (2 ** k) - 1;
    end if;
  end function;


  function is_pow2(k: usize) return bool is
    variable temp: usize;
  begin
    if k = 0 then
      return false;
    end if;
    temp := k;
    while temp > 2 loop 
      if temp rem 2 /= 0 and temp > 2 then
        return false;
      end if;
      temp := temp / 2;
    end loop;
    return true;
  end function;


  function length_bits_enum(k: usize) return usize is
  begin
    return clog2(k);
  end function;


  function length_bits_repr(k: usize) return usize is
  begin
    return flog2p1(k);
  end function;


  function highest_bit_set(k: usize) return usize is
  begin
    return flog2p1(k)-1;
  end function;

end package body;