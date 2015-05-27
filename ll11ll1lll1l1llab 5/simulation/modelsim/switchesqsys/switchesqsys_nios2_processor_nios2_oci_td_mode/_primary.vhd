library verilog;
use verilog.vl_types.all;
entity switchesqsys_nios2_processor_nios2_oci_td_mode is
    port(
        ctrl            : in     vl_logic_vector(8 downto 0);
        td_mode         : out    vl_logic_vector(3 downto 0)
    );
end switchesqsys_nios2_processor_nios2_oci_td_mode;
