library verilog;
use verilog.vl_types.all;
entity ClockDivider is
    port(
        clock           : in     vl_logic;
        divided_clocks  : out    vl_logic_vector(31 downto 0)
    );
end ClockDivider;
