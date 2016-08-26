!        generated by tapenade     (inria, tropics team)
!  tapenade 3.10 (r5363) -  9 sep 2014 09:53
!
!  differentiation of vectorrotation in forward (tangent) mode (with options i4 dr8 r8):
!   variations   of useful results: xp yp zp
!   with respect to varying inputs: x y z angle
!
!      file:          vectorrotation.f90                              
!      author:        andre c. marta                                  
!      starting date: 06-23-2006                                      
!      last modified: 07-28-2006                                      
!
subroutine vectorrotation_d(xp, xpd, yp, ypd, zp, zpd, iaxis, angle, &
& angled, x, xd, y, yd, z, zd)
!
!      vectorrotation rotates a given vector with respect to a      
!      specified axis by a given angle.                             
!         input arguments:                                          
!            iaxis      = rotation axis (1-x, 2-y, 3-z)             
!            angle      = rotation angle (measured ccw in radians)  
!            x, y, z    = coordinates in original system            
!         output arguments:                                         
!            xp, yp, zp = coordinates in rotated system             
!
  use precision
  implicit none
!
!     subroutine arguments.
!
  integer(kind=inttype), intent(in) :: iaxis
  real(kind=realtype), intent(in) :: angle, x, y, z
  real(kind=realtype), intent(in) :: angled, xd, yd, zd
  real(kind=realtype), intent(out) :: xp, yp, zp
  real(kind=realtype), intent(out) :: xpd, ypd, zpd
  intrinsic cos
  intrinsic sin
!
!      begin execution                                                
!
! rotation about specified axis by specified angle
  select case  (iaxis) 
  case (1) 
! rotation about the x-axis
    xpd = xd
    xp = 1.*x + 0.*y + 0.*z
    ypd = cos(angle)*yd - angled*sin(angle)*y + angled*cos(angle)*z + &
&     sin(angle)*zd
    yp = 0.*x + cos(angle)*y + sin(angle)*z
    zpd = cos(angle)*zd - sin(angle)*yd - angled*cos(angle)*y - angled*&
&     sin(angle)*z
    zp = 0.*x - sin(angle)*y + cos(angle)*z
  case (2) 
! rotation about the y-axis
    xpd = cos(angle)*xd - angled*sin(angle)*x - angled*cos(angle)*z - &
&     sin(angle)*zd
    xp = cos(angle)*x + 0.*y - sin(angle)*z
    ypd = yd
    yp = 0.*x + 1.*y + 0.*z
    zpd = angled*cos(angle)*x + sin(angle)*xd + cos(angle)*zd - angled*&
&     sin(angle)*z
    zp = sin(angle)*x + 0.*y + cos(angle)*z
  case (3) 
! rotation about the z-axis
    xpd = cos(angle)*xd - angled*sin(angle)*x + angled*cos(angle)*y + &
&     sin(angle)*yd
    xp = cos(angle)*x + sin(angle)*y + 0.*z
    ypd = cos(angle)*yd - sin(angle)*xd - angled*cos(angle)*x - angled*&
&     sin(angle)*y
    yp = -(sin(angle)*x) + cos(angle)*y + 0.*z
    zpd = zd
    zp = 0.*x + 0.*y + 1.*z
  case default
    write(*, *) 'vectorrotation called with invalid arguments'
    stop
  end select
end subroutine vectorrotation_d
