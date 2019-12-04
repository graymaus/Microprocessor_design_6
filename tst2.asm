; STANDARD HEADER FILE
	PROCESSOR		16F876A
;---REGISTER FILES 선언 ---
;  BANK 0
INDF	 EQU	00H
TMR0	 EQU	01H
PCL	 EQU	02H
STATUS	 EQU	03H
FSR	 EQU	04H	
PORTA	 EQU	05H
PORTB	 EQU	06H
PORTC	 EQU	07H
EEDATA	 EQU	08H
EEADR	 EQU	09H
PCLATH	 EQU	0AH
INTCON	 EQU	0BH
; BANK 1
OPTINOR	 EQU	81H
TRISA	 EQU	85H
TRISB	 EQU	86H
TRISC	 EQU	87H
EECON1	 EQU	88H
EECON2	 EQU	89H
ADCON1	 EQU	9FH
;---STATUS BITS 선언---
IRP	 EQU	7
RP1	 EQU	6
RP0	 EQU	5
NOT_TO 	 EQU	4
NOT_PD 	 EQU	3
ZF 	 EQU	2 ;ZERO FLAG BIT
DC 	 EQU	1 ;DIGIT CARRY/BORROW BIT
CF 	 EQU	0 ;CARRY BORROW FLAG BIT

; -- INTCON BITS 선언 --
; -- OPTION BITS 선언 --

W 	 EQU	B'0' ; W 변수를 0으로 선언
F 	 EQU	.1   ; F 변수를 1로 선언

; --USER
DISP1	 EQU 	20H
DBUF1	 EQU  	21H
DBUF2	 EQU	22H
DISP2	 EQU	23H
COM_B	 EQU	24H
COM_C	 EQU	25H

;MAIN PROGRAM
	ORG	0000
	BSF 	STATUS,RP0 ; BANK를 1로 변경함
	MOVLW	B'00000000'; 
	MOVWF	TRISA
	MOVLW	B'00000111';
	MOVWF	ADCON1
	BCF	STATUS,RP0 ; BANK를 0으로 변경
	
	
	BSF	PORTA,0
	CALL	DELAY
	
	MOVLW	0A2H
	MOVWF	COM_B
	CALL	RS232C
	CALL	DELAY 
	
	MOVLW	B'10100011'
	MOVWF	COM_B
	CALL	RS232C
	CALL	DELAY 	 ; 안정된 동작을 위하여 5ms딜레이
	MOVLW	B'10100101'
	MOVWF	COM_B
	CALL	RS232C
	CALL	DELAY	 ; 안동위5딜
	MOVLW	B'11010001'
	MOVWF	COM_B
	CALL	RS232C
	CALL	DELAY	 ; 안동위5딜
	MOVLW	B'10110111'
	MOVWF	COM_B
	CALL	RS232C
	CALL	DELAY	 ; 안동위5딜
	;민홍
	MOVLW	B'10101101'
	MOVWF	COM_B
	CALL	RS232C
	CALL	DELAY 	 ; 안정된 동작을 위하여 5ms딜레이
	MOVLW	B'10100001'
	MOVWF	COM_B
	CALL	RS232C
	CALL	DELAY	 ; 안동위5딜
	MOVLW	B'10110101'
	MOVWF	COM_B
	CALL	RS232C
	CALL	DELAY	 ; 안동위5딜
	MOVLW	B'01110111'
	MOVWF	COM_B
	CALL	RS232C
	CALL	DELAY	 ; 안동위5딜
	;소영
	MOVLW	00H
	MOVWF	COM_B
	CALL	RS232C
	CALL	DELAY 

BBLP	
	GOTO	BBLP	 ; 프로그램 종료 
	
; SUBROUTINE
RS232C	MOVLW	8
	MOVWF	COM_C
	BCF	PORTA,0	 ; start bit = 0
	CALL	DELAYB	 ; 1/4800 sec delay
;데이터 출력 LOOP
R_LP	BTFSS	COM_B,0	 ; 전송 데이터 0bit 확인
	GOTO	BITX
	;0 bit=1
	BSF	PORTA,0
	GOTO	NEXT1
BITX	BCF	PORTA,0
NEXT1	CALL	DELAYB
; 다음 데이터 만들기 및 마지막 확인
	RRF	COM_B,F
	DECFSZ	COM_C
	GOTO	R_LP
; stop bit 출력
	BSF	PORTA,0
	CALL	DELAYB
	RETURN
	
	
	
DELAY			;5ms 지연
	MOVLW	.125
	MOVWF	DBUF1	 ; 125번을 확인하기 위한 변수
LP1	MOVLW	.10
	MOVWF	DBUF2	 ; 10번을 확인하기 위한 변수
LP2	NOP
	DECFSZ	DBUF2,F
	GOTO	LP2
	DECFSZ	DBUF1,F	 ; 변수를 감소시켜 00이 되었나 확인
	GOTO	LP1	 ; ZERO가 아니면 여기에 들어옴
	RETURN
	
DELAYB			;204us 지연

	MOVLW	.51
	MOVWF	DBUF1	 
LP3	NOP
	DECFSZ	DBUF1,F
	GOTO	LP3
	RETURN
END