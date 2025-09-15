C -*- Mode:Fortran; Coding:us-ascii-unix; fill-column:72 -*-
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C  @file      triSlvF.f
C  @Author    Mitch Richling<https://www.mitchr.me/>
C  @Copyright Copyright 2006 by Mitch Richling.  All rights reserved.
C  @breif     Simple example illustrating strsv from BLAS.@EOL
C  @Keywords  blas lapack netlib fortran linear system algebra
C  @Std       F77 MIL-STD-1753
C
C  How to solve a triangular system.  BLAS supports upper and lower
C  triangular systems, the matrix being transposed, and the diagonal
C  being unitary or not.  This program illustrates the most common case
C  when the matrix is upper triangular and has non-units on the
C  diagonal.

CC----------------------------------------------------------------------

      program triSlvF

      implicit none

      real m(5,5)
      real x(5)

      external strsv

      external sgeprt

      data m/3, 0, 0, 0, 0,
     *       5, 8, 0, 0, 0,
     *       7, 1, 5, 0, 0,
     *       9, 4, 9, 4, 0,
     *       1, 7, 3, 9, 5/

      data x/1, 2, 3, 4, 5/

      call sgeprt(5, 5, m, 'm=')
      call sgeprt(1, 5, x, 'x=')

      !          UPLO, TRANS, DIAG, N, A, LDA, X, INCX )
      call strsv('U', 'N',    'N',  5, m, 5,   x, 1 )

      call sgeprt(5, 5, m, 'm=')
      call sgeprt(1, 5, x, 'x=')

      end
