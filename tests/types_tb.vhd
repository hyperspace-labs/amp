library ieee;
use ieee.std_logic_1164.all;

library work;
use work.types.all;

entity types_tb is
end entity;

architecture sim of types_tb is

  signal my_signal: logic := '1';
begin

  uut: entity work.pseudo
    port map(
      active => open
    );

  c1: process
    variable a0: i32 := 4; 
    variable vec: i32s(0 to 3) := (-10, 5, -5, 0);
    variable smalls: i8s(0 to 2) := (12, 127, -128);

  begin
    a0 := a0 + 10;
    report i32'image(a0);
    report i32'image(vec(1) + a0);
    report bool'image(true);
    wait;
  end process;

end architecture;
