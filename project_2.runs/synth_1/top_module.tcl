# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
create_project -in_memory -part xc7a100tcsg324-3

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/Chris/Documents/GitHub/CECS361/project_2.cache/wt [current_project]
set_property parent.project_path C:/Users/Chris/Documents/GitHub/CECS361/project_2.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo c:/Users/Chris/Documents/GitHub/CECS361/project_2.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib {
  C:/Users/Chris/Documents/GitHub/project_1/d_ff.v
  C:/Users/Chris/Documents/GitHub/project_1/pos_edge_detect.v
  C:/Users/Chris/Documents/GitHub/project_1/counter.v
  C:/Users/Chris/Documents/GitHub/project_1/debounce.v
  C:/Users/Chris/Documents/GitHub/project_1/AISO.v
  C:/Users/Chris/Documents/GitHub/project_1/pulse_generator.v
  C:/Users/Chris/Documents/GitHub/project_1/disp_cont.v
  C:/Users/Chris/Documents/GitHub/project_1/mux8_1.v
  C:/Users/Chris/Documents/GitHub/project_1/ss.v
  C:/Users/Chris/Documents/GitHub/project_1/px_controller.v
  C:/Users/Chris/Documents/GitHub/project_1/top_module.v
  C:/Users/Chris/Documents/GitHub/CECS361/Debounce.v
  C:/Users/Chris/Documents/GitHub/CECS361/c_tick1.v
  C:/Users/Chris/Documents/GitHub/CECS361/px_clk.v
  C:/Users/Chris/Documents/GitHub/CECS361/top_module.v
  C:/Users/Chris/Documents/GitHub/CECS361/counter.v
  C:/Users/Chris/Documents/GitHub/CECS361/disp_cont.v
  C:/Users/Chris/Documents/GitHub/CECS361/mux8_1.v
  C:/Users/Chris/Documents/GitHub/CECS361/pos_edge_detect.v
  C:/Users/Chris/Documents/GitHub/CECS361/px_controller.v
  C:/Users/Chris/Documents/GitHub/CECS361/pulse_generator.v
  C:/Users/Chris/Documents/GitHub/CECS361/AISO.v
  C:/Users/Chris/Documents/GitHub/CECS361/d_ff.v
  C:/Users/Chris/Documents/GitHub/CECS361/ss.v
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/Chris/Documents/GitHub/CECS361/Nexys4DDR_Master.xdc
set_property used_in_implementation false [get_files C:/Users/Chris/Documents/GitHub/CECS361/Nexys4DDR_Master.xdc]

set_param ips.enableIPCacheLiteLoad 0
close [open __synthesis_is_running__ w]

synth_design -top top_module -part xc7a100tcsg324-3


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef top_module.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file top_module_utilization_synth.rpt -pb top_module_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
