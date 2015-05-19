library verilog;
use verilog.vl_types.all;
entity CountUpTestbench is
    generic(
        stimDelay       : integer := 20
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of stimDelay : constant is 1;
end CountUpTestbench;
