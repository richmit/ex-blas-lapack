/* -*- Mode:C; Coding:us-ascii-unix; fill-column:158 -*- */
/*******************************************************************************************************************************************************.H.S.**/
/**
 @file      blas2C.c
 @author    Mitch Richling http://www.mitchr.me/
 @brief     Demonstrate several cblas (level 2) functions. @EOL
 @keywords  blas cblas C fortran numerical linear algebra vector matrix gemv ger
 @std       C99
 @see       https://github.com/richmit/ex-blas-lapack/
 @copyright 
  @parblock
  Copyright (c) 1997,2025, Mitchell Jay Richling <http://www.mitchr.me/> All rights reserved.
  
  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
  
  1. Redistributions of source code must retain the above copyright notice, this list of conditions, and the following disclaimer.
  
  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions, and the following disclaimer in the documentation
     and/or other materials provided with the distribution.
  
  3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software
     without specific prior written permission.
  
  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
  OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
  LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
  DAMAGE.
  @endparblock
 @filedetails   

  This is a simple program intended to illistrate how to make use of #gemv and #ger blas routines (as implimented in the cblas).
*/
/*******************************************************************************************************************************************************.H.E.**/

/*------------------------------------------------------------------------------------------------------------------------------------------------------------*/
#include <math.h>                                                        /* Math stuff              C89      */
#include <stdio.h>                                                       /* I/O lib                 C89      */
#include <stdlib.h>                                                      /* Standard Lib            C89      */

/*------------------------------------------------------------------------------------------------------------------------------------------------------------*/
#include "blaio.h"                                                       /* Basic Linear Algebra I/O         */

/*------------------------------------------------------------------------------------------------------------------------------------------------------------*/
int main(int argc, char **argv) {
  double a[4*5] = {  1.0,  2.0,  3.0,  4.0,  5.0,
                     6.0,  7.0,  8.0,  9.0, 10.0,
                    11.0, 12.0, 13.0, 14.0, 15.0,
                    16.0, 17.0, 18.0, 19.0, 20.0 };
  double x[5]  = {   2.0,  3.0,  4.0,  5.0,  6.0 };
  double y[4];

  printMatrix(CblasRowMajor, 4, 5, a, 8, 3, NULL, NULL, NULL, NULL, NULL, "              a = ");
  printVector(5, x, 8, 3, NULL, NULL, NULL, "              x = ");

  /*          row_order      transform     lenY lenX alpha  a  lda  X  incX  beta  Y, incY */
  cblas_dgemv(CblasRowMajor, CblasNoTrans, 4,   5,   1,     a,   5, x, 1,    0,    y, 1);
  printVector(4, y, 8, 3, NULL, NULL, NULL, "       y<-1.0*a*xT+0.0*y= ");

  /*         row_order       lenY lenX alpha  X  incX  Y, incY A  LDA */
  cblas_dger(CblasRowMajor,  4,   5,   1,     y, 1,    x, 1,   a, 5);
  printMatrix(CblasRowMajor, 4, 5, a, 8, 3, NULL, NULL, NULL, NULL, NULL, "a <- 1.0*x.yT+a = ");

  return 0;
} /* end func main */
