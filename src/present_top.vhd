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
        port(data_in:  in std_logic_vector(63 downto 0);
             data_out: out std_logic_vector(63 downto 0)
        );
    end component;

    component perm_layer
        port(data_in:  in std_logic_vector(63 downto 0);
             data_out: out std_logic_vector(63 downto 0)
        );
    end component;

    component key_schedule
        port(data_in:  	    in std_logic_vector(79 downto 0);
             round_counter: in std_logic_vector(4 downto 0);
             data_out:      out std_logic_vector(79 downto 0)
        );
    end component;

    begin
        SL: sub_layer port map(
            data_in => data_key_added,
            data_out => data_substituted
        );

        PL: perm_layer port map(
            data_in => data_substituted,
            data_out => data_permuted
        );

        KS: key_schedule port map(
            data_in => key_state,
            round_counter => round_counter,
            data_out => key_updated
        );

        data_key_added <= data_state xor key_state(79 downto 16);

        process(clk, reset, plaintext, key)
        begin
            if reset = '1' then
                data_state <= plaintext;
                key_state <= key;
                round_counter <= "00001";
                ciphertext <= x"0000000000000000";
            elsif rising_edge(clk) then
                data_state <= data_permuted;
                key_state <= key_updated;
                round_counter <= std_logic_vector(unsigned(round_counter) + 1);
                
                -- when we are "past" the final round, i.e. the 31st round was finished,
                -- the round counter addition overflows back to zero. Now set the output
                -- signal to the ciphertext.
                case round_counter is
                    when "00000" => ciphertext <= data_key_added;
                    when others => ciphertext <= x"0000000000000000";
                end case;
                --if round_counter = "00000" then
                --    ciphertext <= data_key_added;
                --end if;
            end if;
        end process;
    end behavioral;
