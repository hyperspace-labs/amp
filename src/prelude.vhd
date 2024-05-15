-- Project: amp
-- Package: prelude
--
-- This package brings the separate VHDL packages under a single package
-- for more convenient importing. This package is auto-generated; DO NOT EDIT.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package prelude is

  -- The 8-bit signed integer type.
  subtype i8 is integer range -128 to 127;
  -- The 16-bit signed integer type.
  subtype i16 is integer range -32768 to 32767;
  -- The 32-bit signed integer type.
  subtype i32 is integer range -2147483648 to 2147483647;

  -- The 8-bit unsigned integer type.
  subtype u8 is natural range 0 to 255;
  -- The 16-bit unsigned integer type.
  subtype u16 is natural range 0 to 65535;
  -- The 32-bit unsigned integer type.
  subtype u32 is natural range 0 to 2147483647;

  -- The 8-bit positive integer type.
  subtype p8 is positive range 1 to 256;
  -- The 16-bit positive integer type.
  subtype p16 is positive range 1 to 65536;
  -- The 32-bit positive integer type.
  subtype p32 is positive range 1 to 2147483647;

  -- The compiler-sized signed integer type.
  subtype isize is integer;
  -- The compiler-sized unsigned integer type.
  subtype usize is natural;
  -- The compiler-sized positive integer type.
  subtype psize is positive;

  -- The boolean type.
  subtype bool is boolean;

  -- A character type.
  subtype char is character;

  -- Another naming notation for compiler-sized signed integer type.
  subtype int is integer;
  -- Another naming notation for compiler-sized unsigned integer type.
  subtype nal is natural;
  -- Another naming notation for compiler-sized positive integer type.
  subtype pve is positive;

  -- A fixed-size array of `char` element types.
  subtype str is string;

  -- A fixed-size array of `bit` element types.
  subtype bits is bit_vector;

  -- An unresolved logic type.
  subtype logic is std_ulogic;
  -- A fixed-size array of `logic` element types.
  subtype logics is std_ulogic_vector;

  -- A resolved logic type.
  subtype rlogic is std_logic;
  -- A fixed-size array of `rlogic` element types.
  subtype rlogics is std_logic_vector;

  -- The unsigned logic type.
  subtype usign is unsigned;
  -- The signed logic type.
  subtype isign is signed;

  -- A fixed-size array of `bool` element types.
  type bools is array(natural range<>) of bool;

  -- A fixed-size array of `i8` element types.
  type i8s is array(natural range<>) of i8;
  -- A fixed-size array of `i16` element types.
  type i16s is array(natural range<>) of i16;
  -- A fixed-size array of `i32` element types.
  type i32s is array(natural range<>) of i32;

  -- A fixed-size array of `u8` element types.
  type u8s is array(natural range<>) of u8;
  -- A fixed-size array of `u16` element types.
  type u16s is array(natural range<>) of u16;
  -- A fixed-size array of `u32` element types.
  type u32s is array(natural range<>) of u32;

  -- A fixed-size array of `isize` element types.
  type isizes is array(natural range<>) of isize;
  -- A fixed-size array of `usize` element types.
  type usizes is array(natural range<>) of usize;
  -- A fixed-size array of `psize` element types.
  type psizes is array(natural range<>) of psize;

  -- An unresolved fixed logic vector of length 8.
  subtype byte is logics(7 downto 0);

  -- A resolved fixed logic vector of length 8.
  subtype rbyte is rlogics(7 downto 0);

  -- A fixed-size array of `byte` element types.
  type bytes is array(natural range<>) of byte;

  -- A fixed-size array of `rbyte` element types.
  type rbytes is array(natural range<>) of rbyte;

  -- A severity level type.
  subtype sevel is severity_level;

  -- An empty type.
  type void is (none);

  -- A fixed-size array of `void` element types.
  type voids is array(natural range<>) of void;

  -- Casts a logic vector to a string.
  function to_str(v: logics) return str;

  -- Casts a logic bit to a string.
  function to_str(b: logic) return str;

  -- Casts an integer to a string.
  function to_str(k: int) return str;

  -- Casts a boolean to a string.
  function to_str(b: bool) return str;

  -- Casts a time to a string.
  function to_str(t: time) return str;

  -- Casts a character to a logic bit.
  function to_logic(c: char) return logic;

  -- Casts an unsigned vector to an integer.
  function to_int(v: usign) return int;

  -- Casts a signed vector to an integer.
  function to_int(v: isign) return int;

  -- Casts an integer `k` to a signed vector of `n` bits.
  function to_isign(k: int; n: usize) return isign;

  -- Casts an integer `k` to a unsigned vector of `n` bits.
  function to_usign(k: int; n: usize) return usign;

  -- This function computes the logarithmic (base 2) for `k` and takes the 
  -- ceiling of the result. It effectively determines the minimum number of 
  -- bits required to represent `k` possible values of a space.
  --
  -- Equation: ceil(log2(k))
  function clog2(k: usize) return usize;

  -- This function determines the minimum number of bits required to represent 
  -- the `k` as a decimal number in standard binary representation.
  --
  -- Equation: floor(log2(k) + 1)
  function flog2p1(k: usize) return usize;

  -- This function computes 2 raised to the `k` power.
  -- 
  -- It effectively determines the maximum number of values available for `k`
  -- bits.
  function pow2(k: usize) return usize;

  -- This function computes 2 raised to the `k` minus 1 power.
  -- 
  -- It effectively determines the maximum unsigned number represented in binary 
  -- for `k` bits.
  function pow2m1(k: usize) return usize;

  -- This function checks if `k` is a power of 2.
  --
  -- A number is a power of 2 when its binary represetnation has exactly 1 bit 
  -- set to 1.
  function is_pow2(k: usize) return bool;

  -- Computes the minimum number of bits required to represent `k` possible
  -- values in a set.
  --
  -- Internally, this function uses `clog2(...)`.
  function len_bits_enum(k: usize) return usize;

  -- Computes the minimum number of bits required to represent the decimal
  -- number `k` in standard binary notation.
  --
  -- Internally, this function uses `flog2p1(...)`.
  function len_bits_repr(k: usize) return usize;

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
  function extend_zero(x: logics; n: usize) return logics;

  -- This function performs a sign-extension to the logic vector by a specifying
  -- the total number of bits for the resulting vector. 
  --
  -- Additional bits are filled with the MSB. It is an error for the amount of
  -- bits n < len(x).
  function extend_sign(x: logics; n: usize) return logics;

end package;

package body prelude is

  function to_str(v: logics) return str is
    variable word: str(1 to v'length);
    variable idx_word: psize := 1;
    variable b: logic;
  begin
    for idx in v'range loop
      b := v(idx);
      if b = '1' then
        word(idx_word) := '1';
      elsif b = '0' then
        word(idx_word) := '0';
      elsif b = 'X' then
        word(idx_word) := 'X';
      elsif b = 'U' then
        word(idx_word) := 'U';
      elsif b = 'Z' then
        word(idx_word) := 'Z';
      elsif b = 'W' then
        word(idx_word) := 'W';
      elsif b = 'L' then
        word(idx_word) := 'L';
      elsif b = 'H' then
        word(idx_word) := 'H';
      elsif b = '-' then
        word(idx_word) := '-';
      else
        assert false report "CAST.TO_STR: unsupported logic value" severity warning;
        word(idx_word) := '?';
      end if;
      idx_word := idx_word + 1;
    end loop;
    return word;
  end function;


  function to_str(b: logic) return str is
    variable word: str(1 to 1);
  begin
    if b = '1' then
      word(1) := '1';
    elsif b = '0' then
      word(1) := '0';
    elsif b = 'X' then
      word(1) := 'X';
    elsif b = 'U' then
      word(1) := 'U';
    elsif b = 'Z' then
      word(1) := 'Z';
    elsif b = 'W' then
      word(1) := 'W';
    elsif b = 'L' then
      word(1) := 'L';
    elsif b = 'H' then
      word(1) := 'H';
    elsif b = '-' then
      word(1) := '-';
    else
      assert false report "CAST.TO_STR: unsupported logic value" severity warning;
      word(1) := '?';
    end if;
    return word;
  end function;


  function to_str(k: int) return str is
  begin
    return int'image(k);
  end function;


  function to_str(b: bool) return str is
  begin
    return bool'image(b);
  end function;


  function to_str(t: time) return str is
  begin
    return time'image(t);
  end function;


  function to_logic(c: char) return logic is
  begin
    if c = '1' then
      return '1';
    elsif c = '0' then
      return '0';
    elsif c = 'X' then
      return 'X';
    elsif c = 'U' then
      return 'U';
    elsif c = 'Z' then
      return 'Z';
    elsif c = 'W' then
      return 'W';
    elsif c = 'L' then
      return 'L';
    elsif c = 'H' then
      return 'H';
    elsif c = '-' then
      return '-';
    else
      assert false report "CAST.TO_LOGIC: unsupported character" severity warning;
      return '0';
    end if;
  end function;


  function to_int(v: usign) return int is
  begin
    return to_integer(v);
  end function;

    
  function to_int(v: isign) return int is
  begin
    return to_integer(v);
  end function;


  function to_isign(k: int; n: usize) return isign is
  begin
    return to_signed(k, n);
  end function;


  function to_usign(k: int; n: usize) return usign is
  begin
    return to_unsigned(k, n);
  end function;


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


  function len_bits_enum(k: usize) return usize is
  begin
    return clog2(k);
  end function;


  function len_bits_repr(k: usize) return usize is
  begin
    return flog2p1(k);
  end function;


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


  function extend_zero(x: logics; n: usize) return logics is
    variable tmp: logics(0 downto 0);
  begin
    if n < x'length then
      assert false report "MANIP.EXTEND_ZERO: vector truncated" severity warning;
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


  function extend_sign(x: logics; n: usize) return logics is
    variable tmp: logics(0 downto 0);
  begin
    if n < x'length then
      assert false report "MANIP.EXTEND_SIGN: vector truncated" severity warning;
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