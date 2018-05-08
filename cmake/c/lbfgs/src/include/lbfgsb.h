#ifndef __LBFGSB_H__
#define __LBFGSB_H__

#include <stdio.h>

#ifdef __cplusplus
extern "C" {
#endif

#define LBFGSB_DEBUG_ENABLE 1

typedef enum _nbd_value_type {
	NBD_BOUNDARY_NONE,	// no constraints
	NBD_BOUNDARY_L,		// only lower boundary
	NBD_BOUNDARY_LU,	// both lower and upper boundaries
	NBD_BOUNDARY_U		// only upper boundary
} nbd_value_type;

void print_info(int info, FILE* fp);

typedef void (*lbfgsb_func_type)(double* x, double* f, double* g, int n, void* data);

int lbfgsbminimize_c(
        lbfgsb_func_type funcgrad,
        int n,
        int m,
		double *xp,
        double epsg,    // [in]
        double epsf,    // [in]
        double epsx,    // [in]
        int maxits,     // [in] max iteration number
        int * nbr,      // [in] int nbr[n]
        double *l,      // [in] double l[n]
        double *u,      // [in] double u[n]
        int *info,		// [out] int
        void* data,		// [in]
        int approx_grad // [in] 0: calc grad by funcgrad(default), 1: calc grad by finite difference(epsilon=epsx)
		);

#ifdef __cplusplus
}
#endif

#endif  //__LBFGSB_H__
