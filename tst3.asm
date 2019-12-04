; STANDARD HEADER FILE
	PROCESSOR		16F876A
;---REGISTER FILES ���� ---
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
;---STATUS BITS ����---
IRP	 EQU	7
RP1	 EQU	6
RP0	 EQU	5
NOT_TO 	 EQU	4
NOT_PD 	 EQU	3
ZF 	 EQU	2 ;ZERO FLAG BIT
DC 	 EQU	1 ;DIGIT CARRY/BORROW BIT
CF 	 EQU	0 ;CARRY BORROW FLAG BIT

; -- INTCON BITS ���� --
; -- OPTION BITS ���� --

W 	 EQU	B'0' ; W ������ 0���� ����
F 	 EQU	.1   ; F ������ 1�� ����

; --USER
DISP1	 EQU 	20H
DBUF1	 EQU  	21H
DBUF2	 EQU	22H
DISP2	 EQU	23H
COM_B	 EQU	24H
COM_C	 EQU	25H

;MAIN PROGRAM
	ORG	0000
	BSF 	STATUS,RP0 ; BANK�� 1�� ������
	MOVLW	B'00000000'; 
	MOVWF	TRISA
	MOVLW	B'00000111';
	MOVWF	ADCON1
	BCF	STATUS,RP0 ; BANK�� 0���� ����
	
	
	
	BSF	PORTA,0
	CALL	DELAY

	MOVLW	0A1H
	MOVWF	COM_B
	CALL	RS232C
	CALL	DELAY
	;��ġ�� �˷��ִ� ��ɾ�
	MOVLW	20H
	MOVWF	COM_B
	CALL	RS232C
	CALL	DELAY
	;21��° DOT���� ���
	MOVLW	2H
	MOVWF	COM_B
	CALL	RS232C
	CALL	DELAY
	;����°  ��
	
	MOVLW	0A2H
	MOVWF	COM_B
	CALL	RS232C
	CALL	DELAY
	
	
	
	;�й��� ��� 2015117024
	MOVLW	32
	MOVWF	COM_B
	CALL	RS232C
	CALL	DELAY 	 ; ������ ������ ���Ͽ� 5ms������
	MOVLW	30
	MOVWF	COM_B
	CALL	RS232C
	CALL	DELAY 	 ; ������ ������ ���Ͽ� 5ms������
	MOVLW	31
	MOVWF	COM_B
	CALL	RS232C
	CALL	DELAY 	 ; ������ ������ ���Ͽ� 5ms������
	MOVLW	35
	MOVWF	COM_B
	CALL	RS232C
	CALL	DELAY 	 ; ������ ������ ���Ͽ� 5ms������
	MOVLW	31
	MOVWF	COM_B
	CALL	RS232C
	CALL	DELAY 	 ; ������ ������ ���Ͽ� 5ms������
	MOVLW	31
	MOVWF	COM_B
	CALL	RS232C
	CALL	DELAY 	 ; ������ ������ ���Ͽ� 5ms������
	MOVLW	37
	MOVWF	COM_B
	CALL	RS232C
	CALL	DELAY 	 ; ������ ������ ���Ͽ� 5ms������
	MOVLW	30
	MOVWF	COM_B
	CALL	RS232C
	CALL	DELAY 	 ; ������ ������ ���Ͽ� 5ms������
	MOVLW	32
	MOVWF	COM_B
	CALL	RS232C
	CALL	DELAY 	 ; ������ ������ ���Ͽ� 5ms������
	MOVLW	34
	MOVWF	COM_B
	CALL	RS232C
	CALL	DELAY 	 ; ������ ������ ���Ͽ� 5ms������
	
	;�̸��� ��� ����ȫ
	MOVLW	B'10001000'
	MOVWF	COM_B
	CALL	RS232C
	CALL	DELAY 	 ; ������ ������ ���Ͽ� 5ms������
	MOVLW	B'01110111'
	MOVWF	COM_B
	CALL	RS232C
	CALL	DELAY
	MOVLW	B'10100011'
	MOVWF	COM_B
	CALL	RS232C
	CALL	DELAY 	 ; ������ ������ ���Ͽ� 5ms������
	MOVLW	B'10100101'
	MOVWF	COM_B
	CALL	RS232C
	CALL	DELAY	 ; �ȵ���5��
	MOVLW	B'11010001'
	MOVWF	COM_B
	CALL	RS232C
	CALL	DELAY	 ; �ȵ���5��
	MOVLW	B'10110111'
	MOVWF	COM_B
	CALL	RS232C
	CALL	DELAY	 ; �ȵ���5��
	
	MOVLW	00H
	MOVWF	COM_B
	CALL	RS232C
	CALL	DELAY

BBLP	
	GOTO	BBLP	 ; ���α׷� ���� 
	
; SUBROUTINE
RS232C	MOVLW	8
	MOVWF	COM_C
	BCF	PORTA,0	 ; start bit = 0
	CALL	DELAYB	 ; 1/4800 sec delay
;������ ��� LOOP
R_LP	BTFSS	COM_B,0	 ; ���� ������ 0bit Ȯ��
	GOTO	BITX
	;0 bit=1
	BSF	PORTA,0
	GOTO	NEXT1
BITX	BCF	PORTA,0
NEXT1	CALL	DELAYB
; ���� ������ ����� �� ������ Ȯ��
	RRF	COM_B,F
	DECFSZ	COM_C
	GOTO	R_LP
; stop bit ���
	BSF	PORTA,0
	CALL	DELAYB
	RETURN
	
	
	
DELAY			;5ms ����
	MOVLW	.125
	MOVWF	DBUF1	 ; 125���� Ȯ���ϱ� ���� ����
LP1	MOVLW	.10
	MOVWF	DBUF2	 ; 10���� Ȯ���ϱ� ���� ����
LP2	NOP
	DECFSZ	DBUF2,F
	GOTO	LP2
	DECFSZ	DBUF1,F	 ; ������ ���ҽ��� 00�� �Ǿ��� Ȯ��
	GOTO	LP1	 ; ZERO�� �ƴϸ� ���⿡ ����
	RETURN
	
DELAYB			;204us ����

	MOVLW	.67
	MOVWF	DBUF1	 
LP3	DECFSZ	DBUF1,F
	GOTO	LP3
	RETURN
END