# -*- Mode:make; Coding:us-ascii-unix; fill-column:158 -*-
#########################################################################################################################################################.H.S.##
##
# @file      makefile
# @author    Mitch Richling http://www.mitchr.me/
# @brief     Build fortran 77 examples.@EOL
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
#         Blas              Lapack
TARGETS = blas1 blas2 blas3 slvSys symEig triSlv

#---------------------------------------------------------------------------------------------------------------------------------------------------------------
include ../make.mk

#---------------------------------------------------------------------------------------------------------------------------------------------------------------
blas1 : blas1.f blaio.f
	$(FC) $(FFLAGS) blas1.f blaio.f $(BL_LIB_NAME) -o blas1

blas2 : blas2.f blaio.f
	$(FC) $(FFLAGS) blas2.f blaio.f $(BL_LIB_NAME) -o blas2

blas3 : blas3.f blaio.f
	$(FC) $(FFLAGS) blas3.f blaio.f $(BL_LIB_NAME) -o blas3

slvSys : slvSys.f blaio.f
	$(FC) $(FFLAGS) slvSys.f blaio.f $(LP_LIB_NAME) $(BL_LIB_NAME) -o slvSys

symEig : symEig.f blaio.f
	$(FC) $(FFLAGS) symEig.f blaio.f $(LP_LIB_NAME) $(BL_LIB_NAME) -o symEig

triSlv : triSlv.f blaio.f
	$(FC) $(FFLAGS) triSlv.f blaio.f $(LP_LIB_NAME) $(BL_LIB_NAME) -o triSlv
