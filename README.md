[![Build Status](https://travis-ci.com/tcanich/compare.svg?branch=master)](https://travis-ci.com/tcanich/compare)

# compare

compare is a Fortran module to aid in comparison of real or complex
numbers.  The module specifies a tolerance when making the comparisons to
determine equality or inequality.  


## Usage

Arguments to functions must be of the same type (real or complex).

Default tolerance is 1e-8.

```
eq(X,Y,[t]) -- Logical 
  X: real or complex
  Y: real or complex
  t: optional, real

  Returns true if absolute value of (X - Y) is less than or equal to
  tolerance.  Optional value t sets tolerance, otherwise 1e-8 is used.

gt(X,Y,[t]) -- Logical 

  Returns true if X - Y is greater than tolerance.

lt(X,Y,[t]) -- Logical 

  Returns true if Y - X is greater than tolerance.

ge(X,Y,[t]) -- Logical 

  Returns true if either eq(X,Y) or gt(X,Y) is true.

le(X,Y,[t]) -- Logical 

  Returns true if either eq(X,Y) or lt(X,Y) is true.

setTol([t]) -- Real

  Returns tolerance, t, or default tolerance 1e-6.

```


```
program test_cmp
  use compare, only: eq
  implicit none

  complex :: z1, z2
  real :: r1, r2

  z1 = (1.0,0.0)
  z2 = (0.9999999,0.0)

  r1 = 1.0
  r2 = 0.99999999

  if (eq(z1,z2)) then
    write(*,*) 'Complex equal'
  else
    write(*,*) 'Complex not equal'
  end if

  if (eq(r1,r2)) then
    write(*,*) 'Real equal'
  else
    write(*,*) 'Real not equal'
  end if

end program test_cmp
```

Execution produces

```
./test_cmp
Complex equal
Real equal
```

## Installation

compare is developed with gfortran 7.3.0 and built with CMake.  


## Status

Real and complex number comparison is implemented.  Same size arrays of
real numbers may be compared for equality.
