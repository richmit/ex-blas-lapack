/* -*- Mode:C; Coding:us-ascii-unix; fill-column:158 -*- */
/*******************************************************************************************************************************************************.H.S.**/
/**
 @file      blas1.c
 @author    Mitch Richling http://www.mitchr.me/
 @brief     Demonstrate Level 1 BLAS/CBLAS. @EOL
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

  This code demonstrates several level 1 CBLAS functions: cblas_dswap, cblas_dcopy, cblas_daxpy, cblas_ddotu, cblas_ddot, cblas_dnrm2, cblas_dasum,
  cblas_dscal, cblas_ddotc, cblas_idmax
*/
/*******************************************************************************************************************************************************.H.E.**/

/*------------------------------------------------------------------------------------------------------------------------------------------------------------*/
#include <stdio.h>                                                       /* I/O lib                 C89      */
#include <stdlib.h>                                                      /* Standard Lib            C89      */

/*------------------------------------------------------------------------------------------------------------------------------------------------------------*/
#include "blaio.h"                                                       /* Basic Linear Algebra I/O         */

/*------------------------------------------------------------------------------------------------------------------------------------------------------------*/
int main(int argc, char **argv) {
  double x[4] = {2.0, 3.0, 4.0, 5.0};
  double y[4] = {5.0, 4.0, 9.0, 2.0};
  double d[4];

  printVector(4, x, 3, 1, NULL, NULL, NULL, "            x = ");
  printVector(4, y, 3, 1, NULL, NULL, NULL, "            y = ");

  /*          lenX X  incX Y  incY*/
  cblas_dswap(4,   x, 1,   y, 1);

  printf("After Swap..\n");
  printVector(4, x, 3, 1, NULL, NULL, NULL, "            x = ");
  printVector(4, y, 3, 1, NULL, NULL, NULL, "            y = ");

  /*          lenX X  incX Y  incY*/
  cblas_dcopy(4,   x, 1,   d, 1);
  printf("After Copy (d=x)..\n");
  printVector(4, d, 3, 1, NULL, NULL, NULL, "       d <- x = ");


  /*          lenX alpha X  incX */
  cblas_dscal(4,   2.0,  y, 1);
  printf("After Scale (2*y)..\n");
  printVector(4, y, 3, 1, NULL, NULL, NULL, "        2.0*y = ");

  /*           lenX alpha X  incX y  incY*/
  cblas_daxpy(4,   3.0,  x, 1,   y, 1);
  printf("After Add (y=3*x+y)..\n");
  printVector(4, y, 3, 1, NULL, NULL, NULL, " y <- 3.0*x+y = ");

  /*                                                    lenX X  incX */
  printf("2-norm   of y = %0.2f\n",  (float)cblas_dnrm2(4,   y, 1));
  printf("sum-norm of y = %0.2f\n",  (float)cblas_dasum(4,   y, 1));

  /* Note, the i#amax norm returns the INDEX of the element that corresponds to the max-norm value. */
  /*                                                    lenX X  incX */
  printf("max-norm of y = |y[%d]|\n", (int)cblas_idamax(4,   y, 1));

  /*                                                    lenX X  incX Y  incY */
  printf("      y dot y = %0.2f\n",   (float)cblas_ddot(4,   y, 1,   y, 1));

  return 0;
} /* end func main */
