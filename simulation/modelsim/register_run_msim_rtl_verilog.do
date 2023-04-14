transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/ELEC374-CPU-Design-Project-Main-B\ -\ Phase-4 {D:/ELEC374-CPU-Design-Project-Main-B - Phase-4/alu.v}
vlog -vlog01compat -work work +incdir+D:/ELEC374-CPU-Design-Project-Main-B\ -\ Phase-4 {D:/ELEC374-CPU-Design-Project-Main-B - Phase-4/cu.v}
vlog -vlog01compat -work work +incdir+D:/ELEC374-CPU-Design-Project-Main-B\ -\ Phase-4 {D:/ELEC374-CPU-Design-Project-Main-B - Phase-4/datapath.v}
vlog -vlog01compat -work work +incdir+D:/ELEC374-CPU-Design-Project-Main-B\ -\ Phase-4 {D:/ELEC374-CPU-Design-Project-Main-B - Phase-4/mux_32_1.v}
vlog -vlog01compat -work work +incdir+D:/ELEC374-CPU-Design-Project-Main-B\ -\ Phase-4 {D:/ELEC374-CPU-Design-Project-Main-B - Phase-4/encoder_32_5.v}
vlog -vlog01compat -work work +incdir+D:/ELEC374-CPU-Design-Project-Main-B\ -\ Phase-4 {D:/ELEC374-CPU-Design-Project-Main-B - Phase-4/con_ff.v}
vlog -vlog01compat -work work +incdir+D:/ELEC374-CPU-Design-Project-Main-B\ -\ Phase-4 {D:/ELEC374-CPU-Design-Project-Main-B - Phase-4/d_ff.v}
vlog -vlog01compat -work work +incdir+D:/ELEC374-CPU-Design-Project-Main-B\ -\ Phase-4 {D:/ELEC374-CPU-Design-Project-Main-B - Phase-4/sel.v}
vlog -vlog01compat -work work +incdir+D:/ELEC374-CPU-Design-Project-Main-B\ -\ Phase-4 {D:/ELEC374-CPU-Design-Project-Main-B - Phase-4/decoder_2_4.v}
vlog -vlog01compat -work work +incdir+D:/ELEC374-CPU-Design-Project-Main-B\ -\ Phase-4 {D:/ELEC374-CPU-Design-Project-Main-B - Phase-4/decoder_4_16.v}
vlog -vlog01compat -work work +incdir+D:/ELEC374-CPU-Design-Project-Main-B\ -\ Phase-4 {D:/ELEC374-CPU-Design-Project-Main-B - Phase-4/pc_register.v}
vlog -vlog01compat -work work +incdir+D:/ELEC374-CPU-Design-Project-Main-B\ -\ Phase-4 {D:/ELEC374-CPU-Design-Project-Main-B - Phase-4/gen_register.v}
vlog -vlog01compat -work work +incdir+D:/ELEC374-CPU-Design-Project-Main-B\ -\ Phase-4 {D:/ELEC374-CPU-Design-Project-Main-B - Phase-4/zero_register.v}
vlog -vlog01compat -work work +incdir+D:/ELEC374-CPU-Design-Project-Main-B\ -\ Phase-4 {D:/ELEC374-CPU-Design-Project-Main-B - Phase-4/mdr_register.v}
vlog -vlog01compat -work work +incdir+D:/ELEC374-CPU-Design-Project-Main-B\ -\ Phase-4 {D:/ELEC374-CPU-Design-Project-Main-B - Phase-4/mdr_mux.v}
vlog -vlog01compat -work work +incdir+D:/ELEC374-CPU-Design-Project-Main-B\ -\ Phase-4 {D:/ELEC374-CPU-Design-Project-Main-B - Phase-4/shra_32.v}
vlog -vlog01compat -work work +incdir+D:/ELEC374-CPU-Design-Project-Main-B\ -\ Phase-4 {D:/ELEC374-CPU-Design-Project-Main-B - Phase-4/shr_32.v}
vlog -vlog01compat -work work +incdir+D:/ELEC374-CPU-Design-Project-Main-B\ -\ Phase-4 {D:/ELEC374-CPU-Design-Project-Main-B - Phase-4/shl_32.v}
vlog -vlog01compat -work work +incdir+D:/ELEC374-CPU-Design-Project-Main-B\ -\ Phase-4 {D:/ELEC374-CPU-Design-Project-Main-B - Phase-4/ror_32.v}
vlog -vlog01compat -work work +incdir+D:/ELEC374-CPU-Design-Project-Main-B\ -\ Phase-4 {D:/ELEC374-CPU-Design-Project-Main-B - Phase-4/rol_32.v}
vlog -vlog01compat -work work +incdir+D:/ELEC374-CPU-Design-Project-Main-B\ -\ Phase-4 {D:/ELEC374-CPU-Design-Project-Main-B - Phase-4/and_32.v}
vlog -vlog01compat -work work +incdir+D:/ELEC374-CPU-Design-Project-Main-B\ -\ Phase-4 {D:/ELEC374-CPU-Design-Project-Main-B - Phase-4/or_32.v}
vlog -vlog01compat -work work +incdir+D:/ELEC374-CPU-Design-Project-Main-B\ -\ Phase-4 {D:/ELEC374-CPU-Design-Project-Main-B - Phase-4/not_32.v}
vlog -vlog01compat -work work +incdir+D:/ELEC374-CPU-Design-Project-Main-B\ -\ Phase-4 {D:/ELEC374-CPU-Design-Project-Main-B - Phase-4/neg_32.v}
vlog -vlog01compat -work work +incdir+D:/ELEC374-CPU-Design-Project-Main-B\ -\ Phase-4 {D:/ELEC374-CPU-Design-Project-Main-B - Phase-4/mul_32.v}
vlog -vlog01compat -work work +incdir+D:/ELEC374-CPU-Design-Project-Main-B\ -\ Phase-4 {D:/ELEC374-CPU-Design-Project-Main-B - Phase-4/div_32.v}
vlog -vlog01compat -work work +incdir+D:/ELEC374-CPU-Design-Project-Main-B\ -\ Phase-4 {D:/ELEC374-CPU-Design-Project-Main-B - Phase-4/add_32.v}
vlog -vlog01compat -work work +incdir+D:/ELEC374-CPU-Design-Project-Main-B\ -\ Phase-4 {D:/ELEC374-CPU-Design-Project-Main-B - Phase-4/sub_32.v}
vlog -vlog01compat -work work +incdir+D:/ELEC374-CPU-Design-Project-Main-B\ -\ Phase-4 {D:/ELEC374-CPU-Design-Project-Main-B - Phase-4/ram.v}

vlog -vlog01compat -work work +incdir+D:/ELEC374-CPU-Design-Project-Main-B\ -\ Phase-4 {D:/ELEC374-CPU-Design-Project-Main-B - Phase-4/cu_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  cu_tb

add wave *
view structure
view signals
run 7600 ns
