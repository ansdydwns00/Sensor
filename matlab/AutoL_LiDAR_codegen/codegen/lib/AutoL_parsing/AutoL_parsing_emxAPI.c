/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 * File: AutoL_parsing_emxAPI.c
 *
 * MATLAB Coder version            : 23.2
 * C/C++ source code generated on  : 06-May-2024 17:18:15
 */

/* Include Files */
#include "AutoL_parsing_emxAPI.h"
#include "AutoL_parsing_emxutil.h"
#include "AutoL_parsing_types.h"
#include <stdlib.h>

/* Function Definitions */
/*
 * Arguments    : int numDimensions
 *                const int *size
 * Return Type  : emxArray_real_T *
 */
emxArray_real_T *emxCreateND_real_T(int numDimensions, const int *size)
{
  emxArray_real_T *emx;
  int b_i;
  int numEl;
  emxInit_real_T(&emx, numDimensions);
  numEl = 1;
  for (b_i = 0; b_i < numDimensions; b_i++) {
    numEl *= size[b_i];
    emx->size[b_i] = size[b_i];
  }
  emx->data = (double *)malloc((unsigned int)numEl * sizeof(double));
  emx->numDimensions = numDimensions;
  emx->allocatedSize = numEl;
  return emx;
}

/*
 * Arguments    : double *data
 *                int numDimensions
 *                const int *size
 * Return Type  : emxArray_real_T *
 */
emxArray_real_T *emxCreateWrapperND_real_T(double *data, int numDimensions,
                                           const int *size)
{
  emxArray_real_T *emx;
  int b_i;
  int numEl;
  emxInit_real_T(&emx, numDimensions);
  numEl = 1;
  for (b_i = 0; b_i < numDimensions; b_i++) {
    numEl *= size[b_i];
    emx->size[b_i] = size[b_i];
  }
  emx->data = data;
  emx->numDimensions = numDimensions;
  emx->allocatedSize = numEl;
  emx->canFreeData = false;
  return emx;
}

/*
 * Arguments    : double *data
 *                int rows
 *                int cols
 * Return Type  : emxArray_real_T *
 */
emxArray_real_T *emxCreateWrapper_real_T(double *data, int rows, int cols)
{
  emxArray_real_T *emx;
  emxInit_real_T(&emx, 2);
  emx->size[0] = rows;
  emx->size[1] = cols;
  emx->data = data;
  emx->numDimensions = 2;
  emx->allocatedSize = rows * cols;
  emx->canFreeData = false;
  return emx;
}

/*
 * Arguments    : int rows
 *                int cols
 * Return Type  : emxArray_real_T *
 */
emxArray_real_T *emxCreate_real_T(int rows, int cols)
{
  emxArray_real_T *emx;
  int numEl;
  emxInit_real_T(&emx, 2);
  emx->size[0] = rows;
  numEl = rows * cols;
  emx->size[1] = cols;
  emx->data = (double *)malloc((unsigned int)numEl * sizeof(double));
  emx->numDimensions = 2;
  emx->allocatedSize = numEl;
  return emx;
}

/*
 * Arguments    : emxArray_real_T *emxArray
 * Return Type  : void
 */
void emxDestroyArray_real_T(emxArray_real_T *emxArray)
{
  emxFree_real_T(&emxArray);
}

/*
 * Arguments    : emxArray_real_T **pEmxArray
 *                int numDimensions
 * Return Type  : void
 */
void emxInitArray_real_T(emxArray_real_T **pEmxArray, int numDimensions)
{
  emxInit_real_T(pEmxArray, numDimensions);
}

/*
 * File trailer for AutoL_parsing_emxAPI.c
 *
 * [EOF]
 */
