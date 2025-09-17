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

#        Blas                         Lapack
TARGETS = blas1C blas2C blas3C blas2bC slvSysC                 

include ../make.mk

blas1C : blas1C.c blaio.c blaio.h
	$(CC) $(CFLAGS) $(APLKRZ) ${BL_INC_PATH} blas1C.c blaio.c -lm $(BL_LIB_NAME) -o blas1C

blas2bC : blas2bC.c blaio.c blaio.h 
	$(CC) $(CFLAGS) $(APLKRZ) ${BL_INC_PATH} blas2bC.c blaio.c -lm  $(BL_LIB_NAME) -o blas2bC

blas2C : blas2C.c blaio.c blaio.h 
	$(CC) $(CFLAGS) $(APLKRZ) ${BL_INC_PATH} blas2C.c blaio.c   -lm $(BL_LIB_NAME) -o blas2C

blas3C : blas3C.c blaio.c blaio.h
	$(CC) $(CFLAGS) $(APLKRZ) ${BL_INC_PATH} blas3C.c blaio.c  -lm $(BL_LIB_NAME) -o blas3C

slvSysC : slvSysC.c blaio.c blaio.h
	$(CC) $(CFLAGS) $(APLKRZ) ${BL_INC_PATH} $(LP_INC_PATH) slvSysC.c blaio.c  -lm $(LP_LIB_NAME) $(BL_LIB_NAME) -o slvSysC
