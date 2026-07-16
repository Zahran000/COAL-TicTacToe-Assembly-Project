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

; -------------------------
; Draw the board
; -------------------------
DrawBoard PROC
    
    call Clrscr
    mov eax, lightgreen + (black * 16)      ; Bright cyan heading
    call SetTextColor
    mov edx, OFFSET ticTacToe
    call WriteString

    call crlf
    call crlf
    
    mov eax, lightGray + (black * 16) ; returning to normal color
    call SetTextColor

    mov al, ' '
    call WriteChar
    call WriteChar
    call WriteChar
    call WriteChar
    call WriteChar
    call writechar
    call writechar
    call WriteChar
    call WriteChar
    call writechar
    call WriteChar
    call WriteChar
    call WriteChar
    call WriteChar

    mov edx,offset horizontal
    mov ecx,11
    l1:
    call writestring
    loop l1
    call crlf
    mov ecx,0
    mov esi,offset board
    mov al, ' '
    call WriteChar
    call WriteChar
    call WriteChar
    call WriteChar
    call WriteChar
    call writechar
    call WriteChar
    call WriteChar
    call writechar
    call WriteChar
    call WriteChar
    call WriteChar
    call WriteChar
    mov edx,offset vertical
    call writestring
    
    mov al,' '
    call writechar

nextCell:


    mov al, [esi]
    inc esi
    call WriteChar
    
    mov al, ' '
    call WriteChar
    mov edx,offset vertical
    call writestring
    call writechar
    inc ecx
    cmp ecx,9
    je doneBoard

    ; after every 3 cells, print newline
    mov eax,ecx   
    xor edx,edx    ; clearing edx
    mov ebx,3      ; ebx = 3
    div ebx        ; EAX = quotient, EDX = remainder
    cmp edx,0      ; checking remainder is zero or not
    jne nextCell   ; if (edx)remainder != 0

   
    call Crlf
    call crlf
    
    mov al, ' '
    call WriteChar
    call WriteChar
    call WriteChar
    call WriteChar
    call WriteChar
    call writechar
    call WriteChar
    call WriteChar
    call writechar
    call WriteChar
    call WriteChar
    call WriteChar
    call WriteChar
    
    mov edx,offset vertical
    call writestring
    
    mov al,' '
    call writechar
    jmp nextCell

doneBoard:
    call Crlf
    mov eax,' '
    mov ecx,14
    l3:
    call writechar
    loop l3
    
    mov edx,offset horizontal
    mov ecx,11
    l2:
    call writestring
    loop l2
    call crlf
    call crlf
    ret
DrawBoard ENDP

; -------------------------
; Check if someone won
; return EAX = 1 if win, 0 otherwise
; -------------------------
CheckWinner PROC
    mov eax,0

    ; checking horizontal pattern of row 1
    mov al, board[0]
    cmp al, board[1]
    jne checkRow2
    cmp al, board[2]
    jne checkRow2
    jmp winFound
    ; checking horizontal pattern of row 2
checkRow2:
    mov al, board[3]
    cmp al, board[4]
    jne checkRow3
    cmp al, board[5]
    jne checkRow3
    jmp winFound
    ; checking horizontal pattern of row 3
checkRow3:
    mov al, board[6]
    cmp al, board[7]
    jne checkCol1
    cmp al, board[8]
    jne checkCol1
    jmp winFound

    ; checking vertical pattern of column 1
checkCol1:
    mov al, board[0]
    cmp al, board[3]
    jne checkCol2
    cmp al, board[6]
    jne checkCol2
    jmp winFound
    ; checking vertical pattern of column 2
checkCol2:
    mov al, board[1]
    cmp al, board[4]
    jne checkCol3
    cmp al, board[7]
    jne checkCol3
    jmp winFound
    ; checking vertical pattern of column 3
checkCol3:
    mov al, board[2]
    cmp al, board[5]
    jne checkDiag1
    cmp al, board[8]
    jne checkDiag1
    jmp winFound

    ; checking diagonal 1
checkDiag1:
    mov al, board[0]
    cmp al, board[4]
    jne checkDiag2
    cmp al, board[8]
    jne checkDiag2
    jmp winFound
    ; checking diagonal 2
checkDiag2:
    mov al, board[2]
    cmp al, board[4]
    jne noWin
    cmp al, board[6]
    jne noWin
winFound:
    mov eax,1
    ret
noWin:
    xor eax,eax
    ret
CheckWinner ENDP

; -------------------------
; Check for draw (all filled)
; return EAX = 1 if draw
; -------------------------
CheckDraw PROC
    mov ecx,0
    mov esi,offset board
checkLoop:
    mov al, [esi]
    inc esi
    cmp al,'X'
    je skip
    cmp al,'O'
    je skip
    xor eax,eax
    ret
skip:
    inc ecx
    cmp ecx,9
    jl checkLoop
    mov eax,1
    ret
CheckDraw ENDP

; -------------------------
; Main procedure
; -------------------------
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

    ; check winner
    call CheckWinner
    cmp eax,1
    je winner

    ; check draw
    call CheckDraw
    cmp eax,1
    je draw

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

winner:
    call DrawBoard
    mov edx, OFFSET msgTurn
    call WriteString
    mov al, currentPlayer
    call WriteChar
    mov edx, OFFSET msgWin
    call WriteString
    call Crlf
    exit

draw:
    call DrawBoard
    mov edx, OFFSET msgDraw
    call WriteString
    call Crlf
    exit

main ENDP
END main