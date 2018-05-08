// ==============================================
// (C) Copyright Pricing Partners - 2005 
//
/// \file
/// \brief lbfgs classes
/// \author Quantitative Research Team
/// \date October 2007
/// \note (C) Copyright Pricing Partners - 2005, under Pricing Partners Software license
//
//  Use, modification and distribution are subject to the 
//  Pricing Partners Software license (See accompanying file)
// ==============================================

#ifndef __LBFGSB_HPP__
#define __LBFGSB_HPP__

#include "ap.hpp"
#include "lbfgsb.h"
#include "lbfgsb_common.hpp"

//#include "../../../calibration/model_fitter/optimisend.h"


/*-----------------------------------------------
This routines must be defined by you:
-----------------------------------------------*/


/*************************************************************************
The  subroutine  minimizes  the  function  F(x) of N arguments with simple
constraints using a quasi-Newton method (LBFGS scheme) which is  optimized
to use a minimum amount of memory.

The subroutine generates the approximation of an inverse Hessian matrix by
using information about the last M steps of the algorithm (instead  of N).
It lessens a required amount of memory from a value  of  order  N^2  to  a
value of order 2*N*M.

This subroutine uses the FuncGrad subroutine which calculates the value of
the function F and gradient G in point X. The programmer should define the
FuncGrad subroutine by himself.  It should be noted  that  the  subroutine
doesn't need to waste  time for memory allocation of array G, because  the
memory is allocated in calling the  subroutine.  Setting  a  dimension  of
array G each time when calling a subroutine will excessively slow down  an
algorithm.

The programmer could also redefine the LBFGSNewIteration subroutine  which
is called on each new step. The current point X, the function value F  and
the gradient G are passed  into  this  subroutine.  It  is  reasonable  to
redefine the subroutine for better debugging, for  example,  to  visualize
the solution process.

Input parameters:
    N       -   problem dimension. N>0
    M       -   number of  corrections  in  the  BFGS  scheme  of  Hessian
                approximation  update.  Recommended value:  3<=M<=7.   The
                smaller value causes worse convergence,  the  bigger  will
                not  cause  a  considerably  better  convergence, but will
                cause a fall in the performance. M<=N.
    X       -   initial solution approximation.
                Array whose index ranges from 1 to N.
    EpsG    -   positive number which defines a precision of  search.  The
                subroutine finishes its work if the condition ||G|| < EpsG
                is satisfied, where ||.|| means Euclidian norm, G - gradient
                projection onto a feasible set, X - current approximation.
    EpsF    -   positive number which defines a precision of  search.  The
                subroutine  finishes  its  work if on iteration number k+1
                the condition |F(k+1)-F(k)| <= EpsF*max{|F(k)|, |F(k+1)|, 1}
                is satisfied.
    EpsX    -   positive number which defines a precision of  search.  The
                subroutine  finishes  its  work if on iteration number k+1
                the condition |X(k+1)-X(k)| <= EpsX is satisfied.
    MaxIts  -   maximum number of iterations.
                If MaxIts=0, the number of iterations is unlimited.
    NBD     -   constraint type. If NBD(i) is equal to:
                * 0, X(i) has no constraints,
                * 1, X(i) has only lower boundary,
                * 2, X(i) has both lower and upper boundaries,
                * 3, X(i) has only upper boundary,
                Array whose index ranges from 1 to N.
    L       -   lower boundaries of X(i) variables.
                Array whose index ranges from 1 to N.
    U       -   upper boundaries of X(i) variables.
                Array whose index ranges from 1 to N.

Output parameters:
    X       -   solution approximation.
Array whose index ranges from 1 to N.
    Info    -   a return code:
                    * -2 unknown internal error,
                    * -1 wrong parameters were specified,
                    * 0 interrupted by user,
                    * 1 relative function decreasing is less or equal to EpsF,
                    * 2 step is less or equal to EpsX,
                    * 4 gradient norm is less or equal to EpsG,
                    * 5 number of iterations exceeds MaxIts.

FuncGrad routine description. User-defined.
Input parameters:
    X   -   array whose index ranges from 1 to N.
Output parameters:
    F   -   function value at X.
    G   -   function gradient.
            Array whose index ranges from 1 to N.
The memory for array G has already been allocated in the calling subroutine,
and it isn't necessary to allocate it in the FuncGrad subroutine.

    NEOS, November 1994. (Latest revision June 1996.)
    Optimization Technology Center.
    Argonne National Laboratory and Northwestern University.

    Written by Ciyou Zhu in collaboration with
    R.H. Byrd, P. Lu-Chen and J. Nocedal.
	Modified by Wang on May 02, 2007
*************************************************************************/
void lbfgsbminimize(
	 void (*funcgrad)(const ap::real_1d_array& x, double& f, ap::real_1d_array& g, int n, void* data),
	 const int& n,
     const int& m,
     ap::real_1d_array& x,
     const double& epsg,
     const double& epsf,
     const double& epsx,
     const int& maxits,
     const ap::integer_1d_array& nbd,
     const ap::real_1d_array& l,
     const ap::real_1d_array& u,
     int& info,
	 void* data
	 );


/** 
 * @brief Wrapper class
 * @author Kyunghwan Kim
 */
class LBFGSBFunctor {
    public:
        LBFGSBFunctor() : object_function_(NULL), approx_grad_(0), epsilon_(1e-8), n_(0) {};

		// lbfgsb_func_type is defiend in lbfgsb.h
        int init(lbfgsb_func_type object_function, int n, int approx_grad=1, double epsilon=1e-8) {
            object_function_ = object_function;
            approx_grad_ = approx_grad;
            epsilon_ = epsilon;
            if(approx_grad_ && epsilon_ <= 0.0) {
                LBFGSB_LOG("approx_gras is true but epsilon is non-positive");
                return -1;
            }
            if(approx_grad_ ) {
                if(n <= 0) {
                    LBFGSB_LOG("n is not positive");
                    return -1;
                }
                grad_.setbounds(1, n);
            }
			return 0;
        }

        inline void operator()(ap::real_1d_array& x,
                        double& f,
                        ap::real_1d_array& g,
                        int n,
                        void* data) {
			this->object_function_((double*)x.getcontent(), &f, g.getcontent(), n, data);
            if(approx_grad_) {
                double fadv = 0.0;
                for(int i = 1; i <= n; i++) {
                    x(i) += epsilon_;
                    this->object_function_((double*)x.getcontent(), &fadv, g.getcontent(), n, data);
					x(i) -= epsilon_;
                    grad_(i) = (fadv - f)/epsilon_;
                }
                memcpy(g.getcontent(), grad_.getcontent(), sizeof(double)*n);
            }
		}
    private:
        lbfgsb_func_type object_function_;
        int n_;
		ap::real_1d_array grad_;
        int approx_grad_;
        double epsilon_;
};

/**
 * same routine with lbfgsbminimize
 */
void lbfgsbminimize_functor(
     LBFGSBFunctor& funcgrad,
	 const int& n,
     const int& m,
     ap::real_1d_array& x,
     const double& epsg,
     const double& epsf,
     const double& epsx,
     const int& maxits,
     const ap::integer_1d_array& nbd,
     const ap::real_1d_array& l,
     const ap::real_1d_array& u,
     int& info,
	 void* data
	 );

#endif
