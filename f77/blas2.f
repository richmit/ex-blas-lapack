C -*- Mode:Fortran; Coding:us-ascii-unix; fill-column:72 -*-
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC.H.S.CC
C @file      blas2.f
C @author    Mitch Richling http://www.mitchr.me/
C @brief     Demonstrate Level 2 BLAS. @EOL
C @keywords  blas lapack numerical linear algebra matrix vector netlib
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
C  Demonstrates the DGEMV & DGER routines.
C
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC.H.E.CC

C-----------------------------------------------------------------------
      program blas2F

      implicit none

C     Declare our variables
      double precision a(4,5), x(5), y(4)

      external dgemv, dger
      external dgeprt

C     Initialize the matrix a and the vectors x and y.  Note the
C     elements of a appear transposed in the initilization because of
C     column major storage in FORTRAN.  Also note the use of "d" to
C     explicitly use double precision for the constants.
      data a/ 1.0d0,  6.0d0, 11.0d0, 16.0d0,
     *        2.0d0,  7.0d0, 12.0d0, 17.0d0,
     *        3.0d0,  8.0d0, 13.0d0, 18.0d0,
     *        4.0d0,  9.0d0, 14.0d0, 19.0d0,
     *        5.0d0, 10.0d0, 15.0d0, 20.0d0/
      data x/ 2.0d0,  3.0d0,  4.0d0,  5.0d0, 6.0d0/

C     Print out the matrix and vector we start with
      call dgeprt(4, 5, a, 'a=');
      call dgeprt(1, 5, x, 'x=');

C                tfrm lenY lenX alpha  a  lda X  incX beta   Y, incY
      call dgemv('N', 4,   5,   1.0d0, a, 4,  x, 1,   0.0d0, y, 1)
      write (*,*) 'After call to dgemv:'
      call dgeprt(1, 4, y, 'y<-1.0*a*xT+0.0*y=')

C               lenX lenY alpha    X  incX  Y, incY A  LDA
      call dger(4,   5,   1.0d0,   y, 1,    x, 1,   a, 4)
      call dgeprt(4, 5, a, 'a<-1.0*x.yT+a=')
      end
