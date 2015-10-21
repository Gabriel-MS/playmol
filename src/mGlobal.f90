!   This file is part of Playmol.
!
!    Playmol is free software: you can redistribute it and/or modify
!    it under the terms of the GNU General Public License as published by
!    the Free Software Foundation, either version 3 of the License, or
!    (at your option) any later version.
!
!    Playmol is distributed in the hope that it will be useful,
!    but WITHOUT ANY WARRANTY; without even the implied warranty of
!    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
!    GNU General Public License for more details.
!
!    You should have received a copy of the GNU General Public License
!    along with Playmol. If not, see <http://www.gnu.org/licenses/>.
!
!    Author: Charlles R. A. Abreu (abreu at eq.ufrj.br)
!            Applied Thermodynamics and Molecular Simulation
!            Federal University of Rio de Janeiro, Brazil

module mGlobal

integer,      parameter :: rb = 8      !< Default number of bytes for real numbers
integer,      parameter :: sl = 256    !< Default character string length
character(3), parameter :: csl = "256" !< String with default character string length

integer :: stdout = 6                  !< Standard output unit
integer :: logunit = 0                 !< Output unit for logging

!> A simple random number generator:
type rng
  integer, private :: jsr
  contains
    procedure :: init => rng_init
    procedure :: i32 => rng_i32
    procedure :: uni => i32rng_uniform
    procedure :: letters => rng_letters
end type rng

type tWarning
  character(sl) :: msg
  type(tWarning), pointer :: next => null()
end type tWarning

type(tWarning), pointer :: first_warning => null(), &
                           last_warning => null()

contains

  !=================================================================================================

  subroutine init_log( file )
    character(*), intent(in) :: file
    open( newunit = logunit, file = file, status = "replace" )
  end subroutine init_log

  !=================================================================================================

  subroutine stop_log
    close( logunit )
    logunit = 0
  end subroutine stop_log

  !=================================================================================================

  subroutine write_msg( prefix, msg )
    character(*), intent(in) :: prefix, msg
    write(stdout,'(A,A)',advance='no') prefix, msg
    if (logunit /= 0) write(logunit,'(A,A)',advance='no') prefix, msg
  end subroutine write_msg

  !=================================================================================================

  subroutine end_line()
    write(stdout,'()')
    if (logunit /= 0) write(logunit,'()')
  end subroutine end_line

  !=================================================================================================

  subroutine writeln( msg, msg1, msg2, msg3, msg4, msg5, msg6, msg7, msg8, msg9, advance )
    character(*), intent(in), optional :: msg, msg1, msg2, msg3, msg4, msg5, msg6, msg7, msg8, msg9
    logical,      intent(in), optional :: advance
    if (present(msg))  call write_msg( "", trim(msg) )
    if (present(msg1)) call write_msg( " ", trim(msg1) )
    if (present(msg2)) call write_msg( " ", trim(msg2) )
    if (present(msg3)) call write_msg( " ", trim(msg3) )
    if (present(msg4)) call write_msg( " ", trim(msg4) )
    if (present(msg5)) call write_msg( " ", trim(msg5) )
    if (present(msg6)) call write_msg( " ", trim(msg6) )
    if (present(msg7)) call write_msg( " ", trim(msg7) )
    if (present(msg8)) call write_msg( " ", trim(msg8) )
    if (present(msg9)) call write_msg( " ", trim(msg9) )
    if (present(advance)) then
      if (advance) call end_line
    else
      call end_line
    end if
  end subroutine writeln

  !=================================================================================================

  subroutine warning( msg, msg1, msg2, msg3, msg4, msg5, msg6, msg7, msg8, msg9 )
    character(*), intent(in)           :: msg
    character(*), intent(in), optional :: msg1, msg2, msg3, msg4, msg5, msg6, msg7, msg8, msg9
    if (.not.associated(first_warning)) then
      allocate( first_warning )
      last_warning => first_warning
    else
      allocate( last_warning % next )
      last_warning => last_warning % next
    end if
    last_warning % msg = trim(msg)
    if (present(msg1)) last_warning % msg = trim(last_warning % msg)//" "//trim(msg1)
    if (present(msg2)) last_warning % msg = trim(last_warning % msg)//" "//trim(msg2)
    if (present(msg3)) last_warning % msg = trim(last_warning % msg)//" "//trim(msg3)
    if (present(msg4)) last_warning % msg = trim(last_warning % msg)//" "//trim(msg4)
    if (present(msg5)) last_warning % msg = trim(last_warning % msg)//" "//trim(msg5)
    if (present(msg6)) last_warning % msg = trim(last_warning % msg)//" "//trim(msg6)
    if (present(msg7)) last_warning % msg = trim(last_warning % msg)//" "//trim(msg7)
    if (present(msg8)) last_warning % msg = trim(last_warning % msg)//" "//trim(msg8)
    if (present(msg9)) last_warning % msg = trim(last_warning % msg)//" "//trim(msg9)
    call write_msg( "WARNING:", trim(last_warning % msg) )
    call end_line
  end subroutine warning

  !=================================================================================================

  subroutine reprint_warnings
    type(tWarning), pointer :: ptr
    ptr => first_warning
    if (associated(ptr)) then
      call writeln()
      call writeln( "********** SUMMARY OF WARNINGS **********" )
    end if
    do while (associated(ptr))
      call writeln( ptr % msg )
      ptr => ptr % next
    end do
  end subroutine reprint_warnings

  !=================================================================================================

  subroutine error( msg, msg1, msg2, msg3, msg4, msg5, msg6, msg7, msg8, msg9 )
    character(*), intent(in)           :: msg
    character(*), intent(in), optional :: msg1, msg2, msg3, msg4, msg5, msg6, msg7, msg8, msg9
    call write_msg( "ERROR: ", trim(msg) )
    if (present(msg1)) call write_msg( " ", trim(msg1) )
    if (present(msg2)) call write_msg( " ", trim(msg2) )
    if (present(msg3)) call write_msg( " ", trim(msg3) )
    if (present(msg4)) call write_msg( " ", trim(msg4) )
    if (present(msg5)) call write_msg( " ", trim(msg5) )
    if (present(msg6)) call write_msg( " ", trim(msg6) )
    if (present(msg7)) call write_msg( " ", trim(msg7) )
    if (present(msg8)) call write_msg( " ", trim(msg8) )
    if (present(msg9)) call write_msg( " ", trim(msg9) )
    call end_line
    stop
  end subroutine error

  !=================================================================================================

  subroutine delete_files( filename )
    character(sl),   intent(in) :: filename(:)
    integer :: ifile, unit, ierr
    do ifile = 1, size(filename)
      open( newunit = unit, file = filename(ifile), status = "old", iostat = ierr )
      if (ierr == 0) close(unit, status = "delete")
    end do
  end subroutine delete_files

  !=================================================================================================

  subroutine rng_init( a, seed )
    class(rng), intent(inout) :: a
    integer,    intent(in)    :: seed
    a%jsr = seed
  end subroutine rng_init

  !=================================================================================================

  function rng_i32( a ) result( i32 )
    class(rng), intent(inout) :: a
    integer                   :: i32
    integer :: jz
    jz = a%jsr
    a%jsr = ieor(a%jsr,ishft(a%jsr, 13))
    a%jsr = ieor(a%jsr,ishft(a%jsr,-17))
    a%jsr = ieor(a%jsr,ishft(a%jsr,  5))
    i32 = jz + a%jsr
  end function rng_i32

  !=================================================================================================

  function i32rng_uniform( a ) result( uni )
    class(rng), intent(inout) :: a
    real(8)                   :: uni
    uni = 0.5_8 + 0.2328306e-9_8 * a%i32()
  end function i32rng_uniform

  !=================================================================================================

  function rng_letters( a, n ) result( word )
    class(rng), intent(inout) :: a
    integer,    intent(in)    :: n
    character(sl)             :: word
    integer :: i
    word = ""
    do i = 1, n
      word = trim(word)//achar(97+mod(abs(a % i32()),26))
    end do
  end function rng_letters

  !=================================================================================================

  real(rb) function scalar( u, v )
    real(rb), intent(in) :: u(:), v(:)
    scalar = sum(u*v)
  end function scalar

  !=================================================================================================

  real(rb) function norm( v )
    real(rb), intent(in) :: v(:)
    norm = sqrt(scalar(v,v))
  end function norm

  !=================================================================================================

  function cross( a, b ) result( c )
    real(rb), intent(in) :: a(3), b(3)
    real(rb)             :: c(3)
    c = [ a(2)*b(3) - a(3)*b(2), a(3)*b(1) - a(1)*b(3), a(1)*b(2) - a(2)*b(1) ]
  end function cross

  !=================================================================================================

  elemental real(rb) function cosine( theta )
    real(rb), intent(in) :: theta
    cosine = cos(0.01745329251994329577_rb*theta)
  end function cosine

  !=================================================================================================

  elemental real(rb) function sine( theta )
    real(rb), intent(in) :: theta
    sine = sin(0.01745329251994329577_rb*theta)
  end function sine

  !=================================================================================================

end module mGlobal
