library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity perm_layer is
    port(data_in:  in std_logic_vector(63 downto 0);
         data_out: out std_logic_vector(63 downto 0)
    );
end perm_layer;

architecture structural of perm_layer is
begin
    PERM: for i in 63 downto 0 generate
        data_out((i mod 4) * 16 + (i / 4)) <= data_in(i);
    end generate;
end structural;
