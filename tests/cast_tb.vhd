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

  check: process
    variable vv0: logics(3 downto 0) := "0W-0";

    constant c_p: psize := 10;
    constant c_u: usize := 0;
    constant c_i: isize := -14;

  begin
    assert to_str(c_p) = "10" severity error;
    assert to_str(c_u) = "0" severity error;
    assert to_str(c_i) = "-14" severity error;
    
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
