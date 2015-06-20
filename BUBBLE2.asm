.data_                  ;
  string>sort="zyxwvutsrqponmlkjihgfedcbaZYXWVUTSRQPONMLKJIHGFBECDA9876543210"
  literal>len=003E
.exec_                  ;
.sub(PRINT):            ;
  POPG  CL              ;
CONT:                   ;
  CMP   [CL],000A       ; Is CL at EOL (end of string delimiter)?
  JZ    RETURN          ; If yes, exit subprogram
  OUT   [CL]            ; If no, output character at [CL] to stdout
  INC   CL              ;
  JMP   CONT            ;
RETURN:                 ;
  RET   0001            ;
.endsub:                ;
  MOV   BL,0000         ;
  MOV   CL,sort         ;
  MOV   DL,0000         ;
MAIN:                   ;
  MOV   AL,len          ;
  MOV   BL,[AL]         ;
  CMP   DL,BL           ;
  JZ    BYE             ; Exit if list is sorted
  CMP   [CL],000A       ; Is the display pointer at the end of the list?
  JZ    RESET           ; If yes, jump to reset label
  MOV   AL,[CL]         ; Move value at display pointer to AL
  INC   CL              ; Increment display pointer to get next value
  MOV   BL,[CL]         ; Move value at display pointer to BL
  CMP   BL,000A         ;
  JZ    RESET           ;
  CMP   AL,BL           ; Is AL greater than BL?
  JNS   SWAP            ; If yes, jump to swap label
CHECK:                  ;
  INC   DL              ; Increment swap counter
  JMP   MAIN            ; Jump back to main loop
SWAP:                   ;
  DEC   DL              ; Decrement swap counter
  PUSH  AL              ; Push value 1 to stack from AL
  PUSH  BL              ; Push value 2 to stack from BL
  POP   AL              ; Pop value 2 from stack to AL
  POP   BL              ; Pop value 1 from stack to BL
  DEC   CL              ; Decrement display pointer
  MOV   [CL],AL         ; Move AL to [CL]
  INC   CL              ; Increment display pointer
  MOV   [CL],BL         ; Move BL to [CL]
  JMP   MAIN            ; Jump back to main loop
RESET:                  ;
  MOV   CL,sort         ; Reset display pointer to C0
  JMP   MAIN            ; Jump back to main loop
BYE:                    ;
  MOV   CL,sort         ; Re-initialize display pointer
  PUSHG CL              ;
  CALL  PRINT           ;
  END                   ; End program
