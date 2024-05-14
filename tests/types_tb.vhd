library ieee;
use ieee.std_logic_1164.all;

library work;
use work.types.all;

entity types_tb is
end entity;

architecture sim of types_tb is
begin

  uut: entity work.pseudo
    port map(
      active => open
    );

  check: process
    variable a0: i32 := 4; 
    constant soln_a0: integer := 14;

    variable vec: i32s(0 to 3) := (-10, 5, -5, 0);
    variable smalls: i8s(0 to 2) := (12, 127, -128);

    variable b: logic := '1';
    variable v: logics(3 downto 0) := "1110";

  begin
    a0 := a0 + 10;
    assert a0 = soln_a0 severity error;

    assert smalls(1) = 127 severity error;
    
    assert v(3) = b severity error;
    assert v(0) /= b severity error;

    wait;
  end process;

end architecture;
