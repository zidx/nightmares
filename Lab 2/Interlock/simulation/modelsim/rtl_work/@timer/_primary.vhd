library verilog;
use verilog.vl_types.all;
entity Timer is
    generic(
        uranusHz        : vl_logic_vector(0 to 18) := (Hi1, Hi0, Hi1, Hi1, Hi1, Hi1, Hi1, Hi0, Hi1, Hi0, Hi1, Hi1, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi1)
    );
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        seconds         : out    vl_logic_vector(3 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of uranusHz : constant is 1;
end Timer;
