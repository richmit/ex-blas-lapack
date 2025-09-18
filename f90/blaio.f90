! -*- Mode:F90; Coding:us-ascii-unix; fill-column:129 -*-
!.!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!.H.S.!!
!>
!! @file      blaio.f90
!! @author    Mitch Richling http://www.mitchr.me/
!! @date      2025-09-17
!! @version   VERSION
!! @brief     Simple matrix/vector I/O for examples. @EOL
!! @keywords  blas linear algebra netlib i/o blaio
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
module blaio
  use blas_kinds, only: dp

  implicit none (type, external)
  private
  
  interface sgeprt
     module procedure :: sgeprtv, sgeprtm
  end interface sgeprt

  public :: sgeprtm, sgeprtv, sgeprt
contains

  subroutine sgeprtv(a, tag, wide_o, prec_o, ldel_o, rdel_o)
    use blas_kinds, only: dp
    real(kind=dp),              intent(in) :: a(:)
    character(len=*),           intent(in) :: tag
    integer,          optional, intent(in) :: wide_o, prec_o
    character(len=*), optional, intent(in) :: ldel_o, rdel_o
    integer                                :: wide, prec
    character(len=:), allocatable          :: ldel, rdel
    character(len=1024)                    :: fst
    ! Process optional arguments
    ldel = '['
    if (present(ldel_o))  ldel  = ldel_o
    rdel = ']'            
    if (present(rdel_o))  rdel  = rdel_o
    wide = 9
    if (present(wide_o))  wide  = wide_o
    prec = 3
    if (present(prec_o))  prec  = prec_o
    ! Build format string & write vector
    write (fst, '("(1x,a",i0,",a,a,",i0,"f",i0,".",i0,",1x,a,a)")') len(tag), size(a, 1), wide, prec
    write (*, fst) tag, ldel, ldel, a, rdel, rdel
  end subroutine sgeprtv

  subroutine sgeprtm(a, tag, wide_o, prec_o, ldel_o, rdel_o, lidel_o, ridel_o)
    use blas_kinds, only: dp
    real(kind=dp),              intent(in) :: a(:,:)
    character(len=*),           intent(in) :: tag
    integer,          optional, intent(in) :: wide_o, prec_o
    character(len=*), optional, intent(in) :: ldel_o, rdel_o, lidel_o, ridel_o
    integer                                :: wide, prec
    character(len=:), allocatable          :: ldel, rdel, lidel, ridel
    character(len=1024)                    :: fst
    integer                                :: i
    ! Process optional arguments
    ldel = '['
    if (present(ldel_o))  ldel  = ldel_o
    rdel = ']'            
    if (present(rdel_o))  rdel  = rdel_o
    lidel = '['
    if (present(lidel_o)) lidel = lidel_o
    ridel = ']'
    if (present(ridel_o)) ridel = ridel_o
    wide = 9
    if (present(wide_o))  wide  = wide_o
    prec = 3
    if (present(prec_o))  prec  = prec_o
    ! Build format string & write matrix
    write (fst, '("(1x,a",i0,",a,a,",i0,"f",i0,".",i0,",1x,a,a)")') len(tag), size(a, 2), wide, prec
    do i=1,size(a, 1)
       if( (i == 1) .and. (i == size(a, 1)) ) then
          write (*, fst) tag, ldel, lidel, a(i, :), ridel, rdel
       else if(i == 1) then 
          write (*, fst) tag, ldel, lidel, a(i, :), ridel, ' '
       else if(i == size(a, 1)) then
          write (*, fst) ' ', ' ',  lidel, a(i, :), ridel, rdel
       else
          write (*, fst) ' ', ' ',  lidel, a(i, :), ridel, ' '
       endif
    enddo
  end subroutine sgeprtm
end module blaio
