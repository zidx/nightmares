library verilog;
use verilog.vl_types.all;
entity lights is
    generic(
        idleD           : vl_logic_vector(0 to 6) := (Hi0, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1);
        defaultCam2Behavior: vl_logic := Hi0;
        blank           : vl_logic_vector(0 to 6) := (Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1);
        whichClock      : integer := 16;
        bitMiddle       : vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi1, Hi1);
        bitEnd          : vl_logic_vector(0 to 3) := (Hi1, Hi1, Hi1, Hi1);
        ninethBit       : vl_logic_vector(0 to 3) := (Hi1, Hi0, Hi0, Hi1)
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
        LEDG            : out    vl_logic_vector(7 downto 0);
        SW              : in     vl_logic_vector(9 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of idleD : constant is 1;
    attribute mti_svvh_generic_type of defaultCam2Behavior : constant is 1;
    attribute mti_svvh_generic_type of blank : constant is 1;
    attribute mti_svvh_generic_type of whichClock : constant is 1;
    attribute mti_svvh_generic_type of bitMiddle : constant is 1;
    attribute mti_svvh_generic_type of bitEnd : constant is 1;
    attribute mti_svvh_generic_type of ninethBit : constant is 1;
end lights;
