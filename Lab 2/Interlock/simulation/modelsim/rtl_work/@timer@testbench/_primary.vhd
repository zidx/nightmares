library verilog;
use verilog.vl_types.all;
entity TimerTestbench is
    generic(
        oneSec          : integer := 390625;
        clkDur          : integer := 100
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of oneSec : constant is 1;
    attribute mti_svvh_generic_type of clkDur : constant is 1;
end TimerTestbench;
