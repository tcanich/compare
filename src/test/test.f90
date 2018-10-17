program cmp_test
  use mod_testing, only: assert, initialize_tests, report_tests
  use compare, only: eq, gt, lt, ge, le, setTol
  use iso_fortran_env, only: real32, real64
  implicit none

  logical,dimension(:),allocatable :: tests
  logical :: test_failed
  integer :: n,ntests

  real, dimension(:), allocatable :: r_alloc_arr1, r_alloc_arr2
  real, dimension(10) :: r_dim10_arr1, r_dim10_arr2
  real, dimension(5) :: r_dim5_arr1, r_dim5_arr2 

  real(kind=real64), dimension(:), allocatable :: r64_alloc_arr1, r64_alloc_arr2

  n = 1
  ntests = 36
  call initialize_tests(tests,ntests)

!
! helper function setTol test
!

  tests(n) = assert(eq(setTol(1e-8),setTol()) .eqv. .true., 'Default tolerance')
  n = n + 1
  tests(n) = assert(eq(setTol(1e-6),setTol()) .eqv. .false., 'Not equal to default tolerance')
  n = n + 1
  tests(n) = assert(eq(setTol(1e-6),setTol(0.000001)) .eqv. .true., 'Equal not default tolerance')
  n = n + 1
  tests(n) = assert(eq(setTol(1e-6),0.000001) .eqv. .true., 'Equal bare word not default tolerance')
  n = n + 1
  tests(n) = assert(eq(setTol(1e-6),1e-6) .eqv. .true., 'Equal exponent notation not default tolerance')
  n = n + 1
  
!
! Real tests
!

  tests(n) = assert(eq(1.0,1.0,1e-6) .eqv. .true., 'Real equal: 1.0 == 1.0')
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
! Real array equality tests
!
  r_dim10_arr1 = 0.0
  r_dim10_arr2 = 0.0
  r_dim5_arr1 = 0.0
  r_dim5_arr2 = 0.0
  r_alloc_arr1 = (/0.0,0.0,0.0,0.0,0.0/)
  r_alloc_arr2 = (/0.0,0.0,0.0,0.0,0.0/)

  tests(n) = assert(eq(r_alloc_arr1, r_alloc_arr2) .eqv. .true., 'Equal allocatable same size')
  n = n + 1

  r_alloc_arr2 = (/1.0,2.0,3.0/)
  tests(n) = assert(eq(r_alloc_arr1, r_alloc_arr2) .eqv. .false., 'Allocatable different size')
  n = n + 1

  tests(n) = assert(eq(r_dim10_arr1,r_dim10_arr2) .eqv. .true., 'Fixed same size')
  n = n + 1
  tests(n) = assert(eq(r_dim10_arr1, r_dim5_arr1) .eqv. .false., 'Fixed different size')
  n = n + 1
  tests(n) = assert(eq(r_dim5_arr1, r_alloc_arr1) .eqv. .true., 'Fixed and alloc same size')
  n = n + 1

  r_dim5_arr1 = 1.0
  tests(n) = assert(eq(r_dim5_arr1,r_dim5_arr2) .eqv. .false., 'Fixed same size different values')
  n = n + 1

!
! Real64 tests
!
  tests(n) = assert(eq(1.0_real64, 1.0_real64), 'Real64 equal')
  n = n + 1
  tests(n) = assert(eq(1.000000000000000000001_real64, 1.000000000000001_real64, 1e-12), 'Real64 equal tolerance')
  n = n + 1

!
! Real64 array equality tests
!
  r64_alloc_arr1 = (/1.0,0.1,0.0,0.0,0.0,0.0/)
  r64_alloc_arr2 = (/1.0,0.1,0.0,0.0,0.0,0.0/)


  

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
