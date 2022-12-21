# QuarkTS OS CMakeLists.txt file
# Copyright (C) 2012 Eng. Juan Camilo Gómez Cadavid MSc. All Rights Reserved.
#
# To make use of the QuarkTS OS on your solution just add the following 
# directives to the top-level CMakeLists.txt file :
#
#     add_subdirectory( <relative/path/to/kernel> )
#     target_link_libraries( ${PROJECT_NAME} quarkts )
#
# If the "qconfig.h" header file is not provided, the latest version will be 
# downloaded with the default parameters in the ../os_config directory.
#
# This file is part of the QuarkTS OS distribution.

cmake_minimum_required( VERSION 3.2 )
project( quarkts 
         VERSION 7.3.2 
         DESCRIPTION "An open-source OS for small embedded applications" 
         LANGUAGES C )

add_library( ${PROJECT_NAME}
             qlists.c
             qclock.c
             qstimers.c
             qcritical.c
             qkernel.c
             qtasks.c
             qcoroutine.c
             qmemmang.c
             qqueues.c
             qfsm.c
             qatcli.c
             qtrace.c
             qioutils.c
             qedgecheck.c
             qbsbuffers.c
             qresponse.c
           )
set( QUARKTS_CONFIG_PATH ../os_config )
set_target_properties( ${PROJECT_NAME} PROPERTIES PUBLIC_HEADER include/QuarkTS.h )
target_include_directories( ${PROJECT_NAME} PUBLIC include )
target_include_directories( ${PROJECT_NAME} PUBLIC ../os_config )

if( NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/${QUARKTS_CONFIG_PATH}/qconfig.h" )
    message( STATUS "QuarkTS qconfig.h file not found, downloading default on ${QUARKTS_CONFIG_PATH}..." )
    file( DOWNLOAD
          https://raw.githubusercontent.com/kmilo17pet/QuarkTS/master/src/config/qconfig.h
          ${CMAKE_CURRENT_SOURCE_DIR}/${QUARKTS_CONFIG_PATH}/qconfig.h
          SHOW_PROGRESS
    )
endif()
