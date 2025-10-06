// -*- Mode:C++; Coding:us-ascii-unix; fill-column:158 -*-
/*******************************************************************************************************************************************************.H.S.**/
/**
 @file      slvPly.cpp
 @author    Mitch Richling http://www.mitchr.me/
 @brief     Eigenvalues of a complex matrix. @EOL
 @keywords  blas cblas claback lapack lapacke numerical linear linear algebra matrix vector netlib
 @std       C++23
 @see       https://github.com/richmit/ex-blas-lapack/
 @copyright
  @parblock
  Copyright (c) 2025, Mitchell Jay Richling <http://www.mitchr.me/> All rights reserved.

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

  Using LAPACK's LAPACKE C interface in C++ is generally similar to using it in C; however, there are a few common things that come up:
   - C++ is more strict with types, so we must be a bit more careful and use casts appropriately.
   - Most C++ programmers prefer new/delete to malloc/free.
   - LAPACKE's lapack_complex_X and std::complex<X> share the same memory layout.  We can use std::complex with casts or we can use the
     preprocessor mechinsizm in lapack.h to redefine the lapack_complex_X types.
   - STL array-like containers that provide access to contiguously stored elements may be used instead of arrays.
*/
/*******************************************************************************************************************************************************.H.E.**/

//--------------------------------------------------------------------------------------------------------------------------------------------------------------
#include <iostream>                                                      /* C++ iostream            C++11    */
#include <complex>                                                       /* Complex Numbers         C++11    */
#include <vector>                                                        /* STL vector              C++11    */ 
#include <iomanip>                                                       /* C++ stream formatting   C++11    */

//--------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Here we redefine the complex types we are going to use.  Note these alter the function prototypes in lapacke.h. */
#define LAPACK_COMPLEX_CUSTOM         1
#define lapack_complex_float          std::complex<float>
#define lapack_complex_double         std::complex<double>

#include <lapacke.h>                                                     /* LAPACK C Interface      LAPACKE  */

/*------------------------------------------------------------------------------------------------------------------------------------------------------------*/
typedef lapack_complex_double cplx;

/*------------------------------------------------------------------------------------------------------------------------------------------------------------*/
int main() {
  std::vector<cplx> p      = { { 1.0, 0.0},            // Our polynomial
                                { 0.0, 0.0},  
                                {-5.0, 0.0}, 
                                { 0.0, 0.0},  
                                { 4.0, 0.0} };
  lapack_int        n      = (lapack_int)p.size() - 1; // Companion matrix dimensions are the polynomial degree
  lapack_int        lwork  = -1;                       // Set to -1 for work size query
  lapack_int        inf;
  cplx              *work;                             // Allocated later after query
  cplx              *a     = new cplx[n*n];
  cplx              *w     = new cplx[n*2];
  double            *rwork = new double[n*2];
  cplx              tmp;

  /* Set the elements of a -- we want it to be the companion matrix of p. */
  for(int i=0;i<n*n;i++)
    a[i] = cplx(0.0, 0.0);
  for(int i=1;i<n;i++)
    a[i*n+(i-1)] = cplx(1.0, 0.0);
  for(int i=1;i<=n;i++)
    a[(n-i)*n+(n-1)] = - p[i] / p[0];

  /* Query the optimal value for lwork.  */
  /*                       matrix_layout,    jobvl, jobvr, n, a, lda, w, vl,   ldvl, vr,   ldvr, work, lwork, rwork); */
  inf = LAPACKE_zgeev_work(LAPACK_COL_MAJOR, 'N',   'N',   n, a, n,   w, NULL, n,    NULL, n,    &tmp, lwork, rwork);
  if(inf != 0) {
    std::cout << "ZGEEV Error (lwork query): " << inf << std::endl;
    exit(1);
  }

  /* Allocate work and set lwork. */
  lwork = LAPACK_Z2INT(tmp) + 1;  // Essencially the same as (int)(std::real(tmp)) + 1;
  work  = new cplx[lwork];

  /* Now find the eigenvalues. */
  /*                       matrix_layout,    jobvl, jobvr, n, a, lda, w, vl,   ldvl, vr,   ldvr, work, lwork, rwork); */
  inf = LAPACKE_zgeev_work(LAPACK_COL_MAJOR, 'N',   'N',   n, a, n,   w, NULL, n,    NULL, n,    work, lwork, rwork);
  if(inf != 0) {
    std::cout << "ZGEEV Error (eigenvalue): " << inf << std::endl;
    exit(1);
  }

  /* Print out the roots/eigenvalues -- one per line */
  std::cout << "Roots of p (Eigenvalues of a): " << std::endl;
  for(int i=0;i<n;i++)
    std::cout << n << ":  " << std::fixed << std::setprecision(5) << std::setw(10) << std::real(w[i]) << " " << std::setw(10) << std::imag(w[i]) << "_i" << std::endl;

  /* Free the memory for new'ed arrays. */
  delete[] a;
  delete[] w;    
  delete[] work; 
  delete[] rwork;

  /* All done */
  return 0;

} /* end func main */


