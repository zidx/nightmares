library verilog;
use verilog.vl_types.all;
entity DownCounterSchematic is
    port(
        altera_reserved_tms: in     vl_logic;
        altera_reserved_tck: in     vl_logic;
        altera_reserved_tdi: in     vl_logic;
        altera_reserved_tdo: out    vl_logic;
        PIN_V18         : out    vl_logic;
        PIN_AF14        : in     vl_logic;
        PIN_AB12        : in     vl_logic;
        PIN_V17         : out    vl_logic;
        PIN_W16         : out    vl_logic;
        PIN_V16         : out    vl_logic
    );
end DownCounterSchematic;
