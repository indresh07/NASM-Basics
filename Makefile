objDir := obj
incDir := include
srcDir := src
binDir := bin
files := matrix palindrome encryption

define generateObject
def:
	@nasm -f elf32 -o $(objDir)/$(1).o $(srcDir)/$(1).asm
endef

define generateLst
	@nasm -f elf32 -g -F stabs -o $(objDir)/$(1).o $(srcDir)/$(1).asm  -l list/$(1).lst
endef

define generateExecutable 
	@ld  -m  elf_i386 -o $(binDir)/$(1)   $(objDir)/$(1).o   $(incDir)/io.o
endef

all:
	@make --no-print-directory lst
	@make --no-print-directory executable

executable: $(addprefix $(objDir)/,$(addsuffix .o,$(files)))
	@echo -n "Generating executable files... " 	
	$(foreach file,$(files),$(eval $(call generateExecutable,$(file))))
	@echo "Done"

lst: $(addprefix $(srcDir)/,$(addsuffix .asm,$(files))) 
	@echo -n "Generating object and lst files... "
	$(foreach file,$(files),$(eval $(call generateLst,$(file))))
	@echo "Done"

object: $(addprefix $(srcDir)/,$(addsuffix .asm,$(files)))
	@echo -n "Generating object files... "
	$(foreach file,$(files),$(eval $(call generateObject,$(file))))
	@echo "Done"

clean:
	@echo -n "Deleting files... "
	@rm -f $(binDir)/*
	@rm -f $(objDir)/*
	@rm -f list/*
	@echo "Done"