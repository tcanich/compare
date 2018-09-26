program cmp_test
  use mod_testing, only: assert, initialize_tests, report_tests
  use cmp_mod, only: r_eq, r_gt, r_lt, r_ge, r_le
  implicit none

  logical,dimension(:),allocatable :: tests
  logical :: test_failed
  integer :: n,norder,ntests
  integer,parameter :: stdout = 6
  
  n = 1
  ntests = 13
  call initialize_tests(tests,ntests)
  
  tests(n) = assert(r_eq(1.0,1.0) .eqv. .true., '1.0 == 1.0')
  n = n + 1
  tests(n) = assert(r_eq(1.0,2.0) .eqv. .false., '1.0 /= 2.0')
  n = n + 1
  tests(n) = assert(r_eq(1.0,1.0000000001) .eqv. .true., '1.0 == 1.0000000001')
  n = n + 1
  tests(n) = assert(r_eq(1.0,1.000001) .eqv. .false., '1.0 /= 1.000001')
  n = n + 1
  tests(n) = assert(r_ge(1.0,0.9999) .eqv. .true., '1.0 /= 0.9999')
  n = n + 1
  tests(n) = assert(r_ge(1.0,1.1) .eqv. .false., 'not 1.0 >= 1.1')
  n = n + 1
  tests(n) = assert(r_ge(1.0,1.0) .eqv. .true., '1.0 >= 1.0')
  n = n + 1
  tests(n) = assert(r_le(1.0,1.0) .eqv. .true., '1.0 <= 1.0')
  n = n + 1
  tests(n) = assert(r_le(1.0,1.00000001) .eqv. .true., '1.0 <= 1.00000001')
  n = n + 1
  tests(n) = assert(r_lt(1.0,2.0) .eqv. .true., '1.0 < 2.0')
  n = n + 1
  tests(n) = assert(r_gt(2.0,1.0) .eqv. .true., '2.0 > 1.0')
  n = n + 1
  tests(n) = assert(r_gt(2.0,1.9999999999) .eqv. .false., 'not 2.0 > 1.9999999999')
  n = n + 1
  tests(n) = assert(r_lt(1.99999999999,2.0) .eqv. .false., 'not 1.99999999999 < 2.0')
  n = n + 1

  test_failed = .false.
  call report_tests(tests,test_failed)
  if(test_failed)stop 1

end program cmp_test
