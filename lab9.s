# To compile and run, type in the shell command "gcc lab9.s -o lab9" to compile. Then type "./lab9" to run.
# In order to test my functions, simply change the "factorialInt", "fibonacciInt", and "primeInt" quad values



.section .rodata
factorialInt: .quad 11					
fibonacciInt: .quad 11			# change these integer variables to test different outputs for all 3 problems  
primeInt: .quad 11					

print_facto: .string "1) Factorial of %d is %d\n"
print_fibo: .string "2) %dth Fibonacci number is %d\n"		# declaring string variables to display my results 
is_prime: .string "3) Prime\n"
notPrime: .string "3) Not Prime\n"

.text

.global main
					
print_fibonacci:			
    mov $print_fibo, %rdi		# I have to work on the 4 print function first for string variables..
    mov (fibonacciInt), %rsi
    mov %rdx, %rdx			# ..in order to begin my procedures and loops for these problems.
    xor %rax, %rax
    call printf			# This will display print_fibo and show the argument we pass and the corresponding..
    ret				# ..fibonacci number.
	
					
print_Prime:
    mov $is_prime, %rdi
    xor %rax, %rax		# if divisible by itself and 1 then print that its prime.
    call printf
    ret
    
print_notPrime:
    mov $notPrime, %rdi
    xor %rax, %rax		# if divisible by itself, 1, and something else then print that its not prime
    call printf
    ret
    
print_factorial:
    mov $print_facto, %rdi
    mov (factorialInt), %rsi
    mov %rax, %rdx		# Will print out the argument we pass and resulting factorial as well
    xor %rax, %rax
    call printf 
    ret

				# below you will see me first declare all of my variables then start the looping ..
				# ..function for each problem.
				# This is a recurring theme throughout this program.

factorial:
    mov (factorialInt), %rbx
    mov $1, %rax		# declaring my variables, we need our argument and a variable which equals 1
    jmp factorial_check		# we then jump to the loop
    
factorial_check:
    mov $0, %rcx		# making rcx to take in a literal which is 0
    cmp %rbx, %rcx		# if both are 0 then jump to print the factorial 
    je print_factorial
    
    mul %rbx 			# first does N x 1, then decrements to do N x N-1 until we reach the 0 counter..
    dec %rbx 			# ..to print the factorial. Will only print result once rcx is 0.
    
    jmp factorial_check		# keep looping until comparison is satisfied.
    

prime:
    mov (primeInt), %rsi	# for solve for prime/not prime, we need our argument and 2 moved into registers
    mov $2, %rdi
    jmp prime_loop		# jump to the looping function so we can begin
    
prime_loop:
    cmp %rsi, %rdi		# programs keeps looping as long as a remainder of 1 is not found, we need only..
    je print_Prime		# ..a count of 2 to consider our argument to be prime, rdi cannot be greater than 3..
    				# ..otherwise it is not prime

    xor %rdx, %rdx
    mov %rsi, %rax		# performing our division
    div %rdi
    
    cmp $0, %rdx		# this here stops the loop if we get a remainder of 1 or greater than prints not prime
    je print_notPrime
    
    inc %rdi			# incrementing if a remainder of 1 or greater is not found
    jmp prime_loop
    
fibonacci:
    mov $0, %rbx  		# we need 0 and 1 declared, rbx is A and rcx is B, later on rdx which is C will be A + B
    mov $1, %rcx  
    mov (fibonacciInt), %r8	# our argument 
    jmp fibonacci_loop		# jump to looping function
    
fibonacci_loop:
    cmp $1, %r8			# comparing 1 to r8 which we are decrementing for every loop until r8 becomes 1
    je print_fibonacci		
    
    xor %rdx, %rdx		# have to zero out otherwise fibonacci number is doubled over and over
    lea (%rbx, %rcx), %rdx	# putting A + B in C which is rdx
    
    dec %r8			# decrementing so program can eventually stop 
    
    mov %rcx, %rbx		# A now equals B
    mov %rdx, %rcx		# B now equals C
    
    jmp fibonacci_loop		# restart loop until comparison condition is met
    
main:
    call factorial		
    call fibonacci		# calling our functions in order of the problems in assignment 9 pdf.
    call prime
