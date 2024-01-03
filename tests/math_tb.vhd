library ieee;
use ieee.std_logic_1164.all;

library work;
use work.types.all;
use work.math.all;

entity math_tb is
end entity;

architecture sim of math_tb is

  signal my_signal: logic := '1';
begin

  uut: entity work.pseudo
    port map(
      active => open
    );

  c1: process
    constant v1: usize := 0;
    constant v2: usize := 3;
  begin
    report "clog2: " & usize'image(clog2(v1));
    report "flog2p1: " & usize'image(flog2p1(v1));
    report "pow2m1: " & usize'image(pow2m1(v2));
    report "pow2: " & usize'image(pow2(v2));
    wait;
  end process;

end architecture;