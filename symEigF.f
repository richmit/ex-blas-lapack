C -*- Mode:Fortran; Coding:us-ascii-unix; fill-column:72 -*-
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C  @file      ssteqrF.f
C  @Author    Mitch Richling<https://www.mitchr.me/>
C  @Copyright Copyright 1996 by Mitch Richling.  All rights reserved.
C  @breif     Simple example illustrating sgesv from lapack.@EOL
C  @Keywords  blas linear algebra netlib
C  @Std       F77 MIL-STD-1753
C
C  This little program illustrates the typical way to find the
C  eigenvalues of a symmetric matrix with LAPACK.

CC----------------------------------------------------------------------

      program symeg
 
      implicit none

      real*4 a(4,4), d(4), e(3), t(3), ew(4)
      integer inf, tw(8), z

C     Externals from the blaio library
      external sgeprt
C     Externals from the LAPACK library
      external ssteqr, ssytrd

C     Initialize the matrix a
      data a/1, 2, 3, 4, 
     *       2, 2, 6, 4, 
     *       3, 6, 5, 6, 
     *       4, 4, 6, 6/

C     Print out the matrix we start with
      call sgeprt(4, 5, a, 'a=')

      call ssytrd('U', 4, a, 4, d, e, t, tw, 4, inf)

C     Figure out if the tridiagonal transform worked
      if (inf .eq. 0) then
         write (*,*) 'successful tridiagonal reduction'
      else if (inf .lt. 0) then
         write (*,*) 'illegal value at: %d', -inf
         stop
      else
         write (*,*) 'unknown result (can''t happen!)'
         stop
      end if

      call sgeprt(1, 4, d, 'd=')
      call sgeprt(1, 5, e, 'e=')

C     Compute the solution
      call ssteqr('N', 4, d, e, z, 1, ew, inf)

C     Figure out if we found the eigenvalues or not
      if (inf .eq. 0) then
         write (*,*) 'successful solution'
      else if (inf .lt. 0) then
         write (*,*) 'illegal value at: %d', -inf
         stop
      else
         write (*,*) 'unknown result (can''t happen!)'
         stop
      end if

      write (*,*) 'The Eigenvalues:'
      call sgeprt(1, 4, d, 'd=')

      end
