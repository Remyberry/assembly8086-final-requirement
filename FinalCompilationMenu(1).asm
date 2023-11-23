dseg segment
enterpw db "Enter password: $"
pwacc db "Password Accepted!$"     
pwden db "Password Incorrect!$"
  
msg1 db "City College Of Angeles$"
msg2 db "INSTITUTE OS COMPUTING SCIENCE AND LIBRARY INFORMATION SCIENCE$"
msg3 db "E$"
msg4 db "7COMPARC: COMPUTER ARCHITECTURE AND ORGANIZATION$"
msg5 db "Final Requirement Assembly Language Programs$"
msg6 db "Submitted by:$"
msg7 db "Santos, Jerry Mar$"
msg8 db "21-0015$"
msg9 db "Juanatas, Jon Rembrandt$"    
msg10 db "$"
msg11 db "C303$"
msg12 db "Press enter to proceed to the Main Menu$"

menuTitle db "MAIN MENU$"
act1 db "[1] Input 100 Characters with Space$"
act2 db "[2] Display Alphabets Ascending and Descending Order$"
ascAlp db "[1] Display Ascending$"
desAlp db "[2] Display Descending$"
act3 db "[3] Arithmetic Operation$"
act4 db "[4] Generate Asterisks$"
ascAst db "[1] Ascending Triangle$"  
desAst db "[2] Descending Triangle$"
crtAst db "[3] Curtain$"
askAst db "Input number(1-9): $"
act5 db "[5] Input Personal Information$"
act6 db "[6] Reverse output$"
act7 db "[7] Display Flags$"
act8 db "[8] Convert Uppercase to Lowercase or vice versa$"
act9 db "[9] Vowel or Consonant Character$"
inptChar db "Input a character : $"
isVowel db "The input character is a vowel.$"
isConsonant db "The input character is a consonant.$"
act10 db "[10] Convert numbers to words$"
alis db "[x] Exit program$"
choice db "Enter your choice: $" 

invInpt db "Invalid input!$"
askAgain db "Do you want to try again?[y/n]: $"
bacc db "[x] Exit$"
pw db 8
dseg ends

cseg segment ; list of code/instructions
assume cs:cseg, ds:dseg

;--------------------[Common Procedures]--------------------;
input proc near         ;store input
    mov ah, 01h
    int 21h
    ret
input endp 

inputWE proc near         ;store input without echo
    mov ah, 07h
    int 21h
    ret
inputWE endp    

newLine proc near       ;new line
    mov dl, 10
    mov ah, 02h
    int 21h
    mov dl, 13
    mov ah, 02h
    int 21h
    ret
newLine endp
   
prnt proc near          ;print message
    mov ah, 09h
    int 21h
    ret
prnt endp

prntC proc near          ;print char
    mov ah, 02h
    int 21h
    ret
prntC endp

clrRegs proc near
    mov ax, 0000h
    mov bx, 0000h
    mov cx, 0000h
    mov dx, 0000h
    ret
clrRegs endp

setrc proc near         ;set cursor        
    mov ah,02h
    int 10h
    ret    
setrc endp

;cls proc near           ;clear screen
;    mov ax, 0600h
;    mov bx, 0700h
;    mov cx, 0000h     ; Upper left corner (row = 0, column = 0)
;    mov dx, 184Fh    ; Lower right corner (row = 24, column = 79)
;    int 10h
;    ret
;cls endp 

askRepeat proc near
    lea dx,askAgain                ;ask for repeat
    call prnt
    call input                      ;input=y/n
    cmp al,'y'
    ret
askRepeat endp

scrup proc near
    mov ax,0600h
    int 10h
    ret
scrup endp

cls proc near
    mov ah,06h  ;clear screen instruction
    mov al,00h  ;number of lines to scroll
    mov bh,07h    ;display attribute - colors
    mov ch,0    ;start row
    mov cl,0    ;start col
    mov dh,24d  ;end of row
    mov dl,79d  ;end of col
    int 10h     ;BIOS interrupt
    ret
cls endp

clrDsp proc near
    mov bh, 07h
    mov cx,0000h
    mov dx,184Fh
    int 10h
clrDsp endp

;##########################[MAIN SEGMENT]##########################;

main proc far
mov ax,dseg
mov ds,ax

;--------------------[PASSWORD CHECKING];--------------------;
logout:call cls
call clrRegs
call setrc
lea dx,enterpw
call prnt

mov si,0
pwLoop:call inputWE
mov pw[si],al
inc si
cmp al,0dh
je chkpw
cmp si,9
je chkpw
mov dl,'*'
call prntC
jne pwLoop

chkpw:mov si,0
cmp pw[si],'J'
jne deny
inc si
cmp pw[si],'0'
jne deny
inc si
cmp pw[si],'N'
jne deny
inc si
cmp pw[si],'3'
jne deny
inc si 
cmp pw[si],'N'
jne deny
inc si
cmp pw[si],'J'
jne deny
inc si
cmp pw[si],'3'
jne deny
inc si
cmp pw[si],'R'
jne deny
jmp accept

mov si,0

deny:call newLine
lea dx,pwden
call prnt
call inputWE
jmp logout

accept:call newLine
lea dx,pwacc
call prnt
call inputWE
 
;--------------------[TITLE SCREEN];--------------------;
titleScreen:call cls
call clrRegs
mov dx,021Dh 
call setrc
lea dx,msg1    ;CCA
call prnt
mov dx,040Ah 
call setrc
lea dx,msg2     ;ICSLIS
call prnt
mov dx,0611h 
call setrc
lea dx,msg4     ;7COMPARC
call prnt
mov dx,0714h     ;FINAL REQ
call setrc
lea dx,msg5
call prnt
mov dx,0A22h     ;SUBMITTED BY
call setrc
lea dx,msg6
call prnt
mov dx,0C20h     ;SANTOS
call setrc
lea dx,msg7
call prnt
mov dx,0D25h     ;S STUD
call setrc
lea dx,msg8
call prnt
mov dx,0E1Dh     ;JUANATAS
call setrc
lea dx,msg9
call prnt
mov dx,0F25h     ;J STUD
call setrc
lea dx,msg8
call prnt
mov dx,1026h     ;SECTION
call setrc
lea dx,msg11
call prnt
mov dx,1315h     ;PRESS ENTER
call setrc
lea dx,msg12
call prnt
ehehe:call inputWE
cmp al, 0dh
jne ehehe

;--------------------[MAIN MENU];--------------------;
mainMenu:call cls
call clrRegs
mov dx,031Ah ; call msg1
call setrc
lea dx,menuTitle
call prnt
mov dx,0615h ; row/col
call setrc
lea dx,act1
call prnt
mov dx,0715h ; row/col
call setrc
lea dx,act2
call prnt
mov dx,0815h ; row/col
call setrc
lea dx,act3
call prnt
mov dx,0915h ; row/col
call setrc
lea dx,act4
call prnt
mov dx,0A15h ; row/col
call setrc
lea dx,act5
call prnt
mov dx,0B15h ; row/col
call setrc
lea dx,act6
call prnt
mov dx,0C15h ; row/col
call setrc
lea dx,act7
call prnt
mov dx,0D15h ; row/col
call setrc
lea dx,act8
call prnt
mov dx,0E15h ; row/col
call setrc
lea dx,act9
call prnt
mov dx,0F15h ; row/col
call setrc
lea dx,act10
call prnt  
mov dx,1015h ; row/col
call setrc
lea dx,alis
call prnt

mov dx,1215h ; row/col
call setrc
lea dx,choice
call prnt
call input

cmp al, 31h
jne to2
je do1
    do1:
to2:cmp al, 32h
jne to3
je do2
    do2:
to3:cmp al, 33h 
jne to4
je do3  
    do3:
to4:cmp al, 34h  
jne to5    
je do4
    do4: call clrRegs
    call setrc
    call doAct4
    
to5:cmp al, 35h
jne to6    
je do5 
    do5:
to6:cmp al, 36h
jne to7   
je do6  
    do6:
to7:cmp al, 37h
jne to8    
je do7
    do7: call doAct7
    call clrRegs
    call setrc
    call askRepeat 
    jne mainMenu
    je do7
to8:cmp al, 38h 
jne to9 
je do8
    do8: 
to9:cmp al, 39h
jne to10
je do9
    do9: call clrRegs
    call setrc
    call doAct9
    call newLine
    call askRepeat
    jne mainMenu
    je do9 
to10:cmp al, 10 
jne toX           
je do10
    do10: 
    
toX:cmp al, 78h 
jne catchInputError           
je logout

catchInputError:
call cls
call clrRegs
call setrc 
lea dx, invInpt
call prnt
call input
jmp mainMenu
    

exit:mov ah,4ch
int 21h

ret
main endp  


;--------------------[Activity Procedures]--------------------;
doAct4 proc near
    again4:
    call cls      
    call clrRegs
    call setrc
    lea dx,ascAst
    call prnt
    call newLine
    lea dx,desAst
    call prnt
    call newLine 
    lea dx,crtAst
    call prnt 
    call newLine    
    lea dx,bacc
    call prnt
    call newLine    
    lea dx,choice
    call prnt
    call input
    
    cmp al, 31h  
    jne toDes    
    je doAsc
        doAsc: call clrRegs
        call setrc
        call act4Asc
        call newLine
        call askRepeat
        jne again4
        je doAsc
    toDes:cmp al, 32h  
    jne toCrt    
    je doDes
        doDes: call clrRegs
        call setrc
        call act4Des
        call newLine
        call askRepeat
        jne again4
        je doDes
    toCrt:cmp al, 33h
    jne doBacc      
    je doCrt
        doCrt: call clrRegs
        call setrc
        call act4Crt
        call newLine
        call askRepeat
        jne again4
        je doCrt  
    doBacc:cmp al, 78h  
    jne invInput    
    je mainMenu
    
    invInput:call cls
    call clrRegs
    call setrc
    lea dx,invInpt
    call prnt
    call input
    jmp again4
    ret
doAct4 endp

act4Asc proc near
    call cls            ;call ask
    call setrc
    lea dx,askAst
    call prnt    
    call input                ;store input
    mov cl, al
    add cl, 1
    mov ch, 31h
    call setrc 
    nextLA:                       ;outer loop
        mov bl, 30h
        call newLine                                  
        moreeA:mov dl,'*'      
            call prntC                 ;print asterisk 
            inc bl
            cmp ch, bl
            jne moreeA
        inc ch
        cmp ch, cl
        jne nextLA 
    ret
act4Asc endp  

act4Des proc near
    call cls            ;call ask
    call setrc
    lea dx,askAst
    call prnt    
    call input                ;store input
    mov cl, al
    mov dl,0
    call setrc           
    nextL:                     ;outer loop
    call newLine
    mov bl, cl                                  
        moree:                     ;inner loop
            mov dl,'*'      
            call prntC                 ;print asterisk
            dec bl
            cmp bl, 30h
        jne moree
    dec cl
    cmp cl, 30h
    jne nextL
    ret
act4Des endp 

act4Crt proc near
    call cls            ;call ask
    call setrc
    lea dx,askAst
    call prnt    
    call input                ;store input
    mov cl, al
    mov ch, cl
    add ch, 1            ;store to check final value
    mov dl,0
    call setrc           
    nextRow:                     ;outer loop
    call newLine
    mov bl, cl                                  
        moreC:                     ;inner loop
            mov dl,'*'      
            call prntC                 ;print asterisk
            dec bl
            cmp bl, 30h
        jne moreC
    dec cl
    cmp cl, 30h
    jne nextRow
    add cl, 2
    nextRoww:                       ;outer loop
    mov bl, 30h
    call newLine                                  
    moreCC:
        mov dl,'*'      
        call prntC                 ;print asterisk 
        inc bl
        cmp cl, bl
    jne moreCC
    inc cl
    cmp ch, cl
    jne nextRoww         
    ret
act4Crt endp

doAct7 proc near 
    call cls
    ;mov bh, 00h ;set to normal
    ;mov cx,0100h ;start row/col
    ;mov dx, 184Fh ;end row/col
    ;int 10h ;interrupt 10h display
    
    mov bh, 44h ;set to normal
    mov cx, 0219h ;start row/col
    mov dx, 1335h ;end row/col
    int 10h ;interrupt 10h display
    
    mov bh, 44h ;set to normal
    mov cx, 1319h ;start row/col
    mov dx, 1723h ;end row/col
    int 10h ;interrupt 10h display
    
    mov bh, 44h ;set to normal
    mov cx, 132Bh ;start row/col
    mov dx, 1735h ;end row/col
    int 10h ;interrupt 10h display
    
    mov bh, 44h ;set to normal
    mov cx, 070Eh ;start row/col
    mov dx, 1017h ;end row/col
    int 10h ;interrupt 10h display
    
    mov bh, 33h ;set to normal  //color
    mov cx, 0520h ;start row/col
    mov dx, 0A38h ;end row/col
    int 10h ;interrupt 10h display  
    ret
doAct7 endp

doAct9 proc near
    call cls       
    call setrc
    lea dx,inptChar
    call prnt
    
    call input 
    cmp al,'a'             ;check vowel inputs
    je vowel
    cmp al,'e'
    je vowel
    cmp al,'i'
    je vowel
    cmp al,'o'
    je vowel
    cmp al,'u'
    je vowel
    
    call newLine         
    call setrc
    lea dx,isConsonant    ;call isConsonant
    call prnt
    ret
    
    vowel: call newLine
    call setrc     ;call isVowel                     
    lea dx,isVowel
    call prnt
    ret
doAct9 endp
   
endp
   
cseg ends; ends - end of the segment
end main