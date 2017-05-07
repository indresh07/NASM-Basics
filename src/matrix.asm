%include "include/io.mac"

%macro printij 2

	PutStr obrac
	PutInt %1
	PutStr cbrac
	PutStr obrac
	PutInt %2
	PutStr cbrac
	PutStr colon

%endmacro

.DATA
	rowPrompt	db	"Enter the number of rows in the matrix (max. 10) : ", 0
	colPrompt	db	"Enter the number of columns in the matrix (max. 10): ", 0
	valPrompt	db	"Enter the elements ", 0

	colon	db 	": ",0
	obrac 	db 	"[",0
	cbrac 	db 	"]",0
	tab	  	db 	9, 0


	mat1Msg		db	"Matrix A: ", 0
	mat2Msg		db	"Matrix B: ", 0
	fMatMsg		db	"Matrix A + Matrix B: ", 0
  
.UDATA

	mat1 	resd 	100
	mat2 	resd 	100
	
	m 		resd 	1
	n 		resd 	1
	i 		resd 	1
	j 		resd 	1


.CODE

	.STARTUP

		.main:
			PutStr rowPrompt
			GetInt [m]

			cmp dword[m],10
			jnl done

			PutStr colPrompt
			GetInt [n]

			cmp dword[n],10
			jnl done
  
  			PutStr mat1Msg
  			nwln
  			mov ebx, mat1
  			call read_matrix
  			nwln

			PutStr mat2Msg
  			nwln
  			mov ebx, mat2
  			call read_matrix
  			nwln

  			mov ebx, mat1
  			PutStr mat1Msg
  			nwln
  			call display
  			nwln

  			mov ebx, mat2
  			PutStr mat2Msg
  			nwln
  			call display
  			nwln

  			call matrix_add

  			mov ebx, mat1
  			PutStr fMatMsg
  			nwln
  			call display
  			nwln

  		done:
  			.EXIT

  		read_matrix:

  			mov eax, 0

  			mov dword[i], 0
  
  			rl_mat:
    			mov dword[j], 0
    			cl_mat:
 
	 				printij [i], [j]

			 		GetInt dx
			 		mov [ebx + 2 * eax], dx
			 		
			 		inc eax
			     
			 		inc dword[j]
			 		mov cx, [j]
			 		cmp cx, [n]
			 		jl cl_mat
		 
    		inc dword[i]
    		mov cx, [i]
    		cmp cx, [m]
    		jl rl_mat

    		ret

    	matrix_add:

    		mov eax, 0
    		mov esi, mat1
    		mov edi, mat2

  			mov dword[i], 0
  
  			rl_fMat:
    			mov dword[j], 0
    			cl_fMat:
 
 				mov dx, [edi + 2 * eax]
		 		add  [esi + 2 * eax], dx
		 		
		 		inc eax

		 		inc dword[j]
		 		mov cx, [j]
		 		cmp cx, [n]
		 		jl cl_fMat
		 
    		inc dword[i]
    		mov cx, [i]
    		cmp cx, [m]
    		jl rl_fMat    

    		ret

    	display:

  			mov eax, 0

  			mov dword[i], 0
  
  			rl_pmat:
    			mov dword[j], 0
    			cl_pmat:

		 		PutInt [ebx + 2 * eax]
		 		
		 		inc eax
		     	
		     	PutStr tab

		 		inc dword[j]
		 		mov cx, [j]
		 		cmp cx, [n]
		 		jl cl_pmat

		 	nwln
		 
    		inc dword[i]
    		mov cx, [i]
    		cmp cx, [m]
    		jl rl_pmat

    		ret