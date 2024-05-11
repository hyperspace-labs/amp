library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.types.all;
use work.manip.all;

entity manip_tb is
end entity;

architecture sim of manip_tb is

  signal s0: logic;

  constant CODE: bytes(2 downto 0) := (x"FF", x"BB", x"55");

begin

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
    variable u0: logics(0 to 3) := "0000";
    
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

    v0 := logics(usign(v0) sll 1);
    report logic'image(v0(1));

    v0 := "0001";
    report logic'image(v0(1));

    v0 := v0 sll 1;
    -- v0 := v0 ror 1;

    if v0 = "0001" then
      report "yes";
    else
      report "no";
    end if;

    report "Testing logical shift operators...";

    u0 := "1010";
    u0 := u0 srl 0;
    assert u0 = "1010";

    d0 := "1010";
    d0 := d0 sll 0;
    assert d0 = "1010";

    u0 := "1010";
    u0 := u0 sll 0;
    assert u0 = "1010";

    d0 := "1000";
    d0 := d0 srl 1;
    assert d0 = "0100";
    d0 := d0 srl 2;
    assert d0 = "0001";

    u0 := "1000";
    u0 := u0 srl 1;
    assert u0 = "0100";
    u0 := u0 srl 2;
    assert u0 = "0001";

    d0 := "0001";
    d0 := d0 sll 1;
    assert d0 = "0010";
    d0 := d0 sll 2;
    assert d0 = "1000";

    u0 := "0001";
    u0 := u0 sll 1;
    assert u0 = "0010";
    u0 := u0 sll 2;
    assert u0 = "1000";

    report "Testing arithmetic shift operators...";

    d1 := "1";
    d1 := d1 sla 0;
    assert d1 = "1";

    d1 := "1";
    d1 := d1 sla 1;
    assert d1 = "0";

    u1 := "1";
    u1 := u1 sla 0;
    assert u1 = "1";

    u1 := "1";
    u1 := u1 sla 1;
    assert u1 = "1";

    d1 := "1";
    d1 := d1 sra 0;
    assert d1 = "1";

    d1 := "1";
    d1 := d1 sra 1;
    assert d1 = "1";

    u1 := "1";
    u1 := u1 sra 0;
    assert u1 = "1";

    u1 := "1";
    u1 := u1 sra 1;
    assert u1 = "0";

    d0 := "1010";
    d0 := d0 sra 0;
    assert d0 = "1010";

    u0 := "1010";
    u0 := u0 sra 0;
    assert u0 = "1010";

    d0 := "1010";
    d0 := d0 sla 0;
    assert d0 = "1010";

    u0 := "1010";
    u0 := u0 sla 0;
    assert u0 = "1010";

    d0 := "1000";
    d0 := d0 sra 1;
    assert d0 = "1100";
    d0 := d0 sra 2;
    assert d0 = "1111";

    u0 := "1000";
    u0 := u0 sra 1;
    assert u0 = "0100";
    u0 := u0 sra 2;
    assert u0 = "0001";

    d0 := "0001";
    d0 := d0 sla 1;
    assert d0 = "0010";
    d0 := d0 sla 2;
    assert d0 = "1000";

    u0 := "0001";
    u0 := u0 sla 1;
    assert u0 = "0011";
    u0 := u0 sla 2;
    assert u0 = "1111";

    report "Testing rotation operators...";

    -- rotation right

    d0 := "1001";
    d0 := d0 ror 1;
    assert d0 = "1100";

    d0 := "1100";
    d0 := d0 ror 2;
    assert d0 = "0011";

    d0 := "1100";
    d0 := d0 ror 4;
    assert d0 = "1100";

    d0 := "1100";
    d0 := d0 ror 5;
    assert d0 = "0110";

    u0 := "1001";
    u0 := u0 ror 1;
    assert u0 = "1100";

    u0 := "1100";
    u0 := u0 ror 2;
    assert u0 = "0011";

    u0 := "1100";
    u0 := u0 ror 4;
    assert u0 = "1100";

    u0 := "1100";
    u0 := u0 ror 5;
    assert u0 = "0110";

    -- rotation left

    d0 := "1001";
    d0 := d0 rol 1;
    assert d0 = "0011";

    d0 := "1100";
    d0 := d0 rol 2;
    assert d0 = "0011";

    d0 := "1100";
    d0 := d0 rol 4;
    assert d0 = "1100";

    d0 := "1100";
    d0 := d0 rol 5;
    assert d0 = "1001";

    u0 := "1001";
    u0 := u0 rol 1;
    assert u0 = "0011";

    u0 := "1100";
    u0 := u0 rol 2;
    assert u0 = "0011";

    u0 := "1100";
    u0 := u0 rol 4;
    assert u0 = "1100";

    u0 := "1100";
    u0 := u0 rol 5;
    assert u0 = "1001";

    wait;
  end process;

end architecture;