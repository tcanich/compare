module compare
  use iso_fortran_env, only: real32, real64
  implicit none
  private
  public :: eq, gt, lt, ge, le, setTol

  real, parameter, private :: tolerance = 1e-8

! Provide functions to compare real and complex variables within a
! tolerance value, tolerance.

  interface eq
    module procedure r_eq
    module procedure z_eq
    module procedure r64_eq
    module procedure r_eq_arr
    module procedure r64_eq_arr
  end interface eq

  interface gt
    module procedure r_gt
    module procedure z_gt
  end interface gt

  interface lt
    module procedure r_lt
    module procedure z_lt
  end interface lt

  interface ge
    module procedure r_ge
    module procedure z_ge
  end interface ge

  interface le
    module procedure r_le
    module procedure z_le
  end interface le

contains

  real pure function setTol (t)
    real, intent(in), optional :: t
    real, parameter :: tolerance = 1e-8

    if (present(t)) then
      setTol = t
    else 
      setTol = tolerance
    end if
  end function setTol

  logical pure function r_eq (r1, r2, t)
    real, intent(in) :: r1, r2
    real, intent(in), optional :: t

    if (abs(r1 - r2) <= setTol(t)) then
      r_eq = .true.
    else
      r_eq = .false.
    end if
  end function r_eq

  logical pure function r64_eq (r1, r2, t)
    real(kind=real64), intent(in) :: r1, r2
    real, intent(in), optional :: t

    if (abs(r1 - r2) <= setTol(t)) then
      r64_eq = .true.
    else
      r64_eq = .false.
    end if
  end function r64_eq

  logical pure function z_eq (z1, z2, t)
    complex, intent(in) :: z1, z2
    real, intent(in), optional :: t

    if (abs(z1 - z2) <= setTol(t)) then
      z_eq = .true.
    else
      z_eq = .false.
    end if
  end function z_eq

  logical pure function r_eq_arr (r1,r2,t)
    real, dimension(:), intent(in) :: r1, r2
    real, intent(in), optional :: t
    integer :: i

    r_eq_arr = .false.

    if (size(r1) /= size(r2)) then
      return
    else
      do i = 1, size(r1)
        if (eq(r1(i),r2(i),setTol(t))) then
          r_eq_arr = .true.
        else
          r_eq_arr = .false.
          return
        end if
      end do
    end if
  end function r_eq_arr

  logical pure function r64_eq_arr (r1,r2,t)
    real(kind=real64), dimension(:), intent(in) :: r1, r2
    real, intent(in), optional :: t
    integer :: i

    r64_eq_arr = .false.

    if (size(r1) /= size(r2)) then
      return
    else
      do i = 1, size(r1)
        if (eq(r1(i),r2(i),setTol(t))) then
          r64_eq_arr = .true.
        else
          r64_eq_arr = .false.
          return
        end if
      end do
    end if
  end function r64_eq_arr

  logical pure function r_gt (r1, r2, t)
    real, intent(in) :: r1, r2
    real, intent(in), optional :: t

    if ((r1 - r2) > setTol(t)) then
      r_gt = .true.
    else
      r_gt = .false.
    end if
  end function r_gt

  logical pure function z_gt (z1, z2, t)
    complex, intent(in) :: z1, z2
    real, intent(in), optional :: t

    if ((real(z1) - real(z2)) > setTol(t)) then
      z_gt = .true.
    else
      z_gt = .false.
    end if
  end function z_gt

  logical pure function r_lt (r1, r2, t)
    real, intent(in) :: r1, r2
    real, intent(in), optional :: t

    if ((r2 - r1) > setTol(t)) then
      r_lt = .true.
    else
      r_lt = .false.
    end if
  end function r_lt

  logical pure function z_lt (z1, z2, t)
    complex, intent(in) :: z1, z2
    real, intent(in), optional :: t

    if ((real(z2) - real(z1)) > setTol(t)) then
      z_lt = .true.
    else
      z_lt = .false.
    end if
  end function z_lt

  logical pure function r_ge (r1, r2, t)
    real, intent(in) :: r1, r2
    real, intent(in), optional :: t

    if (r_eq(r1,r2, setTol(t)) .or. r_gt(r1,r2, setTol(t))) then
      r_ge = .true.
    else
      r_ge = .false.
    end if
  end function r_ge

  logical pure function z_ge (z1, z2, t)
    complex, intent(in) :: z1, z2
    real, intent(in), optional :: t

    if (z_eq(z1,z2,setTol(t)) .or. z_gt(z1,z2,setTol(t))) then
      z_ge = .true.
    else
      z_ge = .false.
    end if
  end function z_ge

  logical pure function r_le (r1, r2, t)
    real, intent(in) :: r1, r2
    real, intent(in), optional :: t
    
    if (r_eq(r1,r2,setTol(t)) .or. r_lt(r1,r2,setTol(t))) then
      r_le = .true.
    else
      r_le = .false.
    end if
  end function r_le

  logical pure function z_le (z1, z2, t)
    complex, intent(in) :: z1, z2
    real, intent(in), optional :: t
    
    if (z_eq(z1,z2,setTol(t)) .or. z_lt(z1,z2,setTol(t))) then
      z_le = .true.
    else
      z_le = .false.
    end if
  end function z_le

end module compare

 
