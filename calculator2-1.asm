dseg segment
    firstinput db "Input your first number: $"
    secondinput db "Input your second number: $"
    operation db "Choose your operation [+,-]: $"
    addition db "The sum is : $"  
    subtraction db "The difference is : $" 
    endmsg db "Thank you for using our program! $"
dseg ends
cseg segment
    assume cs:cseg, ds:dseg
main proc far
   mov ax, dseg
   mov ds, ax
   
   mov dx, 0a00h;set location for msg
   call setscr
   lea dx, firstinput;display firstinput message
   call printmsg
   
   call input;input for first number which goes to cl
   mov cl, al
   
   call nextline;nextline
   lea dx, secondinput;display secondinput message
   call printmsg
   
   call input;input for first number which goes to ch
   mov ch, al 
   
   call nextline;nextline
   lea dx, operation;display secondinput message
   call printmsg
   
   call input;input for first number which goes to dl
   mov dl, al
   
   cmp dl, 2bh; if else if addition or subtraction, 2bh = +
   jne minus; since dalawa palang yung pagpipiliin
                   ; so kapag hindi plus matic minus na
   plus:call nextline
   mov al, cl ; move 1st input to al
   add al, ch ; add 1st and 2nd number
   mov ah, 0 ;clear yung ah or else iba yung output
   aaa ; kaya nilipat natin sa al kasi ax yung 
   ;nireread ng converter 
   ;eto yung part na i coconvert ya for addition output
   ;Adjust After Addition
       
   add al, 48
   add ah, 48; para if 1 digit lang yung equal 0 ang ilabas
    
    
   mov bx, ax; lipat natin sa bx since laging nagbabago ax
   lea dx, addition; 
   call printmsg
   
   mov dl, bh; print yung 1st number
   call char
   
   mov dl, bl; print yung 2nd number
   call char
   
   call exit
   
   minus:call nextline
   mov al, cl ; move 1st input to al
   sub al, ch ; subtract 1st and 2nd number
   mov ah, 0 ;clear yung ah or else iba yung output
   aam ; kaya nilipat natin sa al kasi ax yung 
   ;nireread ng converter 
   ; eto yung part na i coconvert ya for subtraction output
   ; Adjust After subtraction
       
   add al, 48
   add ah, 48; para if 1 digit lang yung equal 0 ang ilabas
    
    
   mov bx, ax; lipat natin sa bx since laging nagbabago ax
   lea dx, subtraction; 
   call printmsg
   
   mov dl, bh; print yung 1st number
   call char
   
   mov dl, bl; print yung 2nd number
   call char
   
   call exit
   
   
   exit:call nextline
   lea dx, endmsg
   call printmsg
   
   mov ah, 4ch;code for end program
   int 21h
   ret  
main endp 

nextline proc near
    mov ah, 02h
    mov dl, 0ah
    int 21h
    
    mov ah, 02h
    mov dl, 0dh
    int 21h
    ret
nextline endp

input proc near
    mov ah, 01h
    int 21h 
    ret
input endp

char proc near
    mov ah, 02h
    int 21h
    ret
char endp

setscr proc near
    mov ah, 02h
    int 10h
    ret
setscr endp

printmsg proc near
    mov ah, 09h
    int 21h
    ret
printmsg endp

cseg ends
end main
    