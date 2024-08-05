-- Project: Amp
-- Testbench: mux_tb
--
-- Functional verification for the design-under-test (DUT).

library ieee;
use ieee.std_logic_1164.all;

library std;
use std.textio.all;

library nano;
use nano.amp.all;
use nano.dims.all;
use nano.math.all;

entity mux_tb is
  generic(
    WORD_SIZE: psize := 4;
    SEL_COUNT: psize := 4
  );
end entity;

architecture sim of mux_tb is

  constant CLK_PERIOD: time := 40 ns;

  signal halt: bool := false;
  signal clk: logic := '0';

  signal a: logics(WORD_SIZE*SEL_COUNT-1 downto 0) := (others => '0');
  signal sel: logics(enum(SEL_COUNT)-1 downto 0) := (others => '0');
  signal y: logics(WORD_SIZE-1 downto 0);

begin
  -- Create an instance of the DUT
  dut: entity work.mux(gp)
  generic map(
    WORD_SIZE => WORD_SIZE,
    SEL_COUNT => SEL_COUNT
  )
  port map(
    a => a,
    sel => sel,
    y => y
  );

  -- Run a clock with an even duty cycle
  clk <= not clk after CLK_PERIOD when halt = false;

  -- Send inputs to the DUT and receive outputs from the DUT
  bench: process
    variable d, e, f, g: logics(WORD_SIZE-1 downto 0);

    variable s: logics(sel'range);

  begin

    d := logics(to_usign(1, WORD_SIZE));
    e :=logics(to_usign(3, WORD_SIZE));
    f := logics(to_usign(5, WORD_SIZE));
    g := logics(to_usign(15, WORD_SIZE));

    a <= g & f & e & d;

    s := logics(to_usign(1, enum(SEL_COUNT)));
    sel <= s;
    wait until rising_edge(clk);
    report to_str(y);

    s := logics(to_usign(2, enum(SEL_COUNT)));
    sel <= s;
    wait until rising_edge(clk);
    report to_str(y);

    s := logics(to_usign(0, enum(SEL_COUNT)));
    sel <= s;
    wait until rising_edge(clk);
    report to_str(y);

    s := logics(to_usign(3, enum(SEL_COUNT)));
    sel <= s;
    wait until rising_edge(clk);
    report to_str(y);

    -- Finish the simulation
    halt <= true;
    wait;
  end process;

end architecture;