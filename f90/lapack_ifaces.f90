! -*- Mode:F90; Coding:us-ascii-unix; fill-column:129 -*-
!.!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!.H.S.!!
!>
!! @file      lapack_ifaces.f90
!! @author    Mitch Richling http://www.mitchr.me/
!! @brief     Interface block for the lapack routines we use.@EOL
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
module lapack_ifaces
  implicit none (type, external)

  interface

     subroutine dgesv(n, nrhs, a, lda, ipiv, b, ldb, info)
       use blas_kinds, only: dp
       implicit none (type, external)
       integer,        intent(in)     :: n
       integer,        intent(in)     :: nrhs
       integer,        intent(in)     :: lda
       real(kind=dp),  intent(inout)  :: a(lda, *)
       integer,        intent(out)    :: ipiv(n)
       integer,        intent(in)     :: ldb
       real(kind=dp),  intent(inout)  :: b(ldb, *)
       integer,        intent(out)    :: info
     end subroutine dgesv

     subroutine dsytrd(uplo, n, a, lda, d, e, tau, work, lwork, info)
       use blas_kinds, only: dp
       implicit none (type, external)
       character(1),   intent(in)     :: uplo
       integer,        intent(in)     :: n
       integer,        intent(in)     :: lda
       real(kind=dp),  intent(inout)  :: a(lda, *)
       real(kind=dp),  intent(inout)  :: d(*)
       real(kind=dp),  intent(inout)  :: e(*)
       real(kind=dp),  intent(inout)  :: tau(*)
       integer,        intent(in)     :: lwork
       real(kind=dp),  intent(out)    :: work(max(1,lwork))
       integer,        intent(out)    :: info
     end subroutine dsytrd

     subroutine dsteqr(compz, n, d, e, z, ldz, work, info)
       use blas_kinds, only: dp
       implicit none (type, external)
       character(1),   intent(in)     :: compz
       integer,        intent(in)     :: n
       real(kind=dp),  intent(inout)  :: d(*)
       real(kind=dp),  intent(inout)  :: e(*)
       integer,        intent(in)     :: ldz
       real(kind=dp),  intent(inout)  :: z(ldz, *)
       real(kind=dp),  intent(inout)  :: work(*)
       integer,        intent(out)    :: info
     end subroutine dsteqr

     subroutine dtrsv(uplo, trans, diag, n, a, lda, x, incx)
       use blas_kinds, only: dp
       implicit none (type, external)
       character(1),   intent(in)     :: uplo
       character(1),   intent(in)     :: trans
       character(1),   intent(in)     :: diag
       integer,        intent(in)     :: n
       integer,        intent(in)     :: lda
       real(kind=dp),  intent(inout)  :: a(lda, *)
       real(kind=dp),  intent(inout)  :: x(*)
       integer,        intent(in)     :: incx
     end subroutine dtrsv

     subroutine dgeev(jobvl, jobvr, n, a, lda, wr, wi, vl, ldvl, vr, ldvr, work, lwork, info)
       use blas_kinds, only: dp
       implicit none
       character(1),   intent (in)    :: jobvl
       character(1),   intent (in)    :: jobvr
       integer,        intent (in)    :: n
       integer,        intent (in)    :: lda
       real(kind=dp),  intent (inout) :: a(lda, *)
       real(kind=dp),  intent (inout) :: wr(*)
       real(kind=dp),  intent (inout) :: wi(*)
       integer,        intent (in)    :: ldvl
       real(kind=dp),  intent (inout) :: vl(ldvl, *)
       integer,        intent (in)    :: ldvr
       real(kind=dp),  intent (inout) :: vr(ldvr, *)
       integer,        intent (in)    :: lwork
       real (kind=dp), intent (out)   :: work(max(1,lwork))
       integer,        intent (out)   :: info
     end subroutine dgeev

  end interface

end module lapack_ifaces
