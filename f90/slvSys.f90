! -*- Mode:F90; Coding:us-ascii-unix; fill-column:129 -*-
!.!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!.H.S.!!
!>
!! @file      slvSys.f90
!! @author    Mitch Richling http://www.mitchr.me/
!! @brief     Simple example illustrating DGESV from LAPACK.@EOL
!! @keywords  blas lapack netlib fortran linear system algebra
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
!!  Illustrates how to use DGESV from LAPACK to solve a system of equations.
!!
!.!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!.H.E.!!

!----------------------------------------------------------------------------------------------------------------------------------
program slvSys

  use blas_kinds,    only: dp
  use lapack_ifaces, only: dgesv
  use blaio,         only: sgeprt

  implicit none (type, external)

  real(kind=dp)        :: a(4,4), b(4)
  integer              :: inf 
  integer, allocatable :: pivs(:)

  allocate(pivs(size(a, 1)))

  ! Initialize the matrix a and the vector b
  a = reshape([  1.0_dp,  2.0_dp,  3.0_dp,  4.0_dp, &
       &         6.0_dp,  7.0_dp,  9.0_dp,  9.0_dp, &
       &        11.0_dp, 12.0_dp, 19.0_dp, 14.0_dp, &
       &        16.0_dp, 17.0_dp, 18.0_dp, 12.0_dp], shape(a))
  b = reshape([  1.0_dp,  3.0_dp,  5.0_dp,  6.0_dp], shape(b))

  ! Print out the matrix and vector we start with
  call sgeprt(a, 'a=')
  call sgeprt(b, 'b=')

  ! Compute the solution
  !          n  nrhs a  lda  ipiv  b  ldb, info)
  call dgesv(4, 1,   a, 4,   pivs, b, 4,   inf)

  ! Figure out if dgesv found a solution or not
  if (inf == 0) then
     write (*,*) 'Successful solution'
  else if (inf < 0) then
     write (*,*) 'Illegal value at: ', -inf
     stop
  else if (inf .gt. 0) then
     write (*,*) 'matrix was singular'
     stop
  else
     write (*,*) 'Illegal return code'
     stop
  end if

  ! Print out the answer
  call sgeprt(a, 'a=')
  call sgeprt(b, 'b=')
  write(*,*) 'pivs=', pivs

end program slvSys
