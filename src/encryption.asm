%include "include/io.mac"

.DATA
      inputMsg  db   "Enter string : ",0
      exitPrompt  db   "Exit(y/n) : ",0
      outputMsg  db   "Encrypted string :",0

.UDATA 
      inputStr   resw   1
      exit  resb  1


.CODE
      .STARTUP
      mov byte[exit],'n'
      
      main:
            PutStr  inputMsg
            GetStr inputStr     

            mov eax,-1

            calLength:
            
                  inc eax

                  cmp byte [inputStr + eax],0x00
                  jne  calLength 

            encryption:
                  dec eax

                  check0:
                        cmp byte [inputStr + eax],'0'
                        jne check1
                        je encrypt0

                  encrypt0:
                        mov byte [inputStr + eax],'4'
                        jmp EOS

                  check1:
                        cmp byte [inputStr + eax],'1'
                        jne check2
                        je encrypt1

                  encrypt1:
                        mov byte [inputStr + eax],'6'
                        jmp EOS

                  check2:
                        cmp byte [inputStr + eax],'2'
                        jne check3
                        je encrypt2

                  encrypt2:
                        mov byte [inputStr + eax],'9'
                        jmp EOS

                  check3:
                        cmp byte [inputStr + eax],'3'
                        jne check4
                        je encrypt3

                  encrypt3:
                        mov byte [inputStr + eax],'5'
                        jmp EOS

                  check4:
                        cmp byte [inputStr + eax],'4'
                        jne check5
                        je encrypt4

                  encrypt4:
                        mov byte [inputStr + eax],'0'
                        jmp EOS

                  check5:
                        cmp byte [inputStr + eax],'5'
                        jne check6
                        je encrypt5

                  encrypt5:
                        mov byte [inputStr + eax],'3'
                        jmp EOS

                  check6:
                        cmp byte [inputStr + eax],'6'
                        jne check7
                        je encrypt6

                  encrypt6:
                        mov byte [inputStr + eax],'1'
                        jmp EOS      

                  check7:
                        cmp byte [inputStr + eax],'7'
                        jne check8
                        je encrypt7

                  encrypt7:
                        mov byte [inputStr + eax],'8'
                        jmp EOS

                  check8:
                        cmp byte [inputStr + eax],'8'
                        jne check9
                        je encrypt8

                  encrypt8:
                        mov byte [inputStr + eax],'7'
                        jmp EOS

                  check9:
                        cmp byte [inputStr + eax],'9'
                        jne EOS
                        je encrypt9

                  encrypt9:
                        mov byte [inputStr + eax],'2'
                        jmp EOS

                  EOS:
                        cmp eax, 0
                        jne encryption

            PutStr outputMsg
            PutStr inputStr
            nwln
                  
            PutStr exitPrompt
            GetCh [exit]
            
            cmp byte [exit],'y'
            jne exit2
            je done

            exit2:
            cmp byte [exit],'Y'
            jne main
            je done
       
      nwln

done:
      .EXIT






