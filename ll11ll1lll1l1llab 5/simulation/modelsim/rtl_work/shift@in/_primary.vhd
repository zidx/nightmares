library verilog;
use verilog.vl_types.all;
entity shiftIn is
    port(
        \out\           : out    vl_logic_vector(7 downto 0);
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        \in\            : in     vl_logic
    );
end shiftIn;
