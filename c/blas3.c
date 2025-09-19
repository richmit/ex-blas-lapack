/* -*- Mode:C; Coding:us-ascii-unix; fill-column:158 -*- */
/*******************************************************************************************************************************************************.H.S.**/
/**
 @file      blas3.c
 @author    Mitch Richling http://www.mitchr.me/
 @brief     Demonstrate Level 3 BLAS/CBLAS. @EOL
 @keywords  blas cblas claback lapack lapacke numerical linear linear algebra matrix vector netlib
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

  This code demonstrates the cblas_dgemm routine in the CBLAS.
*/
/*******************************************************************************************************************************************************.H.E.**/

/*------------------------------------------------------------------------------------------------------------------------------------------------------------*/
#include <stdio.h>                                                       /* I/O lib                 C89      */
#include <stdlib.h>                                                      /* Standard Lib            C89      */

/*------------------------------------------------------------------------------------------------------------------------------------------------------------*/
#include "blaio.h"                                                       /* Basic Linear Algebra I/O         */

/*------------------------------------------------------------------------------------------------------------------------------------------------------------*/
int main(int argc, char **argv) {
  double a[4*5] = {  1.0,  2.0,  3.0,  4.0,  5.0, /* CblasRowMajor */
                     6.0,  7.0,  8.0,  9.0, 10.0,
                    11.0, 12.0, 13.0, 14.0, 15.0,
                    16.0, 17.0, 18.0, 19.0, 20.0 };
  double b[5*4] = {  1.0,  0.0,  0.0,  0.0,       /* CblasRowMajor */
                     0.0,  0.0,  1.0,  0.0,
                     0.0,  1.0,  0.0,  0.0,
                     0.0,  0.0,  0.0,  1.0,
                     0.0,  0.0,  0.0,  0.0 };
  double c[4*4];
  double d[4*4] = {  1.0,  2.0,  3.0,  4.0,       /* CblasRowMajor */
                     6.0,  7.0,  8.0,  9.0,
                    11.0, 12.0, 13.0, 14.0,
                    16.0, 17.0, 18.0, 19.0 };
  double e[4*4] = {  1.0,  0.0,  0.0,  0.0,       /* CblasRowMajor */
                     0.0,  0.0,  1.0,  0.0,
                     0.0,  1.0,  0.0,  0.0,
                     0.0,  0.0,  0.0,  1.0 };

   printMatrix(CblasRowMajor, 4, 5, a, 8, 3, NULL, NULL, NULL, NULL, NULL, "              a = ");
   printMatrix(CblasRowMajor, 5, 4, b, 8, 3, NULL, NULL, NULL, NULL, NULL, "              b = ");
   /*          row_order      transform     transform     rowsA colsB K  alpha  a  lda  b  ldb beta c   ldc */
   cblas_dgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans, 4,    4,    5, 1.0,   a,   5, b, 4,  0.0, c,  4);
   printMatrix(CblasRowMajor, 4, 4, c, 8, 3, NULL, NULL, NULL, NULL, NULL, "c <- 1.0*a*b+0.0*c = ");


   printMatrix(CblasRowMajor, 4, 4, d, 8, 3, NULL, NULL, NULL, NULL, NULL, "              d = ");
   printMatrix(CblasRowMajor, 4, 4, e, 8, 3, NULL, NULL, NULL, NULL, NULL, "              e = ");
   /*          row_order      transform     transform     rowsA colsB K  alpha  a  lda  b  ldb beta c   ldc */
   cblas_dgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans, 4,    4,    4, 1.0,   d,   4, e, 4,  0.0, c,  4);
   printMatrix(CblasRowMajor, 4, 4, c, 8, 3, NULL, NULL, NULL, NULL, NULL, "c <- 1.0*d*e+0.0*c = ");

   return 0;
} /* end func main */
