#almog levi 311238596  
.text

.globl swapCase
    .type swapCase, @function

swapCase:
       
       movq %rdi , %r9   	 # save the start of the string.
       call pstrlen       	 # get the len of str.
       
       movq %rax , %r8    	 # save the len, is now a counter.
       addq $1 , %rdi     	 # pointer to the start of the str.
       
   L1:                           # break case.
       
       cmpq $0 , %r8             # stop case.
       je   L6                   # jump to the end of the func.
       
   L2:                           # the check.
        
       call pstrlen              # get the char in the string.  
       cmpq $0x41 , %rax   
       jl   L3          # 'char' < 41 . is no a char.
       
       cmpq $0x7A , %rax 
       jg   L3          # 'char' > 7A . is no a char.
       
       cmpq $0x5A , %rax    
       jle  L4          # the char is big char.
         
       cmpq $0x61 , %rax  
       jge  L5          # the 'char' is small char.
       
   L3:                 # the update.
   
        addq $1 , %rdi   #increas the pointer.
        subq $1 , %r8    #dicreas the counter.           
        jmp  L1
       
   L4: 
   
       addq $0x20 , (%rdi)  # make the swich to a small char.    
       jmp  L3
       
   L5:                    
   
       subq  $0x20 , (%rdi) # make the swich to a big char.    
       jmp  L3
       
   L6:                    #end func
   
        movq %r9 , %rax   # put the start of the string.     
        ret


.data 
    fmt_error: .string "‫‪invalid‬‬ ‫‪input!\n‬‬"
.text

.globl pstrijcmp

    .type pstrijcmp , @function

pstrijcmp:

       #chack if i , j is valid.
       cmpb (%rdi) , %dl
       jge   R_E
       cmpb (%rdi) , %cl
       jge   R_E
       cmpb (%rsi) , %dl
       jge   R_E
       cmpb (%rsi) , %cl
       jge   R_E
       cmpq %rdx , %rcx
       jl   R_E
       
       #start seting
       movq %rdi , %r9        # save the start of 'dest'
       addq $1 , %rdi         # increas the addres to the start of the string.
       addq $1 , %rsi         # increas the addres to the start of the string.
       movq $0 , %r8          # set the counter to 0.
       
       
   R1:                       # break case.
       
       cmpb %r8b , (%r9)     # stop case , the counter == len of 'dest'
       je   R5               # jump to the end of the func.
       
       
   R2:                       # check the pointer with i and j.
        
        cmpq %r8 , %rdx      # check if couter < i
        jg   R4              # continue
        cmpq %r8 , %rcx      # check if counter > j
        jl   R6              # break        
        
   R3:
        # check the value of the ascii char
        movzbq (%rdi) , %r12
        movzbq (%rsi) , %r13
        cmpq %r12 , %r13
        je    R4                # if 'char1' == 'char2' , continue 
        jl    R5                
        
        movq $-1 , %rax
        ret  
        
                
   R4:
   
        addq $1 , %rdi        # increas the pointer
        addq $1 , %rsi        # increas the pointer
        addq $1 , %r8         # increas the counter
        jmp  R1               # go check the break case
        
    
   R5:
     
        movq $1 , %rax        # return 1.
        ret    
        
        
   R6:
     
        movq $0 , %rax        # return 0.
        ret    
            
        
   R_E:             # invalid input
        
        movq $fmt_error , %rdi  #set the formt
        xorq %rax , %rax
        call printf             # print error 
        movq $-2 , %rax
        ret

 

.text

.globl pstrijcpy
    .type pstrijcpy , @function

pstrijcpy:

       #chack if i , j is valid.
       cmpb (%rdi) , %dl
       jge   T_E
       cmpb (%rdi) , %cl
       jge   T_E
       cmpb (%rsi) , %dl
       jge   T_E
       cmpb (%rsi) , %cl
       jge   T_E
       cmpq %rdx , %rcx
       jl   T_E
       
       #start seting
       movq %rdi , %r9   # save the start of 'dest'
       addq $1 , %rdi    # increas the addres to the start of the string.
       addq $1 , %rsi    # increas the addres to the start of the string.
       movq $0 , %r8     # set the counter to 0.
       
       
   T1:                       # break case.
       
       cmpB %r8b , (%r9)     # stop case , the counter == len of 'dest'
       je   T5               # jump to the end of the func.
       
       
   T2:                       # the check.
        
        cmpq %r8 , %rdx      # check if couter < i
        jg   T4             # make ander loop
        cmpq %r8 , %rcx      # check if counter > j
        jl   T5
        
        
   T3:
        # make the swap
        movb (%rsi) , %r12b
        movb %r12b  , (%rdi)
        
        
   T4:
   
        addq $1 , %rdi        # increas the pointer
        addq $1 , %rsi        # increas the pointer
        addq $1 , %r8         # increas the counter
        jmp  T1               # go check the break case
        
    
   T5:
     
        movq %r9 , %rax        # get the string.
        ret    
        
        
   T_E:             # invalid input
        
        movq %rdi , %r12        # save 'dest'
        movq $fmt_error , %rdi  #set the formt
        xorq %rax , %rax
        call printf             # print error 
        movq %r12 , %rax
        ret

 
.text

.globl replaceChar
   .type replaceChar , @function

replaceChar:

       movq %rdi , %r9        # save the start of the string.
       call pstrlen           # get the len of str.
       
       movq %rax , %r8        # save the len, is now a counter.
       addq $1 , %rdi         # pointer to the start of the str.
       
       
   B1:                        # break case.
       
       cmpq $0 , %r8          # stop case.
       je   B5                # jump to the end of the func.
       
       
   B2:                        # the check.
        call pstrlen          # get the char.
        cmpq %rax , %rsi      # check if eqle
        je   B4               # go make the replace
        
        
   B3:
   
        addq $1 , %rdi        # increas the pointer
        subq $1 , %r8         # dicreas the counter
        jmp  B1               # go check the break case
        
        
    B4:
    
        movb %dl , (%rdi)    # make the swich
      
        jmp  B3               # cheack thr break case
        
    
    B5:
        addq $1 , %r9
        movq %r9 , %rax        # get the string.
        ret    

 
 
.text

.globl pstrlen
    .type pstrlen, @function

pstrlen:
       
        movzbl (%rdi) , %eax    # move the first byte of the str.
     
        ret
   

               
