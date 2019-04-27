#almog levi 311238596  
.data

	fmt_1: .string "first pstring length: %d, second pstring length: %d\n"
	fmt_2: .string "old char: %c, new char: %c, first string: %s, second string: %s\n"
	fmt_3: .string "length: %d, string: %s\n"
	fmt_4: .string "compare result: %d\n"
	fmt_5: .string "invalid option!\n"
	fmt_char: .string " %c"
        fmt_index: .string "%d"


.align 8
	
.My_Switch:

	.quad .My_Switch_50		#Case 50
	.quad .My_Switch_51		#Case 51
	.quad .My_Switch_52		#Case 52
	.quad .My_Switch_53		#Case 53
	.quad .My_Switch_54		#Case 54
        .quad .My_Switch_Def	        #Case Default

.text

.globl run_func

	.type run_func, @function

run_func:

        movq %rsp, %rbp                #for correct debugging
        pushq %rbp
        movq %rsp, %rbp                #for correct debugging

        # set the jamp tabel
	leaq -50(%rdi),%r10            # compute case = case-50
	cmpq $4,%r10 		       # compare case:4
	ja .My_Switch_Def	       # go to default case.	
	jmp *.My_Switch(,%r10,8)       # go to MySwich[case]	
	
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	
#case 50
			
.My_Switch_50:
		
	movq %rsi , %rdi		# move str1.
	call pstrlen			# get the len of str1.
		
	movq %rax , %r11 	        # save the len of str1.
	movq %rdx , %rdi		# move str2.
	call pstrlen		        # get the len of str2.

	#set befor print
		
	movq %r11 , %rsi		# move the len of str1 to the 2 arg.
	movq %rax , %rdx   		# move the ken of str2 to the 3 arg.
	movq $fmt_1, %rdi		# set the format to the 1 arg.
	xorq %rax , %rax		
	call printf			# print str1 and str2 size.
			
	jmp .done		        # jump to the end case.
	
		
#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		


.My_Switch_51: 				#case 51

	movq %rsi , %r12	        # save str1.
	movq %rdx , %r13	        # save str2.


	#scanf the old char
	subq $16 , %rsp           	# increase the stack.
	movq $0	, (%rsp)		# initial %rsp with zero.
	movq %rsp , %rsi		# where to put the input.
	movq $fmt_char , %rdi		# set the format.
	xorq %rax , %rax		
	call scanf			
	movq (%rsp) , %r14		# save the old char.
				
	#scanf for the new char
        movq $0	, (%rsp)		# initial %rsp with zero
	movq %rsp , %rsi		# where to put the input.
	movq $fmt_char , %rdi		# set the format.
	movq $0 , %rax			
	call scanf				
	movq (%rsp) , %r15		# save the new char.
				
	#set befor call to replacechar			
	movq %r12 , %rdi		# move str1 to 1 arg.
        movq %r14 , %rsi		# move old char 2 arg.
	movq %r15 , %rdx		# move new char 3 arg.

        call replaceChar

	#set befor call to replacechar.
	movq %rax , %r12		# save the new str1.
	movq %r13 , %rdi		# move str2 to 1 arg.
	movq %r14 , %rsi		# move old char to 2 arg.
	movq %r15 , %rdx		# move new char to 3 arg.

        call replaceChar

        #set befor print
	movq $fmt_2 , %rdi		# put the format in 1 arg.
	movq %r14 , %rsi		# put the old char in 2 arg.
	movq %r15 , %rdx	        # put new char in 3 arg.
	movq %r12 , %rcx	        # put str1 in 4 arg.
	movq %rax , %r8			# put str2 in 5 arg.
				
	xorq %rax , %rax		
	call printf			# print the old,new char and the old,new string.
				
	addq $16 , %rsp			#closr the stack 
	jmp .done
				

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
			
.My_Switch_52: 				#case 52					
			
		
	movq %rsi , %r12		# save str1.				
	movq %rdx, %r13 		# save str2.				       
			
	#scanf the index i.
	subq $16 , %rsp			# increase the stack.
	movq $0	, (%rsp)		# initial %rsp with zero.
	movq %rsp , %rsi		# where to put the input.
	movq $fmt_index , %rdi          # put the format in 1 arg.
	xorq %rax , %rax			
	call scanf			
	movq (%rsp) , %r14		# save the old char.				
				
	#scanf the index j.
	movq $0	, (%rsp)	        # initial %rsp with zero.
	movq %rsp , %rsi		# where to put the input.
	movq $fmt_index , %rdi	        # put the format in 1 arg.
	xorq %rax , %rax			
	call scanf				
	movq (%rsp) , %r15	        # save the new char.
	
        #set befor call to pstrijcpy.			
	movq %r12 , %rdi		# move the str1 to 1 arg.
	movq %r13 , %rsi		# move the str2 to 2 arg.
	movq %r14 , %rdx		# move the i index to 3 arg.
	movq %r15 , %rcx		# move the j index to 4 arg.
				
	call pstrijcpy			# call the function.		
				
	movq %rax , %rdx		# save the new string.
	addq $1 , %rdx 			# increse by one.
	movq %rax , %rdi		# move the new string to 1 arg.
	call pstrlen
	movq %rax , %rsi		# move the length of the string to 2 arg.
	movq $fmt_3 , %rdi		# put the print format in 1 arg.
	movq $0 , %rax			
	call printf			

        addq $16 , %rsp	                #closr the stack  
        jmp .done


#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------			
	
		
.My_Switch_53: 				#case 53
			
	movq %rsi , %rdi		# move str1 to 1 arg.
	call swapCase			# swich lower and upper case. 
	movq %rax , %r10		# save new str1.
				
	movq %rdx , %rdi		# move str2 to 1 arg.
	call swapCase			# swich lower and upper case.

	movq %rax , %rbx		# save new str2.
	movq %r10 , %rdi		# move str1 to 1 arg.
	call pstrlen			# return the length of str1.

	movq %rax , %rsi                # move the len of str1 to 2 arg.
	movq %r10 , %rdx		# move str1 to the 3 arg.
	addq $1, %rdx			# put str1 without his len.
	movq $fmt_3 ,  %rdi	        # put format as 1 arg
	xorq %rax, %rax			
					
	call printf		        # print format
				
	movq %rbx , %rdi		# move str2 to 1 arg.
	call pstrlen			# return the len of str2.
	movq %rax, %rsi			# move str2 len to 2 arg.
	movq %rbx, %rdx			# move str2 to 3 arg
	addq $1 , %rdx 			# set str2 without the len.
	movq $fmt_3 , %rdi		# put the format in 1 arg
	xorq %rax , %rax			
				
	call printf			# print the format.	
	jmp .done

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------			
				
.My_Switch_54: 				#case 54
				

        movq %rsi , %r12	        # save str1.				
        movq %rdx , %r13	        # save str2.
									
			
	#scanf the index i.
	subq $16  ,%rsp		        # increase the stack.
	movq $0	, (%rsp)	        # initial %rsp with zero.
	movq %rsp , %rsi		# %rsi point to %rsp.
	movq $fmt_index , %rdi		# put the format in 1 arg.
	xorq %rax , %rax			
	call scanf			
	movq (%rsp) , %r14		# save index i.											
				
	#scanf the index j
	movq $0	, (%rsp)		# initial %rsp with zero.
	movq %rsp , %rsi	        # %rsi point to %rsp.
	movq $fmt_index	 ,%rdi		# put the format in 1 arg.
	xorq %rax , %rax		
	call scanf				
	movq (%rsp) , %r15	        # save the new char
	
        # set befor call to pstrijcmp			
	movq %r12 , %rdi		# move the str1 to 1 arg.
	movq %r13 , %rsi		# move the str2 to 2 arg.
	movq %r14 , %rdx	        # move the i index to 3 arg.
	movq %r15 , %rcx		# move the j index to 4 arg.
				
	call pstrijcmp			# call the function	
	
        # set befor print			
	movq $fmt_4 , %rdi		# move the format to 1 arg
	movq %rax , %rsi		# move result to 2 arg	
	xorq %rax , %rax			
	call printf
				
	addq $16 , %rsp			# close the stack
	jmp  .done
	
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		
.My_Switch_Def:				#case default
			
		
.done:					#case done		
        popq %rbp
	movq $0 ,%rax			#initial %rax
	ret





			
			
