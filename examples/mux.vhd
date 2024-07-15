-- Project: Amp
-- Entity: mux
--
-- This design unit is a generic mux that showcases one way to use the
-- Amp library.

library ieee;
use ieee.std_logic_1164.all;

library amp;
use amp.prelude.all;
use amp.math.all;
use amp.dims.all;

entity mux is 
  generic(
    -- The width of the words available for selection.
    WORD_SIZE: psize;
    -- The number of lines to select from (choose a power of 2).
    SEL_COUNT: psize
  );
  port(
    a: in logics(WORD_SIZE*SEL_COUNT-1 downto 0);
    sel: in logics(length_bits_enum(SEL_COUNT)-1 downto 0);
    y: out logics(WORD_SIZE-1 downto 0)
  );
end entity;

architecture gp of mux is

  constant y_inner: logics(y'range) := (others => '0');

begin
  
  y <= get_slice(a, y_inner, usize(to_int(usign(sel))));

end architecture;
