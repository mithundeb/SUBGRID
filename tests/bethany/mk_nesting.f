         parameter (Ntotal=30000,nsta_tot=200)
         parameter (Nb=400)
         real west_z(nsta_tot,ntotal),west_u(nsta_tot,ntotal),
     &       time(ntotal),ele(ntotal),
     &        west_v(nsta_tot,ntotal),
     &        east_z(nsta_tot,ntotal),
     &        east_u(nsta_tot,ntotal),east_v(nsta_tot,ntotal),
     &        south_z(nsta_tot,ntotal),south_u(nsta_tot,ntotal),
     &        south_v(nsta_tot,ntotal),
     &        north_z(nsta_tot,ntotal),north_u(nsta_tot,ntotal),
     &        north_v(nsta_tot,ntotal)

         real U_COUPLING_WEST(Nb,Ntotal),
     &       V_COUPLING_WEST(Nb,Ntotal),
     &       Z_COUPLING_WEST(Nb,Ntotal),
     &       U_COUPLING_EAST(Nb,Ntotal),
     &       V_COUPLING_EAST(Nb,Ntotal),
     &       Z_COUPLING_EAST(Nb,Ntotal),
     &       U_COUPLING_SOUTH(Nb,Ntotal),
     &       V_COUPLING_SOUTH(Nb,Ntotal),
     &       Z_COUPLING_SOUTH(Nb,Ntotal),
     &       U_COUPLING_NORTH(Nb,Ntotal),
     &       V_COUPLING_NORTH(Nb,Ntotal),
     &       Z_COUPLING_NORTH(Nb,Ntotal)
         integer J_START_SOUTH,J_START_NORTH,J_START_EAST
     &       J_START_WEST

         CHARACTER(LEN=80) FDIR
         CHARACTER(LEN=4) FILE_NAME
         integer icount
         CHARACTER(LEN=80) string


         icount=0

! input parameters

         nwest=0
         nsouth=0
         neast=0
         nnorth=316

    
         time_cut=0.0   
         iscale = 1

        J_START_WEST = 1
        J_START_EAST = 1
        J_START_SOUTH = 1
        J_START_NORTH = 1


        J_TRIM_WEST = 0
        J_TRIM_EAST = 0
        J_TRIM_SOUTH = 0
        J_TRIM_NORTH = 0

! end input paramters

         Nsm_west=(nwest-1)*iscale +1
         Nsm_south=(nsouth-1)*iscale +1
         Nsm_east=(neast-1)*iscale +1
         Nsm_north=(nnorth-1)*iscale +1

         print*,'Nsm_west',Nsm_west,'Nsm_east',Nsm_east
         print*,'Nsm_north',Nsm_north,'Nsm_south',Nsm_south

! read data
        open(1,file='gauge_data.txt')
        do i=1,Ntotal
          read(1,*,end=200)time(i),ele(i)
        enddo
200     continue
        Ndata=i-1

!  --------------  construct data

        DO K=1,Ndata
          DO I=1,Nsouth
          plag=0.0
          U_COUPLING_SOUTH(I,K)=0.0
          V_COUPLING_SOUTH(I,K)=0.0
          Z_COUPLING_SOUTH(I,K)=0.0
          ENDDO
        ENDDO
! north
        DO K=1,Ndata
          DO I=1,Nnorth
          plag=0.0
          U_COUPLING_north(I,K)=0.
          V_COUPLING_north(I,K)=0.
          Z_COUPLING_north(I,K)=ele(K)
          ENDDO

        ENDDO

! west
        DO K=1,Ndata
          DO I=1,Nwest
          plag=0.0
          U_COUPLING_WEST(I,K)=0.0
          V_COUPLING_WEST(I,K)=0.0
          Z_COUPLING_WEST(I,K)=0.0
          ENDDO
        ENDDO
! east
        DO K=1,Ndata
          DO I=1,Neast
          plag=0.0
          U_COUPLING_east(I,K)=0.0
          V_COUPLING_east(I,K)=0.0
          Z_COUPLING_east(I,K)=0.0
          ENDDO
        ENDDO


        OPEN(1,FILE='coupling.txt')
         WRITE(1,*) 'coupling data'
         WRITE(1,*) 'boundary info: num of points, start point'
         WRITE(1,*) 'EAST'
         WRITE(1,*) Nsm_east, J_START_EAST
         WRITE(1,*) 'WEST'
         WRITE(1,*) Nsm_west, J_START_WEST
         WRITE(1,*) 'SOUTH'
         WRITE(1,*) Nsm_south, 
     &              J_START_SOUTH
         WRITE(1,*) 'NORTH'
         WRITE(1,*) Nsm_north, 
     &              J_START_NORTH


119      FORMAT(5E16.6)

         WRITE(1,*) 'TIME SERIES'
         DO K=1,Ndata
           WRITE(1,*)TIME(K)
! east
           WRITE(1,*)'EAST SIDE'
          IF(Neast>0)THEN
             WRITE(1,119)(U_COUPLING_east(I,K),I=1,Nsm_EAST)
             WRITE(1,119)(V_COUPLING_east(I,K),I=1,Nsm_EAST)
             WRITE(1,119)(Z_COUPLING_east(I,K),I=1,Nsm_EAST)
          ENDIF
! west
           WRITE(1,*)'WEST SIDE'
          IF(NWEST>0)THEN
             WRITE(1,119)(U_COUPLING_WEST(I,K),I=1,Nsm_WEST)
             WRITE(1,119)(V_COUPLING_WEST(I,K),I=1,Nsm_WEST)
             WRITE(1,119)(Z_COUPLING_WEST(I,K),I=1,Nsm_WEST)
          ENDIF

! south
           WRITE(1,*)'SOUTH SIDE'
          IF(NSOUTH>0)THEN
             WRITE(1,119)(U_COUPLING_SOUTH(I,K),I=1,Nsm_SOUTH)
             WRITE(1,119)(V_COUPLING_SOUTH(I,K),I=1,Nsm_SOUTH)
             WRITE(1,119)(Z_COUPLING_SOUTH(I,K),I=1,Nsm_SOUTH)
          ENDIF

! north
           WRITE(1,*)'NORTH SIDE'
          IF(NNORTH>0)THEN
             WRITE(1,119)(U_COUPLING_NORTH(I,K),I=1,Nsm_NORTH)
             WRITE(1,119)(V_COUPLING_NORTH(I,K),I=1,Nsm_NORTH)
             WRITE(1,119)(Z_COUPLING_NORTH(I,K),I=1,Nsm_NORTH)
          ENDIF

         ENDDO ! end time

100      format(999E16.5)

         CLOSE(1)

         end









