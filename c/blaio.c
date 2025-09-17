/* -*- Mode:C; Coding:us-ascii-unix; fill-column:158 -*- */
/*******************************************************************************************************************************************************.H.S.**/
/**
 @file      blaio.c
 @author    Mitch Richling http://www.mitchr.me/
 @brief     matrix/vector I/O.@EOL
 @keywords  blas numerical linear algebra matrix vector
 @std       C99
 @see       https://github.com/richmit/ex-blas-lapack/
 @copyright 
  @parblock
  Copyright (c) 1993,2025, Mitchell Jay Richling <http://www.mitchr.me/> All rights reserved.
  
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

  A few simple matrix/vector print/read functions useful for printing small test cases and debugging
*/
/*******************************************************************************************************************************************************.H.E.**/

/*------------------------------------------------------------------------------------------------------------------------------------------------------------*/
#include <stdlib.h>                                                      /* Standard Lib            C89      */
#include <stdio.h>                                                       /* I/O lib                 C89      */
#include <ctype.h>                                                       /* Char classes            C89      */
#include <string.h>                                                      /* Strings                 C89      */

/*------------------------------------------------------------------------------------------------------------------------------------------------------------*/
#include "blaio.h"                                                       /* Basic Linear Algebra I/O         */

/*------------------------------------------------------------------------------------------------------------------------------------------------------------*/
void printMatrixUbr(const enum CBLAS_ORDER order, /* CBLAS row order                                                 */
                    int n, int m, double *a,      /* Size and array                                                  */
                    char *inStr, char *outStr,    /* "in" string, and "out" string                                   */
                    double minIn, double maxIn,   /* Min/Max values for "in" range.                                  */
                    int wide, int prec,           /* Width and precesion for floats                                  */
                    int *rowPerm, int *colPerm,                                                                      
                    char prtMode,                 /* b=bitmap, V=values, *=in/out)                                   */
                    char *fileName, 
                    int maskMode,                 /* L=below diag, U=above diag, D=Diagnal, M=Mask, 0=NONE, \0=NONE  */
                    char *mask,
                    char *pad,                    /* Right pad string                                                */
                    char *ldel, char *rdel,       /* Left and right delimiter                                        */
                    char *lidel, char *ridel,     /* Left and right INNER delimiter                                  */
                    char *tag                     /* Tag for first line                                              */
  );

/*------------------------------------------------------------------------------------------------------------------------------------------------------------*/
void printVector(int n, double *v, int wide, int prec, char *pad, char *ldel, char *rdel, char *tag) {
  printMatrixUbr(CblasRowMajor, 1, n, v, NULL, NULL, 0.0, 0.0, wide, prec, NULL, NULL, 'V', NULL, '0', NULL, pad, ldel, rdel, "", "", tag);
} /* end func printVector */

/*------------------------------------------------------------------------------------------------------------------------------------------------------------*/
void printMatrix(const enum CBLAS_ORDER order, int n, int m, double *a, int wide, int prec, char *pad, char *ldel, char *rdel, char *lidel, char *ridel, char *tag) {
  printMatrixUbr(order, n, m, a, NULL, NULL, 0.0, 0.0, wide, prec, NULL, NULL, 'V', NULL, '0', NULL, pad, ldel, rdel, lidel, ridel, tag);
} /* end func printMatrix */

/*------------------------------------------------------------------------------------------------------------------------------------------------------------*/
void printMatrixThr(const enum CBLAS_ORDER order, int n, int m, double *a, char *inStr, char *outStr, double minIn, double maxIn, char *pad, char *ldel, char *rdel, char *lidel, char *ridel, char *tag) {
  printMatrixUbr(order, n, m, a, inStr, outStr, minIn, maxIn, 0, 0, NULL, NULL, '*', NULL, '0', NULL, pad, ldel, rdel, lidel, ridel, tag);
} /* end func printMatrixThr */

/*------------------------------------------------------------------------------------------------------------------------------------------------------------*/
void printMatrixUbr(const enum CBLAS_ORDER order, /* CBLAS row order                  */
                    int n, int m, double *a,      /* Size and array                   */
                    char *inStr, char *outStr,    /* "in" string, and "out" string    */
                    double minIn, double maxIn,   /* Min/Max values for "in" range.   */
                    int wide, int prec,           /* Width and precesion for floats   */
                    int *rowPerm, int *colPerm,   /* Permute rows i->xx[i]            */
                    char prtMode,                 /* b=bitmap, V=values, *=in/out     */
                    char *fileName,               /* if NULL, stdout.                 */
                    int maskMode,                 /* L, U, D, M-Mask, 0=NONE          */
                    char *mask,                   /* Mask (same size as a) ctrl print */
                    char *pad,                    /* Right pad string                 */
                    char *ldel, char *rdel,       /* Left and right delimiter         */
                    char *lidel, char *ridel,     /* Left and right INNER delimiter   */
                    char *tag                     /* Tag for first line               */
  ) {
  int i, j, iP, jP;
  int k, ldelLen, tagLen, cIdx, prtPerMask;
  double pVal;

  if(inStr == NULL)  inStr  = "*";
  if(outStr == NULL) outStr = " ";
  if(wide < 0)       wide   = 5;
  if(prec < 0)       prec   = 2;
  if(ldel == NULL)   ldel   = "[";
  if(ridel == NULL)  ridel  = "]";
  if(lidel == NULL)  lidel  = "[";
  if(rdel == NULL)   rdel   = "]";
  if(pad  == NULL)   pad    = " ";
  if(tag  == NULL)   tag    = "";

  ldelLen = strlen(ldel);
  tagLen = strlen(tag);
  for(j=0; j<n; j++) {
    if(j==0) 
      printf("%s%s%s%s", tag, ldel, lidel, pad);
    else {
      for(k=0;k<tagLen;k++) printf(" ");
      for(k=0;k<ldelLen;k++) printf(" ");
      printf("%s%s", lidel, pad);
    } /* end if/else */
    for(i=0; i<m; i++) {
      if(colPerm != NULL)
        iP = colPerm[i];
      else
        iP = i;
      if(rowPerm != NULL)
        jP = rowPerm[j];
      else
        jP = j;
      if(order == CblasColMajor)
        cIdx = n*iP+jP;
      else
        cIdx = m*jP+iP;
      pVal = a[cIdx];
      // Figure out what the mask has to do with printing..
      if(maskMode == '0')
        prtPerMask = 1;
      else if(maskMode == 'L')
        prtPerMask = (iP<jP);  // Row order specific!  Fix this.
      else if(maskMode == 'D')
        prtPerMask = (iP==jP);
      else if(maskMode == 'U')
        prtPerMask = (iP>jP);  // Row order specific!  Fix this.
      else if(maskMode == 'M')
        prtPerMask = mask[cIdx];
      else
        prtPerMask = 1;

      if(prtMode == '*') {
        if( prtPerMask && (pVal >= minIn) && (pVal <= maxIn) )
          printf("%s%s", inStr, pad);
        else 
          printf("%s%s", outStr, pad);
      } else {
        if(prtPerMask)
          printf("%*.*f%s", wide, prec, pVal, pad);
        else
          printf("%*s%s", wide, outStr, pad);
      } /* end if/else */
    } /* end for */
    if(j==n-1)
      printf("%s%s\n", ridel, rdel);
    else
      printf("%s\n", ridel);
  } /* end for */
} /* end func printMatrixUbr*/
