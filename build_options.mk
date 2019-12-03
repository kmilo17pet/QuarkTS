####
#### Generic Makefile only for C projects
####
#### This file is public domain.
#### J. Camilo Gomez C.
####
##############################
### Configurable variables ###
##############################
# The compiler
CC = gcc
# The linker
LD = gcc
# Flags to pass to the compiler for release builds
CFLAGS ?= -Wall -Os -std=c89 -pedantic -D_POSIX_C_SOURCE=199309L -MD
# Flags to pass to the linker
LFLAGS ?= -lm -lpthread
# Output directories
OBJ_DIR := obj
BIN_DIR := bin
OBJ_EXT ?= .o
