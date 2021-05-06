C -*- Mode:Fortran; Coding:us-ascii-unix; fill-column:72 -*-
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C  @file      blaio.f
C  @Author    Mitch Richling<https://www.mitchr.me/>
C  @Copyright Copyright 1995 by Mitch Richling.  All rights reserved.
C  @breif     FORTRAN linear algebra matrix vector I/O blas.@EOL
C  @Keywords  blas linear algebra netlib i/o blaio
C  @Std       F77 MIL-STD-1753
C  @Notes     This set of routines are intended to provide simple
C             matrix/vector I/O useful for debugging and simple examples.
C             All of the example programs in this directory utilize this
C             set of functions to help make each example less cluttered
C             with I/O statements, and thus easier to understand.

CC----------------------------------------------------------------------
      subroutine sgeprt(m, n, a, c) 
        integer m, n
        real a(m,n)
        character*(*) c
        call sprtmx(m, n, a, 9, 3, '[', ']', '[', ']', c)
      end

CC----------------------------------------------------------------------
      subroutine sprtmx(m, n, a, wide, prec, ldel, 
     *                   rdel, lidel, ridel, tag)
      integer m, n, wide, prec
      real*4  a(m, n)
      character*(*) ldel, rdel, lidel, ridel, tag
C     Local vars      
      character fst*70
      integer i, j
C     Build format string
C     Start of format string
      fst = '(1x,a'
C     Width of label
      write (fst(index(fst, ' '):len(fst)), *) len(tag)
      call zapspc(fst);
C     ,a,a for the brackets 
      fst(index(fst, ' '):len(fst))=',a,a,';
      write (fst(index(fst, ' '):len(fst)), *) n, 'f', wide, '.', prec
      call zapspc(fst);
C     ,a,a for the last brackets, and the final paren
      fst(index(fst, ' '):len(fst))=',1x,a,a)';
C     Use format string and print out the matrix      
      do i=1,m
         if( (i .eq. 1) .and. (i .eq. m) ) then
            write (*, fst) tag,ldel,lidel, (a(i, j), j=1,n), ridel,rdel
         else if(i .eq. 1) then 
            write (*, fst) tag,ldel,lidel, (a(i, j), j=1,n), ridel,' '
         else if(i .eq. m) then
            write (*, fst) ' ',' ',lidel, (a(i, j), j=1,n),ridel,rdel
         else
            write (*, fst) ' ',' ',lidel, (a(i, j), j=1,n),ridel,' '
         endif
      enddo
      end

CC----------------------------------------------------------------------
      subroutine zapspc(instr)
      character*(*) instr
      integer       i, j
      j=1
      do i=1,len(instr)
         if( .not. (instr(i:i) .eq. ' ')) then
            instr(j:j)=instr(i:i)
            j=j+1
         endif
      enddo
      instr(j:len(instr)) = ' '
      end
     
