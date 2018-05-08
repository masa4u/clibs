
#include "ap.hpp"
#include "lbfgsb.h"
#include "lbfgsb.hpp"
#include "lbfgsb_common.hpp"

#include <string.h>

int lbfgsbminimize_c(
        lbfgsb_func_type funcgrad,
        int n,
        int m,
        double *xp,     // [in] [out] xp[n]
        double epsg,    // [in]
        double epsf,    // [in]
        double epsx,    // [in]
        int maxits,     // [in] max iteration number
        int * nbr,      // [in] int nbr[n]
        double *l,      // [in] double l[n]
        double *u,      // [in] double u[n]
        int *info,		// [out] int
        void* data,     // [in]
        int approx_grad) {

    int ret = 0;
    int i = 0;

    LBFGSB_REQUIRE(funcgrad != NULL, "funcgrad is NULL");
    LBFGSB_REQUIRE(xp != NULL, "xp is NULL");
    LBFGSB_REQUIRE(n > 0, "n is zero or negative value");
    LBFGSB_REQUIRE(epsg > 0 && epsf > 0 && epsx > 0, "eps value must be positive");
    LBFGSB_REQUIRE(nbr != NULL, "nbr is NULL");
    LBFGSB_REQUIRE(l != NULL, "l is NULL");
    LBFGSB_REQUIRE(u != NULL, "u is NULL");
    LBFGSB_REQUIRE(n >= m, "n >= m is required");

    ap::real_1d_array x;
    ap::real_1d_array g;
    ap::real_1d_array ub;
    ap::real_1d_array lb;
    ap::integer_1d_array nbd;

    x.setcontent(1, n, xp);
    g.setbounds(1, n);
    ub.setcontent(1, n, u);
    lb.setcontent(1, n, l);
    nbd.setcontent(1, n, nbr);

    LBFGSBFunctor func;
	if(approx_grad) {
		LBFGSB_LOG("approx_grad is true. use finite difference");
	}
    ret = func.init(funcgrad, n, approx_grad, epsx);
    LBFGSB_REQUIRE(ret == 0, "LBFGSBFunctor.init() error");

    int iInfo = 0;
    lbfgsbminimize_functor(func, n, m, x, epsg, epsf, epsx, maxits, nbd, lb, ub, iInfo, data);

    if(info != NULL)
        *info = iInfo;

	if(iInfo < 0) {
		ret = -1;
	}
    memcpy(xp, x.getcontent(), sizeof(double)*n);

FINAL:
    return ret;
}

