C -*- Mode:Fortran; Coding:us-ascii-unix; fill-column:72 -*-
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C  @file      blas1F.f
C  @Author    Mitch Richling<https://www.mitchr.me/>
C  @Copyright Copyright 1996 by Mitch Richling.  All rights reserved.
C  @breif     Demonstrate Level 1 BLAS.@EOL
C  @Keywords  blas linear algebra netlib
C  @Std       F77 MIL-STD-1753
C
C  This little program illustrates how to use several of the single
C  precision BLAS routines: isamax, sswap, scopy, sscal, saxpy, snrm2,
C  sasum, & sdot.
C             

CC----------------------------------------------------------------------

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
