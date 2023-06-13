N_SIZE = 10

        .text
main:
        # Registers:
        # $t0 = i
        # $t1 = &numbers[0] (base address of the array)
        # $t2 = i * 4
        # $t3 = &numbers[i] (address of the element within the array)
        # $t4 = numbers[i] (value of the element within the array)
        
loop_init:        
        li      $t0, 0                  # int i = 0;
        
loop_condition:
        bge     $t0, N_SIZE, epilogue   # if (i >= N_SIZE) goto epilogue;
        
loop_body:
        # Address of the element we are interested about:
        # &numbers[i] = Base address + offset * sizeof(element)
        
        la      $t1, numbers            # $t1 = &numbers[0]
        
        mul     $t2, $t0, 4             # Multiply the offset by 4 bytes (since we have an integer array)
        add     $t3, $t1, $t2           # $t3 = &numbers[i] + i * 4
        lw      $t4, ($t3)              # $t4 = numbers[i]
        
        bge     $t4, 0, print_element   # if (numbers[i] >= 0) goto print_element
        
        addi    $t4, $t4, 42            # numbers[i] += 42;
        sw      $t4, ($t3)              # Store the updated value back in the memory
        
print_element:
        move    $a0, $t4                # printf("%d", numbers[i]);
        li      $v0, 1
        syscall
        
        li      $a0, '\n'               # printf("%c", '\n');
        li      $v0, 11
        syscall

loop_step:
        addi    $t0, $t0, 1             # i++;
        j       loop_condition
        
epilogue:
        jr      $ra                     # return 0;
        
        .data
numbers:
        .word   0, 1, 2, -3, 4, -5, 6, -7, 8, 9