set list_of_lib_files(1) "sky130_fd_sc_hd__ff_100C_1v65.lib"
set list_of_lib_files(2) "sky130_fd_sc_hd__ff_100C_1v95.lib"
set list_of_lib_files(3) "sky130_fd_sc_hd__ff_n40C_1v56.lib"
set list_of_lib_files(4) "sky130_fd_sc_hd__ff_n40C_1v65.lib"
set list_of_lib_files(5) "sky130_fd_sc_hd__ff_n40C_1v76.lib"
set list_of_lib_files(6) "sky130_fd_sc_hd__ff_n40C_1v95.lib"
set list_of_lib_files(7) "sky130_fd_sc_hd__ss_100C_1v40.lib"
set list_of_lib_files(8) "sky130_fd_sc_hd__ss_100C_1v60.lib"
set list_of_lib_files(9) "sky130_fd_sc_hd__ss_n40C_1v28.lib"
set list_of_lib_files(10) "sky130_fd_sc_hd__ss_n40C_1v35.lib"
set list_of_lib_files(11) "sky130_fd_sc_hd__ss_n40C_1v40.lib"
set list_of_lib_files(12) "sky130_fd_sc_hd__ss_n40C_1v44.lib"
set list_of_lib_files(13) "sky130_fd_sc_hd__ss_n40C_1v60.lib"
set list_of_lib_files(14) "sky130_fd_sc_hd__ss_n40C_1v76.lib"
set list_of_lib_files(15) "sky130_fd_sc_hd__tt_025C_1v80.lib"
set list_of_lib_files(16) "sky130_fd_sc_hd__tt_100C_1v80.lib"


for {set i 1} {$i <= [array size list_of_lib_files]} {incr i} {
read_liberty  /home/keerthana/Desktop/VSDBabySoC/src/lib/$list_of_lib_files($i)
read_liberty -min ../lib/avsdpll.lib
read_liberty -max ../lib/avsdpll.lib
read_liberty -min ../lib/avsddac.lib
read_liberty -max ../lib/avsddac.lib
read_verilog /home/keerthana/Desktop/VSDBabySoC/src/module/vsdbabysoc.synth.v
link_design vsdbabysoc

read_sdc /home/keerthana/Desktop/VSDBabySoC/src/sdc/vsdbabysoc_synthesis.sdc

report_checks -path_delay min_max -fields {nets cap slew input_pins fanout} -digits {4} > /home/keerthana/Desktop/VSDBabySoC/output/min_max_$list_of_lib_files($i).txt

exec echo "$list_of_lib_files($i)" >> /home/keerthana/Desktop/VSDBabySoC/output/sta_worst_max_slack.txt
report_worst_slack -max -digits {4} >> /home/keerthana/Desktop/VSDBabySoC/output/sta_worst_max_slack.txt

exec echo "$list_of_lib_files($i)" >> /home/keerthana/Desktop/VSDBabySoC/output/sta_worst_min_slack.txt
report_worst_slack -min -digits {4} >> /home/keerthana/Desktop/VSDBabySoC/output/sta_worst_min_slack.txt

}

