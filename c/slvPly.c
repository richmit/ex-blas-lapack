/* -*- Mode:C; Coding:us-ascii-unix; fill-column:158 -*- */
/*******************************************************************************************************************************************************.H.S.**/
/**
 @file      slvPly.c
 @author    Mitch Richling http://www.mitchr.me/
 @brief     Eigenvalues of a complex matrix. @EOL
 @keywords  blas cblas claback lapack lapacke numerical linear linear algebra matrix vector netlib
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
 @filedetails

  Demonstrate LAPACK's LAPACKE_zgeev_work function as exposed in the LAPACKE C interface.  In this example we construct a complex companion matrix for a
  complex polynomial so the eigenvalues of the matrix are the roots of the polynomial.  The polynomial in question is:
  @f[ x^4-5*x^2+4 = (x+2)(x+1)(x-1)(x-2) @f]
*/
/*******************************************************************************************************************************************************.H.E.**/

/*------------------------------------------------------------------------------------------------------------------------------------------------------------*/
#include <stdio.h>                                                       /* I/O lib                 C89      */
#include <stdlib.h>                                                      /* Standard Lib            C89      */
#include <lapacke.h>                                                     /* LAPACK C Interface      LAPACKE  */

/*------------------------------------------------------------------------------------------------------------------------------------------------------------*/
#include "blaio.h"                                                       /* Basic Linear Algebra I/O         */

/*------------------------------------------------------------------------------------------------------------------------------------------------------------*/
int main(int argc, char **argv) {
  lapack_complex_double p[]   = { lapack_make_complex_double(1.0, 0.0),      // Our polynomial
                                  lapack_make_complex_double(0.0, 0.0),  
                                  lapack_make_complex_double(-5.0, 0.0), 
                                  lapack_make_complex_double(0.0, 0.0),  
                                  lapack_make_complex_double(4.0, 0.0) };
  lapack_int            n     = sizeof(p) / sizeof(lapack_complex_double) - 1;
  lapack_int            lda   = n;
  lapack_int            ldvl  = n;
  lapack_int            ldvr  = n;
  lapack_int            lwork = -1; /* We use -1 in the first call to LAPACKE_zgeev_work to query the best value for lwork */
  lapack_int            inf;
  lapack_complex_double *a, *work, *w, *vr, *vl;
  double                *rwork;

  vr    = 0; /* NULL pointer because we don't need space, just a pointer to pass to LAPACKE_zgeev_work */
  vl    = 0; /* NULL pointer because we don't need space, just a pointer to pass to LAPACKE_zgeev_work */
  a     = (lapack_complex_double *)malloc(sizeof(lapack_complex_double)*n*lda);
  w     = (lapack_complex_double *)malloc(sizeof(lapack_complex_double)*n);
  rwork = (double *)malloc(sizeof(double)*n*2);

  /* Set the elements of a -- we want it to be the companion matrix of p. */
  for(int i=0;i<n*n;i++)
    a[i] = lapack_make_complex_double(0.0, 0.0);
  for(int i=1;i<n;i++)
    a[i*n+(i-1)] = lapack_make_complex_double(1.0, 0.0);
  for(int i=1;i<=n;i++)
    a[(n-i)*n+(n-1)] = -p[i]/p[0];

  /* Query the optimal value for lwork.  */
  work  = (lapack_complex_double *)malloc(sizeof(lapack_complex_double)*1);
  inf = LAPACKE_zgeev_work(LAPACK_COL_MAJOR, 'N', 'N', n, a, lda, w, vl, ldvl, vr, ldvr, work, lwork, rwork);
  if(inf != 0) {
    printf("Solution Error (lwork query): %d\n", inf);
    exit(1);
  } /* end if */

  /* Allocate work & set lwork */
  printf("Optimal lwork value %f\n\n", lapack_complex_double_real(work[0]));
  lwork = (int)(lapack_complex_double_real(work[0])) + 1;
  free(work);
  work  = (lapack_complex_double *)malloc(sizeof(lapack_complex_double)*lwork);

  /* The "work" version of LAPACKE version of zgeev. */
  inf = LAPACKE_zgeev_work(LAPACK_COL_MAJOR, 'N', 'N', n, a, lda, w, vl, ldvl, vr, ldvr, work, lwork, rwork);
  if(inf != 0) {
    printf("Solution Error (eigenvalue): %d\n", inf);
    exit(1);
  } /* end if */

  /* Print out the eigenvalues -- one per line */
  printf("\nThe Roots of p (the eigenvalues of a)\n");
  for(int i=0;i<n;i++)
    printf("(%20.5g, %20.5g)\n", lapack_complex_double_real(w[i]), lapack_complex_double_imag(w[i]));

  /* Free the memory allocated by malloc */
  free(a);    
  free(w);    
  free(work); 
  free(rwork);

  /* All done */
  return 0;

} /* end func main */
