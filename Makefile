# Find the current directory to get the paths correct
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
mkfile_dir := $(dir $(mkfile_path))

# Adds the Captivate library to the include and library paths
#LDFLAGS += $(mkfile_dir)/lib/mathlib/libraries/QmathLib.lib
LDFLAGS += $(mkfile_dir)/lib/mathlib/libraries/QmathLib_CCS_MPY32_5xx_6xx_CPUX_small_code_small_data.lib
#LDFLAGS += $(mkfile_dir)/lib/mathlib/libraries/IQmathLib.lib
LDFLAGS += $(mkfile_dir)/lib/mathlib/libraries/IQmathLib_CCS_MPY32_5xx_6xx_CPUX_small_code_small_data.lib
# LDFLAGS += $(mkfile_dir)/lib/driverlib/MSP430FR2xx_4xx/libraries/driverlib.lib
LDFLAGS += $(mkfile_dir)/lib/driverlib/MSP430FR2xx_4xx/libraries/driverlib_scsd.lib
LDFLAGS += $(mkfile_dir)/lib/captivate/BASE/libraries/captivate_fr2522_family.lib

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

CAPTIVATE_SRCS := $(mkfile_dir)./lib/captivate/BASE/CAPT_ISR.c
CAPTIVATE_SRCS += $(mkfile_dir)./lib/captivate/COMM/I2CSlave.c
CAPTIVATE_SRCS += $(mkfile_dir)./lib/captivate/COMM/FunctionTimer.c
CAPTIVATE_SRCS += $(mkfile_dir)./lib/captivate/ADVANCED/CAPT_Manager.c
CAPTIVATE_SRCS += $(mkfile_dir)./lib/captivate_app/CAPT_BSP.c
CAPTIVATE_SRCS += $(mkfile_dir)./lib/captivate_app/CAPT_App.c
#CAPTIVATE_SRCS += $(mkfile_dir)./lib/captivate/COMM/UART.c
#CAPTIVATE_SRCS += $(mkfile_dir)./lib/captivate/COMM/CAPT_Interface.c

CAPTIVATE := captivate.a

CAPTIVATE_OBJS := $(patsubst %.c,%.o,$(CAPTIVATE_SRCS))

$(CAPTIVATE_OBJS): %.o: %.c
	$(CC) -c -o $@ $(CFLAGS) $<

# captivate target
$(CAPTIVATE): $(CAPTIVATE_OBJS)
	ar rcs $@ $^
