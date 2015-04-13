transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/zachn/Documents/nightmares/Lab1/DownCounterSchematic {C:/Users/zachn/Documents/nightmares/Lab1/DownCounterSchematic/flipflop.v}
vlog -sv -work work +incdir+C:/Users/zachn/Documents/nightmares/Lab1/DownCounterSchematic/output_files {C:/Users/zachn/Documents/nightmares/Lab1/DownCounterSchematic/output_files/ClockDivider.sv}

