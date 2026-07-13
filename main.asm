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
    mov eax, lightgreen + (black * 16)      
    call SetTextColor
    mov edx, OFFSET ticTacToe
    call WriteString
    call crlf
    call crlf
    
    mov eax, lightGray + (black * 16) 
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

    mov eax,ecx   
    xor edx,edx    
    mov ebx,3      
    div ebx        
    cmp edx,0      
    jne nextCell   
   
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

main PROC
gameLoop:
    call DrawBoard

    mov edx, OFFSET msgTurn
    call WriteString
    mov al, currentPlayer
    call WriteChar
    call Crlf
    
    exit 
main ENDP
END main