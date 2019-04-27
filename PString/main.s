#almog levi 311238596  
.data

fmt_len: .string "%hhu"
fmt_string: .string " %s\0"
fmt_case: .string " %d"


.text



.global main
    .type main, @function
main:
        movq %rsp, %rbp #for correct debugging
        pushq %rbp
        movq %rsp, %rbp #for correct debugging
        
        # set str1
        subq $8 , %rsp             # increas the stack    
        movq $0 , (%rsp)            # zero 
        movq %rsp , %rsi            # put her the len       
        movq $fmt_len , %rdi        # the format in 1 arg
        xorq %rax , %rax            
        call scanf
        movzbq (%rsp) , %r12        # save the len
       
        sub %r12 , %rsp             # increas the stack by the len
        movq %rsp , %rsi            # put her the string       
        movq $fmt_string , %rdi     # the format in 1 arg
        xorq %rax , %rax
        call scanf
           
        subq $1 , %rsp              # increas the stack by 1 for the len
        movb %r12b , (%rsp)         # move the len to the start of the string
        movq %rsp , %r14            # save str1.
        
        
        # set str2
        subq $11 , %rsp             # increas the stack    
        movq $0  , (%rsp)            # zero 
        movq %rsp , %rsi            # put her the len       
        movq $fmt_len , %rdi        # the format in 1 arg
        xorq %rax , %rax            
        call scanf
        movzbq (%rsp) , %r13        # save the len
       
        subq %r13 , %rsp             # increas the stack by the len
        movq %rsp , %rsi            # put her the string       
        movq $fmt_string , %rdi     # the format in 1 arg
        xorq %rax , %rax
        call scanf
           
        subq $1 , %rsp               # increas the stack by 1 for the len
        movb %r13b , (%rsp)          # move the len to the start of the string
        movq %rsp , %rbx             # save str2.
        
        # set case
        subq $11 , %rsp              # increas the stack    
        movq $0  , (%rsp)            # zero 
        movq %rsp , %rsi             # put her the len       
        movq $fmt_case , %rdi        # the format in 1 arg
        xorq %rax , %rax            
        call scanf
        movq (%rsp) , %r15         # save the case
        
        #save the size of stack
        pushq %r12
        pushq %r13
        
        
        #set call to run_func
        movq %r15 , %rdi
        movq %r14 , %rsi
        movq %rbx , %rdx
       
        call run_func 
        
        
        popq %r13
        popq %r12 
        addq %r13 , %rsp
        addq %r12 , %rsp
        addq $40 , %rsp
        xorq  %rax, %rax
        ret

