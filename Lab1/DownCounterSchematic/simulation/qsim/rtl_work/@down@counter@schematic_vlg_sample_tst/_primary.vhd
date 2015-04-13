library verilog;
use verilog.vl_types.all;
entity DownCounterSchematic_vlg_sample_tst is
    port(
        PIN_AB12        : in     vl_logic;
        PIN_AF14        : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end DownCounterSchematic_vlg_sample_tst;
