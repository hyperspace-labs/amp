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
    constant v3: usize := 4;

    constant tests: usizes := (0, 3, 4, 8, 15, 16);
    variable num: usize := 0;
  begin
    report "clog2: " & usize'image(clog2(v1));
    report "flog2p1: " & usize'image(flog2p1(v1));
    report "pow2m1: " & usize'image(pow2m1(v2));
    report "pow2: " & usize'image(pow2(v2));

    for k in tests'range loop
      num := tests(k);
      report "value: " & int'image(num);
      report "needs " & usize'image(len_bits_repr(num)) & " bits to be decimal number";
      report "needs " & usize'image(len_bits_enum(num)) & " bits to enumerate spaces";
    end loop;
    wait;
  end process;

end architecture;