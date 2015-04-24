library verilog;
use verilog.vl_types.all;
entity enteringUranus is
    generic(
        defaultState    : vl_logic_vector(0 to 2) := (Hi0, Hi0, Hi0);
        arriveTiming    : vl_logic_vector(0 to 2) := (Hi0, Hi0, Hi1);
        waitForEvacuate : vl_logic_vector(0 to 2) := (Hi0, Hi1, Hi0);
        evacTiming      : vl_logic_vector(0 to 2) := (Hi0, Hi1, Hi1);
        waitForPressurize: vl_logic_vector(0 to 2) := (Hi1, Hi0, Hi0);
        pressurizeTiming: vl_logic_vector(0 to 2) := (Hi1, Hi0, Hi1);
        \exit\          : vl_logic_vector(0 to 2) := (Hi1, Hi1, Hi0);
        a               : vl_logic_vector(0 to 6) := (Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi0);
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
        arriving        : in     vl_logic;
        evac            : in     vl_logic;
        pressurize      : in     vl_logic;
        counterVal      : in     vl_logic_vector(2 downto 0);
        display         : out    vl_logic_vector(6 downto 0);
        canOut          : out    vl_logic;
        canIn           : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of defaultState : constant is 1;
    attribute mti_svvh_generic_type of arriveTiming : constant is 1;
    attribute mti_svvh_generic_type of waitForEvacuate : constant is 1;
    attribute mti_svvh_generic_type of evacTiming : constant is 1;
    attribute mti_svvh_generic_type of waitForPressurize : constant is 1;
    attribute mti_svvh_generic_type of pressurizeTiming : constant is 1;
    attribute mti_svvh_generic_type of \exit\ : constant is 1;
    attribute mti_svvh_generic_type of a : constant is 1;
    attribute mti_svvh_generic_type of e : constant is 1;
    attribute mti_svvh_generic_type of p : constant is 1;
    attribute mti_svvh_generic_type of nothing : constant is 1;
end enteringUranus;
