library verilog;
use verilog.vl_types.all;
entity shiftOut is
    port(
        \out\           : out    vl_logic;
        hempTea         : out    vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        load            : in     vl_logic;
        byteIn          : in     vl_logic_vector(7 downto 0)
    );
end shiftOut;
