library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.types.all;
use work.dim.all;
use work.cast.all;

entity dim_tb is
end entity;

architecture sim of dim_tb is

  signal s0: logic;

  signal line0: logics(3 downto 0) := "1111";

  constant A_LEN: usize := 2;
  constant B_LEN: usize := 4;

  signal g0: logics(A_LEN*B_LEN-1 downto 0) := (others => '0');

  signal a0: logics(A_LEN-1 downto 0) := "11";

begin

  g0 <= set_2d1d(g0, a0, 1);

  line0(index_1d(2)) <= '0';

  uut: entity work.pseudo
    port map(
      active => open
    );

  c1: process
    constant X_LEN: usize := 1;
    constant Y_LEN: usize := 4;

    constant code: bytes(2 downto 0) := (x"FF", x"BB", x"55");

    variable grid: logics(X_LEN*Y_LEN-1 downto 0) := ('0', '0', '1', '1');
    
    variable row: logics(X_LEN-1 downto 0);
    variable col: logics(Y_LEN-1 downto 0);
  begin

    row := get_2d1d(grid, row, 0);
    -- col := get2d1d(grid, 4, Y_LEN);
    row(0) := '1';

    row(index_1d(0)) := '0';
    report logic'image(row(index_1d(0)));

    report logic'image(line0(index_1d(2)));

    wait for 0 ns;

    report to_str(g0);
    report to_str(get_2d1d(g0, a0, 1));
    wait;
  end process;

end architecture;