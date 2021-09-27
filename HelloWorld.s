;----------------------------------------------------------------------------------
;-- (c) Rajesh Panicker
;--	License terms :
;--	You are free to use this code as long as you
;--		(i) DO NOT post it on any public repository;
;--		(ii) use it only for educational purposes;
;--		(iii) accept the responsibility to ensure that your implementation does not violate any intellectual property of ARM Holdings or other entities.
;--		(iv) accept that the program is provided "as is" without warranty of any kind or assurance regarding its suitability for any particular purpose;
;--		(v) send an email to rajesh.panicker@ieee.org briefly mentioning its use (except when used for the course CG3207 at the National University of Singapore);
;--		(vi) retain this notice in this file or any files derived from this.
;----------------------------------------------------------------------------------

	AREA    MYCODE, CODE, READONLY, ALIGN=9 
   	  ENTRY
	  
; ------- <code memory (ROM mapped to Instruction Memory) begins>
; Total number of instructions should not exceed 127 (126 excluding the last line 'halt B halt').

; This sample program prints "Welcome to CG3207" in response to press of button. There should be sufficient time gap between the press of buttons.	
	LDR R6, ZERO 			; R6 stores the constant 0, which we need frequently as we do not have MOV implemented. Hence, something like MOV R1, #4 is accomplished by ADD R1, R6, #4
	LDR R7, LSB_MASK 		; A mask for extracting out the LSB to check for '\0'
	LDR R8, DIPS			; Address of DIPS
	LDR R9, PBS				; Address of pushbuttons
	LDR R10, SEVENSEG		; Address of seven segment display
WAIT_START
	LDR R1, [R9]			; read button state
	CMN R1, #0				; check for button press
	BEQ WAIT_START			; go back and wait if no button is pressed
WAIT_DIP_1
	LDR R2, [R8]
	CMN R2, #0				; check that at least one DIP is turned on
	BEQ WAIT_DIP_1			; wait for DIP
	STR R2, [R10]			; show number on 7-Seg display
WAIT_DP
	LDR R1, [R9]			; read button state for DP
	CMN R1, #0				; check for button press
	BEQ WAIT_DP				; go back and wait if no button is pressed
WAIT_DIP_2
	LDR R3, [R8]
	CMN R3, #0				; check that at least one DIP is turned on
	BEQ WAIT_DIP_2			; wait for DIP
	STR R3, [R10]			; show number on 7-Seg display
	
; Calculate the result and display
	CMP R1, #0x01
	BEQ ADDITION
	CMP R1, #0x02
	BEQ SUBTRACTION
	CMP R1, #0x04
	BEQ SHIFT
ADDITION
	AND R4, R2, R3
	STR R4, [R10]
	B WAIT_START
SUBTRACTION
	ORR R4, R2, R3
	STR R4, [R10]
	B WAIT_START
SHIFT
	ADD R4, R2, R3, LSR #8	
	STR R4, [R10]
	B WAIT_START
halt
	B    halt				; infinite loop to halt computation. // A program should not "terminate" without an operating system to return control to
							; keep halt	B halt as the last line of your code.

; ------- <\code memory (ROM mapped to Instruction Memory) ends>


	AREA    CONSTANTS, DATA, READONLY, ALIGN=9 
; ------- <constant memory (ROM mapped to Data Memory) begins>
; All constants should be declared in this section. This section is read only (Only LDR, no STR).
; Total number of constants should not exceed 128 (124 excluding the 4 used for peripheral pointers).
; If a variable is accessed multiple times, it is better to store the address in a register and use it rather than load it repeatedly.

;Peripheral pointers
LEDS
		DCD 0x00000C00		; Address of LEDs. //volatile unsigned int * const LEDS = (unsigned int*)0x00000C00;  
DIPS
		DCD 0x00000C04		; Address of DIP switches. //volatile unsigned int * const DIPS = (unsigned int*)0x00000C04;
PBS
		DCD 0x00000C08		; Address of Push Buttons. Used only in Lab 2
CONSOLE
		DCD 0x00000C0C		; Address of UART. Used only in Lab 2 and later
CONSOLE_IN_valid
		DCD 0x00000C10		; Address of UART. Used only in Lab 2 and later
CONSOLE_OUT_ready
		DCD 0x00000C14		; Address of UART. Used only in Lab 2 and later
SEVENSEG
		DCD 0x00000C18		; Address of 7-Segment LEDs. Used only in Lab 2 and later

; Rest of the constants should be declared below.
ZERO
		DCD 0x00000000		; constant 0
LSB_MASK
		DCD 0x000000FF		; constant 0xFF
DELAY_VAL
		DCD 0x00000004		; delay time.
variable1_addr
		DCD variable1		; address of variable1. Required since we are avoiding pseudo-instructions // unsigned int * const variable1_addr = &variable1;
constant1
		DCD 0xABCD1234		; // const unsigned int constant1 = 0xABCD1234;
string1   
		DCB  "\r\nWelcome to CG3207..\r\n",0	; // unsigned char string1[] = "Hello World!"; // assembler will issue a warning if the string size is not a multiple of 4, but the warning is safe to ignore
stringptr
		DCD string1			;
		
; ------- <constant memory (ROM mapped to Data Memory) ends>	


	AREA   VARIABLES, DATA, READWRITE, ALIGN=9
; ------- <variable memory (RAM mapped to Data Memory) begins>
; All variables should be declared in this section. This section is read-write.
; Total number of variables should not exceed 128. 
; No initialization possible in this region. In other words, you should write to a location before you can read from it (i.e., write to a location using STR before reading using LDR).

variable1
		DCD 0x00000000		;  // unsigned int variable1;
; ------- <variable memory (RAM mapped to Data Memory) ends>	

		END	
		
;const int* x;         // x is a non-constant pointer to constant data
;int const* x;         // x is a non-constant pointer to constant data 
;int*const x;          // x is a constant pointer to non-constant data