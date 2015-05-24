	component switchesqsys is
		port (
			clk_clk                 : in  std_logic                    := 'X';             -- clk
			reset_reset_n           : in  std_logic                    := 'X';             -- reset_n
			switches_export         : in  std_logic_vector(7 downto 0) := (others => 'X'); -- export
			leds_export             : out std_logic_vector(7 downto 0);                    -- export
			readytodownload1_export : in  std_logic                    := 'X';             -- export
			outsignal_export        : out std_logic_vector(1 downto 0);                    -- export
			curbyte1_export         : in  std_logic_vector(7 downto 0) := (others => 'X'); -- export
			readytodownload2_export : in  std_logic                    := 'X';             -- export
			curbyte2_export         : in  std_logic_vector(7 downto 0) := (others => 'X'); -- export
			stroberead1_export      : in  std_logic                    := 'X';             -- export
			stroberead2_export      : in  std_logic                    := 'X'              -- export
		);
	end component switchesqsys;

	u0 : component switchesqsys
		port map (
			clk_clk                 => CONNECTED_TO_clk_clk,                 --              clk.clk
			reset_reset_n           => CONNECTED_TO_reset_reset_n,           --            reset.reset_n
			switches_export         => CONNECTED_TO_switches_export,         --         switches.export
			leds_export             => CONNECTED_TO_leds_export,             --             leds.export
			readytodownload1_export => CONNECTED_TO_readytodownload1_export, -- readytodownload1.export
			outsignal_export        => CONNECTED_TO_outsignal_export,        --        outsignal.export
			curbyte1_export         => CONNECTED_TO_curbyte1_export,         --         curbyte1.export
			readytodownload2_export => CONNECTED_TO_readytodownload2_export, -- readytodownload2.export
			curbyte2_export         => CONNECTED_TO_curbyte2_export,         --         curbyte2.export
			stroberead1_export      => CONNECTED_TO_stroberead1_export,      --      stroberead1.export
			stroberead2_export      => CONNECTED_TO_stroberead2_export       --      stroberead2.export
		);

