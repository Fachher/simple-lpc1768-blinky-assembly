# ######################################################################
#    Riscy Pygness makefile for LPC17xx                                #
#     (especially the LPCXpresso LPC1769 board)                        #
#                                                                      #
#    See the Riscy Pygness User Manual for instructions.               # 
#                                                                      #
# ######################################################################


# ######################################################################
# Set especially these variables for your environment
# ######################################################################

FLASHER = /Applications/SEGGER/JLink/JLinkExe
BIN = /Users/fachhersyed/Programs/arm-cs-tools/bin
PREASM = ./preasm.tcl

ASMFLAGS = -mcpu=cortex-m3 -mthumb -mapcs-32 -gstabs
LNKFLAGS =  -v -T lpc17xx.ld -nostartfiles

.PRECIOUS: %.o %.hex %.bin %.srec %.elf %.s

all: led-lpc17xx.bin

clean:
	@ echo "...cleaning"
	rm -f *.o *.elf *.hex led*.s *.bin *.lst *.lnkh *.lnkt

%.s: %.asm
	@ echo "preassembly $@"
	$(PREASM) $*.asm $@ 

%.o: %.s 
	$(BIN)/arm-none-eabi-as $(ASMFLAGS) -ahls=$*.lst  -o $@ $*.s

%.dis: %.elf
	$(BIN)/arm-none-eabi-objdump  -d --source $<  > $@

%.hex: %.bin
	$(BIN)/arm-none-eabi-objcopy --input-target binary  --output-target ihex  $<  $*.hex

%.srec: %.bin
	$(BIN)/arm-none-eabi-objcopy --input-target binary  --output-target srec  $<  $*.srec

%.bin: %.elf
	$(BIN)/arm-none-eabi-objcopy -O binary $<  $*.bin

%.elf: %.o
	@ echo "...linking $@"
	$(BIN)/arm-none-eabi-ld $(LNKFLAGS) -o $@ $<
	$(BIN)/arm-none-eabi-objdump -h $@ > $*.lnkh
	$(BIN)/arm-none-eabi-objdump -t $@ > $*.lnkt

flash:
	@ echo "Flashing board"
	$(FLASHER) -CommanderScript flashlpc1768.jlink
