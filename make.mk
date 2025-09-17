##
# @file      makefile
# @author    Mitch Richling <https://www.mitchr.me/>
# @Copyright Copyright 1997,2014 by Mitch Richling.  All rights reserved.
# @brief     Simple make file to build the examples in this directory.@EOL
# @Keywords  
# @Std       GenericMake
#
#            
#            

.PHONY: all clean

# Put your compiler and basic compile options here
FC       = gfortran
CC       = gcc
FFLAGS   = -Wall
CFLAGS   = -Wall

# # LAPACK/BLAS compile/link options for generic linux:
# BL_LIB_PATH =
# BL_LIB_NAME = -lblas
# BL_INC_PATH = 
# LP_LIB_PATH =
# LP_LIB_NAME = -llapack
# LP_INC_PATH = 

# LAPACK/BLAS compile/link options for MSYS2 using OpenBLAS on MS Windows:
BL_LIB_PATH =
BL_LIB_NAME = -lopenblas
BL_INC_PATH = -I/mingw64/include/OpenBLAS
LP_LIB_PATH =
LP_LIB_NAME = -llapack
LP_INC_PATH = 

all : $(TARGETS)
	@echo Make Complete

clean :
	rm -rf *~ *.bak $(TARGETS) *.o *.obj *.exe *.EXE a.out *.OBJ *.O *.MOD *.mod
