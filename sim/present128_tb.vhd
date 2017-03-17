--------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date:   14:37:59 02/28/2017
-- Design Name:
-- Module Name:   /home/julian/Projekt/Xilinx Projects/present-vhdl/src/present_tb.vhd
-- Project Name:  present-vhdl
-- Target Device:
-- Tool versions:
-- Description:
--
-- VHDL Test Bench Created by ISE for module: present_top
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes:
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE std.textio.ALL;
USE ieee.std_logic_textio.ALL;
USE work.util.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;

ENTITY present128_tb IS
END present128_tb;

ARCHITECTURE behavior OF present128_tb IS

    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT present_top
    GENERIC(
         k : key_enum
        );
    PORT(
         plaintext : IN  std_logic_vector(63 downto 0);
         key : IN  std_logic_vector(key_bits(k)-1 downto 0);
         clk : IN  std_logic;
         reset : IN  std_logic;
         ciphertext : OUT  std_logic_vector(63 downto 0)
        );
    END COMPONENT;


   --Inputs
   signal plaintext : std_logic_vector(63 downto 0) := (others => '0');
   signal key : std_logic_vector(127 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal ciphertext : std_logic_vector(63 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
   uut: present_top GENERIC MAP (
          k => K_128
        ) PORT MAP (
          plaintext => plaintext,
          key => key,
          clk => clk,
          reset => reset,
          ciphertext => ciphertext
        );

   -- Clock process definitions
   clk_process: process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;


   -- Stimulus process
   stim_proc: process
      variable ct: line;
   begin
      -- hold reset state for 100 ns.
      wait for 100 ns;

      -- Test vector from:
      -- http://www.lightweightcrypto.org/downloads/implementations/pypresent.py
      reset <= '1';
      plaintext <= x"0123456789ABCDEF";
      key <= x"0123456789ABCDEF0123456789ABCDEF";
      wait for 10 ns;
      reset <= '0';
      wait for 320 ns;
      hwrite(ct, ciphertext);
      report "Ciphertext is " & ct.all & " (expected value: 0E9D28685E671DD6)";
      deallocate(ct);

      wait;
   end process;

END;
