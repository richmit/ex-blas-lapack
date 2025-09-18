! -*- Mode:F90; Coding:us-ascii-unix; fill-column:129 -*-
!.!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!.H.S.!!
!>
!! @file      symEig.f90
!! @author    Mitch Richling http://www.mitchr.me/
!! @brief     Simple example illustrating dgesv from lapack.@EOL
!! @keywords  
!! @std       F90 F95 F2003 F2008 F2018 F2023
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
!!  This little program illustrates the typical way to find the eigenvalues of a symmetric matrix with LAPACK.
!!
!.!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!.H.E.!!

!----------------------------------------------------------------------------------------------------------------------------------
program symEig

  use blas_kinds,    only: dp
  use lapack_ifaces, only: dsytrd, dsteqr
  use blaio,         only: sgeprt

  implicit none (type, external)

  integer, parameter :: n = 4
  real(kind=dp)  :: a(n,n), d(n), e(n-1), t(n-1), ew(n), tw(8), z(1,1)
  integer        :: inf

  ! Initialize the matrix a
  a = reshape([  1.0_dp, 2.0_dp, 3.0_dp, 4.0_dp, &
       &         2.0_dp, 2.0_dp, 6.0_dp, 4.0_dp, &
       &         3.0_dp, 6.0_dp, 5.0_dp, 6.0_dp, &
       &         4.0_dp, 4.0_dp, 6.0_dp, 6.0_dp], shape(a))

  ! Print out the matrix we start with
  call sgeprt(a, 'a=')

  ! Transform to symmetric tridiagonal form via similarity transforms
  !           uplo, n, a, lda, d, e, tau, work, lwork, info
  call dsytrd('U',  4, a, 4,   d, e, t,   tw,   4,     inf)

  ! Figure out if the tridiagonal transform worked
  if (inf == 0) then
     write (*,*) 'successful tridiagonal reduction'
  else if (inf < 0) then
     write (*,*) 'Illegal value at: ', -inf
     stop
  else
     write (*,*) 'Illegal return code'
     stop
  end if

  call sgeprt(d, 'd=')
  call sgeprt(e, 'e=')

  ! Compute the solution
  !           compz n  d  e  z  ldz work info
  call dsteqr('N',  4, d, e, z, 1,  ew,  inf)

  ! Figure out if we found the eigenvalues or not
  if (inf == 0) then
     write (*,*) 'Successful solution'
  else if (inf < 0) then
     write (*,*) 'Illegal value at: ', -inf
     stop
  else
     write (*,*) 'Illegal return code'
     stop
  end if

  write (*,*) 'The Eigenvalues:'
  call sgeprt(d, 'd=')

end program symEig
