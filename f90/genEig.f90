! -*- Mode:F90; Coding:us-ascii-unix; fill-column:129 -*-
!.!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!.H.S.!!
!>
!! @file      genEig.f90
!! @author    Mitch Richling http://www.mitchr.me/
!! @brief     Eigenvalues via dsytrd & dgeev. @EOL
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
!.!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!.H.E.!!

!----------------------------------------------------------------------------------------------------------------------------------
program genEig

  use blas_kinds,    only: dp
  use lapack_ifaces, only: dgeev
  use blaio,         only: dgeprt
implicit none (type, external)

  integer, parameter :: n = 4
  real(kind=dp) :: a(n,n)
  real(kind=dp) :: wr(n), wi(n) ! real and imaginary parts of eigenvalues
  real(kind=dp) :: vl(n,n), vr(n,n)! eigenvectors: left (vl) and right (vr)
  integer       :: inf, lwork
  real(kind=dp), allocatable :: work(:)

  ! Initialize the matrix a
  a = reshape([  10.0_dp, 2.0_dp, 3.0_dp, 8.0_dp, &
       &          9.0_dp, 3.0_dp, 6.0_dp, 4.0_dp, &
       &          3.0_dp, 6.0_dp, 5.0_dp, 6.0_dp, &
       &          4.0_dp, 4.0_dp, 6.0_dp, 6.0_dp], shape(a))
  ! Print out the matrix we start with
  call dgeprt(a, 'a=')

  ! It is possible to ask dgeev to compute the best size for the WORK array if you can't figure it out beforehand.
  lwork = -1
  allocate(work(1))
  !          jobvl jobvr n  a  lda  wr  wi  vl  ldvl vr  ldvr work  lwork  info
  call dgeev('N',  'N',  n, a, n,   wr, wi, vl, n,   vr, n,   work, lwork, inf)
  if(inf /= 0) then
     print *, "Error during workspace query in dgeev. info: ", inf
     error stop
  end if

  ! The optimal size is in work(1)
  lwork = int(work(1))
  deallocate(work)
  allocate(work(lwork))

  ! call dgeev for eigenvalue computation
  !          jobvl jobvr n  a  lda wr  wi  vl  ldvl vr  ldvr work  lwork  info
  call dgeev('N',  'N',  n, a, n,  wr, wi, vl, n,   vr, n,   work, lwork, inf)

  ! Figure out if the computation worked
  if (inf == 0) then
     write (*,*) 'successful eigenvalue computation'
  else if (inf < 0) then
     write (*,*) 'Illegal value at: ', -inf
     stop
  else if (inf > 0) then
     write (*,*) 'QR failed to find all eigenvalues.  info: ', -inf
     stop
  else
     write (*,*) 'Illegal return code'
     stop
  end if

  write (*,*) 'The Eigenvalues:'
  call dgeprt(wr, 'wr=')
  call dgeprt(wi, 'wi=')

end program genEig
