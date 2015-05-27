library verilog;
use verilog.vl_types.all;
entity shiftOut_testbench is
    generic(
        clkDur          : integer := 2
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of clkDur : constant is 1;
end shiftOut_testbench;
