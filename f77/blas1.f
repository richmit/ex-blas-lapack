C -*- Mode:Fortran; Coding:us-ascii-unix; fill-column:72 -*-
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC.H.S.CC
C @file      blas1.f
C @author    Mitch Richling http://www.mitchr.me/
C @brief     Demonstrate Level 1 BLAS. @EOL
C @keywords  blas linear algebra netlib
C @std       F77 MIL-STD-1753
C @see       https://github.com/richmit/ex-blas-lapack/
C @copyright 
C  @parblock
C  Copyright (c) 1996,2025, Mitchell Jay Richling All rights reserved.
C  
C  Redistribution and use in source and binary forms, with or without
C  modification, are permitted provided that the following conditions
C  are met:
C  
C  1. Redistributions of source code must retain the above copyright
C     notice, this list of conditions, and the following disclaimer.
C  
C  2. Redistributions in binary form must reproduce the above
C     copyright notice, this list of conditions, and the following
C     disclaimer in the documentation and/or other materials provided
C     with the distribution.
C  
C  3. Neither the name of the copyright holder nor the names of its
C     contributors may be used to endorse or promote products derived
C     from this software without specific prior written permission.
C  
C  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
C  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
C  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
C  FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
C  COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
C  INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
C  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
C  SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
C  HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
C  STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
C  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
C  OF THE POSSIBILITY OF SUCH DAMAGE.
C  @endparblock
C @filedetails   
C
C  This program illustrates how to use several of the single precision
C  BLAS routines: isamax, sswap, scopy, sscal, saxpy, snrm2, sasum, &
C  sdot.
C
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC.H.E.CC


C-----------------------------------------------------------------------
      program blas1F
 
      implicit none

C     Declare our variables
      real*4 x(4), y(4), d(4)

      real*4   snrm2, sasum, sdot

      integer  isamax
      external isamax
      external sswap, scopy, sscal, saxpy
      external snrm2, sasum, sdot

      external sgeprt

C     Initialize the matrix a and the vector b
      data x/2, 3, 4, 5/
      data y/5, 4, 9, 2/

C     Print out the matrix and vector we start with
      call sgeprt(1, 4, x, '            x = ')
      call sgeprt(1, 4, y, '            y = ')

C                lenX X  incX Y  incY
      call sswap(4,   x, 1,   y, 1)

      write (*,*) 'After Swap..'
      call sgeprt(1, 4, x, '            x = ')
      call sgeprt(1, 4, y, '            y = ')

C                lenX X  incX Y  incY
      call scopy(4,   x, 1,   d, 1)
      write (*,*) 'After Copy (d=x)..'
      call sgeprt(1, 4, d, '       d <- x = ')

C                lenX alpha X  incX
      call sscal(4,   2.0,  y, 1)
      write (*,*) 'After Scale (2*y)..'
      call sgeprt(1, 4, y, '   y <- 2.0*y = ')

C                lenX alpha X  incX y  incY
      call saxpy(4,   3.0,  x, 1,   y, 1)
      write (*,*) 'After Add (y=3*x+y)..'
      call sgeprt(1, 4, y, ' y <- 3.0*x+y = ')

C                                          lenX X  incX
      write (*,*) '2-norm   of y=',  snrm2(4,   y, 1)
      write (*,*) 'sum-norm of y=',  sasum(4,   y, 1)

C                                                   lenX X  incX
      write (*,*) 'index of max-norm of y=', isamax(4,   y, 1)

C                                  lenX X  incX Y  incY
      write (*,*) 'y dot y=', sdot(4,   y, 1,   y, 1)

      end
