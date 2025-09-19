C -*- Mode:Fortran; Coding:us-ascii-unix; fill-column:72 -*-
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC.H.S.CC
C @file      slvSys.f
C @author    Mitch Richling http://www.mitchr.me/
C @brief     Solve a system of equations with DGESV. @EOL
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
C  Demonstrates the DGESV routine from LAPACK to solve a system of
C  equations.
C
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC.H.E.CC

C-----------------------------------------------------------------------
      program slvSysF

      implicit none

      double precision a(4,4), b(4)
      integer pivs(4), inf

C     Externals from the blaio library
      external dgeprt
C     Externals from the LAPACK library
      external dgesv

C     Initialize the matrix a and the vector b
      data a/ 1, 2, 3, 4,
     *        6, 7, 9, 9,
     *       11,12,19,14,
     *       16,17,18,12/
      data b/ 1, 3, 5, 6/

C     Print out the matrix and vector we start with
      call dgeprt(4, 4, a, 'a=')
      call dgeprt(1, 4, b, 'b=')

C     Compute the solution
      call dgesv(4, 1, a, 4, pivs, b, 4, inf)

C     Figure out if dgesv found a solution or not
      if (inf .eq. 0) then
         write (*,*) 'Successful solution'
      else if (inf .lt. 0) then
         write (*,*) 'Illegal value at: ', -inf
         stop
      else if (inf .gt. 0) then
         write (*,*) 'matrix was singular'
         stop
      else
         write (*,*) 'Illegal return code'
         stop
      end if

C     Print out the answer
      call dgeprt(4, 4, a, 'a=')
      call dgeprt(1, 4, b, 'b=')
      write(*,*) 'pivs=', pivs

      end
