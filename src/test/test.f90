program cmp_test
  use mod_testing, only: assert, initialize_tests, report_tests
  use compare, only: eq, gt, lt, ge, le
  implicit none

  logical,dimension(:),allocatable :: tests
  logical :: test_failed
  integer :: n,ntests
  
  n = 1
  ntests = 23
  call initialize_tests(tests,ntests)
  
!
! Real tests
!

  tests(n) = assert(eq(1.0,1.0) .eqv. .true., 'Real equal: 1.0 == 1.0')
  n = n + 1
  tests(n) = assert(eq(1.0,2.0) .eqv. .false., 'Real not equal: 1.0 /= 2.0')
  n = n + 1
  tests(n) = assert(eq(1.0,1.0000000001) .eqv. .true., 'Real not equal in tolerance: 1.0 == 1.0000000001')
  n = n + 1
  tests(n) = assert(eq(1.0,1.000001) .eqv. .false., 'Real not equal out of tolerance: 1.0 /= 1.000001')
  n = n + 1
  tests(n) = assert(ge(1.0,0.9999) .eqv. .true., 'Real greater/equal out of tolerance: 1.0 /= 0.9999')
  n = n + 1
  tests(n) = assert(ge(1.0,1.1) .eqv. .false., 'Real not greater/equal: 1.0 >= 1.1')
  n = n + 1
  tests(n) = assert(ge(1.0,1.0) .eqv. .true., 'Real greater/equal equal: 1.0 >= 1.0')
  n = n + 1
  tests(n) = assert(le(1.0,1.0) .eqv. .true., 'Real less/equal equal: 1.0 <= 1.0')
  n = n + 1
  tests(n) = assert(le(1.0,1.00000001) .eqv. .true., 'Real less/equal in tolerance: 1.0 <= 1.00000001')
  n = n + 1
  tests(n) = assert(lt(1.0,2.0) .eqv. .true., 'Real less: 1.0 < 2.0')
  n = n + 1
  tests(n) = assert(gt(2.0,1.0) .eqv. .true., 'Real greater: 2.0 > 1.0')
  n = n + 1
  tests(n) = assert(gt(2.0,1.9999999999) .eqv. .false., 'Real not greater in tolerance: 2.0 > 1.9999999999')
  n = n + 1
  tests(n) = assert(lt(1.99999999999,2.0) .eqv. .false., 'Real not less in tolerance: 1.99999999999 < 2.0')
  n = n + 1

!
! Complex tests
!

  tests(n) = assert(eq((1.0,0.0),(1.0,0.0)) .eqv. .true., 'Complex equal: (1.0,0.0) == (1.0,0.0)')
  n = n + 1
  tests(n) = assert(.not. eq((1.0,0.0),(0.0,-1.0)) .eqv. .true., 'Complex not equal: (1.0,0.0) /= (0.0,-1.0)')
  n = n + 1
  tests(n) = assert(gt((1.0,0.0),(0.0,-1.0)) .eqv. .true., 'Complex greater: (1.0,0.0) > (0.0,-1.0)')
  n = n + 1
  tests(n) = assert(gt((1.0,0.0),(0.99999999,0.0)) .eqv. .false., 'Complex not greater: (1.0,0.0) /> (0.999999999,0.0)')
  n = n + 1
  tests(n) = assert(lt((1.0,0.0),(1.5,0.0)) .eqv. .true., 'Complex less: (1.0,0.0) < (1.5,0.0)')
  n = n + 1
  tests(n) = assert(ge((1.0,0.0),(0.1,0.0)) .eqv. .true., 'Complex greater/equal: (1.0,0.0) >= (0.1,0.0)')
  n = n + 1
  tests(n) = assert(ge((1.0,0.0),(0.99999999,0.0)) .eqv. .true., 'Complex greater/equal: (1.0,0.0) >= (0.999999999,0.0)')
  n = n + 1
  tests(n) = assert(le((1.0,0.0),(2.0,0.0)) .eqv. .true., 'Complex less/equal: (1.0,0.0) <= (2.0,0.0)')
  n = n + 1
  tests(n) = assert(le((1.0,0.0),(0.99999999,0.0)) .eqv. .true., 'Complex less/equal: (1.0,0.0) <= (0.999999999,0.0)')
  n = n + 1
  tests(n) = assert(le((2.0,0.0),(1.0,0.0)) .eqv. .false., 'Complex not less/equal: (2.0,0.0) <= (1.0,0.0)')
  n = n + 1

  test_failed = .false.
  call report_tests(tests,test_failed)
  if(test_failed)stop 1

end program cmp_test
