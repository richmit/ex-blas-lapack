/* -*- Mode:C; Coding:us-ascii-unix; fill-column:158 -*- */
/*******************************************************************************************************************************************************.H.S.**/
/**
 @file      slvSysC.c
 @author    Mitch Richling http://www.mitchr.me/
 @brief     Demonstrate LAPACK's sgesv functions.@EOL
 @keywords  lapacke claback cblas sgesv numerical linear algebra
 @std       C99
 @see       https://github.com/richmit/ex-blas-lapack/
 @copyright 
  @parblock
  Copyright (c) 1998,2025, Mitchell Jay Richling <http://www.mitchr.me/> All rights reserved.
  
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
 @todo      @EOL@EOL
 @warning   @EOL@EOL
 @bug       @EOL@EOL
 @filedetails   

  Demonstrate LAPACK's Xgesv function as exposed in the LAPACKE C interface.  Note that you can still use the claback calls.
*/
/*******************************************************************************************************************************************************.H.E.**/

/*------------------------------------------------------------------------------------------------------------------------------------------------------------*/
#include <stdio.h>                                                       /* I/O lib                 C89      */
#include <stdlib.h>                                                      /* Standard Lib            C89      */
#include <cblas.h>                                                       /* C BLAS                  BLAS     */
#include <lapacke.h>                                                     /* LAPACK C Interface      LAPACKE  */

/*------------------------------------------------------------------------------------------------------------------------------------------------------------*/
#include "blaio.h"                                                       /* Basic Linear Algebra I/O         */

/*------------------------------------------------------------------------------------------------------------------------------------------------------------*/
int main(int argc, char **argv) {
  lapack_int n       = 4;
  lapack_int nrhs    = 1;
  lapack_int lda     = n;
  lapack_int ldb     = n;
  double a[]         = {   1.0,  2.0,  3.0,  4.0,  /* n*n */
                           6.0,  7.0,  9.0,  9.0,
                          11.0, 12.0, 19.0, 14.0,
                          16.0, 17.0, 18.0, 12.0,
                        };
  double b[]         = {1.0, 3.0, 5.0, 6.0};       /* n*nrhs */
  lapack_int ipiv[]  = {  0,   0,   0,   0};       /* n */
  lapack_int inf;
  int i;

  printMatrix(CblasColMajor, 4, 4, a, 15, 10, NULL, NULL, NULL, NULL, NULL, "a=");
  printMatrix(CblasColMajor, 1, 4, b, 15, 10, NULL, NULL, NULL, NULL, NULL, "b=");

  /* The LAPACKE version of dgesv */
  inf = LAPACKE_dgesv(LAPACK_COL_MAJOR, n, nrhs, a, lda, ipiv, b, ldb);
  /* We can use the lapacke header with old clapack code too.  Example: */
  // dgesv_(&n, &nrhs, a, &lda, ipiv, b, &ldb, &inf);

  if(inf == 0) {
    printf("Successful Solution\n");
  } else if(inf < 0) {
    printf("Illegal value at: %d\n", -(int)inf);
    exit(1);
  } else if(inf > 0) {
    printf("Matrix was singular\n");
    exit(1);
  } else {
    printf("Unknown Result (Can't happen!)\n");
    exit(1);
  } /* end if/else */

  printMatrix(CblasColMajor, 4, 4, a, 15, 10, NULL, NULL, NULL, NULL, NULL, "a=");
  printMatrix(CblasColMajor, 1, 4, b, 15, 10, NULL, NULL, NULL, NULL, NULL, "b=");

  printf("PIV=");
  for(i=0;i<4;i++)
    printf("%4d ", (int)(ipiv[i]));
  printf("\n");

  return 0;

} /* end func main */
