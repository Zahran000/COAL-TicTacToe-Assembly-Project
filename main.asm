INCLUDE Irvine32.inc

.DATA

; Game board
board BYTE '1','2','3','4','5','6','7','8','9'

; Current player
currentPlayer BYTE 'X'

; Messages
msgTurn BYTE "Player ",0
msgEnter BYTE "Enter position (1-9): ",0
msgInvalid BYTE "Spot Already taken, try other option.",0
msgWin BYTE " wins!",0
msgDraw BYTE "It's a draw!",0

less BYTE "Try greater Input",0
great BYTE "Try lesser Input",0

; Board title
ticTacToe BYTE "=====================================",0Ah,0Dh
           BYTE "|        T I C   T A C   T O E      |",0Ah,0Dh
           BYTE "=====================================",0

; Board symbols
vertical BYTE "|",0
horizontal BYTE "-",0

.CODE

main PROC

    exit

main ENDP

END main