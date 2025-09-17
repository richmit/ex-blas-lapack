C -*- Mode:Fortran; Coding:us-ascii-unix; fill-column:72 -*-
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C  @file      blas3F.f
C  @Author    Mitch Richling<https://www.mitchr.me/>
C  @Copyright Copyright 1996 by Mitch Richling.  All rights reserved.
C  @breif     Simple example illustrating level 3 BLAS.@EOL
C  @Keywords  blas linear algebra netlib
C  @Std       F77 MIL-STD-1753
C
C  This little program illustrates sgemm routine.
C             

CC----------------------------------------------------------------------

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
