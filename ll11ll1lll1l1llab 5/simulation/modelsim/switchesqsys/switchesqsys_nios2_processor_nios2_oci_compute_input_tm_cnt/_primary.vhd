library verilog;
use verilog.vl_types.all;
entity switchesqsys_nios2_processor_nios2_oci_compute_input_tm_cnt is
    port(
        atm_valid       : in     vl_logic;
        dtm_valid       : in     vl_logic;
        itm_valid       : in     vl_logic;
        compute_input_tm_cnt: out    vl_logic_vector(1 downto 0)
    );
end switchesqsys_nios2_processor_nios2_oci_compute_input_tm_cnt;
