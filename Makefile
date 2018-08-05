# Find the current directory to get the paths correct
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
mkfile_dir := $(dir $(mkfile_path))

# Adds the Captivate library to the include and library paths
LDFLAGS += -L$(mkfile_dir)/lib/captivate/BASE/libraries/ -lcaptivate_fr2522_family
LDFLAGS += -L$(mkfile_dir)/lib/driverlib/MSP430FR2xx_4xx/libraries -ldriverlib
LDFLAGS += -L$(mkfile_dir)/lib/mathlib/libraries -lQmathLib -lIQmathLib

INCLUDES += -I$(mkfile_dir)/lib
INCLUDES += -I$(mkfile_dir)/lib/driverlib
INCLUDES += -I$(mkfile_dir)/lib/driverlib/MSP430FR2xx_4xx
INCLUDES += -I$(mkfile_dir)/lib/mathlib
INCLUDES += -I$(mkfile_dir)/lib/captivate
INCLUDES += -I$(mkfile_dir)/lib/captivate/ADVANCED
INCLUDES += -I$(mkfile_dir)/lib/captivate/BASE
INCLUDES += -I$(mkfile_dir)/lib/captivate/COMM
INCLUDES += -I$(mkfile_dir)/lib/captivate_app
# INCLUDES += -I$(mkfile_dir)/lib/captivate_config
