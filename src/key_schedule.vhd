library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity key_schedule is
    port(data_in:       in std_logic_vector(79 downto 0);
         round_counter: in std_logic_vector(4 downto 0);
         data_out:      out std_logic_vector(79 downto 0)
    );
end key_schedule;

architecture structural of key_schedule is
    signal shifted: std_logic_vector(79 downto 0);

    component sbox
        port(data_in:  in std_logic_vector(3 downto 0);
             data_out: out std_logic_vector(3 downto 0)
        );
    end component;

    begin
        shifted <= data_in(18 downto 0) & data_in(79 downto 19);

        SB: sbox port map(
            data_in => shifted(79 downto 76),
            data_out => data_out(79 downto 76)
        );
        data_out(75 downto 20) <= shifted(75 downto 20);
        data_out(19 downto 15) <= shifted(19 downto 15) xor round_counter;
        data_out(14 downto 0) <= shifted(14 downto 0);
    end structural;
