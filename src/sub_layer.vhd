library ieee;
use ieee.std_logic_1164.all;

entity sub_layer is
    port(data_in:  in std_logic_vector(63 downto 0);
         data_out: out std_logic_vector(63 downto 0)
    );
end sub_layer;

architecture structural of sub_layer is
    component sbox
        port(data_in:  in std_logic_vector(3 downto 0);
             data_out: out std_logic_vector(3 downto 0)
        );
    end component;
begin
    GEN_SBOXES: for i in 15 downto 0 generate
        SX: sbox port map(
            data_in => data_in(4*i+3 downto 4*i),
            data_out => data_out(4*i+3 downto 4*i)
        );
    end generate;
end structural;
