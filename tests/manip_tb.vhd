library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.types.all;
use work.manip.all;
use work.cast.all;

entity manip_tb is
end entity;

architecture sim of manip_tb is

  signal s0: logic;

  constant CODE: bytes(2 downto 0) := (x"FF", x"BB", x"55");

  signal k0: logics(1 downto 0) := "01";
  signal k0_comp: logics(1 downto 0);

begin

  k0_comp <= not k0;

  uut: entity work.pseudo
    port map(
      active => open
    );

  c1: process
    variable v0: logics(3 downto 0) := (others => '0');
    variable v1: logics(3 downto 0) := "0001";

    variable r0: rlogics(3 downto 0) := (others => '0');
    variable r1: rlogics(3 downto 0) := "0001";

    variable d0: logics(3 downto 0) := "0000";

    variable d0_trunc: logics(1 downto 0) := "00";
    variable d0_exten: logics(5 downto 0) := "000000";

    variable u0: logics(0 to 3) := "0000";

    variable u0_trunc: logics(0 to 1) := "00";
    variable u0_exten: logics(0 to 5) := "000000";
    
    variable d1: logics(0 downto 0) := "0";
    variable u1: logics(0 to 0) := "0";

    variable rs: logics(1 downto 0);
  begin
    rs := logics(resize(usign(d0), 2));
    -- wait;

    v0 := logics(usign(v0) + usign(v1));
    -- saves 16 characters per addition and retains explicit casting
    -- v0 := std_logic_vector(unsigned(v0) + unsigned(v1));
    report logic'image(v0(0));
    -- v0 := logics(usign(v0) + '1');

    r0 := rlogics(usign(r0) - usign(r1));
    report rlogic'image(r0(0));

    v0 := "0001";
    v0 := shift_ll(v0, 1);
    report "v0(1) = " & logic'image(v0(1));
    v0 := shift_rl(v0, 1);
    report "v0(1) = " & logic'image(v0(1));
    
    v0 := "0010";
    v0 := rotate_r(v0, 1);

    if v0 = "0001" then
      report "yes";
    else
      report "no";
    end if;

    report "Testing logical shift operators...";

    u0 := "1010";
    u0 := shift_rl(u0, 0);
    assert u0 = "1010";

    d0 := "1010";
    d0 := shift_ll(d0, 0);
    assert d0 = "1010";

    u0 := "1010";
    u0 := shift_ll(u0, 0);
    assert u0 = "1010";

    d0 := "1000";
    d0 := shift_rl(d0, 1);
    assert d0 = "0100";
    d0 := shift_rl(d0, 2);
    assert d0 = "0001";

    u0 := "1000";
    u0 := shift_rl(u0, 1);
    assert u0 = "0100";
    u0 := shift_rl(u0, 2);
    assert u0 = "0001";

    d0 := "0001";
    d0 := shift_ll(d0, 1);
    assert d0 = "0010";
    d0 := shift_ll(d0, 2);
    assert d0 = "1000";

    u0 := "0001";
    u0 := shift_ll(u0, 1);
    assert u0 = "0010";
    u0 := shift_ll(u0, 2);
    assert u0 = "1000";

    report "Testing arithmetic shift operators...";

    d1 := "1";
    d1 := shift_la(d1, 0);
    assert d1 = "1";

    d1 := "1";
    d1 := shift_la(d1, 1);
    assert d1 = "0";

    u1 := "1";
    u1 := shift_la(u1, 0);
    assert u1 = "1";

    u1 := "1";
    u1 := shift_la(u1, 1);
    assert u1 = "1";

    d1 := "1";
    d1 := shift_ra(d1, 0);
    assert d1 = "1";

    d1 := "1";
    d1 := shift_ra(d1, 1);
    assert d1 = "1";

    u1 := "1";
    u1 := shift_ra(u1, 0);
    assert u1 = "1";

    u1 := "1";
    u1 := shift_ra(u1, 1);
    assert u1 = "0";

    d0 := "1010";
    d0 := shift_ra(d0, 0);
    assert d0 = "1010";

    u0 := "1010";
    u0 := shift_ra(u0, 0);
    assert u0 = "1010";

    d0 := "1010";
    d0 := shift_la(d0, 0);
    assert d0 = "1010";

    u0 := "1010";
    u0 := shift_la(u0, 0);
    assert u0 = "1010";

    d0 := "1000";
    d0 := shift_ra(d0, 1);
    assert d0 = "1100";
    d0 := shift_ra(d0, 2);
    assert d0 = "1111";

    u0 := "1000";
    u0 := shift_ra(u0, 1);
    assert u0 = "0100";
    u0 := shift_ra(u0, 2);
    assert u0 = "0001";

    d0 := "0001";
    d0 := shift_la(d0, 1);
    assert d0 = "0010";
    d0 := shift_la(d0, 2);
    assert d0 = "1000";

    u0 := "0001";
    u0 := shift_la(u0, 1);
    assert u0 = "0011";
    u0 := shift_la(u0, 2);
    assert u0 = "1111";

    report "Testing rotation operators...";

    -- rotation right

    d0 := "1001";
    d0 := rotate_r(d0, 1);
    assert d0 = "1100";

    d0 := "1100";
    d0 := rotate_r(d0, 2);
    assert d0 = "0011";

    d0 := "1100";
    d0 := rotate_r(d0, 4);
    assert d0 = "1100";

    d0 := "1100";
    d0 := rotate_r(d0, 5);
    assert d0 = "0110";

    u0 := "1001";
    u0 := rotate_r(u0, 1);
    assert u0 = "1100";

    u0 := "1100";
    u0 := rotate_r(u0, 2);
    assert u0 = "0011";

    u0 := "1100";
    u0 := rotate_r(u0, 4);
    assert u0 = "1100";

    u0 := "1100";
    u0 := rotate_r(u0, 5);
    assert u0 = "0110";

    -- rotation left

    d0 := "1001";
    d0 := rotate_l(d0, 1);
    assert d0 = "0011";

    d0 := "1100";
    d0 := rotate_l(d0, 2);
    assert d0 = "0011";

    d0 := "1100";
    d0 := rotate_l(d0, 4);
    assert d0 = "1100";

    d0 := "1100";
    d0 := rotate_l(d0, 5);
    assert d0 = "1001";

    u0 := "1001";
    u0 := rotate_l(u0, 1);
    assert u0 = "0011";

    u0 := "1100";
    u0 := rotate_l(u0, 2);
    assert u0 = "0011";

    u0 := "1100";
    u0 := rotate_l(u0, 4);
    assert u0 = "1100";

    u0 := "1100";
    u0 := rotate_l(u0, 5);
    assert u0 = "1001";

    wait for 0 ns;
    report isize'image(to_integer(usign(k0_comp)));

    report "Testing extension functions (downto)...";

    d0 := "1100";
    d0_trunc := extend_z(d0, d0_trunc'length);
    report to_str(d0_trunc);

    d0_exten := extend_z(d0, d0_exten'length);
    report to_str(d0_exten);

    d0_trunc := extend_s(d0, d0_trunc'length);
    report to_str(d0_trunc);

    d0_exten := extend_s(d0, d0_exten'length);
    report to_str(d0_exten);

    report "Testing extension functions (to)...";

    u0 := "1001";
    u0_trunc := extend_z(u0, u0_trunc'length);
    report to_str(u0_trunc);

    u0_exten := extend_z(u0, u0_exten'length);
    report to_str(u0_exten);

    u0_trunc := extend_s(u0, u0_trunc'length);
    report to_str(u0_trunc);

    u0_exten := extend_s(u0, u0_exten'length);
    report to_str(u0_exten);

    wait;
  end process;

end architecture;