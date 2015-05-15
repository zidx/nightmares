	component first_nios2_system is
		port (
			reset_reset_n                      : in  std_logic                    := 'X'; -- reset_n
			clk_clk                            : in  std_logic                    := 'X'; -- clk
			led_pio_external_connection_export : out std_logic_vector(7 downto 0)         -- export
		);
	end component first_nios2_system;

	u0 : component first_nios2_system
		port map (
			reset_reset_n                      => CONNECTED_TO_reset_reset_n,                      --                       reset.reset_n
			clk_clk                            => CONNECTED_TO_clk_clk,                            --                         clk.clk
			led_pio_external_connection_export => CONNECTED_TO_led_pio_external_connection_export  -- led_pio_external_connection.export
		);

