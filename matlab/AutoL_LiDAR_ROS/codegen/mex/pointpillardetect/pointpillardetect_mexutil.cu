//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// pointpillardetect_mexutil.cu
//
// Code generation for function 'pointpillardetect_mexutil'
//

// Include files
#include "pointpillardetect_mexutil.h"
#include "pointpillardetect_data.h"
#include "pointpillardetect_types.h"
#include "rt_nonfinite.h"
#include "MWCudaMemoryFunctions.hpp"
#include "stdio.h"
#include "stdlib.h"
#include "string.h"
#include <cstring>

// Function Definitions
void checkCudaError(cudaError_t errCode, const char_T *file, uint32_T b_line)
{
  if (errCode != cudaSuccess) {
    raiseCudaError(errCode, file, b_line, cudaGetErrorName(errCode),
                   cudaGetErrorString(errCode));
  }
}

void checkRunTimeError(const char_T *errMsg, const char_T *file,
                       uint32_T b_line)
{
  emlrtRTEInfo rtInfo;
  uint32_T errMsgLen;
  rtInfo = createEmlrtInfoStruct(file, b_line);
  errMsgLen = (uint32_T)strlen(errMsg);
  emlrtErrorWithMessageIdR2018a(
      emlrtRootTLSGlobal, &rtInfo, "dnn_core:cnncodegen:RunTimeError",
      "dnn_core:cnncodegen:RunTimeError", 3, mxCHAR_CLASS, errMsgLen, errMsg);
}

int64_T computeEndIdx(int64_T start, int64_T end, int64_T stride)
{
  int64_T newEnd;
  newEnd = -1L;
  if ((stride > 0L) && (start <= end)) {
    newEnd = (end - start) / stride;
  } else if ((stride < 0L) && (end <= start)) {
    newEnd = (start - end) / -stride;
  }
  return newEnd;
}

uint64_T computeNumIters(int32_T ub)
{
  uint64_T numIters;
  numIters = 0UL;
  if (ub >= 0) {
    numIters = static_cast<uint64_T>(ub + 1);
  }
  return numIters;
}

uint64_T computeNumIters(int32_T ub, int32_T b_ub)
{
  uint64_T n;
  uint64_T numIters;
  n = 0UL;
  if (ub >= 0) {
    n = static_cast<uint64_T>(ub + 1);
  }
  numIters = n;
  n = 0UL;
  if (b_ub >= 0) {
    n = static_cast<uint64_T>(b_ub + 1);
  }
  numIters *= n;
  return numIters;
}

emlrtRTEInfo createEmlrtInfoStruct(const char_T *file, uint32_T b_line)
{
  emlrtRTEInfo b_rtInfo;
  uint32_T len;
  char_T *brk;
  char_T *fn;
  char_T *pn;
  len = (uint32_T)strlen(file);
  pn = static_cast<char_T *>(calloc(len + 1U, 1U));
  fn = static_cast<char_T *>(calloc(len + 1U, 1U));
  memcpy(pn, file, len);
  memcpy(fn, file, len);
  brk = strrchr(fn, '.');
  *brk = '\x00';
  brk = strrchr(fn, '/');
  if (brk == nullptr) {
    brk = strrchr(fn, '\\');
  }
  if (brk == nullptr) {
    brk = fn;
  } else {
    brk++;
  }
  b_rtInfo.lineNo = static_cast<int32_T>(b_line);
  b_rtInfo.colNo = 0;
  b_rtInfo.fName = brk;
  b_rtInfo.pName = pn;
  return b_rtInfo;
}

void gpuEmxEnsureCapacity_boolean_T(const emxArray_boolean_T *cpu,
                                    emxArray_boolean_T *gpu,
                                    boolean_T needsCopy)
{
  int32_T i;
  int32_T totalSizeCpu;
  int32_T totalSizeGpu;
  boolean_T *newData;
  if (gpu->numDimensions == 0) {
    gpu->numDimensions = cpu->numDimensions;
    gpu->size = static_cast<int32_T *>(emlrtCallocMex(
        static_cast<uint32_T>(gpu->numDimensions), sizeof(int32_T)));
  }
  totalSizeCpu = 1;
  totalSizeGpu = 1;
  for (i = 0; i < cpu->numDimensions; i++) {
    totalSizeGpu *= gpu->size[i];
    totalSizeCpu *= cpu->size[i];
    gpu->size[i] = cpu->size[i];
  }
  if (gpu->allocatedSize < totalSizeCpu) {
    i = cpu->allocatedSize;
    if (i < totalSizeCpu) {
      i = totalSizeCpu;
    }
    checkCudaError(
        mwCudaMalloc(&newData, static_cast<uint32_T>(i) * sizeof(boolean_T)),
        __FILE__, __LINE__);
    needsCopy = (needsCopy && gpu->canFreeData);
    if (needsCopy) {
      checkCudaError(
          cudaMemcpy(newData, gpu->data,
                     static_cast<uint32_T>(totalSizeGpu) * sizeof(boolean_T),
                     cudaMemcpyDeviceToDevice),
          __FILE__, __LINE__);
    }
    if (gpu->canFreeData) {
      checkCudaError(mwCudaFree(gpu->data), __FILE__, __LINE__);
    }
    gpu->data = newData;
    gpu->allocatedSize = i;
    gpu->canFreeData = true;
  }
}

void gpuEmxEnsureCapacity_real_T(const emxArray_real_T *cpu,
                                 emxArray_real_T *gpu, boolean_T needsCopy)
{
  real_T *newData;
  int32_T i;
  int32_T totalSizeCpu;
  int32_T totalSizeGpu;
  if (gpu->numDimensions == 0) {
    gpu->numDimensions = cpu->numDimensions;
    gpu->size = static_cast<int32_T *>(emlrtCallocMex(
        static_cast<uint32_T>(gpu->numDimensions), sizeof(int32_T)));
  }
  totalSizeCpu = 1;
  totalSizeGpu = 1;
  for (i = 0; i < cpu->numDimensions; i++) {
    totalSizeGpu *= gpu->size[i];
    totalSizeCpu *= cpu->size[i];
    gpu->size[i] = cpu->size[i];
  }
  if (gpu->allocatedSize < totalSizeCpu) {
    i = cpu->allocatedSize;
    if (i < totalSizeCpu) {
      i = totalSizeCpu;
    }
    checkCudaError(
        mwCudaMalloc(&newData, static_cast<uint32_T>(i) * sizeof(real_T)),
        __FILE__, __LINE__);
    needsCopy = (needsCopy && gpu->canFreeData);
    if (needsCopy) {
      checkCudaError(
          cudaMemcpy(newData, gpu->data,
                     static_cast<uint32_T>(totalSizeGpu) * sizeof(real_T),
                     cudaMemcpyDeviceToDevice),
          __FILE__, __LINE__);
    }
    if (gpu->canFreeData) {
      checkCudaError(mwCudaFree(gpu->data), __FILE__, __LINE__);
    }
    gpu->data = newData;
    gpu->allocatedSize = i;
    gpu->canFreeData = true;
  }
}

void gpuEmxEnsureCapacity_uint8_T(const emxArray_uint8_T *cpu,
                                  emxArray_uint8_T *gpu, boolean_T needsCopy)
{
  int32_T i;
  int32_T totalSizeCpu;
  int32_T totalSizeGpu;
  uint8_T *newData;
  if (gpu->numDimensions == 0) {
    gpu->numDimensions = cpu->numDimensions;
    gpu->size = static_cast<int32_T *>(emlrtCallocMex(
        static_cast<uint32_T>(gpu->numDimensions), sizeof(int32_T)));
  }
  totalSizeCpu = 1;
  totalSizeGpu = 1;
  for (i = 0; i < cpu->numDimensions; i++) {
    totalSizeGpu *= gpu->size[i];
    totalSizeCpu *= cpu->size[i];
    gpu->size[i] = cpu->size[i];
  }
  if (gpu->allocatedSize < totalSizeCpu) {
    i = cpu->allocatedSize;
    if (i < totalSizeCpu) {
      i = totalSizeCpu;
    }
    checkCudaError(
        mwCudaMalloc(&newData, static_cast<uint32_T>(i) * sizeof(uint8_T)),
        __FILE__, __LINE__);
    needsCopy = (needsCopy && gpu->canFreeData);
    if (needsCopy) {
      checkCudaError(
          cudaMemcpy(newData, gpu->data,
                     static_cast<uint32_T>(totalSizeGpu) * sizeof(uint8_T),
                     cudaMemcpyDeviceToDevice),
          __FILE__, __LINE__);
    }
    if (gpu->canFreeData) {
      checkCudaError(mwCudaFree(gpu->data), __FILE__, __LINE__);
    }
    gpu->data = newData;
    gpu->allocatedSize = i;
    gpu->canFreeData = true;
  }
}

void gpuEmxFree_real32_T(emxArray_real32_T *gpu)
{
  if (gpu->data != (void *)4207599121UL) {
    checkCudaError(mwCudaFree(gpu->data), __FILE__, __LINE__);
  }
  emlrtFreeMex(gpu->size);
}

void gpuEmxFree_real_T(emxArray_real_T *gpu)
{
  if (gpu->data != (void *)4207599121UL) {
    checkCudaError(mwCudaFree(gpu->data), __FILE__, __LINE__);
  }
  emlrtFreeMex(gpu->size);
}

void gpuEmxFree_uint8_T(emxArray_uint8_T *gpu)
{
  if (gpu->data != (void *)4207599121UL) {
    checkCudaError(mwCudaFree(gpu->data), __FILE__, __LINE__);
  }
  emlrtFreeMex(gpu->size);
}

void gpuEmxMemcpyCpuToGpu_real_T(emxArray_real_T *gpu,
                                 const emxArray_real_T *cpu)
{
  int32_T actualSize;
  actualSize = 1;
  for (int32_T i{0}; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
  }
  checkCudaError(cudaMemcpy(gpu->data, cpu->data,
                            static_cast<uint32_T>(actualSize) * sizeof(real_T),
                            cudaMemcpyHostToDevice),
                 __FILE__, __LINE__);
}

void gpuEmxMemcpyCpuToGpu_uint8_T(emxArray_uint8_T *gpu,
                                  const emxArray_uint8_T *cpu)
{
  int32_T actualSize;
  actualSize = 1;
  for (int32_T i{0}; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
  }
  checkCudaError(cudaMemcpy(gpu->data, cpu->data,
                            static_cast<uint32_T>(actualSize) * sizeof(uint8_T),
                            cudaMemcpyHostToDevice),
                 __FILE__, __LINE__);
}

void gpuEmxMemcpyGpuToCpu_real_T(emxArray_real_T *cpu, emxArray_real_T *gpu)
{
  int32_T actualSize;
  actualSize = 1;
  for (int32_T i{0}; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
  }
  checkCudaError(cudaMemcpy(cpu->data, gpu->data,
                            static_cast<uint32_T>(actualSize) * sizeof(real_T),
                            cudaMemcpyDeviceToHost),
                 __FILE__, __LINE__);
}

void gpuEmxReset_real32_T(emxArray_real32_T *gpu)
{
  std::memset(gpu, 0, sizeof(emxArray_real32_T));
}

void gpuEmxReset_real_T(emxArray_real_T *gpu)
{
  std::memset(gpu, 0, sizeof(emxArray_real_T));
}

void gpuEmxReset_uint8_T(emxArray_uint8_T *gpu)
{
  std::memset(gpu, 0, sizeof(emxArray_uint8_T));
}

void raiseCudaError(int32_T errCode, const char_T *file, uint32_T b_line,
                    const char_T *errorName, const char_T *errorString)
{
  emlrtRTEInfo rtInfo;
  uint64_T len;
  char_T *brk;
  char_T *fn;
  char_T *pn;
  len = strlen(file);
  pn = static_cast<char_T *>(calloc(len + 1UL, 1UL));
  fn = static_cast<char_T *>(calloc(len + 1UL, 1UL));
  memcpy(pn, file, len);
  memcpy(fn, file, len);
  brk = strrchr(fn, '.');
  *brk = '\x00';
  brk = strrchr(fn, '/');
  if (brk == nullptr) {
    brk = strrchr(fn, '\\');
  }
  if (brk == nullptr) {
    brk = fn;
  } else {
    brk++;
  }
  rtInfo.lineNo = static_cast<int32_T>(b_line);
  rtInfo.colNo = 0;
  rtInfo.fName = brk;
  rtInfo.pName = pn;
  emlrtCUDAError(static_cast<uint32_T>(errCode), (char_T *)errorName,
                 (char_T *)errorString, &rtInfo, emlrtRootTLSGlobal);
}

// End of code generation (pointpillardetect_mexutil.cu)