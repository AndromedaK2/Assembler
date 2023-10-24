.data
dividend:   .word   0       # Memory location for dividend
divisor:    .word   0       # Memory location for divisor
quotient:   .float  0.0     # Memory location for quotient
precision:  .word   0       # Memory location for precision
newline:    .asciiz "\n"    # Newline character for printing

.text
.globl main
main:
    # Read dividend, divisor, and precision from user input
    li $v0, 5                   # System call code for reading integer
    syscall                     # Read dividend
    move $t0, $v0               # Move dividend to $t0 register

    li $v0, 5                   # System call code for reading integer
    syscall                     # Read divisor
    move $t1, $v0               # Move divisor to $t1 register

    li $v0, 5                   # System call code for reading integer
    syscall                     # Read precision
    move $t2, $v0               # Move precision to $t2 register

    sw $t0, dividend            # Store dividend in memory
    sw $t1, divisor             # Store divisor in memory
    sw $t2, precision           # Store precision in memory

    # Calculate sign
    lw $t0, dividend            # Load dividend from memory
    slt $t1, $zero, $t0         # Check if dividend is negative
    lw $t2, divisor             # Load divisor from memory
    slt $t3, $zero, $t2         # Check if divisor is negative
    xor $t4, $t1, $t3           # XOR to determine sign
    beqz $t4, positive_quotient # If sign is positive, branch to positive_quotient

    li $t5, -1                  # Set sign to -1 (negative)
    j calculate_quotient       # Jump to calculate_quotient

positive_quotient:
    li $t5, 1                   # Set sign to 1 (positive)

calculate_quotient:
    # Load dividend, divisor, and precision from memory
    lw $t0, dividend            # Load dividend
    lw $t1, divisor             # Load divisor
    lw $t2, precision           # Load precision

    # Handle division by zero
    beqz $t1, division_by_zero  # If divisor is zero, branch to division_by_zero

    # Calculate integer part of the quotient
    li $t3, 0                   # Initialize quotient to 0
    li $t4, 0                   # Initialize remainder to 0

    loop_integer:
        bge $t0, $t1, subtract    # If dividend >= divisor, branch to subtract
        j construct_decimal      # Jump to construct_decimal

    subtract:
        sub $t0, $t0, $t1         # Subtract divisor from dividend
        addi $t3, $t3, 1         # Increment quotient
        j loop_integer           # Jump back to loop_integer

    construct_decimal:
        li $t5, 0               # Initialize decimalPlaces to 0
        li $t6, 0               # Initialize decimalDigit to 0
        li $t7, 0               # Initialize decimalQuotient to 0

    loop_decimal:
        beqz $t0, done           # If dividend is zero, jump to done

        mul $t0, $t0, 10         # Multiply dividend by 10
        div $t0, $t1             # Divide dividend by divisor
        mflo $t6                # Move the quotient to decimalDigit
        mfhi $t0                # Move the remainder to dividend
        addi $t5, $t5, 1        # Increment decimalPlaces
        add $t7, $t7, $t6       # Append decimalDigit to decimalQuotient

        blt $t5, $t2, loop_decimal   # If decimalPlaces < precision, jump to loop_decimal

    done:
        beqz $t0, skip_padding      # If dividend is zero, jump to skip_padding

        sub $t6, $t2, $t5           # Calculate remaining padding
        li $t7, 0                   # Clear decimalDigit

    pad_decimal:
        addi $t6, $t6, -1           # Decrement padding count
        beqz $t6, print_quotient    # If padding count is zero, jump to print_quotient

        mul $t7, $t7, 10            # Multiply decimalDigit by 10
        j pad_decimal               # Jump back to pad_decimal

    print_quotient:
        move $t6, $t3               # Move integer part of quotient to $t6
        move $t0, $t7               # Move decimal part of quotient to $t0

        # Print sign
        beqz $t5, print_positive    # If sign is positive, jump to print_positive

        #li $v0, 4                   # System call code for printing string
        #la $a0, "-"                 # Load address of the "-" string
        #syscall                     # Print "-"

    print_positive:
        # Print integer part of quotient
        li $v0, 1                   # System call code for printing integer
        move $a0, $t6               # Move integer part of quotient to $a0
        syscall                     # Print integer

        # Print decimal point
        #li $v0, 4                   # System call code for printing string
        #la $a0, "."                 # Load address of the "." string
        #syscall                     # Print "."

        # Print decimal part of quotient
        li $v0, 1                   # System call code for printing integer
        move $a0, $t0               # Move decimal part of quotient to $a0
        syscall                     # Print integer

    print_newline:
        # Print newline character
        li $v0, 4                   # System call code for printing string
        la $a0, newline             # Load address of the newline string
        syscall                     # Print newline

    division_by_zero:
        #li $v0, 4                   # System call code for printing string
        #la $a0, "Error: Division by zero"  # Load address of the error message
        #syscall                     # Print error message

    exit_program:
        li $v0, 10                  # System call code for program exit
        syscall                     # Exit program
    skip_padding: