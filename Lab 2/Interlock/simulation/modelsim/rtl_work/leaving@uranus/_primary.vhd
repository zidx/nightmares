library verilog;
use verilog.vl_types.all;
entity leavingUranus is
    generic(
        s0              : vl_logic_vector(0 to 2) := (Hi0, Hi0, Hi0);
        s1              : vl_logic_vector(0 to 2) := (Hi0, Hi0, Hi1);
        s2              : vl_logic_vector(0 to 2) := (Hi0, Hi1, Hi0);
        s3              : vl_logic_vector(0 to 2) := (Hi0, Hi1, Hi1);
        s4              : vl_logic_vector(0 to 2) := (Hi1, Hi0, Hi0);
        s5              : vl_logic_vector(0 to 2) := (Hi1, Hi0, Hi1);
        s6              : vl_logic_vector(0 to 2) := (Hi1, Hi1, Hi0);
        s7              : vl_logic_vector(0 to 2) := (Hi1, Hi1, Hi1);
        l               : vl_logic_vector(0 to 6) := (Hi1, Hi0, Hi0, Hi0, Hi1, Hi1, Hi1);
        e               : vl_logic_vector(0 to 6) := (Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi0);
        p               : vl_logic_vector(0 to 6) := (Hi0, Hi0, Hi0, Hi1, Hi1, Hi0, Hi0);
        nothing         : vl_logic_vector(0 to 6) := (Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1)
    );
    port(
        rst             : in     vl_logic;
        rstCounter      : out    vl_logic;
        clock           : in     vl_logic;
        innerPort       : in     vl_logic;
        outerPort       : in     vl_logic;
        leaving         : in     vl_logic;
        evac            : in     vl_logic;
        pressurize      : in     vl_logic;
        counterVal      : in     vl_logic_vector(2 downto 0);
        display         : out    vl_logic_vector(6 downto 0);
        canOut          : out    vl_logic;
        canIn           : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of s0 : constant is 1;
    attribute mti_svvh_generic_type of s1 : constant is 1;
    attribute mti_svvh_generic_type of s2 : constant is 1;
    attribute mti_svvh_generic_type of s3 : constant is 1;
    attribute mti_svvh_generic_type of s4 : constant is 1;
    attribute mti_svvh_generic_type of s5 : constant is 1;
    attribute mti_svvh_generic_type of s6 : constant is 1;
    attribute mti_svvh_generic_type of s7 : constant is 1;
    attribute mti_svvh_generic_type of l : constant is 1;
    attribute mti_svvh_generic_type of e : constant is 1;
    attribute mti_svvh_generic_type of p : constant is 1;
    attribute mti_svvh_generic_type of nothing : constant is 1;
end leavingUranus;
