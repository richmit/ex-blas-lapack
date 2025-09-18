! -*- Mode:F90; Coding:us-ascii-unix; fill-column:129 -*-
!.!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!.H.S.!!
!>
!! @file      blas1.f90
!! @author    Mitch Richling http://www.mitchr.me/
!! @brief     Demonstrate Level 1 BLAS. @EOL
!! @keywords  blas cblas c fortran numerical linear algebra vector matrix
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
!!  This program illustrates how to make use of several level 1 blas functions found in the cblas (ATLAS).  Functions
!!  illustrated:
!!
!!      - dswap           
!!      - dcopy
!!      - daxpy
!!      - ddotu
!!      - ddot
!!      - dnrm2
!!      - dasum     
!!      - dscal
!!      - ddotc
!!      - idmax
!!
!.!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!.H.E.!!

!----------------------------------------------------------------------------------------------------------------------------------
program blas1

  use blas_kinds,  only: dp
  use blas_ifaces, only: idamax, dswap, dcopy, dscal, daxpy, dnrm2, dasum, ddot
  use blaio,       only: sgeprt

  implicit none (type, external)

  real(kind=dp) :: x(4), y(4), d(4)

  ! Initialize the vectors
  x = reshape([ 2.0_dp, 3.0_dp, 4.0_dp, 5.0_dp ], shape(x))
  y = reshape([ 5.0_dp, 4.0_dp, 9.0_dp, 2.0_dp ], shape(y))

  ! Print out the matrix and vector we start with
  call sgeprt(x, '            x = ')
  call sgeprt(y, '            y = ')

  !          lenX X  incX Y  incY
  call dswap(4,   x, 1,   y, 1)

  write (*,*) 'After Swap..'
  call sgeprt(x, '            x = ')
  call sgeprt(y, '            y = ')

  !          lenX X  incX Y  incY
  call dcopy(4,   x, 1,   d, 1)
  write (*,*) 'After Copy (d=x)..'
  call sgeprt(d, '       d <- x = ')

  !          lenX alpha    X  incX
  call dscal(4,   2.0_dp,  y, 1)
  write (*,*) 'After Scale (2*y)..'
  call sgeprt(y, '   y <- 2.0*y = ')

  !          lenX alpha    X  incX y  incY
  call daxpy(4,   3.0_dp,  x, 1,   y, 1)
  write (*,*) 'After Add (y=3*x+y)..'
  call sgeprt(y, ' y <- 3.0*x+y = ')

  !                                    lenX X  incX
  write (*,*) '2-norm   of y=',  dnrm2(4,   y, 1)
  write (*,*) 'sum-norm of y=',  dasum(4,   y, 1)

  !                                             lenX X  incX
  write (*,*) 'index of max-norm of y=', idamax(4,   y, 1)

  !                            lenX X  incX Y  incY
  write (*,*) 'y dot y=', ddot(4,   y, 1,   y, 1)

end program blas1
