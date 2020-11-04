# 1) To compile and run this code. Type "gcc lab8.s -o lab8" in the shell command. Then Type "./lab8" to run the code
#    and display the output.
# 2) Feel free to change the A,B, and C quad values to check if your triangle is valid (TRUE) or invalid (FALSE).


.section .rodata		# Because we are solving for a valid/invalid triangle, I wanted to declare.. 
A: .quad 5 			# ..variables a,b, and c for the triangle sides. The string variables TRUE/FALSE..  
B: .quad 5			# will be our output which will depend on our triangle sides.
C: .quad 5
TRUE: .string "TRUE\n" 
FALSE: .string "FALSE\n" 

.text 

.global main 

print_true:			# I wanted to start my program by making sure I am able to print my TRUE and..
    mov $TRUE, %rdi		# ..and FALSE strings correctly. As my tests that I will run on my A,B, and C..
    xor %rax, %rax		# ..variables depend on it.
    call printf
    ret				# These two variables are what we are going to print if whether or not all conditions.. 
				# ..are satisfied for our triangle.
print_false:			
    mov $FALSE, %rdi		
    xor %rax, %rax
    call printf
    ret
    				
movABC:				# the movABC function allows me to overwrite the values of RBX, RCX, and RDX..
    mov (A), %rbx		# ..everytime I implement them in a certain function. I have to call this function..
    mov (B), %rcx		# ..before starting one of my test functions otherwise the values of these registers..
    mov (C), %rdx		# ..is being doubled and will display an incorrect boolean value.
    ret
    
ABtoC:				# In the assignment 8 rubric there are 3 conditions that need to be satisfied. So..
    add %rbx, %rcx		
    cmp %rcx, %rdx		# ..function ABtoC will check if A + B > C. Then function ACtoB will check if ..
    jl ACtoB
    call print_false		# ..A + C > B. Lastly, function BCtoA will check if will check if B + C > A.
    ret
    				# All of these functions start by performing arithmetic for..
ACtoB:
    call movABC			# ..the former half of the equation which is everything to the left of the greater ..
    		
    add %rbx, %rdx		# ..than sign. We than use the CMP instruction to compare left hand side of the ..
    cmp %rdx, %rcx 
    jl BCtoA			# ..equation to the right hand side. We use the JL instruction to jump to the next ..
    call print_false
    ret				# ..test function if the right hand side is NOT greater than the left hand side. 
    				# ..Now if the right hand side IS greater than the left hand side, then the program..
BCtoA:				# ..does not jump and will continue on to print false because it failed 1/3 of our..
    call movABC
    				# ..tests. For a valid triangle, all 3 of our tests must come back as "TRUE"
    add %rcx, %rdx		# ..So the program will jump if it satisfies ABtoC then ACtoB, and finally if the.. 
    cmp %rdx, %rbx 		
    jl print_true		# ..program reaches and satifies BCtoA. Then our triangle is valid or "TRUE".
    call print_false
    ret				# If at any point the values of A,B, and C cause the program to not jump, then our..
    
main:				# ..triangle is invalid or "FALSE".
    mov (A), %rbx
    mov (B), %rcx		# Our main function declares our values before we call function ABtoC. Our program.. 
    mov (C), %rdx		# ..must start with function ABtoC because of how our JMP instruction is implemented.
    				# Function ABtoC should also be called first because it is our most important test. If our ..
    call ABtoC			# A,B, and C values don't pass this stage then regardless of how our A,B,C values are..
				# ..setup it will always catch a false triangle before it even moves on.
				
				# Which is why I don't need to call functions ACtoB and BCtoA in the main function.
