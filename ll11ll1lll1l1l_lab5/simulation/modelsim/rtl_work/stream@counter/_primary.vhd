library verilog;
use verilog.vl_types.all;
entity streamCounter is
    port(
        sampleBit       : out    vl_logic;
        strobe          : out    vl_logic;
        rst             : in     vl_logic;
        clk             : in     vl_logic;
        enable          : in     vl_logic
    );
end streamCounter;
