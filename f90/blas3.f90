! -*- Mode:F90; Coding:us-ascii-unix; fill-column:129 -*-
!.!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!.H.S.!!
!>
!! @file      blas3.f90
!! @author    Mitch Richling http://www.mitchr.me/
!! @brief     Demonstrate Level 3 BLAS. @EOL
!! @keywords  blas lapack numerical linear algebra matrix vector netlib
!! @std       F2023
!! @see       https://github.com/richmit/ex-blas-lapack/
!! @copyright
!!  @parblock
!!  Copyright (c) 2025, Mitchell Jay Richling <http://www.mitchr.me/> All rights reserved.
!!
!!  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following
!!  conditions are met:
!!
!!  1. Redistributions of source code must retain the above copyright notice, this list of conditions, and the following
!!     disclaimer.
!!
!!  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions, and the following
!!     disclaimer in the documentation and/or other materials provided with the distribution.
!!
!!  3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products
!!     derived from this software without specific prior written permission.
!!
!!  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
!!  INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
!!  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
!!  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
!!  USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
!!  LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
!!  OF THE POSSIBILITY OF SUCH DAMAGE.
!!  @endparblock
!! @filedetails
!!
!!  This little program illustrates sgemm routine with modern Fortran.
!!
!.!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!.H.E.!!

!----------------------------------------------------------------------------------------------------------------------------------
program blas3

  use blas_kinds,  only: dp
  use blas_ifaces, only: dgemm
  use blaio,       only: dgeprt

  implicit none (type, external)

  real(kind=dp) :: a(4,5), b(5,4), c(4,4), d(4,4), e(4,4)

  ! Initialize the arrays.  Note the elements of a appear transposed because of Fortran's column major storage.  In modern
  ! fortran we can use the ORDER argument to reshape to list the elements in row major order if we wish.
  a = reshape([ 1.0_dp,  6.0_dp, 11.0_dp, 16.0_dp, &
       &        2.0_dp,  7.0_dp, 12.0_dp, 17.0_dp, &
       &        3.0_dp,  8.0_dp, 13.0_dp, 18.0_dp, &
       &        4.0_dp,  9.0_dp, 14.0_dp, 19.0_dp, &
       &        5.0_dp, 10.0_dp, 15.0_dp, 20.0_dp], shape(a))
  b = reshape([ 1.0_dp,  0.0_dp,  0.0_dp,  0.0_dp, 0.0_dp, &
       &        0.0_dp,  0.0_dp,  1.0_dp,  0.0_dp, 0.0_dp, &
       &        0.0_dp,  1.0_dp,  0.0_dp,  0.0_dp, 0.0_dp, &
       &        0.0_dp,  0.0_dp,  0.0_dp,  1.0_dp, 0.0_dp], shape(b))
  d = reshape([ 1.0_dp,  6.0_dp, 11.0_dp, 16.0_dp, &
       &        2.0_dp,  7.0_dp, 12.0_dp, 17.0_dp, &
       &        3.0_dp,  8.0_dp, 13.0_dp, 18.0_dp, &
       &        4.0_dp,  9.0_dp, 14.0_dp, 19.0_dp], shape(d))
  e = reshape([ 1.0_dp,  0.0_dp,  0.0_dp,  0.0_dp, &
       &        0.0_dp,  0.0_dp,  1.0_dp,  0.0_dp, &
       &        0.0_dp,  1.0_dp,  0.0_dp,  0.0_dp, &
       &        0.0_dp,  0.0_dp,  0.0_dp,  1.0_dp], shape(e))

  call dgeprt(a, 'a= ')
  call dgeprt(b, 'b= ')
  !          tfm  tfm  rowA colB K  alpha   a  lda  b  ldb beta    c  ldc */
  call dgemm('N', 'N', 4,   4,   5, 1.0_dp, a, 4,   b, 5,  0.0_dp, c, 4)
  write (*,*) 'After call to dgemm:'
  call dgeprt(c, 'c <- 1.0*a*b+0.0*c = ')

  call dgeprt(d, 'd= ')
  call dgeprt(e, 'e= ')
  !          tfm  tfm  rowA colB K  alpha   a  lda  b  ldb beta    c  ldc */
  call dgemm('N', 'N', 4,   4,   4, 1.0_dp, d, 4,   e, 4,  0.0_dp, c, 4)
  call dgeprt(c, 'c <- 1.0*d*e+0.0*c = ')

end program blas3
