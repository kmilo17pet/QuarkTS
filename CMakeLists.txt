cmake_minimum_required(VERSION 3.12)
project(QuarkTS C)

set(CMAKE_C_STANDARD 11)

include_directories(.)

add_executable(QuarkTS
        main.c
        QuarkTS.c
        QuarkTS.h)
