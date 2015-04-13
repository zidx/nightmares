library verilog;
use verilog.vl_types.all;
entity ClockDivider is
    generic(
        whichClock      : integer := 10
    );
    port(
        clock           : in     vl_logic;
        \out\           : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of whichClock : constant is 1;
end ClockDivider;
