!***************************************************************************************
! Command Line Math Utilities
!***************************************************************************************
!
! Name:     tcal (Triangle Calculator)
! Version:  1.06.0 - May,2023
! Topic:    Plane Geometry
! Purpose:  Given the sides a, b and c of a triangle, calculate its principal elements
! Language: Fortran
! Author:   José Cintra
! Web Site: https://github.com/JoseCintra/CLIMathUtils
! License:  Unlicense, described in http://unlicense.org
!
!***************************************************************************************

PROGRAM tcal

   !*****************************
   ! variable declaration section
   !*****************************
   use f90getopt ! Library for command-line parsing (https://github.com/haniibrahim/f90getopt)
   use tcal_lib ! tcal library
   real a, b, c ! Triangle sides
   real :: angles(6) ! Triangle angles (internal and external)
   real :: heights(3)
   character(len=1) :: short ! for parse command line
   type(option_s) :: opts(5) ! for parse command line

   !************************
   ! Variable initialization
   !************************
   opts(1) = option_s("aside", .true., "a")
   opts(2) = option_s("bside", .true., "b")
   opts(3) = option_s("cside", .true., "c")
   opts(3) = option_s("help", .false., "h")
   opts(4) = option_s("version", .false., "v")
   a = 0
   b = 0
   c = 0
   short = ""

   !**********************************************
   ! Command line parsing - getting triangle sides
   !**********************************************
   if (command_argument_count() .eq. 0) then
      write (*, '(a)') "ERROR: Program has options. Use options -h or --help for details"
   end if
   do
      short = getopt("a:b:c:hv", opts) ! Separate variable for Intel Fortran compatibility
      select case (short)
      case (char(0))
         exit
      case ("a") ! option -a --alpha
         if (isnum(trim(optarg)) .gt. 0) then
            read (optarg, *) a
         else
            write (*, '(a)') "ERROR: Option -a or --aside is not a number."
            stop
         end if
      case ("b")
         if (isnum(trim(optarg)) .gt. 0) then
            read (optarg, *) b
         else
            write (*, '(a)') "ERROR: Option -b or --bside is not a number."
            stop
         end if
      case ("c")
         if (isnum(trim(optarg)) .gt. 0) then
            read (optarg, *) c
         else
            write (*, '(a)') "ERROR: Option -c or --cside is not a number."
            stop
         end if
      case ("h") ! help output
         write (*, '(/8(A/),/,2(A/),/,2(A/))') &
            "Function: Calculate the main elements of a triangle, being informed the dimensions of its sides", &
            "Usage:    tricalc [options] …", &
            "Options:", &
            "  -h    --help      --> Print this help and exit", &
            "  -v    --version   --> Print version information and exit", &
            "  -a X  --aside=X   --> X is the length of side a", &
            "  -b X  --bside=X   --> X is the length of side b", &
            "  -c X  --cside=X   --> X is the length of side c", &
            "Example:", &
            "tricalc -a 3 -b 4 -c 5 --> Calculates the triangle of sides 3,4, and 5", &
            "This is open source software with ABSOLUTELY NO WARRANTY.", &
            "License: Unlicense, described in http://unlicense.org"
         stop
      case ("v") ! version output
         write (*, '((/A),/,(A/))') "tcal 1.01.1 (May,2023)", "By José Cintra (https://github.com/JoseCintra/CLIMathUtils)"
         stop
      end select
   end do

   !**********************
   ! Start of calculations
   !**********************

   ! Checking if the sides are valid
   if (.not. is_triangle(a, b, c)) then
      write (*, *) "ERROR: invalid sides"
      stop
   end if

   angles = get_angles(a, b, c)
   heights = get_heights(a, b, c)
   ! Show sides
   print('(/a/, a/)'), "Triangle Calculator", "-------------------"
   print('(a)'), "Dimensions:"
   print('(a, F0.4)'), "Side a         = ", a
   print('(a, F0.4)'), "Side b         = ", b
   print('(a, F0.4)'), "Side c         = ", c
   print('(a, F0.4)'), "Perimeter      = ", get_perimeter(a, b, c)
   print('(a, F0.4)'), "Semiperimeter  = ", get_perimeter(a, b, c)/2
   print('(a, F0.4)'), "Area by Heron  = ", get_area_by_heron(a, b, c);
   print('(a, F0.4/)'), "Area by Height = ", get_area_by_height(a, b, c);
   ! Calculate and Show the angles of the triangle
   print('(a)'), "Angles in decimal degrees:"
   print('(a, F0.4)'), "Internal angle A       = ", angles(1)
   print('(a, F0.4)'), "Internal angle B       = ", angles(2)
   print('(a, F0.4)'), "Internal angle C       = ", angles(3)
   print('(a, F0.4)'), "External angle of A    = ", angles(4)
   print('(a, F0.4)'), "External angle of B    = ", angles(5)
   print('(a, F0.4)'), "External angle of C    = ", angles(6);
   ! Calculate and Show the types of the triangle
   print('(a)'), "Types:"
   print('(a, a)'), "By side  = ", get_type_by_side(a, b, c)
   print('(a, a/)'), "By angle = ", get_type_by_angle(a, b, c)
   ! Calculate and Show the heights of the triangle
   print('(a)'), "Heights:"
   print('(a, F0.4)'), "Height in a = ", heights(1)
   print('(a, F0.4)'), "Height in b = ", heights(2)
   print('(a, F0.4/)'), "Height in c = ", heights(3);

END PROGRAM tcal
