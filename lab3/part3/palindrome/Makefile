# CSE x25 Lab 2
TOP_MODULE = palindrome
SYNTH_SOURCES += $(TOP_MODULE).sv
SYNTH_SOURCES += bsg_mem_1r1w.v
SYNTH_SOURCES += bsg_mem_1r1w_synth.v
SYNTH_SOURCES += bsg_counter_set_en.v
SYNTH_SOURCES += bsg_counter_set_down.v
SYNTH_SOURCES += ../../provided_modules/inv.sv
SYNTH_SOURCES += ../../provided_modules/dff.sv
NONSYNTH_SOURCES += ../../provided_modules/nonsynth_clock_gen.sv
NONSYNTH_SOURCES += ../../provided_modules/nonsynth_reset_gen.sv
-include ../../simulation.mk
-include ../../fpga.mk
