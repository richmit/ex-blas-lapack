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

# Fortran + Blas
TARGBF = blas1F blas2F blas3F
# C + Blas
TARGBC = blas1C blas2C blas3C blas2bC
# Fortran + Lapack
TARGLF = slvSysF symEigF triSlvF 
# C + Lapack
TARGLC = slvSysC                 

# Put your compiler and basic compile options here
FC       = gfortran
CC       = gcc
FFLAGS   = -Wall
CFLAGS   = -Wall

# LAPACK/BLAS compile/link options for generic linux:
BL_LIB_PATH =
BL_LIB_NAME = -lblas
BL_INC_PATH = -I /mingw64/include/OpenBLAS
LP_LIB_PATH =
LP_LIB_NAME = -llapack
LP_INC_PATH = -I/usr/include/atlas

# LAPACK/BLAS compile/link options for OSX:
# APLKRZ  = -framework Accelerate 

# LAPACK/BLAS compile/link options for MSYS2 using OpenBLAS on MS Windows:
# BL_LIB_PATH =
# BL_LIB_NAME = -lopenblas
# BL_INC_PATH = -I /mingw64/include/OpenBLAS
# LP_LIB_PATH =
# LP_LIB_NAME = -llapack
# LP_INC_PATH = -I/usr/include/atlas

# You will need a Fortran compiler for the TARG*F targets.
#TARGETS = $(TARGBC) $(TARGBF) $(TARGLF) $(TARGLC) 
TARGETS = $(TARGBC) $(TARGBF) 

all : $(TARGETS)
	@echo Make Complete

blas1C : blas1C.c blaio.c blaio.h
	$(CC) $(CFLAGS) $(APLKRZ) ${BL_INC_PATH} blas1C.c blaio.c -lm $(BL_LIB_NAME) -o blas1C

blas1F : blas1F.f blaio.f
	$(FC) $(FFLAGS) blas1F.f blaio.f $(BL_LIB_NAME) -o blas1F

blas2bC : blas2bC.c blaio.c blaio.h 
	$(CC) $(CFLAGS) $(APLKRZ) ${BL_INC_PATH} blas2bC.c blaio.c -lm  $(BL_LIB_NAME) -o blas2bC

blas2C : blas2C.c blaio.c blaio.h 
	$(CC) $(CFLAGS) $(APLKRZ) ${BL_INC_PATH} blas2C.c blaio.c   -lm $(BL_LIB_NAME) -o blas2C

blas2F : blas2F.f blaio.f
	$(FC) $(FFLAGS) blas2F.f blaio.f $(BL_LIB_NAME) -o blas2F

blas3C : blas3C.c blaio.c blaio.h
	$(CC) $(CFLAGS) $(APLKRZ) ${BL_INC_PATH} blas3C.c blaio.c  -lm $(BL_LIB_NAME) -o blas3C

blas3F : blas3F.f blaio.f
	$(FC) $(FFLAGS) blas3F.f blaio.f $(BL_LIB_NAME) -o blas3F

slvSysC : slvSysC.c blaio.c blaio.h
	$(CC) $(CFLAGS) $(APLKRZ) ${BL_INC_PATH} $(LP_INC_PATH) slvSysC.c blaio.c  -lm $(LP_LIB_NAME) $(BL_LIB_NAME) -o slvSysC

slvSysF : slvSysF.f blaio.f
	$(FC) $(FFLAGS) slvSysF.f blaio.f $(LP_LIB_NAME) $(BL_LIB_NAME) -o slvSysF

symEigF : symEigF.f blaio.f
	$(FC) $(FFLAGS) symEigF.f blaio.f $(LP_LIB_NAME) $(BL_LIB_NAME) -o symEigF

triSlvF : triSlvF.f blaio.f
	$(FC) $(FFLAGS) triSlvF.f blaio.f $(LP_LIB_NAME) $(BL_LIB_NAME) -o triSlvF

clean :
	rm -rf a.out *~ *.bak $(TARGBF) $(TARGBC) $(TARGLF) $(TARGLC)
