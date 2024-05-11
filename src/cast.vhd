-- Project: amp
-- Package: cast
--
-- Conversion functions between data types in VHDL. These functions
-- are called in higher-level hardware driver layer functions.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.types.all;

package cast is

    -- Casts a logic vector to a string.
    function to_str(v: logics) return str;

    -- Casts a logic bit to a string.
    function to_str(b: logic) return str;

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

end package;


package body cast is

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

end package body;