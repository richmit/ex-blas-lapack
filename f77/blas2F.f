C -*- Mode:Fortran; Coding:us-ascii-unix; fill-column:72 -*-
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C  @file      blas2F.f
C  @Author    Mitch Richling<https://www.mitchr.me/>
C  @Copyright Copyright 1996 by Mitch Richling.  All rights reserved.
C  @breif     Simple example illustrating level 2 BLAS.@EOL
C  @Keywords  blas linear algebra netlib
C  @Std       F77 MIL-STD-1753
C
C  This little program illustrates how to use the single precision sgemv
C  & sger routines.

CC----------------------------------------------------------------------
      
      program blas2F
 
      implicit none

C     Declare our variables
      real*4 a(4,5), x(5), y(4)

      external sgemv, sger
      external sgeprt

C     Initialize the matrix a and the vectors x and y.
C     Note the elements of a appear transposed in the initilization
C     because of column major storage in FORTRAN...
      data a/ 1,  6, 11, 16,
     *        2,  7, 12, 17,
     *        3,  8, 13, 18,
     *        4,  9, 14, 19,
     *        5, 10, 15, 20/
      data x/  2, 3, 4, 5, 6/

C     Print out the matrix and vector we start with
      call sgeprt(4, 5, a, 'a=');
      call sgeprt(1, 5, x, 'x=');

C                tfrm lenY lenX alpha a  lda X  incX beta Y, incY
      call sgemv('N', 4,   5,   1.0,  a, 4,  x, 1,   0.0, y, 1)
      write (*,*) 'After call to sgemv:'
      call sgeprt(1, 4, y, 'y<-1.0*a*xT+0.0*y=')

C               lenX lenY alpha  X  incX  Y, incY A  LDA
      call sger(4,   5,   1.0,   y, 1,    x, 1,   a, 4)
      call sgeprt(4, 5, a, 'a<-1.0*x.yT+a=')
      end
