####################################################################
# This file contains the code required to build source files to
# analyze the memory segments and its behaviour at run time using 
# gcc tools
#
# Author: Chandra Kiran Saladi
# Date: 06/24/2018
###################################################################
include sources.mk

# Compiler Flags
CC = arm-none-eabi-gcc
LD = arm-none-eabi-ld
SIZE = arm-none-eabi-size
OBJDUMP = arm-none-eabi-objdump
NM = arm-none-eabi-nm 
LDFLAGS = -Wl,-Map=$(TARGET).map -T $(LINKER_FILE)
TARGET = c1m3

CFLAGS = -std=c99 $(ARMFLAGS) #-Wall -Werror -g -O0 

# Architectures Specific Flags ARM
		CPU = cortex-m4
		ARCH = thumb
		SPECS = nosys.specs
		FPU = fpv4-sp-d16
ARMFLAGS = -mcpu=$(CPU) --specs=$(SPECS) -m$(ARCH) #-march=armv7e-m -mfloat-abi=hard -mfpu=$(FPU)

#NM flags
NMFLAGS = -S --size-sort -s

#Platform Specific Files
LINKER_FILE = msp432p401r.lds

ASMS = $(SOURCES:.c=.s)

OBJS = $(SOURCES:.c=.o)

%.o : %.c
	$(CC) -c $(CFLAGS) -o $@ $<
	$(NM) $(NMFLAGS) $@
%.s : %.c
	$(CC) -S $< -o $@


.PHONY: build
build: $(ASMS) $(TARGET).out $(TARGET).asm
	$(NM) $(NMFLAGS) $(TARGET).out

$(TARGET).asm : $(TARGET).out
	$(OBJDUMP) -d $(TARGET).out >> $@
	
$(TARGET).out: $(OBJS)
	 $(CC) $(OBJS) $(CFLAGS) $(LDFLAGS) -o $@ 

.PHONY: clean

clean:
	rm -rf $(OBJS) $(ASMS) *.s $(TARGET).out $(TARGET).map $(TARGET).asm
