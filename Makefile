#Error : Makefile:28: *** recipe commences before first target.  Stop.
#		 Makefile:33: *** recipe commences before first target.  Stop.
#		 Makefile:38: *** recipe commences before first target.  Stop.

objDir := obj
incDir := include
srcDir := src
lstDir := list
binDir := bin
files := matrix palindrome encryption

define generateObject
	nasm -f elf32 -o $(objDir)/$1.o $(srcDir)/$1.asm
endef

define generateLst
	nasm -f elf32 -g -F stabs -o $(objDir)/$(1).o $(srcDir)/$(1).asm -l $(lstDir)/$(1).lst
endef

define generateExecutable
	ld -m elf_i386 -o $(binDir)/$(1) $(objDir)/$(1).o $(incDir)/io.o
endef

all:
	@make --no-print-directory lst
	@make --no-print-directory executable

executable: $(addprefix $(objDir)/,$(addsuffix .o,$(files))) | $(binDir)
	@echo -n "Generating executable files... "
	@$(foreach file,$(files),$(call generateExecutable,$(file)) && ) true
	@echo "Done"

lst: $(addprefix $(srcDir)/,$(addsuffix .asm,$(files))) | $(objDir) $(lstDir)
	@echo -n "Generating object and lst files... "
	@$(foreach file,$(files),$(call generateLst,$(file)) && ) true
	@echo "Done"

object: $(addprefix $(srcDir)/,$(addsuffix .asm,$(files))) | $(objDir)
	@echo -n "Generating object files... "
	@$(foreach file,$(files),$(call generateObject,$(file)) && ) true
	@echo "Done"

$(objDir):
	@mkdir $(objDir)

$(lstDir):
	@mkdir $(lstDir)

$(binDir):
	@mkdir $(binDir)

clean:
	@echo -n "Deleting files... "
	@rm -f $(binDir)/*
	@rm -f $(objDir)/*
	@rm -f list/*
	@echo "Done"