## init git repo automatically
```
git submodule init

git submodule update --recursive --remote
```
## c/cpp library for quant

 * c/c++ libraries
   * blas, f2c, gsl, gslcblas, lapack, lbfgs, lets be rational, levmar

 * utility
   * bison/flex

## build
 * windows(vs2015)
 * linux(ubuntu)

```bash
$ cmake --build . --target ALL_BUILD --config Release
```
