library verilog;
use verilog.vl_types.all;
entity switchesqsys_mm_interconnect_0 is
    port(
        clk_0_clk_clk   : in     vl_logic;
        nios2_processor_reset_n_reset_bridge_in_reset_reset: in     vl_logic;
        nios2_processor_data_master_address: in     vl_logic_vector(13 downto 0);
        nios2_processor_data_master_waitrequest: out    vl_logic;
        nios2_processor_data_master_byteenable: in     vl_logic_vector(3 downto 0);
        nios2_processor_data_master_read: in     vl_logic;
        nios2_processor_data_master_readdata: out    vl_logic_vector(31 downto 0);
        nios2_processor_data_master_write: in     vl_logic;
        nios2_processor_data_master_writedata: in     vl_logic_vector(31 downto 0);
        nios2_processor_data_master_debugaccess: in     vl_logic;
        nios2_processor_instruction_master_address: in     vl_logic_vector(13 downto 0);
        nios2_processor_instruction_master_waitrequest: out    vl_logic;
        nios2_processor_instruction_master_read: in     vl_logic;
        nios2_processor_instruction_master_readdata: out    vl_logic_vector(31 downto 0);
        curByteIn_s1_address: out    vl_logic_vector(1 downto 0);
        curByteIn_s1_readdata: in     vl_logic_vector(31 downto 0);
        curByteOut_s1_address: out    vl_logic_vector(1 downto 0);
        curByteOut_s1_write: out    vl_logic;
        curByteOut_s1_readdata: in     vl_logic_vector(31 downto 0);
        curByteOut_s1_writedata: out    vl_logic_vector(31 downto 0);
        curByteOut_s1_chipselect: out    vl_logic;
        empty_s1_address: out    vl_logic_vector(1 downto 0);
        empty_s1_readdata: in     vl_logic_vector(31 downto 0);
        inStrobe_s1_address: out    vl_logic_vector(1 downto 0);
        inStrobe_s1_readdata: in     vl_logic_vector(31 downto 0);
        jtag_uart_avalon_jtag_slave_address: out    vl_logic_vector(0 downto 0);
        jtag_uart_avalon_jtag_slave_write: out    vl_logic;
        jtag_uart_avalon_jtag_slave_read: out    vl_logic;
        jtag_uart_avalon_jtag_slave_readdata: in     vl_logic_vector(31 downto 0);
        jtag_uart_avalon_jtag_slave_writedata: out    vl_logic_vector(31 downto 0);
        jtag_uart_avalon_jtag_slave_waitrequest: in     vl_logic;
        jtag_uart_avalon_jtag_slave_chipselect: out    vl_logic;
        LEDs_s1_address : out    vl_logic_vector(1 downto 0);
        LEDs_s1_write   : out    vl_logic;
        LEDs_s1_readdata: in     vl_logic_vector(31 downto 0);
        LEDs_s1_writedata: out    vl_logic_vector(31 downto 0);
        LEDs_s1_chipselect: out    vl_logic;
        load_s1_address : out    vl_logic_vector(1 downto 0);
        load_s1_write   : out    vl_logic;
        load_s1_readdata: in     vl_logic_vector(31 downto 0);
        load_s1_writedata: out    vl_logic_vector(31 downto 0);
        load_s1_chipselect: out    vl_logic;
        nios2_processor_jtag_debug_module_address: out    vl_logic_vector(8 downto 0);
        nios2_processor_jtag_debug_module_write: out    vl_logic;
        nios2_processor_jtag_debug_module_read: out    vl_logic;
        nios2_processor_jtag_debug_module_readdata: in     vl_logic_vector(31 downto 0);
        nios2_processor_jtag_debug_module_writedata: out    vl_logic_vector(31 downto 0);
        nios2_processor_jtag_debug_module_byteenable: out    vl_logic_vector(3 downto 0);
        nios2_processor_jtag_debug_module_waitrequest: in     vl_logic;
        nios2_processor_jtag_debug_module_debugaccess: out    vl_logic;
        onchip_memory_s1_address: out    vl_logic_vector(9 downto 0);
        onchip_memory_s1_write: out    vl_logic;
        onchip_memory_s1_readdata: in     vl_logic_vector(31 downto 0);
        onchip_memory_s1_writedata: out    vl_logic_vector(31 downto 0);
        onchip_memory_s1_byteenable: out    vl_logic_vector(3 downto 0);
        onchip_memory_s1_chipselect: out    vl_logic;
        onchip_memory_s1_clken: out    vl_logic;
        outSignal_s1_address: out    vl_logic_vector(1 downto 0);
        outSignal_s1_write: out    vl_logic;
        outSignal_s1_readdata: in     vl_logic_vector(31 downto 0);
        outSignal_s1_writedata: out    vl_logic_vector(31 downto 0);
        outSignal_s1_chipselect: out    vl_logic;
        readyToDownload_s1_address: out    vl_logic_vector(1 downto 0);
        readyToDownload_s1_readdata: in     vl_logic_vector(31 downto 0);
        switches_s1_address: out    vl_logic_vector(1 downto 0);
        switches_s1_readdata: in     vl_logic_vector(31 downto 0)
    );
end switchesqsys_mm_interconnect_0;
