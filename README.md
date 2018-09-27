[![Build Status](https://travis-ci.com/tcanich/compare.svg?branch=master)](https://travis-ci.com/tcanich/compare)

# compare

compare is a Fortran module to aid in comparison of real or complex
numbers.  The module specifies a tolerance when making the comparisons to
determine equality or inequality.  

## Usage

Arguments to functions must be of the same type (real or complex).

Tolerance is 0.00000001.

eq(X,Y) -- Logical, returns true if absolute value of X - Y is less than or equal to tolerance.

gt(X,Y) -- Logical, returns true if X - Y is greater than tolerance.

lt(X,Y) -- Logical, returns true if Y - X is greater than tolerance.

ge(X,Y) -- Logical, returns true if either eq(X,Y) or gt(X,Y) is true.

le(X,Y) -- Logical, returns true if either eq(X,Y) or lt(X,Y) is true.


```
program test_cmp
  use cmp_mod, only: eq, ge, le, gt, lt
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

## Status

Real and complex number comparison is implemented.
