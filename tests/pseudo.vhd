library ieee;
use ieee.std_logic_1164.all;

entity pseudo is
  port(
    active: out std_logic
  );
end entity;

architecture rtl of pseudo is
begin

  active <= '1';
  
end architecture;