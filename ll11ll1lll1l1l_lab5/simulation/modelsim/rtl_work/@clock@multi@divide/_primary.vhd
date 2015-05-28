library verilog;
use verilog.vl_types.all;
entity ClockMultiDivide is
    generic(
        clkVal          : vl_logic_vector(0 to 2) := (Hi1, Hi0, Hi1)
    );
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        divided_clock   : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of clkVal : constant is 1;
end ClockMultiDivide;
