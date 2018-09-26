module cmp_mod
  implicit none
  private
  public :: r_eq, r_gt, r_lt, r_ge, r_le

! Provide functions to compare real and complex variables within a
! tolerance value, tolerance.

! r_eq, r_gt, r_lt, r_ge, r_le
! c_eq, c_gt, c_lt, c_ge, c_le

  real, parameter :: tolerance = 0.00000001

contains

  logical pure function r_eq (r1, r2)
    real, intent(in) :: r1, r2

    if (abs(r1 - r2) <= tolerance) then
      r_eq = .true.
    else
      r_eq = .false.
    end if
  end function r_eq

  logical pure function r_gt (r1, r2)
    real, intent(in) :: r1, r2

    if ((r1 - r2) > tolerance) then
      r_gt = .true.
    else
      r_gt = .false.
    end if
  end function r_gt

  logical pure function r_lt (r1, r2)
    real, intent(in) :: r1, r2

    if ((r2 - r1) > tolerance) then
      r_lt = .true.
    else
      r_lt = .false.
    end if
  end function r_lt

  logical pure function r_ge (r1, r2)
    real, intent(in) :: r1, r2

    if (r_eq(r1,r2) .or. r_gt(r1,r2)) then
      r_ge = .true.
    else
      r_ge = .false.
    end if
  end function r_ge

  logical pure function r_le (r1, r2)
    real, intent(in) :: r1, r2
    
    if (r_eq(r1,r2) .or. r_lt(r1,r2)) then
      r_le = .true.
    else
      r_le = .false.
    end if
  end function r_le

end module cmp_mod

 
