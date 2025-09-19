! -*- Mode:F90; Coding:us-ascii-unix; fill-column:129 -*-
!.!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!.H.S.!!
!>
!! @file      triSlv.f90
!! @author    Mitch Richling http://www.mitchr.me/
!! @brief     Solve a triangular system with DTRSV. @EOL
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
!!  BLAS supports upper and lower triangular systems, the matrix being transposed, and the diagonal being unitary or not.  This
!!  program illustrates the most common case when the matrix is upper triangular and has non-units on the diagonal.
!!
!.!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!.H.E.!!

!----------------------------------------------------------------------------------------------------------------------------------
program triSlv

  use blas_kinds,    only: dp
  use lapack_ifaces, only: dtrsv
  use blaio,         only: dgeprt

  implicit none (type, external)

  real(kind=dp) :: m(5,5), x(5)

  m = reshape([ 3.0_dp, 0.0_dp, 0.0_dp, 0.0_dp, 0.0_dp, &
       &        5.0_dp, 8.0_dp, 0.0_dp, 0.0_dp, 0.0_dp, &
       &        7.0_dp, 1.0_dp, 5.0_dp, 0.0_dp, 0.0_dp, &
       &        9.0_dp, 4.0_dp, 9.0_dp, 4.0_dp, 0.0_dp, &
       &        1.0_dp, 7.0_dp, 3.0_dp, 9.0_dp, 5.0_dp], shape(m))

  x = reshape([ 1.0_dp, 2.0_dp, 3.0_dp, 4.0_dp, 5.0_dp], shape(x))

  call dgeprt(m, 'm=')
  call dgeprt(x, 'x=')

  !          uplo, trans, diag, n, a, lda, x, incx
  call dtrsv('U',  'N',   'N',  5, m, 5,   x, 1)

  call dgeprt(m, 'm=')
  call dgeprt(x, 'x=')

end program triSlv
