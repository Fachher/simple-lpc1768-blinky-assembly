;;; led-lpc17xx.asm
;;; written by Frank Sergeant
;;;    frank@pygmy.utoh.org
;;;    http://pygmy.utoh.org/riscy
;;; This program is in the public domain.  See http://pygmy.utoh.org/riscy/cortex/
;;; for notes about the program and how to assemble, link, and burn to flash.

;;; Blink the LED on the LPCXpresso LPC1769 ARM Cortex M3 board
;;; (or any LPC17xx ARM board with perhaps minor modifications).

;;; The LED on the Xpresso board is labeled LED2 and is just to the
;;; left of (inside of) J6-36.  It is connected to P0.22. The LED is
;;; on when P0.22 is high.
        
;;; Directives
        .thumb                  ; (same as saying '.code 16')
        .syntax unified

;;; Equates

        .equ LED_MASK, 0x00400000 ; i.e., bit 22
        
        .equ PINSEL0,  0x4002C000
        .equ PINSEL1,  0x4002C004

        .equ FIO0DIR,      0x2009C000 ; port direction, 0 (default) = input
        .equ FIO0MASK,     0x2009C010 ; port direction, 0 (default) = input
        .equ FIO0PIN,      0x2009C014
        .equ FIO0SET,      0x2009C018
        .equ FIO0CLR,      0x2009C01C
        
        .equ STACKINIT,   0x10004000

        ;.equ LEDDELAY,    800000
        .equ LEDDELAY,    300000

.section .text
        .org 0

;;; Vectors
vectors:
        .word STACKINIT         ; stack pointer value when stack is empty
        .word _start + 1        ; reset vector (manually adjust to odd for thumb)
        .word _nmi_handler + 1  ;
        .word _hard_fault  + 1  ;
        .word _memory_fault + 1 ;
        .word _bus_fault + 1    ;
        .word _usage_fault + 1  ;

_start:

        ldr r6, = PINSEL1
        ;; set P0.22 as a GPIO pin
        ;; P0.22 is controlled by bits 13:12 of PINSEL1
        ;; xxxx xxxx xxxx xxxx xx11 xxxx xxxx xxxx
        ;;    0    0    0    0    3    0    0    0

        ldr r0, [r6]
        bic r0, r0, # 0x00003000  ; clear bits 13:12 to force GPIO mode
        str r0, [r6]


        ;; set LED output pin (i.e. P0.22) as an output
        ldr r6, = FIO0DIR             ; for PORT0
        mov r0, # LED_MASK            ;  all inputs except for pin 22
        str r0, [r6]
        
        ;; r0 still contains LED_MASK 
        ldr r5, = FIO0CLR
        ldr r6, = FIO0SET

loop:
        str r0, [r5]            ; clear P0.22, turning off LED
        ldr r1, = LEDDELAY
delay1:
        subs r1, 1
        bne delay1

        str r0, [r6]            ; set P0.22, turning on LED
        ldr r1, = LEDDELAY
delay2:
        subs r1, 1
        bne delay2

        b loop                 ; continue forever

_dummy:                        ; if any int gets triggered, just hang in a loop
_nmi_handler:
_hard_fault:
_memory_fault:
_bus_fault:
_usage_fault:
        add r0, 1
        add r1, 1
        b _dummy
