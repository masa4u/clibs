#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

#include "lbfgsb.h"


typedef struct _lbfgsb_param {
    double value;
	double result;
} lbfgsb_param;


static void target_func(double* x, double * f, double *g, int n, void* data) {
	static int iterno = 0;
    lbfgsb_param *param = (lbfgsb_param*)data;
	double target = param->value;
	double x_value = x[0];

	// calculate gradient
	g[0] = -cos(x_value);
	param->result = x_value;
    *f = (sin(x_value) - target)/target * 10000;
	*f = pow(*f, 2);
	printf("[%d] x_value = %f\tf = %e\tg = %f\n", iterno, x_value, f, g[0]);
	iterno++;
}

#define N 1
#define PI 3.1415926535897931159979634685441851615906

void test_root_finding_main() {
    const int n = 1;

    double x[] = {0.5};

	int nbd[] = {NBD_BOUNDARY_LU};
	double lb[] = {-1.0};
    double ub[] = { 2.0};

    int info = 0;
    int maxits = 1000;

	double epsg, epsf, epsx;
	double precision = 10e-12;

    int m = 1;

	lbfgsb_param param;
	memset(&param, 0x00, sizeof(param));

	printf("simple root finding\n");

	epsg = 1e-5;
	epsg = epsf = epsx = precision;

	printf("debug x = %f\n", x[0]);
	
    param.value = 1.0;

	lbfgsbminimize_c(target_func, n, m, x, epsg, epsf, epsx, maxits, nbd, lb, ub, &info, &param, 1);

	//printf("calibration status = %s\n", str_info(info).c_str());

	printf("sol = %.20f\n", x[0]);
	printf("relative_error = %.20f %%\n", (x[0]/PI*2 - 1.0)*100);

};
