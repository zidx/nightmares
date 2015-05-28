library verilog;
use verilog.vl_types.all;
entity lights_testbench is
    generic(
        clkDur          : integer := 100
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of clkDur : constant is 1;
end lights_testbench;
