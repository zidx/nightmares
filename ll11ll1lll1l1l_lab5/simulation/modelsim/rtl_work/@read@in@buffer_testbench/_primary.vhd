library verilog;
use verilog.vl_types.all;
entity ReadInBuffer_testbench is
    generic(
        clkDur          : integer := 100;
        sampleDur       : vl_notype
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of clkDur : constant is 1;
    attribute mti_svvh_generic_type of sampleDur : constant is 3;
end ReadInBuffer_testbench;
