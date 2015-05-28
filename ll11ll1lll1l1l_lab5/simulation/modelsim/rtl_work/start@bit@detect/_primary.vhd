library verilog;
use verilog.vl_types.all;
entity startBitDetect is
    port(
        enable          : out    vl_logic;
        rst             : in     vl_logic;
        clk             : in     vl_logic;
        bitStream       : in     vl_logic
    );
end startBitDetect;
