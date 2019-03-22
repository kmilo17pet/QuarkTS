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
CFLAGS ?= -std=c89 -Wall -O3
# Flags to pass to the linker
LFLAGS ?= -lm -lpthread
# Output directories
OBJ_DIR := obj
BIN_DIR := bin
OBJ_EXT ?= .o
#####################################
### Do NOT touch the lines below  ###
#####################################
INC 	:= 	-I. $(addprefix -I./,$(dir $(wildcard src/**/*.h)))
SRC 	:= 	$(wildcard src/**/*.c)
OBJ 	:= 	$(addprefix $(OBJ_DIR)/,$(SRC:.c=$(OBJ_EXT)))
OUT 	= 	$(BIN_DIR)/$(notdir $(CURDIR))

.SUFFIXES:
.PHONY: clean show

$(OUT): $(OBJ)
	@mkdir -p $(dir $@)
	$(LD) $^ $(LFLAGS) -o $@
	@echo "-------------------------------"
	@echo "Build Success!"

$(OBJ_DIR)/%$(OBJ_EXT): %.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) $(INC)  -c $< -o $@

run: $(OUT)
	@./$(OUT)

test: run
clean:
	@$(RM) -rf $(OUT) $(OBJ_DIR) $(BIN_DIR)

show:
	@echo SRC =  $(SRC)