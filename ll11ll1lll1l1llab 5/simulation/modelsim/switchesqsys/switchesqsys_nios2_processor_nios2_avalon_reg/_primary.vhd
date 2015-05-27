library verilog;
use verilog.vl_types.all;
entity switchesqsys_nios2_processor_nios2_avalon_reg is
    port(
        address         : in     vl_logic_vector(8 downto 0);
        clk             : in     vl_logic;
        debugaccess     : in     vl_logic;
        monitor_error   : in     vl_logic;
        monitor_go      : in     vl_logic;
        monitor_ready   : in     vl_logic;
        reset_n         : in     vl_logic;
        write           : in     vl_logic;
        writedata       : in     vl_logic_vector(31 downto 0);
        oci_ienable     : out    vl_logic_vector(31 downto 0);
        oci_reg_readdata: out    vl_logic_vector(31 downto 0);
        oci_single_step_mode: out    vl_logic;
        ocireg_ers      : out    vl_logic;
        ocireg_mrs      : out    vl_logic;
        take_action_ocireg: out    vl_logic
    );
end switchesqsys_nios2_processor_nios2_avalon_reg;
