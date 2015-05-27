library verilog;
use verilog.vl_types.all;
entity UserInput is
    port(
        clk             : in     vl_logic;
        \in\            : in     vl_logic;
        pressed         : out    vl_logic
    );
end UserInput;
