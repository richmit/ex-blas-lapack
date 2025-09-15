C -*- Mode:Fortran; Coding:us-ascii-unix; fill-column:72 -*-
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C  @file      slvSysF.f
C  @Author    Mitch Richling<https://www.mitchr.me/>
C  @Copyright Copyright 1996 by Mitch Richling.  All rights reserved.
C  @breif     Simple example illustrating SGESV from LAPACK.@EOL
C  @Keywords  blas lapack netlib fortran linear system algebra
C  @Std       F77 MIL-STD-1753
C
C  This little program illustrates how to use the SGESV from LAPACK to
C  solve a system of equations.  This example is parallel to the C
C  version so that the two may be easily compared.
C             

CC----------------------------------------------------------------------

      program slvSysF
 
      implicit none

      real*4 a(4,4), b(4)
      integer pivs(4), inf 

C     Externals from the blaio library
      external sgeprt
C     Externals from the LAPACK library
      external sgesv

C     Initialize the matrix a and the vector b
      data a/ 1, 2, 3, 4,
     *        6, 7, 9, 9,
     *       11,12,19,14,
     *       16,17,18,12/
      data b/ 1, 3, 5, 6/

C     Print out the matrix and vector we start with
      call sgeprt(4, 4, a, 'a=')
      call sgeprt(1, 4, b, 'b=')

C     Compute the solution
      call sgesv(4, 1, a, 4, pivs, b, 4, inf)

C     Figure out if sgesv found a solution or not
      if (inf .eq. 0) then
         write (*,*) 'successful solution'
      else if (inf .lt. 0) then
         write (*,*) 'illegal value at: %d', -inf
         stop
      else if (inf .gt. 0) then
         write (*,*) 'matrix was singular'
         stop
      else
         write (*,*) 'unknown result (can''t happen!)'
         stop
      end if

C     Print out the answer
      call sgeprt(4, 4, a, 'a=')
      call sgeprt(1, 4, b, 'b=')
      write(*,*) 'pivs=', pivs

      end
