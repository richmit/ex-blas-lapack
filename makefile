

all : 
	make -C c   all
	make -C f77 all
	make -C f90 all

clean : 
	make -C c   clean
	make -C f77 clean
	make -C f90 clean
	rm -rf *~ *.bak *.o *.obj *.exe *.EXE a.out *.OBJ *.O *.MOD *.mod

