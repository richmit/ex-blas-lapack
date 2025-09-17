C -*- Mode:Fortran; Coding:us-ascii-unix; fill-column:72 -*-
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC.H.S.CC
C @file      blaio.f
C @author    Mitch Richling http://www.mitchr.me/
c @brief     fortran 77 linear algebra matrix vector i/o blas.@EOL
C @keywords  blas linear algebra netlib i/o blaio
C @std       F77 MIL-STD-1753
C @see       https://github.com/richmit/ex-blas-lapack/
C @copyright
C  @parblock
C  Copyright (c) 1995,2025, Mitchell Jay Richling All rights reserved.
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
C  This set of routines are intended to provide simple matrix/vector I/O
C  useful for debugging and simple examples.  All of the example
C  programs in this directory utilize this set of functions to help make
C  each example less cluttered with I/O statements, and thus easier to
C  understand.
C
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC.H.E.CC

C-----------------------------------------------------------------------
      subroutine sgeprt(m, n, a, c)
        integer m, n
        real a(m,n)
        character*(*) c
        call sprtmx(m, n, a, 9, 3, '[', ']', '[', ']', c)
      end

C-----------------------------------------------------------------------
      subroutine sprtmx(m, n, a, wide, prec, ldel,
     *                  rdel, lidel, ridel, tag)
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

C-----------------------------------------------------------------------
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
