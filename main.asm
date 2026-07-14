INCLUDE Irvine32.inc

.DATA
board BYTE '1','2','3','4','5','6','7','8','9'
currentPlayer BYTE 'X'

msgTurn BYTE "Player ",0
msgEnter BYTE "Enter position (1-9): ",0
msgInvalid BYTE "Spot Already taken, try other option.",0
msgWin BYTE " wins!",0
msgDraw BYTE "It's a draw!",0
less byte "Try greater Input",0
great byte "Try lesser Input",0
ticTacToe BYTE "=====================================", 0Ah, 0Dh
          BYTE "|        T I C   T A C   T O E      |", 0Ah, 0Dh
          BYTE "=====================================", 0
vertical byte "|",0
horizontal byte "-",0

.CODE

DrawBoard PROC
    ; [Exact DrawBoard code from Milestone 3 remains here]
    ; (Truncated for brevity in this view, but copy from M3)
    ret
DrawBoard ENDP

main PROC
gameLoop:
    call DrawBoard

    ; show current player
    mov edx, OFFSET msgTurn
    call WriteString
    mov al, currentPlayer
    call WriteChar
    call Crlf
    jmp getMove
    
lesser:
    mov edx, offset less
    call writestring
    call crlf
    jmp getMove
    
greater:
    mov edx, offset great
    call writestring
    call crlf

getMove:
    mov edx, OFFSET msgEnter
    call WriteString
    call ReadInt

    cmp eax,1
    jl lesser
    cmp eax,9
    jg greater

    dec eax        ; convert 1-9 to 0-8
    mov ebx,eax

    mov al, board[ebx]
    cmp al,'X'
    je invalid
    cmp al,'O'
    je invalid

    ; place mark
    mov al, currentPlayer
    mov board[ebx], al

    ; switch player
    cmp currentPlayer,'X'
    jne setX
    mov currentPlayer,'O'
    jmp gameLoop
    
setX:
    mov currentPlayer,'X'
    jmp gameLoop

invalid:
    mov edx, OFFSET msgInvalid
    call WriteString
    call Crlf
    jmp getMove

main ENDP
END main