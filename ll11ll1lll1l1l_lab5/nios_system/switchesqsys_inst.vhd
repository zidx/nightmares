	component switchesqsys is
		port (
			clk_clk                : in  std_logic                    := 'X';             -- clk
			reset_reset_n          : in  std_logic                    := 'X';             -- reset_n
			switches_export        : in  std_logic_vector(7 downto 0) := (others => 'X'); -- export
			leds_export            : out std_logic_vector(7 downto 0);                    -- export
			readytodownload_export : in  std_logic                    := 'X';             -- export
			outsignal_export       : out std_logic_vector(1 downto 0);                    -- export
			curbyteout_export      : out std_logic_vector(7 downto 0);                    -- export
			instrobe_export        : in  std_logic                    := 'X';             -- export
			load_export            : out std_logic;                                       -- export
			curbytein_export       : in  std_logic_vector(7 downto 0) := (others => 'X'); -- export
			empty_export           : in  std_logic                    := 'X'              -- export
		);
	end component switchesqsys;

	u0 : component switchesqsys
		port map (
			clk_clk                => CONNECTED_TO_clk_clk,                --             clk.clk
			reset_reset_n          => CONNECTED_TO_reset_reset_n,          --           reset.reset_n
			switches_export        => CONNECTED_TO_switches_export,        --        switches.export
			leds_export            => CONNECTED_TO_leds_export,            --            leds.export
			readytodownload_export => CONNECTED_TO_readytodownload_export, -- readytodownload.export
			outsignal_export       => CONNECTED_TO_outsignal_export,       --       outsignal.export
			curbyteout_export      => CONNECTED_TO_curbyteout_export,      --      curbyteout.export
			instrobe_export        => CONNECTED_TO_instrobe_export,        --        instrobe.export
			load_export            => CONNECTED_TO_load_export,            --            load.export
			curbytein_export       => CONNECTED_TO_curbytein_export,       --       curbytein.export
			empty_export           => CONNECTED_TO_empty_export            --           empty.export
		);

