# I compiled my code by using the command "gcc lab7.s -o lab7" in the shell. Then type "./lab7" in the shell to display the output.							
# To test my code, simply change the A and B quad values to whatever you want and perform the shell commands again. 


.section .rodata 
result1: .string "1) %d * 5 = %d\n"		    # So instead of just printing the result, I also wanted to display the equations..			
result2: .string "2) (%d + %d) - (%d / %d) = %d\n"  # ..before it as well, so I have created the necessary string variables that will be displayed..
result3: .string "3) (%d - %d) + (%d * %d) = %d\n"  # ..when we call this program in the shell command
A: .quad 15 						
B: .quad 15
 
.text
 
.global main 			# my program will begin here as usual					

print_result1:
    mov $result1, %rdi
    xor %rax, %rax					
    call printf			# print_result1, print_result2, and print_result3 will print out my equations and results along with it.
    ret				# These print functions display the equation but dont display the integers in them, except for print_result2..		
    				# ..where I placed my arguments in advance in order to avoid clutter in my main function later on.
print_result2:
    mov $result2, %rdi
    xor %rax, %rax		# I could have done the same thing with print_result3 but by then my code was already working therefore, I didn't.. 
    				# ..bother as it didn't make a difference whether I placed my arguments before or after my main function.
    mov (A), %rsi
    mov (B), %rdx
    mov (A), %rcx					
    mov (B), %r8                                       
    mov %rbx, %r9
    
    call printf
    ret 

print_result3:
    mov $result3, %rdi
    xor %rax, %rax					
    call printf
    ret
	 
main:			# In the main function is where I conducted all of my arithmetic, for the first equation. I placed my A variable ..
    mov (A), %rsi	# ..5 variable into the RDI and RSI registers. There wasn't a point to pushing them on the stack, I merely was ..	
    push %rsi		# ..testing the stack out. I didnt use the memory in any way for this first equation, so you can ignore the push..   				
    mov $5, %rdi        # ..instruction.					
    push %rdi				
    
    mov %rsi, %rax	# I wanted RAX to hold the A variable and RDX to hold the 5 variable. That way I could use the mul instruction.				
    mov %rdi, %rdx	# After using mul, the result is now in RAX, I moved the RAX result back into RDX. I did this because if I called RDX ..				
    mul %rdx		# ..too early without placing the RAX result in the correct register. Then call print_result1 would show a different ..				
    mov %rax, %rdx	# ..result.				
    call print_result1					
    
    
    mov (A), %rsi	# We are only using RSI and RDX registers to hold the A and B value to avoid clutter.			
    mov (B), %rdx				
    add %rsi, %rdx	# this add instruction helps us complete the former half of the second equation which is (a + b) ..			
    push %rdx		# ..and I want to store the result in the stack so I can put it in the RBX register later on.			
    
    
    mov (B), %rbx	# Now we have to complete the ladder half of the equation which is (a / b). To do this I had to make my numerator..			
    xor %rdx, %rdx	# ..which is RAX is the correct value along with RBX which is the denominator. 			
    mov (A), %rax	# When the div instruction is executed, we get a floating point error. I believe this is because RAX and RDX are ..			
    div %rbx		# ..are combined when the div instruction is done. So that is why I did 'xor %rdx, %rdx" which fixed the issue.			
    
    pop %rbx				
    sub %rax, %rbx      # We are popping RBX as I mentioned previously so that we can perform the final arithmetic operation which the subtraction			
    
    call print_result2			 
    
    mov (A), %rsi	
    mov (B), %rdx	# Now on to the third equation, I placed my A and B values in the correct 4 arguments to display my equation correctly.		
    mov (A), %rcx
    mov (B), %r8	# We will use R9 later on to display the result once the arithmetic is completed
    
    mov %rsi, %rbx			
    mov %rdx, %rdi	# These three lines of code are just me placing the values of A and B in the correct registers and call the sub..			
    sub %rdi, %rbx	# ..instruction. Sense the first half of the equation is complete, I am going to leave RBX alone because it is done.

		
    mov (A), %rax			
    mul %r8		# R8 is our B value which we initialized before beginning our arithmetic stage. Here we are just multiplying A * B.

		
    add (B), %rdx	# I did this because I had a problem where my format string was not displaying my equation correctly. So this was a..			
			# ..simply and easy fix to make sure that the B value in (a - b) was displaying correctly. 		


    add %rbx, %rax      # the former half and ladder half of the equation have already been solved. Now all I needed to do is add them and ..			
    mov %rax, %r9	# ..put the result in R9.		
    
    
    call print_result3			
