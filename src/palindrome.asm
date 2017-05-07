%include "include/io.mac"

.DATA
	
	inputMsg db "Enter a string : ", 0
	pOutputMsg db "String is a palindrome.", 0
	nOutputMsg db "String is not a plaindrome.", 0

.UDATA
	
	inputStr resw 1

.CODE
	.STARTUP

	PutStr inputMsg
	GetStr inputStr

	mov eax, -1

	calLength:

		inc eax

		cmp byte [inputStr + eax], 0x00
		jne calLength

	mov ebx, -1

	checkPalindrome:

		inc ebx
		dec eax
		
		mov dl, byte [inputStr + eax]
		cmp dl, byte [inputStr + ebx]
		jne negative

		cmp eax, 0
		jne checkPalindrome

	PutStr pOutputMsg
	nwln
	jmp done

	negative:

		PutStr nOutputMsg
		nwln

	done:

		.EXIT

