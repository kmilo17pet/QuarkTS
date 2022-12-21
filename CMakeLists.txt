cmake_minimum_required( VERSION 3.2 )
project( quarkts VERSION 7.3.2 DESCRIPTION "An open-source OS for small embedded applications")

add_library( quarkts 
             qatcli.c
             qbsbuffers.c
             qclock.c
             qcoroutine.c
             qcritical.c
             qedgecheck.c
             qfsm.c
             qioutils.c
             qkernel.c
             qlists.c
             qmemmang.c
             qqueues.c
             qresponse.c
             qstimers.c
             qtasks.c
             qtrace.c
           )
target_include_directories( quarkts PUBLIC include )
target_include_directories( quarkts PUBLIC ../config )

if( NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/../config/qconfig.h" )
	message( STATUS "QuarkTS qconfig.h file not found, downloading latest..." )
	file( DOWNLOAD
	      https://raw.githubusercontent.com/kmilo17pet/QuarkTS/master/src/config/qconfig.h
	      ${CMAKE_CURRENT_SOURCE_DIR}/../config/qconfig.h
	      SHOW_PROGRESS
	)
endif()
