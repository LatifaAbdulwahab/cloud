
.model small
.stack 100h
.data

MSG db 'u3o5Y7 9s8s2i4M6 0l9l2iW4 2I$'
;to count litters to print it
count dw 0 

.code

 main proc 
        
    mov dx, @data
    mov ds,dx  
     
    mov ah, 9 
    lea dx , MSG
    int 21h  
     
    ;loop to move all msg 
    mov cx, 28
    lea si,MSG 
    jcxz skip 
    
    move:
    ;msg > 41h(A) 
    cmp [si] ,41h
    jge Upper  
    
    ;msg > 61h (a)
    cmp [si] ,61h
    jge Lower2  
    
    ;msg = space 
    CMP [SI],' '
    je pushin 
    
   ;msg >= 0
    cmp [si],30h
    jge num1 
    
    ;msg <= 9
    num1:
    cmp [si],39h
    jle number
    
    number:
    add si,1 

    loop move  
   
    ;msg < 5Ah(Z)
    Upper: 
    cmp [si], 5Ah
    jle pushin 
   
    ;msg < 7Ah(z)
    Lower2:
    cmp [si], 7Ah
    jle pushin
     
    pushin:
    mov ax,0
    mov al,[si]
    ;we have to do ah=0 to push al in stack(stack just accepts 16bit) 
    ;and ax, 00ffh 
    push ax 
    add si,1 
    add count,1
    loop move 

    skip: 
    call print  
    
    mov ah, 4ch
    int 21h

  main endp 
 
    print proc
        
        mov ah,2
        mov dl, 0ah
        int 21h 
        
        mov ah,2
        mov dl, 0dh
        int 21h 
          
        pop ax 
        mov cx, count
        jcxz sk 
    
        ;loop to print litters 
        revers:
        mov ah,2
        ;out from stack to dx 
        pop dx   
        int 21h
        loop revers 
          
        sk:
 ;i will miss you to
        
   print endp 
    end main 
        
       