C -*- Mode:Fortran; Coding:us-ascii-unix; fill-column:72 -*-
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC.H.S.CC
C @file      symEig.f
C @author    Mitch Richling http://www.mitchr.me/
C @brief     Eigenvalues of a symmetric matrix via ssytrd & ssteqr. @EOL
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
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC.H.E.CC

C-----------------------------------------------------------------------
      program symEigF

      implicit none

      real a(4,4), d(4), e(3), t(3), ew(4)
      integer inf, tw(8), z

C     Externals from the blaio library
      external sgeprt
C     Externals from the LAPACK library
      external ssteqr, ssytrd

C     Initialize the matrix a
      data a/1.0, 2.0, 3.0, 4.0,
     *       2.0, 2.0, 6.0, 4.0,
     *       3.0, 6.0, 5.0, 6.0,
     *       4.0, 4.0, 6.0, 6.0/

C     Print out the matrix we start with
      call sgeprt(4, 4, a, 'a=')

C     Transform to symmetric tridiagonal form via similarity transforms
C                 uplo, n, a, lda, d, e, tau, work, lwork, info
      call ssytrd('U',  4, a, 4,   d, e, t,   tw,   4,     inf)

C     Figure out if the tridiagonal transform worked
      if (inf .eq. 0) then
         write (*,*) 'successful tridiagonal reduction'
      else if (inf .lt. 0) then
         write (*,*) 'Illegal value at: ', -inf
         stop
      else
         write (*,*) 'Illegal return code'
         stop
      end if

      call sgeprt(1, 4, d, 'd=')
      call sgeprt(1, 3, e, 'e=')

C     Compute the solution
      call ssteqr('N', 4, d, e, z, 1, ew, inf)

C     Figure out if we found the eigenvalues or not
      if (inf .eq. 0) then
         write (*,*) 'Successful solution'
      else if (inf .lt. 0) then
         write (*,*) 'Illegal value at: ', -inf
         stop
      else
         write (*,*) 'Illegal return code'
         stop
      end if

      write (*,*) 'The Eigenvalues:'
      call sgeprt(1, 4, d, 'd=')

      end
