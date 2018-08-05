# target binary
ELF		=	example.elf

# source directories
SRCDIR	=	.

# includes
INCLUDES =	-I.

# object files
OBJDIR	=	obj
# binary files
BINDIR	=	bin
# cross compile prefix
CROSS_COMPILE	=	msp430-elf-

# target MCU
ifeq ($(MCU),)
	# default target
	MCU := msp430fr2512
else
	MCU := $(MCU)
endif

# cpu flags for target
CPUFLAGS	=	-mmcu=$(MCU) -msmall -DTARGET_IS_MSP430FR2XX_4XX

# include CapTIVate library
include ../Makefile

# cflags for target
CFLAGS		:=	-ffunction-sections \
				-Os \
				-std=gnu11 \
				-Wall -Wextra -Wno-main -Werror \
				$(CPUFLAGS) \
				$(INCLUDES) \
				$(CFLAGS)

CXXFLAGS	:=	$(CFLAGS) $(CXXFLAGS)
ASMFLAGS	:=	$(CFLAGS) $(ASMFLAGS)

LDFLAGS		:=	$(CPUFLAGS) \
				-ffunction-sections \
				-Wl,--gc-sections \
				$(LDFLAGS)
				# -Tldscripts/$(MCU).ld -Tldscripts/$(MCU)_symbols.ld \

LIBS		:= 

CC				=	$(CROSS_COMPILE)gcc
CXX				=	$(CROSS_COMPILE)g++
AS				=	$(CROSS_COMPILE)gcc
LD				=	$(CROSS_COMPILE)gcc
SIZE_PROG		=	$(CROSS_COMPILE)size
OBJCOPY			=	$(CROSS_COMPILE)objcopy
STRIP			=	$(CROSS_COMPILE)strip

MKDIR			=	mkdir -p
RM				=	rm -rf

# Makefile rules
# do not edit
SRC		=	$(foreach sdir, $(SRCDIR), $(wildcard $(sdir)/*.c))
SRC		+=	$(foreach sdir, $(SRCDIR), $(wildcard $(sdir)/*.cpp))
SRC		+=	$(foreach sdir, $(SRCDIR), $(wildcard $(sdir)/*.S))
SRC		+=	$(foreach sdir, $(SRCDIR), $(wildcard $(sdir)/*.s))

OBJDIRS	=	$(foreach odir, $(SRCDIR), $(OBJDIR)/$(odir))
OBJ		=	$(patsubst %.c, $(OBJDIR)/%.o, $(SRC))
OBJ		:=	$(patsubst %.cpp, $(OBJDIR)/%.o, $(OBJ))
OBJ		:=	$(patsubst %.S, $(OBJDIR)/%.o, $(OBJ))
OBJ		:=	$(patsubst %.s, $(OBJDIR)/%.o, $(OBJ))


ELF		:=	$(BINDIR)/$(ELF)
SREC	=	$(ELF:.elf=.s19)
BIN		=	$(ELF:.elf=.bin)

all: build

build: $(ELF) $(BIN) $(SREC) size
	echo -e "\n\nBuild finished for $(MCU)\n"

debug: CFLAGS += -O0 -DDEBUG -g
debug: all

clean:
	-$(RM) $(BINDIR) $(OBJDIR)

$(OBJDIR)/%.o: %.c
	$(CC) -c -o $@ $(CFLAGS) $<

$(OBJDIR)/%.o: %.cpp
	$(CXX) -c -o $@ $(CXXFLAGS) $<

$(OBJDIR)/%.o: %.S
	$(AS) -c -o $@ $(ASMFLAGS) $<

$(OBJDIR)/%.o: %.s
	$(AS) -c -o $@ $(ASMFLAGS) $<

$(ELF): $(OBJDIRS) $(OBJ) $(CAPTIVATE)
	$(LD) -o $(ELF) $(OBJ) $(CAPTIVATE) $(LDFLAGS)

size: $(ELF)
	$(SIZE_PROG) $(ELF)

$(BIN): $(ELF)
	$(OBJCOPY) -O binary $(ELF) $(BIN)

$(SREC): $(ELF)
	$(OBJCOPY) -O srec $(ELF) $(SREC)

$(OBJDIRS):
	$(MKDIR) $(OBJDIRS) $(BINDIR)

strip: $(ELF)
	$(STRIP) $(ELF)

fr2512: build

PROG 		= mspdebug
DRIVER		= tilib
COMMAND		= "prog $(ELF)"

ifeq ($(MCU),msp430fr2512)
	PROG_OPTS = --fet-force-id MSP430FR2512
else
	PROG_OPTS =
endif

prog: $(ELF)
	@echo -e "    PRG\t$(ELF)"
	@$(PROG) $(DRIVER) $(PROG_OPTS) $(COMMAND)
