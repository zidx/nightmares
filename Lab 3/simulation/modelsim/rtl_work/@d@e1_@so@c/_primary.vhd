library verilog;
use verilog.vl_types.all;
entity DE1_SoC is
    generic(
        defaultCam1Behavior: vl_logic := Hi1;
        defaultCam2Behavior: vl_logic := Hi0;
        blank           : vl_logic_vector(0 to 6) := (Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1);
        whichClock      : integer := 0
    );
    port(
        CLOCK_50        : in     vl_logic;
        HEX0            : out    vl_logic_vector(6 downto 0);
        HEX1            : out    vl_logic_vector(6 downto 0);
        HEX2            : out    vl_logic_vector(6 downto 0);
        HEX3            : out    vl_logic_vector(6 downto 0);
        HEX4            : out    vl_logic_vector(6 downto 0);
        HEX5            : out    vl_logic_vector(6 downto 0);
        KEY             : in     vl_logic_vector(3 downto 0);
        LEDR            : out    vl_logic_vector(9 downto 0);
        SW              : in     vl_logic_vector(9 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of defaultCam1Behavior : constant is 1;
    attribute mti_svvh_generic_type of defaultCam2Behavior : constant is 1;
    attribute mti_svvh_generic_type of blank : constant is 1;
    attribute mti_svvh_generic_type of whichClock : constant is 1;
end DE1_SoC;
