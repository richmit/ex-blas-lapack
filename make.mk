# -*- Mode:make; Coding:us-ascii-unix; fill-column:158 -*-
#########################################################################################################################################################.H.S.##
##
# @file      make.mk
# @author    Mitch Richling http://www.mitchr.me/
# @brief     Setup variables for the development envionrment.@EOL
# @std       GNUmake
# @see       https://github.com/richmit/ex-blas-lapack/
# @copyright
#  @parblock
#  Copyright (c) 1997,2014,2025, Mitchell Jay Richling <http://www.mitchr.me/> All rights reserved.
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
# @filedetails
#
#  THis is a GNUmake include file used to define standard targets and set variables for the development enviornment.
#
#########################################################################################################################################################.H.E.##

#---------------------------------------------------------------------------------------------------------------------------------------------------------------
.PHONY: all clean

#---------------------------------------------------------------------------------------------------------------------------------------------------------------
# Put your compiler and basic compile options here

FC       = gfortran
CC       = gcc
FFLAGS   = -Wall
CFLAGS   = -Wall

#---------------------------------------------------------------------------------------------------------------------------------------------------------------
# Configure variables for libraries and include paths here.

# # LAPACK/BLAS compile/link options for generic linux:
# BL_LIB_PATH =
# BL_LIB_NAME = -lblas
# BL_INC_PATH =
# LP_LIB_PATH =
# LP_LIB_NAME = -llapack -llapacke
# LP_INC_PATH =

# LAPACK/BLAS compile/link options for ucrt64 using the mingw64 version of OpenBLAS on MS Windows:
BL_LIB_PATH =
BL_LIB_NAME = -lopenblas
BL_INC_PATH = -I/ucrt64/include/OpenBLAS
LP_LIB_PATH =
LP_LIB_NAME = -llapack -llapacke
LP_INC_PATH =

#---------------------------------------------------------------------------------------------------------------------------------------------------------------
# These are standard targets each make file supports.

all : $(TARGETS)
	@echo Make Complete

clean :
	rm -rf *~ *.bak $(TARGETS) *.o *.obj *.exe *.EXE a.out *.OBJ *.O *.MOD *.mod
