! -*- Mode:F90; Coding:us-ascii-unix; fill-column:129 -*-
!.!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!.H.S.!!
!>
!! @file      blas_ifaces.f90
!! @author    Mitch Richling http://www.mitchr.me/
!! @date      2025-09-17
!! @version   VERSION
!! @brief     Interface blocks for the BLAS routines we use.@EOL
!! @keywords  blas linear algebra netlib
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
module blas_ifaces
  implicit none (type, external)

  interface
     function idamax(n, x, incx)
       use blas_kinds, only: dp
       implicit none (type, external)
       integer                      :: idamax
       integer,       intent(in)    :: n
       real(kind=dp), intent(in)    :: x(*)
       integer,       intent(in)    :: incx
     end function idamax

     subroutine dswap(n, x, incx, y, incy)
       use blas_kinds, only: dp
       implicit none (type, external)
       integer,       intent(in)    :: n
       real(kind=dp), intent(inout) :: x(*)
       integer,       intent(in)    :: incx
       real(kind=dp), intent(inout) :: y(*)
       integer,       intent(in)    :: incy
     end subroutine dswap

     subroutine dcopy(n, x, incx, y, incy)
       use blas_kinds, only: dp
       implicit none (type, external)
       integer,       intent(in)    :: n
       real(kind=dp), intent(inout) :: x(*)
       integer,       intent(in)    :: incx
       real(kind=dp), intent(inout) :: y(*)
       integer,       intent(in)    :: incy
     end subroutine dcopy

     subroutine dscal(n, alpha, x, incx)
       use blas_kinds, only: dp
       implicit none (type, external)
       integer,       intent(in)    :: n
       real(kind=dp), intent(in)    :: alpha
       real(kind=dp), intent(inout) :: x(*)
       integer,       intent(in)    :: incx
     end subroutine dscal

     subroutine daxpy(n, alpha, x, incx, y, incy)
       use blas_kinds, only: dp
       implicit none (type, external)
       integer,       intent(in)    :: n
       real(kind=dp), intent(in)    :: alpha
       real(kind=dp), intent(in)    :: x(*)
       integer,       intent(in)    :: incx
       real(kind=dp), intent(inout) :: y(*)
       integer,       intent(in)    :: incy
     end subroutine daxpy

     function dnrm2(n, x, incx)
       use blas_kinds, only: dp
       implicit none (type, external)
       real(kind=dp)                :: dnrm2
       integer,       intent(in)    :: n
       real(kind=dp), intent(in)    :: x(*)
       integer,       intent(in)    :: incx
     end function dnrm2

     function dasum(n, x, incx)
       use blas_kinds, only: dp
       implicit none (type, external)
       real(kind=dp)                :: dasum
       integer,       intent(in)    :: n
       real(kind=dp), intent(in)    :: x(*)
       integer,       intent(in)    :: incx
     end function dasum

     function ddot(n, x, incx, y, incy)
       use blas_kinds, only: dp
       implicit none (type, external)
       real(kind=dp)                :: ddot
       integer,       intent(in)    :: n
       real(kind=dp), intent(in)    :: x(*)
       integer,       intent(in)    :: incx
       real(kind=dp), intent(in)    :: y(*)
       integer,       intent(in)    :: incy
     end function ddot

     subroutine dgemv(trans, m, n, alpha, a, lda, x, incx, beta, y, incy)
       use blas_kinds, only: dp
       implicit none (type, external)
       character(1),  intent(in)    :: trans
       integer,       intent(in)    :: m
       integer,       intent(in)    :: n
       real(kind=dp), intent(in)    :: alpha
       integer,       intent(in)    :: lda
       real(kind=dp), intent(in)    :: a(lda, *)
       real(kind=dp), intent(in)    :: x(*)
       integer,       intent(in)    :: incx
       real(kind=dp), intent(in)    :: beta
       real(kind=dp), intent(inout) :: y(*)
       integer,       intent(in)    :: incy
     end subroutine dgemv

     subroutine dger(m, n, alpha, x, incx, y, incy, a, lda)
       use blas_kinds, only: dp
       implicit none (type, external)
       integer,       intent(in)    :: m
       integer,       intent(in)    :: n
       real(kind=dp), intent(in)    :: alpha
       real(kind=dp), intent(in)    :: x(*)
       integer,       intent(in)    :: incx
       real(kind=dp), intent(in)    :: y(*)
       integer,       intent(in)    :: incy
       integer,       intent(in)    :: lda
       real(kind=dp), intent(inout) :: a(lda, *)
     end subroutine dger

     subroutine dgemm(transa, transb, m, n, k, alpha, a, lda, b, ldb, beta, c, ldc)
       use blas_kinds, only: dp
       implicit none (type, external)
       character(1),  intent(in)    :: transa
       character(1),  intent(in)    :: transb
       integer,       intent(in)    :: m
       integer,       intent(in)    :: n
       integer,       intent(in)    :: k
       real(kind=dp), intent(in)    :: alpha
       integer,       intent(in)    :: lda
       real(kind=dp), intent(in)    :: a(lda, *)
       integer,       intent(in)    :: ldb
       real(kind=dp), intent(in)    :: b(ldb, *)
       real(kind=dp), intent(in)    :: beta
       integer,       intent(in)    :: ldc
       real(kind=dp), intent(inout) :: c(ldc, *)
     end subroutine dgemm

  end interface

end module blas_ifaces
