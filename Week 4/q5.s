        .text
main:
        # Registers:
        # $t0 = x (later changed to $s0)
        # $t1 = y
        # $t2 = sum
        
        begin
        push    $ra             # Save the value of the current return address
        push    $s0             # We need the value of x after the function call
        
        li      $s0, 10         # int x = 10;
        li      $t1, 5          # int y = 5;
        
        # Steps to invoke a function:
        # 1. Load the arguments into the $a registers
        # 2. Call `jal function_name` to execute the function
        # 3. Restore the return value from $v0 (if necessary)
        # We will also need to store the relevant $ra and $s registers
        
        move    $a0, $s0        # Load x (for the function call)        
        move    $a1, $t1        # Load y (for the function call)
        
        jal     add_nums
        move    $t2, $v0        # Move the returned value into 'sum'
        
        move    $a0, $t2        # printf("%d", sum);
        li      $v0, 1
        syscall
        
        li      $a0, '\n'       # printf("%c", '\n');
        li      $v0, 11
        syscall
        
        move    $a0, $s0        # printf("%d", x);
        li      $v0, 1
        syscall
        
        li      $a0, '\n'       # printf("%c", '\n');
        li      $v0, 11
        syscall
        
        pop     $s0             # Pop the 'pushed' values in reverse order
        pop     $ra
        end
        
        li      $v0, 0          # return 0;
        jr      $ra
        
        
add_nums:
        add     $t0, $a0, $a1   # $t0 = x + y (we never use this register again)
        move    $v0, $t0        # $v0 = $t0 (so that we can return 'sum' in $v0)
        jr      $ra