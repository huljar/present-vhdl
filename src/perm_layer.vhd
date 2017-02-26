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
        -- data_out(0)  <= data_in(0);
        -- data_out(16) <= data_in(1);
        -- data_out(32) <= data_in(2);
        -- data_out(48) <= data_in(3);
        -- data_out(1)  <= data_in(4);
        -- data_out(17) <= data_in(5);
        -- data_out(33) <= data_in(6);
        -- data_out(49) <= data_in(7);
        --
        -- data_out(2)  <= data_in(8);
        -- data_out(18) <= data_in(9);
        -- data_out(34) <= data_in(10);
        -- data_out(50) <= data_in(11);
        -- data_out(3)  <= data_in(12);
        -- data_out(19) <= data_in(13);
        -- data_out(35) <= data_in(14);
        -- data_out(51) <= data_in(15);
        --
        -- data_out(4)  <= data_in(16);
        -- data_out(20) <= data_in(17);
        -- data_out(36) <= data_in(18);
        -- data_out(52) <= data_in(19);
        -- data_out(5)  <= data_in(20);
        -- data_out(21) <= data_in(21);
        -- data_out(37) <= data_in(22);
        -- data_out(53) <= data_in(23);
        --
        -- data_out(6)  <= data_in(24);
        -- data_out(22) <= data_in(25);
        -- data_out(38) <= data_in(26);
        -- data_out(54) <= data_in(27);
        -- data_out(7)  <= data_in(28);
        -- data_out(23) <= data_in(29);
        -- data_out(39) <= data_in(30);
        -- data_out(55) <= data_in(31);
        --
        -- data_out(8)  <= data_in(32);
        -- data_out(24) <= data_in(33);
        -- data_out(40) <= data_in(34);
        -- data_out(56) <= data_in(35);
        -- data_out(9)  <= data_in(36);
        -- data_out(25) <= data_in(37);
        -- data_out(41) <= data_in(38);
        -- data_out(57) <= data_in(39);
        --
        -- data_out(10) <= data_in(40);
        -- data_out(26) <= data_in(41);
        -- data_out(42) <= data_in(42);
        -- data_out(58) <= data_in(43);
        -- data_out(11) <= data_in(44);
        -- data_out(27) <= data_in(45);
        -- data_out(43) <= data_in(46);
        -- data_out(59) <= data_in(47);
        --
        -- data_out(12) <= data_in(48);
        -- data_out(28) <= data_in(49);
        -- data_out(44) <= data_in(50);
        -- data_out(60) <= data_in(51);
        -- data_out(13) <= data_in(52);
        -- data_out(29) <= data_in(53);
        -- data_out(45) <= data_in(54);
        -- data_out(61) <= data_in(55);
        --
        -- data_out(14) <= data_in(56);
        -- data_out(30) <= data_in(57);
        -- data_out(46) <= data_in(58);
        -- data_out(62) <= data_in(59);
        -- data_out(15) <= data_in(60);
        -- data_out(31) <= data_in(61);
        -- data_out(47) <= data_in(62);
        -- data_out(63) <= data_in(63);
    end structural;
