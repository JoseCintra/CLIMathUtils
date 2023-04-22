!***************************************************************************************
! Command Line Math Utilities
!***************************************************************************************
!
! Name:     tcal_lib (Triangle Calculator Library)
! Version:  1.06.0 - May,2023
! Topic:    Plane Geometry
! Purpose:  Set of functions for calculating triangle elements
! Language: Fortran
! Author:   José Cintra
! Web Site: https://github.com/JoseCintra/CLIMathUtils
! License:  Unlicense, described in http://unlicense.org
!
!***************************************************************************************

MODULE tcal_lib

   ! General base types and functions for tcal
   implicit none
   real, parameter  :: pi = 3.14159265 !358979323846
   real, parameter  :: deg2rad = pi/180.0
   real, parameter  :: rad2deg = 180.0/pi

CONTAINS

   !*******************
   ! Function is_triangle
   ! Determines whether a triangle is valid by the triangle inequality theorem:
   ! In a triangle, the length of each side is less than the sum of the other two sides
   !***********************************************************************************/
   pure function is_triangle(a, b, c) result(ret_val)
      implicit none
      real, intent(in) :: a, b, c
      logical ret_val
      ret_val = .false.
      if (a .gt. 0 .and. b .gt. 0 .and. c .gt. 0) then
         ret_val = (a .lt. (b + c) .and. b .lt. (a + c) .and. c .lt. (a + b))
      end if
   end function is_triangle

   !**********************
   ! Function getPerimeter
   ! Calculates the perimeter of the triangle with sides ABC
   !***********************************************************************************/
   pure function get_perimeter(a, b, c) result(ret_val)
      implicit none
      real, intent(in) :: a, b, c
      real ret_val
      ret_val = a + b + c
   end function get_perimeter

   !********************
   ! Function get_angles
   ! Calculates triangle angles using the law of cosines.
   ! It also calculates the exterior angles and stores them in the same array
   !************************************************************************/
   pure function get_angles(a, b, c) result(ret_val)
      implicit none
      real, intent(in) :: a, b, c
      real :: ret_val(6)
      ret_val(1) = acos(((b*b + c*c - a*a)/(2.0*b*c)))*rad2deg
      ret_val(2) = acos(((a*a + c*c - b*b)/(2.0*a*c)))*rad2deg
      ret_val(3) = acos(((a*a + b*b - c*c)/(2.0*a*b)))*rad2deg
      ret_val(4) = 180.0 - ret_val(1)
      ret_val(5) = 180.0 - ret_val(2)
      ret_val(6) = 180.0 - ret_val(3)
   end function get_angles

   !************************
   ! Function get_type_by_side
   ! Determines the type of the triangle, according to its sides
   !*************************************************************/
   function get_type_by_side(a, b, c) result(ret_val)
      implicit none
      real, intent(in) :: a, b, c
      character(len=11) :: ret_val
      ret_val = "Isosceles";
      if (a .eq. b .and. b .eq. c) then
         ret_val = "Equilateral";
      else if (a .ne. b .and. b .ne. c) then
         ret_val = "Scalene";
      end if
   end function get_type_by_side

   !***************************
   ! Function get_type_by_angle
   ! Determines the type of the triangle, according to its angles
   !*************************************************************/
   function get_type_by_angle(a, b, c) result(ret_val)
      implicit none
      real, intent(in) :: a, b, c
      character(len=6) :: ret_val
      real :: angles(6)
      real :: aa, ab, ac
      angles = get_angles(a, b, c) ! Get the angles
      aa = angles(1) ! Angle A
      ab = angles(2) ! Angle B
      ac = angles(3) ! Angle C
      ret_val = "Acute"
      if ((aa .eq. 90.0) .or. (ab .eq. 90.0) .or. (ac .eq. 90.0)) then
         ret_val = "Rigth"
      else if ((aa .gt. 90.0) .or. (ab .gt. 90.0) .or. (ac .gt. 90.0)) then
         ret_val = "Obtuse"
      end if

   end function get_type_by_angle

   !***************************
   ! Function get_area_by_heron
   ! Claculates the triangle area by Herons's formula
   !*************************************************
   pure function get_area_by_heron(a, b, c) result(ret_val)
      implicit none
      real, intent(in) :: a, b, c
      real ret_val
      real sp
      sp = get_perimeter(a, b, c)/2.0 ! semiperimeter
      ret_val = sqrt(sp*(sp - a)*(sp - b)*(sp - c))
   end function get_area_by_heron

   !***************************
   ! Function get_area_by_height
   ! Calculates the area of the triangle by the height formula
   !*************************************************
   pure function get_area_by_height(a, b, c) result(ret_val)
      implicit none
      real, intent(in) :: a, b, c
      real ret_val
      real h(3)
      h = get_heights(a, b, c)
      ret_val = (a*h(1))/2.0
   end function get_area_by_height

   !********************
   ! Function get_heights
   ! Calculates triangle heights
   !************************************************************************/
   pure function get_heights(a, b, c) result(ret_val)
      implicit none
      real, intent(in) :: a, b, c
      real :: ret_val(3)
      real area
      area = get_area_by_heron(a, b, c)
      ret_val(1) = 2.0*area/a
      ret_val(2) = 2.0*area/b
      ret_val(3) = 2.0*area/c
   end function get_heights

END MODULE

