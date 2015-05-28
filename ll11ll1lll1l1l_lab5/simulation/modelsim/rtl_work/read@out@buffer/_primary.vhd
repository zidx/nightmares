library verilog;
use verilog.vl_types.all;
entity readOutBuffer is
    port(
        empty           : out    vl_logic;
        outputStream    : out    vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        load            : in     vl_logic;
        parallelIn      : in     vl_logic_vector(7 downto 0)
    );
end readOutBuffer;
