####
#### Generic Makefile only for C projects
####
#### This file is public domain.
#### J. Camilo Gomez C.
####
include build_options.mk
###################################################################################################
### Do NOT touch the lines below , use the build_options.mk file to change the compile behavior ###
###################################################################################################
INC 	:= 	$(sort -I. $(addprefix -I./,$(dir  $(wildcard *.h */*.h */*/*.h */*/*/*.h)   )) )
SRC 	:= 	$(wildcard src/**/*.c)
OBJ 	:= 	$(addprefix $(OBJ_DIR)/,$(SRC:.c=$(OBJ_EXT)))
OUT 	= 	$(BIN_DIR)/$(notdir $(CURDIR))

.SUFFIXES:
.PHONY: all clean show rebuild

$(OUT): $(OBJ)
	@mkdir -p $(dir $@)
	$(LD) $^ $(LFLAGS) -o $@

$(OBJ_DIR)/%$(OBJ_EXT): %.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) $(INC)  -c $< -o $@ 
	
rebuild:
	$(MAKE) clean
	$(MAKE) all

all: $(OUT)	
run: $(OUT)
	@./$(OUT)

test: run
clean:
	@$(RM) -rf $(OUT) $(OBJ_DIR) $(BIN_DIR)
show:
	@echo INC =  $(INC)
	@echo SRC =  $(SRC)

-include $(OBJ:.o=.d)	