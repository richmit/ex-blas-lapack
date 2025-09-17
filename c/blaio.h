/* -*- Mode:C; Coding:us-ascii-unix; fill-column:158 -*- */
/*******************************************************************************************************************************************************.H.S.**/
/**
 @file      blaio.h
 @author    Mitch Richling http://www.mitchr.me/
 @brief     Basic Linear Algebra I/O Subroutines.@EOL
 @std       C99
 @see       https://github.com/richmit/ex-blas-lapack/
 @copyright 
  @parblock
  Copyright (c) 1999,2025, Mitchell Jay Richling <http://www.mitchr.me/> All rights reserved.
  
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

  Include file for the BLAIO (Basic Linear Algebra I/O Subroutines).  The BLAIO is intended to provide a very simple interface for printing and reading matrix
  and vector quantities.  The library is primarily useful for debugging software making use of BLAS or higher level numerical linear algebra libraries.
*/
/*******************************************************************************************************************************************************.H.E.**/

/*------------------------------------------------------------------------------------------------------------------------------------------------------------*/
#include <cblas.h>                                                       /* C BLAS                  BLAS     */

/*------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* This function is intended to be used as a utility function for numerical software working with REALT precession vectors in C.  It will attractively print
   vectors in semi-mathematical notation in an easy and flexible way. */
void printVector(int n, double *v,        /* Size and array                 */
                 int wide, int prec,      /* Width and precesion for floats */
                 char *pad,               /* Right pad string               */
                 char *ldel, char *rdel,  /* Left and right delimiter       */
                 char *tag                /* Tag for first line             */
  );

/*------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* Print a matrix out with the matrix elements printed a format string like "%wide.precf".  Each row will be delimited by lidel/ridel.  The matrix will be
   delimited by ldel/rdel.  Each number, and left delimiter will be followed by the pad string.  The first line of the matrix will have the tag string printed
   at the start of the line, and all remaining lines will have spaces printed to align the rest of the matrix past the tag. */
void printMatrix(const enum CBLAS_ORDER order, 
                 int n, int m, double *a,  /* Size and array                 */
                 int wide, int prec,       /* Width and precesion for floats */
                 char *pad,                /* Right pad string               */
                 char *ldel, char *rdel,   /* Left and right delimiter       */
                 char *lidel, char *ridel, /* Left and right INNER delimiter */
                 char *tag                 /* Tag for first line             */
  );
