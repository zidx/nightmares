library verilog;
use verilog.vl_types.all;
entity ReadInBuffer is
    port(
        charOut         : out    vl_logic_vector(7 downto 0);
        rst             : in     vl_logic;
        clk             : in     vl_logic;
        sampleBit       : in     vl_logic;
        \in\            : in     vl_logic
    );
end ReadInBuffer;
