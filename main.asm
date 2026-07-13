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
less byte "Try greater Input",0
great byte "Try lesser Input",0

; Board title & symbols
ticTacToe BYTE "=====================================", 0Ah, 0Dh
          BYTE "|        T I C   T A C   T O E      |", 0Ah, 0Dh
          BYTE "=====================================", 0
vertical byte "|",0
horizontal byte "-",0

.CODE

main PROC
gameLoop:
    ; We will call DrawBoard here later
    
    ; Show current player
    mov edx, OFFSET msgTurn
    call WriteString
    mov al, currentPlayer
    call WriteChar
    call Crlf
    
    ; Switch player (temporary logic to test the loop)
    cmp currentPlayer,'X'
    jne setX
    mov currentPlayer,'O'
    ; jmp gameLoop ; Commented out to prevent infinite loop for now
    jmp endGame

setX:
    mov currentPlayer,'X'
    ; jmp gameLoop

endGame:
    exit
main ENDP
END main