library verilog;
use verilog.vl_types.all;
entity fourBitCounter is
    port(
        \out\           : out    vl_logic_vector(3 downto 0);
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        enable          : in     vl_logic
    );
end fourBitCounter;
