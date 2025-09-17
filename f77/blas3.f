C -*- Mode:Fortran; Coding:us-ascii-unix; fill-column:72 -*-
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC.H.S.CC
C @file      blas3.f
C @author    Mitch Richling http://www.mitchr.me/
C @brief     Simple example illustrating level 3 BLAS.@EOL
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
C  This little program illustrates sgemm routine.
C
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC.H.E.CC

C-----------------------------------------------------------------------
      program blas3F
 
      implicit none

      real*4 a(4,5), b(5,4), c(4,4), d(4,4), e(4,4)

C     Externals from the BLAS library
      external sgemm
C     Externals from the blaio library
      external sgeprt

C     Initialize things.
C     Note the elements of a appear transposed in the initilization
C     because of column major storage in FORTRAN...
      data a/ 1,  6, 11, 16,
     *        2,  7, 12, 17,
     *        3,  8, 13, 18,
     *        4,  9, 14, 19,
     *        5, 10, 15, 20/
      data b/1,0,0,0,0,
     *       0,0,1,0,0,
     *       0,1,0,0,0,
     *       0,0,0,1,0/
      data d/ 1,6,11,16,
     *        2,7,12,17,
     *        3,8,13,18,
     *        4,9,14,19/
      data e/1,0,0,0,
     *       0,0,1,0,
     *       0,1,0,0,
     *       0,0,0,1/

      call sgeprt(4, 5, a, 'a= ')
      call sgeprt(5, 4, b, 'b= ')
C                tfm  tfm  rowA colB K  alpha a lda  b  ldb beta c  ldc */
      call sgemm('N', 'N', 4,   4,   5, 1.0,  a,  4, b, 5,  0.0, c, 4)
      write (*,*) 'After call to sgemm:'
      call sgeprt(4, 4, c, 'c <- 1.0*a*b+0.0*c = ')


      call sgeprt(4, 4, d, 'd= ')
      call sgeprt(4, 4, e, 'e= ')
C                tfm  tfm  rowA colB K  alpha a  lda  b  ldb beta c  ldc */
      call sgemm('N', 'N', 4,   4,   4, 1.0,  d,   4, e, 4,  0.0, c, 4)
      call sgeprt(4, 4, c, 'c <- 1.0*d*e+0.0*c = ')

      end
