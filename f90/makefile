# -*- Mode:make; Coding:us-ascii-unix; fill-column:158 -*-
#########################################################################################################################################################.H.S.##
##
# @file      makefile
# @author    Mitch Richling http://www.mitchr.me/
# @date      2025-09-17
# @version   VERSION
# @brief     @EOL
# @keywords  
# @std       GNUmake BSDmake SYSVmake GenericMake
# @see       https://github.com/richmit/ex-blas-lapack/
# @copyright 
#  @parblock
#  Copyright (c) 2025, Mitchell Jay Richling <http://www.mitchr.me/> All rights reserved.
#  
#  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
#  
#  1. Redistributions of source code must retain the above copyright notice, this list of conditions, and the following disclaimer.
#  
#  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions, and the following disclaimer in the documentation
#     and/or other materials provided with the distribution.
#  
#  3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software
#     without specific prior written permission.
#  
#  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
#  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
#  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
#  OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
#  LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
#  DAMAGE.
#  @endparblock
# @todo      @EOL@EOL
# @warning   @EOL@EOL
# @bug       @EOL@EOL
# @filedetails
#
#  File details go here.  Multiple paragraphs are fine....
#
#########################################################################################################################################################.H.E.##

################################################################################################################################################################
#***************************************************************************************************************************************************************
#===============================================================================================================================================================
#---------------------------------------------------------------------------------------------------------------------------------------------------------------

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

TARGETS = blas1 blas2 blas3 slvSys symEig triSlv genEig

include ../make.mk

blas_kinds.mod blas_kinds.o &: blas_kinds.f90 
	$(FC) $(FFLAGS) -c blas_kinds.f90 

blas_ifaces.mod blas_ifaces.o &: blas_ifaces.f90 blas_kinds.mod blas_kinds.o
	$(FC) $(FFLAGS) -c blas_ifaces.f90 

lapack_ifaces.mod lapack_ifaces.o &: lapack_ifaces.f90 blas_kinds.mod blas_kinds.o
	$(FC) $(FFLAGS) -c lapack_ifaces.f90 

blaio.mod blaio.o &: blaio.f90 blas_kinds.mod blas_kinds.o
	$(FC) $(FFLAGS) -c blaio.f90 

blas1 : blas1.f90 blaio.o blas_ifaces.o blas_kinds.o
	$(FC) $(FFLAGS) blas1.f90 blaio.f90 $(BL_LIB_NAME) -o blas1

blas2 : blas2.f90 blaio.o blas_ifaces.o blas_kinds.o
	$(FC) $(FFLAGS) blas2.f90 blaio.f90 $(BL_LIB_NAME) -o blas2

blas3 : blas3.f90 blaio.o blas_ifaces.o blas_kinds.o
	$(FC) $(FFLAGS) blas3.f90 blaio.f90 $(BL_LIB_NAME) -o blas3

slvSys : slvSys.f90 blaio.o lapack_ifaces.o blas_ifaces.o blas_kinds.o
	$(FC) $(FFLAGS) slvSys.f90 blaio.f90 $(LP_LIB_NAME) $(BL_LIB_NAME) -o slvSys

symEig : symEig.f90 blaio.o lapack_ifaces.o blas_ifaces.o blas_kinds.o
	$(FC) $(FFLAGS) symEig.f90 blaio.f90 $(LP_LIB_NAME) $(BL_LIB_NAME) -o symEig

triSlv : triSlv.f90 blaio.o lapack_ifaces.o blas_ifaces.o blas_kinds.o
	$(FC) $(FFLAGS) triSlv.f90 blaio.f90 $(LP_LIB_NAME) $(BL_LIB_NAME) -o triSlv

genEig : genEig.f90 blaio.o lapack_ifaces.o blas_ifaces.o blas_kinds.o
	$(FC) $(FFLAGS) genEig.f90 blaio.f90 $(LP_LIB_NAME) $(BL_LIB_NAME) -o genEig
