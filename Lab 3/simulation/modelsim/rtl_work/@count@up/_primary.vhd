library verilog;
use verilog.vl_types.all;
entity CountUp is
    generic(
        c0              : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi0, Hi0);
        c1              : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi0, Hi1);
        c2              : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi1, Hi0);
        c3              : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi1, Hi1);
        c4              : vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi0, Hi0);
        c5              : vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi0, Hi1);
        c6              : vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi1, Hi0);
        c7              : vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi1, Hi1);
        c8              : vl_logic_vector(0 to 3) := (Hi1, Hi0, Hi0, Hi0);
        c9              : vl_logic_vector(0 to 3) := (Hi1, Hi0, Hi0, Hi1);
        c10             : vl_logic_vector(0 to 3) := (Hi1, Hi0, Hi1, Hi0);
        nothing         : vl_logic_vector(0 to 6) := (Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1);
        zero            : vl_logic_vector(0 to 6) := (Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        one             : vl_logic_vector(0 to 6) := (Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi1);
        two             : vl_logic_vector(0 to 6) := (Hi0, Hi1, Hi0, Hi0, Hi1, Hi0, Hi0);
        three           : vl_logic_vector(0 to 6) := (Hi0, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0);
        four            : vl_logic_vector(0 to 6) := (Hi0, Hi0, Hi1, Hi1, Hi0, Hi0, Hi1);
        five            : vl_logic_vector(0 to 6) := (Hi0, Hi0, Hi1, Hi0, Hi0, Hi1, Hi0);
        six             : vl_logic_vector(0 to 6) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0);
        seven           : vl_logic_vector(0 to 6) := (Hi1, Hi1, Hi1, Hi1, Hi0, Hi0, Hi0);
        eight           : vl_logic_vector(0 to 6) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        nine            : vl_logic_vector(0 to 6) := (Hi0, Hi0, Hi1, Hi1, Hi0, Hi0, Hi0);
        ten             : vl_logic_vector(0 to 6) := (Hi0, Hi1, Hi0, Hi0, Hi0, Hi1, Hi0)
    );
    port(
        count           : in     vl_logic_vector(3 downto 0);
        hex             : out    vl_logic_vector(6 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of c0 : constant is 1;
    attribute mti_svvh_generic_type of c1 : constant is 1;
    attribute mti_svvh_generic_type of c2 : constant is 1;
    attribute mti_svvh_generic_type of c3 : constant is 1;
    attribute mti_svvh_generic_type of c4 : constant is 1;
    attribute mti_svvh_generic_type of c5 : constant is 1;
    attribute mti_svvh_generic_type of c6 : constant is 1;
    attribute mti_svvh_generic_type of c7 : constant is 1;
    attribute mti_svvh_generic_type of c8 : constant is 1;
    attribute mti_svvh_generic_type of c9 : constant is 1;
    attribute mti_svvh_generic_type of c10 : constant is 1;
    attribute mti_svvh_generic_type of nothing : constant is 1;
    attribute mti_svvh_generic_type of zero : constant is 1;
    attribute mti_svvh_generic_type of one : constant is 1;
    attribute mti_svvh_generic_type of two : constant is 1;
    attribute mti_svvh_generic_type of three : constant is 1;
    attribute mti_svvh_generic_type of four : constant is 1;
    attribute mti_svvh_generic_type of five : constant is 1;
    attribute mti_svvh_generic_type of six : constant is 1;
    attribute mti_svvh_generic_type of seven : constant is 1;
    attribute mti_svvh_generic_type of eight : constant is 1;
    attribute mti_svvh_generic_type of nine : constant is 1;
    attribute mti_svvh_generic_type of ten : constant is 1;
end CountUp;
