FLAG_ROWS = 6
FLAG_COLS = 12

        .text
        
main:
        # Registers:
        # $t0 = row
        # $t1 = col
        # $t2 = &flag[0][0]
        # $t3 = Offset for 2D array
        # $t4 = &flag[row][col]
        # $t5 = flag[row][col]
        
row_init:
        li      $t0, 0                  # int row = 0;
        
row_cond:
        bge     $t0, FLAG_ROWS, epilogue        # if (row >= FLAG_ROWS) goto epiloguel;

row_body:

col_init:
        li      $t1, 0                  # int col = 0;

col_cond:
        bge     $t1, FLAG_COLS, col_end         # if (col >= FLAG_COLS) goto col_end;

col_body:

        # Formula for calculating the address of the 2D array element:
        # Base address + (row * NUM_COLS + col) * sizeof(element)
        
        la      $t2, flag               # $t2 = base address of array
        mul     $t3, $t0, FLAG_COLS     # $t3 = row * FLAG_COLS
        add     $t3, $t3, $t1           # $t3 = row * FLAG_COLS + col = memory offset
        
        # Multiplying $t3 with 1 (the size of a char) is essentially $t3 itself
        
        add     $t4, $t2, $t3           # $t4 = &flag[row][col]
        lb      $t5, ($t4)              # $t5 = flag[row][col]
        
        move    $a0, $t5                # printf("%c", flag[row][col]);
        li      $v0, 11
        syscall

        addi    $t1, $t1, 1             # col = col + 1;
        j       col_cond

col_end:
        li      $a0, '\n'               # printf("%c", '\n');
        li      $v0, 11
        syscall
        
row_end:
        addi    $t0, $t0, 1             # row = row + 1;
        j       row_cond

epilogue:
        li      $v0, 0                  # return 0;
        jr      $ra


        .data
flag:
        .byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
        .byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
        .byte '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.'
        .byte '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.'
        .byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
        .byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
        