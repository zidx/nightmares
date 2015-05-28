library verilog;
use verilog.vl_types.all;
entity switchesqsys is
    port(
        clk_clk         : in     vl_logic;
        reset_reset_n   : in     vl_logic;
        switches_export : in     vl_logic_vector(7 downto 0);
        leds_export     : out    vl_logic_vector(7 downto 0);
        readytodownload_export: in     vl_logic;
        outsignal_export: out    vl_logic_vector(1 downto 0);
        curbyteout_export: out    vl_logic_vector(7 downto 0);
        instrobe_export : in     vl_logic;
        load_export     : out    vl_logic;
        curbytein_export: in     vl_logic_vector(7 downto 0);
        empty_export    : in     vl_logic
    );
end switchesqsys;
