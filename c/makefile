# -*- Mode:make; Coding:us-ascii-unix; fill-column:158 -*-
#########################################################################################################################################################.H.S.##
##
# @file      makefile
# @author    Mitch Richling http://www.mitchr.me/
# @brief     Build C examples.@EOL
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
#########################################################################################################################################################.H.E.##

#---------------------------------------------------------------------------------------------------------------------------------------------------------------
#         Blas                     Lapack
TARGETS = blas1 blas2 blas3 blas2b slvSys

#---------------------------------------------------------------------------------------------------------------------------------------------------------------
include ../make.mk

#---------------------------------------------------------------------------------------------------------------------------------------------------------------
blas1 : blas1.c blaio.c blaio.h
	$(CC) $(CFLAGS) $(APLKRZ) ${BL_INC_PATH} blas1.c blaio.c  -lm $(BL_LIB_NAME) -o blas1

blas2b : blas2b.c blaio.c blaio.h
	$(CC) $(CFLAGS) $(APLKRZ) ${BL_INC_PATH} blas2b.c blaio.c -lm $(BL_LIB_NAME) -o blas2b

blas2 : blas2.c blaio.c blaio.h
	$(CC) $(CFLAGS) $(APLKRZ) ${BL_INC_PATH} blas2.c blaio.c  -lm $(BL_LIB_NAME) -o blas2

blas3 : blas3.c blaio.c blaio.h
	$(CC) $(CFLAGS) $(APLKRZ) ${BL_INC_PATH} blas3.c blaio.c  -lm $(BL_LIB_NAME) -o blas3

slvSys : slvSys.c blaio.c blaio.h
	$(CC) $(CFLAGS) ${BL_INC_PATH} $(LP_INC_PATH) slvSys.c blaio.c -lm $(LP_LIB_NAME) $(BL_LIB_NAME) -o slvSys
