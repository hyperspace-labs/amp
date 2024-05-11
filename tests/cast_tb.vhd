library ieee;
use ieee.std_logic_1164.all;

library work;
use work.types.all;
use work.cast.all;

entity cast_tb is
end entity;

architecture sim of cast_tb is

  signal b0: logic := '1';
  signal v0: logics(3 downto 0) := "1010";
  
begin

  uut: entity work.pseudo
    port map(
      active => open
    );

  c1: process
    variable vv0: logics(3 downto 0) := "0W-0";
  begin
    report to_str(v0);
    report to_str(b0);
    report int'image(to_int(isign(v0)));
    report int'image(to_int(usign(v0)));

    report logic'image(to_logic('a'));

    report "vv0 = " & to_str(vv0);
    vv0 := logics(to_usign(16, vv0'length));
    report "vv0 = " & to_str(vv0);
    wait;
  end process;

end architecture;
