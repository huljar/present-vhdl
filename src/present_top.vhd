library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity present_top is
    port(plaintext:  in std_logic_vector(63 downto 0);
         key:        in std_logic_vector(79 downto 0);
         clk:        in std_logic;
         reset:      in std_logic;
         ciphertext: out std_logic_vector(63 downto 0)
    );
end present_top;

architecture behavioral of present_top is
    signal data_state,
           data_key_added,
           data_substituted,
           data_permuted: std_logic_vector(63 downto 0);
    signal key_state,
           key_updated: std_logic_vector(79 downto 0);
    signal round_counter: std_logic_vector(4 downto 0);

    component sub_layer
        port(sub_in:  in std_logic_vector(63 downto 0);
             sub_out: out std_logic_vector(63 downto 0)
        );
    end component;

    component perm_layer
        port(perm_in:  in std_logic_vector(63 downto 0);
             perm_out: out std_logic_vector(63 downto 0)
        );
    end component;

    component key_schedule
        port(ks_in:  in std_logic_vector(79 downto 0);
             rc:     in std_logic_vector(4 downto 0);
             ks_out: out std_logic_vector(79 downto 0)
        );
    end component;

    begin
        SL: sub_layer port map(
            sub_in => data_key_added,
            sub_out => data_substituted
        );

        PL: perm_layer port map(
            perm_in => data_substituted,
            perm_out => data_permuted
        );

        KS: key_schedule port map(
            ks_in => key_state,
            rc => round_counter,
            ks_out => key_updated
        );

        data_key_added <= data_state xor key_state(79 downto 16);

        process(clk, reset)
        begin
            if reset = '1' then
                data_state <= plaintext;
                key_state <= key;
                round_counter <= b"00001";
            elsif rising_edge(clk) then
                data_state <= data_permuted;
                key_state <= key_updated;
                round_counter <= std_logic_vector(unsigned(round_counter) + 1);
            end if;
        end process;
    end behavioral;
