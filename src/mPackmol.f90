module mPackmol

use mGlobal
use mStruc
use mBox

implicit none

type rng
  integer, private :: jsr
  contains
    procedure :: init => rng_init
    procedure :: i32 => rng_i32
    procedure :: letters => rng_letters
end type rng

contains

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

  subroutine packmol_file_names( inputfile, molfile, mixfile, random_names )
    character(sl), intent(out) :: inputfile, molfile(:), mixfile
    logical,       intent(in)  :: random_names
    integer :: seed, i
    type(rng) :: random
    if (random_names) then
      call system_clock( count = seed )
      call random % init( seed )
      inputfile = trim(random % letters(10))//".inp"
      do i = 1, size(molfile)
        molfile(i) = trim(random % letters(10))//".xyz"
      end do
      mixfile = trim(random % letters(10))//".xyz"
    else
      inputfile = "packmol.inp"
      do i = 1, size(molfile)
        molfile(i) = "molecule_"//trim(int2str(i))//".xyz"
      end do
      mixfile = "packmol_output.xyz"
    end if
  end subroutine packmol_file_names

  !=================================================================================================

  subroutine packmol_count_molecules( lpack, molcount )
    type(StrucList), intent(in)  :: lpack
    integer,         intent(out) :: molcount(:)
    integer :: imol, narg
    character(sl) :: arg(4)
    type(Struc), pointer :: ptr
    molcount = 0
    ptr => lpack % first
    do while (associated(ptr))
      imol = str2int(ptr % id(1))
      call split( ptr % params, narg, arg )
      select case (arg(1))
        case ("move","fix"); molcount(imol) = molcount(imol) + 1
        case ("copy","pack"); molcount(imol) = molcount(imol) + str2int(arg(2))
      end select
      ptr => ptr % next
    end do
  end subroutine packmol_count_molecules

  !=================================================================================================

  subroutine packmol_xyz_files( lpack, lmol, lcoord, natoms, molfile )

    type(StrucList), intent(in)  :: lpack, lmol, lcoord
    integer,         intent(in)  :: natoms(:)
    character(sl),   intent(out) :: molfile(:)

    integer :: ifile, nfiles, imol, unit, iatom
    logical :: found
    type(Struc), pointer :: ptr, coord
    integer, allocatable :: molecule(:)

    ! Determine which molecules are present in the packmol list (disregarding repeated ones):
    ptr => lpack % first
    nfiles = 0
    allocate( molecule(lpack % count()) )
    do while (associated(ptr))
      imol = str2int(ptr % id(1))
      if (all(molecule(1:nfiles) /= imol)) then
        nfiles = nfiles + 1
        molecule(nfiles) = imol
      end if
      ptr => ptr % next
    end do

    ! Search for the first atom of each molecule in the coordinate list:
    do ifile = 1, nfiles
      imol = molecule(ifile)

      ptr => lmol % first
      found = .false.
      do while (.not.found)
        found = (str2int(ptr % params) == imol)
        if (.not.found) ptr => ptr % next
      end do
      call lcoord % search( ptr % id, coord )
      if (.not.associated(coord)) call error( "molecule", int2str(imol), "lacks coordinates" )

      open( newunit = unit, file = molfile(ifile), status = "replace" )
      write(unit,'(A)') trim(int2str(natoms(imol)))
      write(unit,'("# Generated by playmol")')
      do iatom = 1, natoms(imol)
        write(unit,'(A)') trim(coord % id(1))//" "//trim(coord % params)
        coord => coord % next
      end do
      close(unit)
    end do

  end subroutine packmol_xyz_files

  !=================================================================================================

  subroutine packmol_delete_files( filename )
    character(sl),   intent(in) :: filename(:)
    integer :: ifile, unit, ierr
    do ifile = 1, size(filename)
      open( newunit = unit, file = filename(ifile), status = "old", iostat = ierr )
      if (ierr == 0) close(unit, status = "delete")
    end do
  end subroutine packmol_delete_files

  !=================================================================================================

  subroutine packmol_input_file( lpack, seed, tol, Lbox, inputfile, mixfile, molfile )
    type(StrucList), intent(in) :: lpack
    integer,         intent(in) :: seed
    real(rb),        intent(in) :: tol, Lbox(3)
    character(sl),   intent(in) :: inputfile, mixfile, molfile(:)

    integer :: unit, imol, narg
    character(sl) :: box_limits, arg(4)
    type(Struc), pointer :: ptr

    ! Define box limits:
    box_limits = join(real2str([-0.5_rb*(Lbox - tol), +0.5_rb*(Lbox - tol)]))

    ! Create packmol input script:
    open( newunit = unit, file = inputfile, status = "replace" )
    write(unit,'("# Generated by playmol",/)')
    write(unit,'("tolerance ",A)') trim(real2str(tol))
    write(unit,'("filetype xyz")')
    write(unit,'("output ",A)') trim(mixfile)
    ptr => lpack % first
    do while (associated(ptr))
      imol = str2int(ptr % id(1))
      write(unit,'(/,"structure ",A)') trim(molfile(imol))
      call split( ptr % params, narg, arg )
      select case (arg(1))
        case ("move","fix")
          write(unit,'("  number 1")')
          if (arg(1) == "fix") write(unit,'("  center")')
          write(unit,'("  fixed ",A," 0.0 0.0 0.0")') trim(join(arg(2:4)))
        case ("copy","pack")
          write(unit,'("  number ",A)') trim(arg(2))
          write(unit,'("  inside box ",A)') trim(box_limits)
          if (arg(1) == "copy") then
            write(unit,'("  constrain_rotation x 0.0 0.0")')
            write(unit,'("  constrain_rotation y 0.0 0.0")')
            write(unit,'("  constrain_rotation z 0.0 0.0")')
          end if
      end select
      write(unit,'("end structure")')
      ptr => ptr % next
    end do
    close(unit)

  end subroutine packmol_input_file

  !=================================================================================================

  subroutine run_packmol( lpack, lmol, lcoord, nmol, natoms, Lbox, seed, tol, action )
    type(StrucList), intent(in) :: lpack, lmol, lcoord
    integer,         intent(in) :: nmol, natoms(nmol), seed
    real(rb),        intent(in) :: Lbox(3), tol
    character(sl),   intent(in) :: action

    integer :: nfiles
    character(sl) :: molfile(nmol), mixfile, inputfile

    call packmol_file_names( inputfile, molfile, mixfile, random_names = .false.)
    call packmol_xyz_files( lpack, lmol, lcoord, natoms, molfile )
    call packmol_input_file( lpack, seed, tol, Lbox, inputfile, mixfile, molfile )

    call lpack % destroy
  end subroutine run_packmol

  !=================================================================================================

end module mPackmol
