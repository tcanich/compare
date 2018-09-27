# compare

compare is a Fortran module to aid in comparison of real or complex
numbers.  The module specifies a tolerance when making the comparisons to
determine equality or inequality.  

## Usage

Arguments to functions must be of the same type (real or complex).

```
program test_cmp
  use cmp_mod, only: eq, ge, le, gt, lt
  implicit none


  real :: foo, bar

  foo = 1.0
  bar = 0.99999999

  if (eq(foo,bar)) then
    write(*,*) 'Equal'
  else
    write(*,*) 'Not equal'
  end if

end program test_cmp
```

Execution produces

```
./test_cmp
 Equal
```

## Status

Real and complex number comparison is implemented.
