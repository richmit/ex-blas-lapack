C -*- Mode:Fortran; Coding:us-ascii-unix; fill-column:72 -*-
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC.H.S.CC
C @file      triSlv.f
C @author    Mitch Richling http://www.mitchr.me/
C @brief     Solve a triangular system with STRSV. @EOL
C @keywords  blas lapack numerical linear algebra matrix vector netlib
C @std       F77 MIL-STD-1753
C @see       https://github.com/richmit/ex-blas-lapack/
C @copyright
C  @parblock
C  Copyright (c) 2006,2025, Mitchell Jay Richling All rights reserved.
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
C  BLAS supports upper and lower triangular systems, the matrix being
C  transposed, and the diagonal being unitary or not.  This program
C  illustrates the most common case when the matrix is upper triangular
C  and has non-units on the diagonal.
C
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC.H.E.CC

C-----------------------------------------------------------------------
      program triSlvF

      implicit none

      real m(5,5)
      real x(5)

      external strsv

      external sgeprt

      data m/3.0, 0.0, 0.0, 0.0, 0.0,
     *       5.0, 8.0, 0.0, 0.0, 0.0,
     *       7.0, 1.0, 5.0, 0.0, 0.0,
     *       9.0, 4.0, 9.0, 4.0, 0.0,
     *       1.0, 7.0, 3.0, 9.0, 5.0/

      data x/1, 2, 3, 4, 5/

      call sgeprt(5, 5, m, 'm=')
      call sgeprt(1, 5, x, 'x=')

      !          UPLO, TRANS, DIAG, N, A, LDA, X, INCX
      call strsv('U', 'N',    'N',  5, m, 5,   x, 1)

      call sgeprt(5, 5, m, 'm=')
      call sgeprt(1, 5, x, 'x=')

      end
