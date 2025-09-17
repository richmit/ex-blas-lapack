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

#         Blas                 Lapack
TARGETS = blas1F blas2F blas3F slvSysF symEigF triSlvF 

include ../make.mk

blas1F : blas1F.f blaio.f
	$(FC) $(FFLAGS) blas1F.f blaio.f $(BL_LIB_NAME) -o blas1F

blas2F : blas2F.f blaio.f
	$(FC) $(FFLAGS) blas2F.f blaio.f $(BL_LIB_NAME) -o blas2F

blas3F : blas3F.f blaio.f
	$(FC) $(FFLAGS) blas3F.f blaio.f $(BL_LIB_NAME) -o blas3F

slvSysF : slvSysF.f blaio.f
	$(FC) $(FFLAGS) slvSysF.f blaio.f $(LP_LIB_NAME) $(BL_LIB_NAME) -o slvSysF

symEigF : symEigF.f blaio.f
	$(FC) $(FFLAGS) symEigF.f blaio.f $(LP_LIB_NAME) $(BL_LIB_NAME) -o symEigF

triSlvF : triSlvF.f blaio.f
	$(FC) $(FFLAGS) triSlvF.f blaio.f $(LP_LIB_NAME) $(BL_LIB_NAME) -o triSlvF
