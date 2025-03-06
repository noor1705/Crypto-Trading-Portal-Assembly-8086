    .MODEL SMALL
    .STACK 100H
    
    .DATA
    ; Messages
    greeting_message0 DB "          |************************************************************|$"    
    greeting_message1 DB "          |                                                            |$" 
    greeting_message2 DB "          |                                                            |$"
    greeting_message3 DB "          |                   Crypto Trading Portal                    |$"    
    greeting_message4 DB "          |                                                            |$"
    greeting_message5 DB "          |                                                            |$"
    greeting_message6 DB "          |************************************************************|$" 
    
    new_line DB 10, 13, "$"
    menu_message DB "1. Show Market Prices$"
    menu_message2 DB "2. Buy Cryptocurrency$"
    menu_message3 DB "3. Sell Cryptocurrency$"
    menu_message4 DB "4. View Wallet Balance$"
    menu_message5 DB "5. Exit$"
    enter_choice DB "Enter your choice: $"
    invalid_choice DB "Invalid choice, try again.$"
    
    market_prices DB "Bitcoin (BTC): 100$"
    price_eth DB "Ethereum (ETH): 10$"
    price_xrp DB "Ripple (XRP): 1$"
    
    wallet_balance_label DB "Wallet Balance: $"
    btc_holding_label DB "Bitcoin Holdings: $"
    eth_holding_label DB "Ethereum Holdings: $"
    xrp_holding_label DB "Ripple Holdings: $"
    
    btc_holding DW 0
    eth_holding DW 0
    xrp_holding DW 0
    wallet_balance DW 5000 ; Wallet starts with $5000
    
    buy_prompt DB "Enter crypto to buy (1-BTC, 2-ETH, 3-XRP): $"
    sell_prompt DB "Enter crypto to sell (1-BTC, 2-ETH, 3-XRP): $"
    enter_amount DB "Enter Quantity: $"
                                                                                                                    
                                                                                                                    
                                                                                                                    
    buy_success DB "Transaction successful!$"
    sell_fail DB "Insufficient holdings or funds!$"
    press_key DB "Press any key to return to the main menu.$"                                 
    press_key_buy DB "Press '1' to buy again and any other key to return to the main menu.$"
    press_key_sell DB "Press '1' to sell again and any other key to return to the main menu.$"     
    
    invalid_amount DB 10,13,"Invalid amount. Try again.", 10, 13, 10, 13, "Quantity should be one digit only i.e. between 1-9. ",10,13,"$"
    
    .CODE
        MOV AX, @DATA
        MOV DS, AX
    
    main_menu:
        CALL clear_screen ; Clear the screen before displaying the main menu
    
   
            
        LEA DX, new_line
        MOV AH, 09H
        INT 21H
        lea dx,new_line
        mov ah,09h
        int 21h  
    
        LEA DX, menu_message
        MOV AH, 09H
        INT 21H
    
        LEA DX, new_line
        MOV AH, 09H
        INT 21H
    
        LEA DX, menu_message2
        MOV AH, 09H
        INT 21H
    
        LEA DX, new_line
        MOV AH, 09H
        INT 21H
    
        LEA DX, menu_message3
        MOV AH, 09H
        INT 21H
    
        LEA DX, new_line
        MOV AH, 09H
        INT 21H
    
        LEA DX, menu_message4
        MOV AH, 09H
        INT 21H
    
        LEA DX, new_line
        MOV AH, 09H
        INT 21H
    
        LEA DX, menu_message5
        MOV AH, 09H
        INT 21H
    
        ; Prompt for input from user choice
        LEA DX, new_line
        MOV AH, 09H
        INT 21H
    
        LEA DX, enter_choice
        MOV AH, 09H
        INT 21H
    
        MOV AH, 01H
        INT 21H
        MOV BL, AL
    
        ; Handle choice
        CMP BL, '1'
        JE show_market
        CMP BL, '2'
        JE buy_crypto
        CMP BL, '3'
        JE sell_crypto
        CMP BL, '4'
        JE view_wallet
        CMP BL, '5'
        JE exit_program
    
        ; Invalid input
        lea dx,new_line
        mov ah,09h
        int 21h  
        LEA DX, invalid_choice
        MOV AH, 09H
        INT 21H
        JMP main_menu
    
    show_market:
        CALL clear_screen ; Clear the screen before displaying market prices
    
        ; Display market prices
        LEA DX, new_line
        MOV AH, 09H
        INT 21H
    
        LEA DX, market_prices
        MOV AH, 09H
        INT 21H
    
        LEA DX, new_line
        MOV AH, 09H
        INT 21H
    
        LEA DX, price_eth
        MOV AH, 09H
        INT 21H
    
        LEA DX, new_line
        MOV AH, 09H
        INT 21H
    
        LEA DX, price_xrp
        MOV AH, 09H
        INT 21H
    
        ; Wait for any key press to return to main menu
        LEA DX, new_line
        MOV AH, 09H
        INT 21H
    
        LEA DX, press_key
        MOV AH, 09H
        INT 21H
    
        MOV AH, 01H
        INT 21H
        JMP main_menu
buy_crypto:
        CALL clear_screen ; Clear the screen before displaying buy options

        display_market_prices:
        LEA DX, new_line
        MOV AH, 09H
        INT 21H

        LEA DX, market_prices
        MOV AH, 09H
        INT 21H

        LEA DX, new_line
        MOV AH, 09H
        INT 21H

        LEA DX, price_eth
        MOV AH, 09H
        INT 21H

        LEA DX, new_line
        MOV AH, 09H
        INT 21H

        LEA DX, price_xrp
        MOV AH, 09H
        INT 21H

        ; Get crypto to buy
        LEA DX, new_line
        MOV AH, 09H
        INT 21H

        LEA DX, buy_prompt
        MOV AH, 09H
        INT 21H

        MOV AH, 01H
        INT 21H
        MOV BL, AL ; Store the user's choice

        ; Check validity of the choice
        CMP BL, '1'
        JE valid_choice
        CMP BL, '2'
        JE valid_choice
        CMP BL, '3'
        JE valid_choice

    invalid_market_choice:   
        LEA DX, new_line
        MOV AH, 09H
        INT 21H

        LEA DX, invalid_choice
        MOV AH, 09H
        INT 21H

        LEA DX, new_line
        MOV AH, 09H
        INT 21H

        JMP display_market_prices ; Return to the main menu after an invalid choice

    valid_choice:
        LEA DX, new_line
        MOV AH, 09H
        INT 21H

        validate_amount:
        ; Print "Enter amount:"
        LEA DX, enter_amount
        MOV AH, 09H
        INT 21H

        ; Take input from user
        MOV AH, 01H
        INT 21H
        MOV CL, AL            ; Store input character in CL

        ; Validate the input (ASCII for '1' is 31h and '9' is 39h)
        CMP CL, '1'
        JL invalid_crypto_amount     ; If less than '1', jump to invalid_crypto_amount
        CMP CL, '9'
        JG invalid_crypto_amount     ; If greater than '9', jump to invalid_crypto_amount

        ; Deduct wallet balance and update holdings
        CMP BL, '1'
        JE BuyBTC
        CMP BL, '2'
        JE BuyETH
        CMP BL, '3'
        JE BuyXRP

        JMP main_menu



    BuyBTC:
        MOV BL, CL
        MOV AX, 100          ; BTC price (10 units per BTC)
        MOV CX, 0           ; Clear CX
        MOV CL, BL          ; Move input amount into CL
        SUB CL, '0'         ; Convert ASCII to integer
        MOV DX, 0           ; Clear DX for MUL
        MUL CX              ; Calculate cost (AX * amount)
        CMP AX, wallet_balance
        JG insufficient_funds_buy
        SUB wallet_balance, AX
        ADD btc_holding, CX
        JMP transaction_success_buy

    BuyETH: 
        MOV BL, CL
        MOV AX, 10           ; ETH price (5 units per ETH)
        MOV CX, 0           ; Clear CX
        MOV CL, BL          ; Move input amount into CL
        SUB CL, '0'         ; Convert ASCII to integer
        MOV DX, 0           ; Clear DX for MUL
        MUL CX              ; Calculate cost (AX * amount)
        CMP AX, wallet_balance
        JG insufficient_funds_buy
        SUB wallet_balance, AX
        ADD eth_holding, CX
        JMP transaction_success_buy

    BuyXRP:
        MOV BL, CL
        MOV AX, 1           ; XRP price (1 unit per XRP)
        MOV CX, 0           ; Clear CX
        MOV CL, BL          ; Move input amount into CL
        SUB CL, '0'         ; Convert ASCII to integer
        MOV DX, 0           ; Clear DX for MUL
        MUL CX              ; Calculate cost (AX * amount)
        CMP AX, wallet_balance
        JG insufficient_funds_buy
        SUB wallet_balance, AX
        ADD xrp_holding, CX
        JMP transaction_success_buy



    
    sell_crypto:
        CALL clear_screen ; Clear the screen before displaying sell options
    
        ; Display sell prompt 
    display_selling_prices:
        LEA DX, new_line
        MOV AH, 09H
        INT 21H
    
        ; Display Bitcoin holdings
        LEA DX, new_line
        MOV AH, 09H
        INT 21H
    
        LEA DX, btc_holding_label
        MOV AH, 09H
        INT 21H
    
        ; Convert btc_holding to string
        MOV AX, btc_holding
        MOV CX, 10
        MOV BX, 0
    
    print_btc_sell:
        XOR DX, DX
        DIV CX
        ADD DL, '0'
        PUSH DX
        INC BX
        CMP AX, 0
        JNE print_btc_sell
    
    print_btc_sell_digits:
        POP DX
        MOV AH, 02H
        INT 21H
        DEC BX
        JNZ print_btc_sell_digits
    
        LEA DX, new_line
        MOV AH, 09H
        INT 21H
    
        ; Display Ethereum holdings
        LEA DX, eth_holding_label
        MOV AH, 09H
        INT 21H
    
        ; Convert eth_holding to string
        MOV AX, eth_holding
        MOV CX, 10
        MOV BX, 0
    
    print_eth_sell:
        XOR DX, DX
        DIV CX
        ADD DL, '0'
        PUSH DX
        INC BX
        CMP AX, 0
        JNE print_eth_sell
    
    print_eth_sell_digits:
        POP DX
        MOV AH, 02H
        INT 21H
        DEC BX
        JNZ print_eth_sell_digits
    
        LEA DX, new_line
        MOV AH, 09H
        INT 21H
    
        ; Display Ripple holdings
        LEA DX, xrp_holding_label
        MOV AH, 09H
        INT 21H
    
        ; Convert xrp_holding to string
        MOV AX, xrp_holding
        MOV CX, 10
        MOV BX, 0
    
    print_xrp_sell:
        XOR DX, DX
        DIV CX
        ADD DL, '0'
        PUSH DX
        INC BX
        CMP AX, 0
        JNE print_xrp_sell
    
    print_xrp_sell_digits:
        POP DX
        MOV AH, 02H
        INT 21H
        DEC BX
        JNZ print_xrp_sell_digits
    
       ; Get crypto to sell
        LEA DX, new_line
        MOV AH, 09H
        INT 21H
    
        LEA DX, sell_prompt
        MOV AH, 09H
        INT 21H
    
        MOV AH, 01H
        INT 21H
        MOV BL, AL ; Store the user's choice
    
        ; Check validity of the choice
        CMP BL, '1'
        JE valid_choice_sell
        CMP BL, '2'
        JE valid_choice_sell
        CMP BL, '3'
        JE valid_choice_sell
    
    invalid_choice_sell:   
        LEA DX, new_line
        MOV AH, 09H
        INT 21H
        
        LEA DX, invalid_choice
        MOV AH, 09H
        INT 21H
        
        LEA DX, new_line
        MOV AH, 09H
        INT 21H
        
        JMP display_selling_prices
    
    valid_choice_sell:
        LEA DX, new_line
        MOV AH, 09H
        INT 21H
    
    validate_sell_amount:
        ; Print "Enter amount:"
        lea dx, enter_amount
        mov ah, 09h
        int 21h
    
        ; Take input from user
        mov ah, 01h
        int 21h
        sub al, '0'         ; Convert ASCII input to numeric
        mov cl, al          ; Store the numeric value in CL
    
        ; Check if input is valid
        cmp cl, 1
        jl invalid_sell_amount ; If less than 1, jump to invalid_sell_amount
        cmp cl, 9
        jg invalid_sell_amount ; If greater than 9, jump to invalid_sell_amount
    
        ; Deduct wallet balance and update holdings
        CMP BL, '1'
        JE SellBTC
        CMP BL, '2'
        JE SellETH
        CMP BL, '3'
        JE SellXRP    
        JMP main_menu
    
    SellBTC:
        MOV AX, btc_holding
        CMP AX, CX          ; Compare holdings with input amount
        JL insufficient_funds_sell
        MOV AX, CX
        MOV BX, 100          ; Assume BTC price is 10 units
        MUL BX              ; Multiply amount by price
        ADD wallet_balance, AX
        SUB btc_holding, CX
        JMP transaction_success_sell
    
    SellETH:
        MOV AX, eth_holding
        CMP AX, CX
        JL insufficient_funds_sell
        MOV AX, CX
        MOV BX, 10          ; Assume ETH price is 10 units
        MUL BX
        ADD wallet_balance, AX
        SUB eth_holding, CX
        JMP transaction_success_sell
    
    SellXRP:
        MOV AX, xrp_holding
        CMP AX, CX
        JL insufficient_funds_sell
        MOV AX, CX
        MOV BX, 1           ; Assume XRP price is 1 unit
        MUL BX
        ADD wallet_balance, AX
        SUB xrp_holding, CX
        JMP transaction_success_sell
    
    
        JMP main_menu    

view_wallet:
        ; Clear the screen before displaying wallet balance
        CALL clear_screen

        ; Display wallet balance label
        LEA DX, wallet_balance_label
        MOV AH, 09H
        INT 21H

        ; Convert wallet_balance to string and display
        MOV AX, wallet_balance
        MOV CX, 10
        MOV BX, 0

    print_balance:
        XOR DX, DX         ; Clear DX for division
        DIV CX             ; Divide AX by 10
        ADD DL, '0'        ; Convert remainder to ASCII
        PUSH DX            ; Push ASCII digit onto stack
        INC BX             ; Increment BX for digit count
        CMP AX, 0          ; Check if AX is zero
        JNE print_balance  ; Repeat if not zero

    print_balance_digits:
        POP DX             ; Pop ASCII digit from stack
        MOV AH, 02H        ; Function to display a character
        INT 21H
        DEC BX             ; Decrement BX
        JNZ print_balance_digits ; Repeat until all digits are displayed

        ; Display new line
        LEA DX, new_line
        MOV AH, 09H
        INT 21H

        ; Display Bitcoin holdings label
        LEA DX, btc_holding_label
        MOV AH, 09H
        INT 21H

        ; Convert btc_holding to string and display
        MOV AX, btc_holding
        MOV CX, 10
        MOV BX, 0

    print_btc:
        XOR DX, DX
        DIV CX
        ADD DL, '0'
        PUSH DX
        INC BX
        CMP AX, 0
        JNE print_btc

    print_btc_digits:
        POP DX
        MOV AH, 02H
        INT 21H
        DEC BX
        JNZ print_btc_digits

        ; Display new line
        LEA DX, new_line
        MOV AH, 09H
        INT 21H

        ; Display Ethereum holdings label
        LEA DX, eth_holding_label
        MOV AH, 09H
        INT 21H

        ; Convert eth_holding to string and display
        MOV AX, eth_holding
        MOV CX, 10
        MOV BX, 0

    print_eth:
        XOR DX, DX
        DIV CX
        ADD DL, '0'
        PUSH DX
        INC BX
        CMP AX, 0
        JNE print_eth

    print_eth_digits:
        POP DX
        MOV AH, 02H
        INT 21H
        DEC BX
        JNZ print_eth_digits

        ; Display new line
        LEA DX, new_line
        MOV AH, 09H
        INT 21H

        ; Display Ripple holdings label
        LEA DX, xrp_holding_label
        MOV AH, 09H
        INT 21H

        ; Convert xrp_holding to string and display
        MOV AX, xrp_holding
        MOV CX, 10
        MOV BX, 0

    print_xrp:
        XOR DX, DX
        DIV CX
        ADD DL, '0'
        PUSH DX
        INC BX
        CMP AX, 0
        JNE print_xrp

    print_xrp_digits:
        POP DX
        MOV AH, 02H
        INT 21H
        DEC BX
        JNZ print_xrp_digits

        ; Display new line
        LEA DX, new_line
        MOV AH, 09H
        INT 21H

        ; Wait for any key press to return to main menu
        LEA DX, press_key
        MOV AH, 09H
        INT 21H

        MOV AH, 01H        ; Wait for key press
        INT 21H
        JMP main_menu      ; Return to main menu


    transaction_success_buy:
        LEA DX, new_line
        MOV AH, 09H
        INT 21H
    
        LEA DX, buy_success
        MOV AH, 09H
        INT 21H
    
        ; Wait for any key press to return to main menu
        LEA DX, new_line
        MOV AH, 09H
        INT 21H
    
        LEA DX, press_key_buy
        MOV AH, 09H
        INT 21H

        LEA DX, new_line
        MOV AH, 09H
        INT 21H
                 
        LEA DX, new_line
        MOV AH, 09H
        INT 21H
        
        
        LEA DX,enter_choice
        MOV AH,09H
        INT 21H
            
        MOV AH, 01H
        INT 21H
        cmp al,'1'
        JE buy_crypto
        JMP main_menu
    
    insufficient_funds_buy:
        LEA DX, new_line
        MOV AH, 09H
        INT 21H
    
        LEA DX, sell_fail
        MOV AH, 09H
        INT 21H
    
        ; Wait for any key press to return to main menu
        LEA DX, new_line
        MOV AH, 09H
        INT 21H
    
        LEA DX, press_key_buy
        MOV AH, 09H
        INT 21H
        
        LEA DX, new_line
        MOV AH, 09H
        INT 21H
        
                 
        LEA DX, new_line
        MOV AH, 09H
        INT 21H
        
                
        LEA DX,enter_choice
        MOV AH,09H
        INT 21H
    
        MOV AH, 01H
        INT 21H
        cmp al,'1'
        JE buy_crypto
        JMP main_menu
    transaction_success_sell:
        LEA DX, new_line
        MOV AH, 09H
        INT 21H
    
        LEA DX, buy_success
        MOV AH, 09H
        INT 21H
    
        ; Wait for any key press to return to main menu
        LEA DX, new_line
        MOV AH, 09H
        INT 21H
    
        LEA DX, press_key_sell
        MOV AH, 09H
        INT 21H
        
        LEA DX, new_line
        MOV AH, 09H
        INT 21H
                 
        LEA DX, new_line
        MOV AH, 09H
        INT 21H
        
                
        
        LEA DX,enter_choice
        MOV AH,09H
        INT 21H
            
        MOV AH, 01H
        INT 21H
        cmp al,'1'
        JE sell_crypto
        JMP main_menu
    
    insufficient_funds_sell:
        LEA DX, new_line
        MOV AH, 09H
        INT 21H
    
        LEA DX, sell_fail
        MOV AH, 09H
        INT 21H
    
        ; Wait for any key press to return to main menu
        LEA DX, new_line
        MOV AH, 09H
        INT 21H
    
        LEA DX, press_key_sell
        MOV AH, 09H
        INT 21H
        
        LEA DX, new_line
        MOV AH, 09H
        INT 21H
                 
        LEA DX, new_line
        MOV AH, 09H
        INT 21H
        
                
        
        LEA DX,enter_choice
        MOV AH,09H
        INT 21H
    
        MOV AH, 01H
        INT 21H
        cmp al,'1'
        JE sell_crypto
        JMP main_menu
    
    exit_program:
        MOV AH, 4CH
        INT 21H
    
    clear_screen PROC
        MOV AH, 06H   ; Scroll up function
        MOV AL, 0     ; Clear entire window
        MOV BH, 03H   ; Page background attribute (white on black)
        MOV CX, 0     ; Top-left corner of the screen (row 0, column 0)
        MOV DX, 184FH ; Bottom-right corner of the screen (row 24, column 79)
        INT 10H       ; BIOS video interrupt
    
        ; Set cursor position to top-left corner
        MOV AH, 02H   ; Set cursor position function
        MOV BH, 0     ; Page number
        MOV DH, 0     ; Row 0
        MOV DL, 0     ; Column 0
        INT 10H       ; BIOS video interrupt
        
                ; Printing the greeting message
            lea dx,greeting_message0
            mov ah,09h
            int 21h
            
            lea dx,new_line
            mov ah,09h
            int 21h    
            
            lea dx,greeting_message1
            mov ah,09h
            int 21h
            
            lea dx,new_line
            mov ah,09h
            int 21h
            
            lea dx,greeting_message2
            mov ah,09h
            int 21h
            
            lea dx,new_line
            mov ah,09h
            int 21h
            
            lea dx,greeting_message3
            mov ah,09h
            int 21h
            
            lea dx,new_line
            mov ah,09h
            int 21h                        
             
            lea dx,greeting_message4
            mov ah,09h
            int 21h
            
            lea dx,new_line
            mov ah,09h
            int 21h
              
            lea dx,greeting_message5
            mov ah,09h
            int 21h
            
            lea dx,new_line
            mov ah,09h
            int 21h 
            
            lea dx,greeting_message6
            mov ah,09h
            int 21h
            
            lea dx,new_line
            mov ah,09h
            int 21h
        RET
    clear_screen ENDP
    
    
    invalid_crypto_amount:
        ; Print "Invalid amount. Try again." 
        LEA DX, new_line
        MOV AH, 09H
        INT 21H
    
        lea dx, invalid_amount
        mov ah, 09h
        int 21h
    
        ; Retry input
        jmp validate_amount
    
    
    invalid_sell_amount:
        ; Print "Invalid amount. Try again." 
        LEA DX, new_line
        MOV AH, 09H
        INT 21H
        
        lea dx, invalid_amount
        mov ah, 09h
        int 21h
    
        ; Retry input
        jmp validate_sell_amount                    
        
    END