-- Project: Amp
-- Entity: Mux
--
-- This design unit is a generic mux that showcases one way to use the
-- Amp library.

library ieee;
use ieee.std_logic_1164.all;

library micro;
use micro.amp.all;
use micro.math.all;

entity mux is 
  generic(
    -- The width of the words available for selection.
    WORD_SIZE: psize;
    -- The number of lines to select from (choose a power of 2).
    SEL_COUNT: psize
  );
  port(
    a: in logics(WORD_SIZE*SEL_COUNT-1 downto 0);
    sel: in logics(enum(SEL_COUNT)-1 downto 0);
    y: out logics(WORD_SIZE-1 downto 0)
  );
end entity;

architecture gp of mux is

  signal y_inner: logics(y'range);

begin

  y_inner <= a(((to_int(usign(sel))+1)*y_inner'length)-1+0 downto (to_int(usign(sel))*y_inner'length)+0);

  y <= y_inner;

end architecture;
