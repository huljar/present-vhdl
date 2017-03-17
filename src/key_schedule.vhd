library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.util.all;

entity key_schedule is
    generic(k: key_enum);
    port(data_in:       in std_logic_vector(key_bits(k)-1 downto 0);
         round_counter: in std_logic_vector(4 downto 0);
         data_out:      out std_logic_vector(key_bits(k)-1 downto 0)
    );
end key_schedule;

architecture structural of key_schedule is
    signal shifted: std_logic_vector(key_bits(k)-1 downto 0);

    component sbox
        port(data_in:  in std_logic_vector(3 downto 0);
             data_out: out std_logic_vector(3 downto 0)
        );
    end component;
begin
    SCHEDULE_80: if k = K_80 generate
        shifted <= data_in(18 downto 0) & data_in(79 downto 19);

        SB: sbox port map(
            data_in => shifted(79 downto 76),
            data_out => data_out(79 downto 76)
        );
        data_out(75 downto 20) <= shifted(75 downto 20);
        data_out(19 downto 15) <= shifted(19 downto 15) xor round_counter;
        data_out(14 downto 0) <= shifted(14 downto 0);
    end generate;

    SCHEDULE_128: if k = K_128 generate
        shifted <= data_in(66 downto 0) & data_in(127 downto 67);

        SB1: sbox port map(
            data_in => shifted(127 downto 124),
            data_out => data_out(127 downto 124)
        );
        SB2: sbox port map(
            data_in => shifted(123 downto 120),
            data_out => data_out(123 downto 120)
        );
        data_out(119 downto 67) <= shifted(119 downto 67);
        data_out(66 downto 62) <= shifted(66 downto 62) xor round_counter;
        data_out(61 downto 0) <= shifted(61 downto 0);
    end generate;
end structural;
