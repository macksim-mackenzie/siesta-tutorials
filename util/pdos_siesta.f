      program pdosex

C     PROGRAM TO EXTRACT THE PDOS ATOMS FROM THE .PDOS SIESTA FILE.

      logical fim, file_exist
      integer :: n,I,l, m, zz, unt, nat,Iat,at,J,Mesh,auxi,updown
      integer :: contf
      character line*70, postr*11, nstr*26, lstr*26, mstr*26,indxtr*13
      character line1*70, line2*70, line3*70, line4*70, line5*70
      character zstr*26, arq*20,spin*7,elimit*20,istart*30 
      character (len=10) :: auxc,lauxc
      character which1*7, which2
      real :: x, y, z, E,dosup,dosdown
      real, dimension(:,:), allocatable ::  pdoss, pdosp, pdosd, pdostot
      real, dimension(:), allocatable ::  En
      integer, dimension(:), allocatable:: ati

       write(6,*)
       write(6,*)'    THIS PROGRAM REQUIRES AN INPUT FILE AS BELOW:   '
       write(6,*)' -------------------------------------------------- '
       write(6,*)'    systemlabel.PDOS                                '
       write(6,*)'    N        number of atoms to perform PDOS extract'
       write(6,*)'    1        index of the 1° desired atom           '
       write(6,*)'    ...                  ...                        '
       write(6,*)'    ...                  ...                        '
       write(6,*)'    ...                  ...                        '
       write(6,*)'    N-1                  ...                        '
       write(6,*)'    N        index of the N° desired atom           '
       write(6,*)' ---------------------------------------------------'
       write(6,*) 

C     --------------- TESTING IF THE .PDOS FILE EXIST --------------
      read(5,'(a20)') arq
      inquire(file=arq, exist=file_exist)  
      if (.not. file_exist) then
         write(6,*) '!!!!! Systemlabel.PDOS file not found !!!!!'
         write(6,*)
         stop
      endif

      unt=13
      open(unit=unt, file=arq, status='old')
C     --------------------------------------------------------------
C     ------------------ READING THE INPUT FILE---------------------
C            VERIFING IF THE SYSTEM IS OR NOT SPIN-POLIRIZED
      read(unt,*)                                 ! <pdos> line
      read(unt,'(a7,i1)')spin,updown              ! <nspin> line
      if(updown==1) then
      write(6,*) 'Non spin polarized system!'
      else
      write(6,*) 'Spin polarized system!'
      endif
C     -------------------------------------------------------------
C     ------------------ DETERMING THE MESH ENERGY ----------------      
     
      read(unt,*)                                 !<norbitals> line
      read(unt,*)                                 !
      contf=0                    
      elimit= "<"
10    read(unt,*)istart
      if(trim(istart).ne.elimit) then
       contf=contf+1
      goto 10
      else if(trim(istart).eq.elimit)then
      goto 20 
      endif
20      Mesh=contf
      write(6,*) 'The mesh-energy used is=', Mesh
 

C     -------------------DEFINING THE LENGHT OF VECTORS-------------
      read(5,*) nat
      allocate(ati(nat))
      allocate(pdoss(Mesh,2))
      allocate(pdosp(Mesh,2))
      allocate(pdosd(Mesh,2))
      allocate(pdostot(Mesh,2))
      allocate(En(Mesh)) 
             
      pdoss=0.0
      pdosp=0.0
      pdosd=0.0
      pdostot=0.0
C     --------------------------------------------------------------
C     ----------------- CREATING THE ENERGY VECTOR -----------------
         rewind 13
         read(unt,*)
         read(unt,*)
         read(unt,*)
         read(unt,*) 
         do I = 1,Mesh
           read(unt,*) En(I)
         enddo
C     --------------------------------------------------------------
C     ------- CREATING THE COMPARING VECTOR TO THE ATOMS LIST-------
          do Iat = 1,nat
             read(5,*) ati(Iat)
          enddo
C     --------------------------------------------------------------    

C     -----WHICH SIESTA VERSION THE .PDOS FILE IS FROM?-------------
          read(unt,*)
          read(unt,*)
          read(unt,'(a8,a1)') which1, which2
          if (which2=='1') then
          write(6,*) 'The .PDOS used file is from Siesta-2.0.x version!'
          goto 40
          else if(which2==' ') then
          write(6,*) 'The .PDOS used file is from Siesta-1.3 version!'
          endif
C     
C     --------------- INITIALIZING THE LOOP CALCULATION ------------   
C     --------------------- FOR SIESTA-1.3 VERSION ----------------- 
         do while (.not. fim)
          read(unt,'(a70)') line
          if ( index(line,"/pdos").ne.0 ) then
                     fim = .true.
          end if 
          if (index (line,"atom_index=") .eq. 2) then
            read(line,'(a13,i25)') indxtr, at
             do I = 1,nat
             if( at .eq. ati(I) ) then
               read(unt,*) line
               read(unt,*) line
               read(unt,'(a70)') line1
               read(unt,'(a70)') line2
               read(unt,'(a70)') line3
               read(unt,'(a70)') line4
            read(line2, '(a26,i3)') lstr, l
                  read(unt,*) line5
                  read(unt,*) line5
                  do J = 1,Mesh
                 read(unt,'(a70)') line5
                    if( updown==1 ) then
                        read(line5,*) dosup
                      read(line5,*) dosup
                        if ( l == 0 ) then
                            pdoss(J,1)= pdoss(J,1)+dosup
                        end if
                        if ( l == 1 ) then
                             pdosp(J,1)= pdosp(J,1)+dosup
                        end if
                         if ( l == 2 ) then
                             pdosd(J,1)= pdosd(J,1)+dosup
                         end if
                             pdostot(J,1)=pdostot(J,1)+dosup

                  else if( updown==2 ) then
                        read(line5,*) dosup,dosdown
                        if ( l == 0 ) then
                              pdoss(J,1)= pdoss(J,1)+dosup
                              pdoss(J,2)= pdoss(J,2)+dosdown
                        end if
                        if ( l == 1 ) then
                              pdosp(J,1)= pdosp(J,1)+dosup
                              pdosp(J,2)= pdosp(J,2)+dosdown
                        end if
                        if ( l == 2 ) then
                              pdosd(J,1)= pdosd(J,1)+dosup
                              pdosd(J,2)= pdosd(J,2)+dosdown
                       end if
                              pdostot(J,1)=pdostot(J,1)+dosup
                              pdostot(J,2)=pdostot(J,2)+dosdown
                  endif
                enddo
             endif
          enddo
          endif
        enddo
        goto 50

C     -------------------- FOR SIESTA-2.0.X VERSION ----------------

40         do while (.not. fim)
             open(22,file='temp.dat',status='new')
       
         auxi=0 
       
          read(unt,'(a70)') line
          if ( index(line,"/pdos").ne.0 ) then
                     fim = .true.
          end if 
          if (index (line,"atom_index=") .eq. 2) then
            read(line,'(a13,a10)') indxtr, auxc
            auxc=trim(auxc)
            auxi=len_trim(auxc)
          write(22,*) auxc(1:auxi-1)
          close(22)
          open(22,file='temp.dat',status='old')
          read(22,*) at 

             do I = 1,nat
               auxi=0
             if( at .eq. ati(I) ) then
               read(unt,*) line
               read(unt,*) line
               read(unt,'(a70)') line1
               read(unt,'(a70)') line2
               read(unt,'(a70)') line3
               read(unt,'(a70)') line4
            read(line2, '(a4,i1)') lstr, l

                  read(unt,*) line5
                  read(unt,*) line5
                  do J = 1,Mesh 
                 read(unt,'(a70)') line5
                    if( updown==1 ) then
                        read(line5,*) dosup
                        if ( l == 0 ) then
                            pdoss(J,1)= pdoss(J,1)+dosup
                        end if
                        if ( l == 1 ) then
                             pdosp(J,1)= pdosp(J,1)+dosup
                        end if
                         if ( l == 2 ) then
                             pdosd(J,1)= pdosd(J,1)+dosup
                         end if
                             pdostot(J,1)=pdostot(J,1)+dosup

                  else if( updown==2 ) then
                        read(line5,*) dosup,dosdown
                        if ( l == 0 ) then
                              pdoss(J,1)= pdoss(J,1)+dosup 
                              pdoss(J,2)= pdoss(J,2)+dosdown
                        end if
                        if ( l == 1 ) then
                              pdosp(J,1)= pdosp(J,1)+dosup 
                              pdosp(J,2)= pdosp(J,2)+dosdown
                        end if
                        if ( l == 2 ) then
                              pdosd(J,1)= pdosd(J,1)+dosup 
                              pdosd(J,2)= pdosd(J,2)+dosdown
                       end if 
                              pdostot(J,1)=pdostot(J,1)+dosup
                              pdostot(J,2)=pdostot(J,2)+dosdown
                  endif       
                enddo
             endif
          enddo
          endif
        close(22,status='delete')
        enddo

50     open(unit=14,file='pdos_s1.dat')
       open(unit=15,file='pdos_p1.dat')
       open(unit=16,file='pdos_d1.dat')
       open(unit=17,file='pdos_tot1.dat')

      do J = 1, Mesh
        write(14,*) En(J),pdoss(J,1)
        write(15,*) En(J),pdosp(J,1)
        write(16,*) En(J),pdosd(J,1)
        write(17,*) En(J),pdostot(J,1) 
      enddo 
      if(updown==2) then 
      open(unit=18,file='pdos_s2.dat')
      open(unit=19,file='pdos_p2.dat')
      open(unit=20,file='pdos_d2.dat')
      open(unit=21,file='pdos_tot2.dat')

      do J = 1, Mesh
        write(18,*) En(J),pdoss(J,2)
        write(19,*) En(J),pdosp(J,2)
        write(20,*) En(J),pdosd(J,2)
        write(21,*) En(J),pdostot(J,2)
      enddo
      endif
      stop
      end
