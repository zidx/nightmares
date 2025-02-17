library verilog;
use verilog.vl_types.all;
entity switchesqsys_nios2_processor_nios2_oci_pib is
    port(
        clk             : in     vl_logic;
        clkx2           : in     vl_logic;
        jrst_n          : in     vl_logic;
        tw              : in     vl_logic_vector(35 downto 0);
        tr_clk          : out    vl_logic;
        tr_data         : out    vl_logic_vector(17 downto 0)
    );
end switchesqsys_nios2_processor_nios2_oci_pib;
