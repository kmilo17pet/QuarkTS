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
EXTRAFLAGS ?= -flto -Wextra -Wimplicit-fallthrough=0 -Wformat-security -Wduplicated-cond -Wfloat-equal -Wshadow -Wconversion -Wsign-conversion -Wjump-misses-init -Wlogical-not-parentheses -Wnull-dereference  -Wnull-dereference -Wstringop-overflow 
CFLAGS ?= -fdump-rtl-expand -Wall $(EXTRAFLAGS)  -fstrict-aliasing -O2 -std=c99 -D_POSIX_C_SOURCE=199309L -MD -Wstrict-aliasing -DQLIST_D_HANDLING
# Flags to pass to the linker
LFLAGS ?= -lm  
# Output directories
OBJ_DIR := obj
BIN_DIR := bin
OBJ_EXT ?= .o
