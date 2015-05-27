library verilog;
use verilog.vl_types.all;
entity switchesqsys_mm_interconnect_0_rsp_mux is
    port(
        sink0_valid     : in     vl_logic;
        sink0_data      : in     vl_logic_vector(91 downto 0);
        sink0_channel   : in     vl_logic_vector(11 downto 0);
        sink0_startofpacket: in     vl_logic;
        sink0_endofpacket: in     vl_logic;
        sink0_ready     : out    vl_logic;
        sink1_valid     : in     vl_logic;
        sink1_data      : in     vl_logic_vector(91 downto 0);
        sink1_channel   : in     vl_logic_vector(11 downto 0);
        sink1_startofpacket: in     vl_logic;
        sink1_endofpacket: in     vl_logic;
        sink1_ready     : out    vl_logic;
        src_valid       : out    vl_logic;
        src_data        : out    vl_logic_vector(91 downto 0);
        src_channel     : out    vl_logic_vector(11 downto 0);
        src_startofpacket: out    vl_logic;
        src_endofpacket : out    vl_logic;
        src_ready       : in     vl_logic;
        clk             : in     vl_logic;
        reset           : in     vl_logic
    );
end switchesqsys_mm_interconnect_0_rsp_mux;
