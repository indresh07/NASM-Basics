#Error : Makefile:28: *** recipe commences before first target.  Stop.
#		 Makefile:33: *** recipe commences before first target.  Stop.
#		 Makefile:38: *** recipe commences before first target.  Stop.

objDir := obj
incDir := include
srcDir := src
lstDir := list
binDir := bin
files := matrix palindrome encryption
all:
	@make --no-print-directory lst
	@make --no-print-directory object
	@make --no-print-directory executable

executable: $(files:%=$(binDir)/%)

lst: $(files:%=$(lstDir)/%.lst)

object: $(files:%=$(objDir)/%.o)

$(objDir)/%.o : $(srcDir)/%.asm | $(objDir)
	@echo -n "Generating $(notdir $@)... "
	@nasm -f elf32 -o $@ $<
	@echo "Done"

$(lstDir)/%.lst: $(srcDir)/%.asm  | $(lstDir)
	@echo -n "Generating $(notdir $@)... "
	@nasm -f elf32 -g -F stabs -l $@ $<
	@echo "Done"
	@rm -f $(srcDir)/*.o

$(binDir)/% : $(objDir)/%.o  | $(binDir)
	@echo -n "Generating $(notdir $@)... "
	@ld -m elf_i386 -o $@ $< $(incDir)/io.o
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
	@rm -f $(lstDir)/*
	@rmdir $(binDir)
	@rmdir $(objDir)
	@rmdir $(lstDir)
	@echo "Done"