#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "lbfgsb.h"

/**
 * p : [a, b, m, s, r]
 * x : log forward moneyness
 */
double svi(double *p, double x) {
	double xm = x - p[2];
	double s  = p[3];
	return p[0] + p[1]*(p[4]*xm + sqrt(xm*xm + s*s));
}

typedef struct _lbfgsb_param {
	double * log_moneyness;
	double * quotes;
	double T;
	int moneyness_size;
} lbfgsb_param;

double user_min(double x, double y) {
    if(x < y)
        return x;
    return y;
}

double user_max(double x, double y) {
	if(x > y)
		return x;
	return y;
}

static void target_func(double* p, double *f, double* g, int n, void* data) {
	int i;
	lbfgsb_param *param = (lbfgsb_param*)data;
	double weight = 0, error = 0, consts = 0.0, consts2 = 0.0;
	double sum = 0.0;

	for(i = 0; i < param->moneyness_size; i++) {
		double x = param->log_moneyness[i];
		double sig = param->quotes[i];
		double var_vec = sig*sig;
		double var_cal = svi(p, x);
		error += exp(x*3.0) * pow(var_cal - var_vec, 2);
		consts += user_min(var_cal, 0.0) * -0.1;
	}
	// calculate constraints 1
	consts = exp(user_max(p[1] * (1.0 + fabs(p[4])) * param->T - 4.0, 0.0) ) - 1.0;
	consts2= exp(consts) - 1.0;
	*f = error + consts + consts2;
}

#define N 5
#define STRIKE_SIZE 17

void test_svi_main() {

	int i;
	const int strike_size = 17;
	const int n = 5;

	double x[N] = {0.05, 0.1, 0, 0.1, -0.5};
	double moneyness[STRIKE_SIZE] = {0.40, 0.45, 0.50, 0.55, 0.60, 0.65, 0.70, 0.75, 0.80, 0.85, 0.90, 0.95, 1.00, 1.05, 1.10, 1.15, 1.20};
	double log_moneyness[STRIKE_SIZE];
	double quotes[STRIKE_SIZE] = {38.4, 36.3, 34.4, 32.6, 31.0, 29.5, 28.1, 26.8, 25.6, 24.4, 23.3, 22.3, 21.4, 20.6, 19.8, 19.2, 18.7};

	int nbd[] = {NBD_BOUNDARY_L, NBD_BOUNDARY_L, NBD_BOUNDARY_NONE, NBD_BOUNDARY_L, NBD_BOUNDARY_LU};
	double lb[] = {-0.5, 0, 0, 0, -0.75};
	double ub[] = {0, 0, 0, 0, -0.25};
	int info = 0;
	int maxits = 15000;
	
	double epsg, epsf, epsx;
	double precision = 10e-12;
	double g[N];
	int m = 5;

	lbfgsb_param param;
	memset(&param, 0x00, sizeof(param));

	printf("svi test\n");

	for(i = 0; i < strike_size; i++) quotes[i] /= 100.0;

	memset(log_moneyness, 0x00, sizeof(double)*strike_size);

	for(i = 0; i < strike_size; i++) log_moneyness[i] = log(moneyness[i]);

	epsg = epsf = epsx = precision;
	memset(g, 0x00, sizeof(double)*n);

	param.log_moneyness = log_moneyness;
	param.quotes = quotes;
	param.moneyness_size = strike_size;
	param.T = 1.0;

	lbfgsbminimize_c(target_func, n, m, x, epsg, epsf, epsx, maxits, nbd, lb, ub, &info, &param, 1);

	printf("a = %f\n", x[0]);
	printf("b = %f\n", x[1]);
	printf("m = %f\n", x[2]);
	printf("s = %f\n", x[3]);
	printf("r = %f\n", x[4]);
	
}
