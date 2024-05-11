library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.types.all;
use work.dim.all;

entity dim_tb is
end entity;

architecture sim of dim_tb is

  signal s0: logic;

begin

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

    row := get2d1d(grid, 1, X_LEN);
    -- col := get2d1d(grid, 4, Y_LEN);
    row(0) := '1';
    wait;
  end process;

end architecture;