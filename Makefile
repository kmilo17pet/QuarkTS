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
COM_COLOR   = \033[0;34m
OBJ_COLOR   = \033[0;36m
OK_COLOR    = \033[0;32m
ERROR_COLOR = \033[0;31m
WARN_COLOR  = \033[0;33m
NO_COLOR    = \033[m

OK_STRING    = "[OK]"
ERROR_STRING = "[ERROR]"
WARN_STRING  = "[WARNING]"
COM_STRING   = "Compiling"
SUCCESS_STRING = "Success!"
LINK_STRING = "Linking..."

define run_and_test
echo $(1); \
printf "%b" "$(COM_COLOR)$(COM_STRING) $(OBJ_COLOR)$(@F)$(NO_COLOR)\r"; \
$(1) 2> $@.log; \
RESULT=$$?; \
if [ $$RESULT -ne 0 ]; then \
  printf "%-60b%b" "$(COM_COLOR)$(COM_STRING)$(OBJ_COLOR) $@" "$(ERROR_COLOR)$(ERROR_STRING)$(NO_COLOR)\n"   ; \
elif [ -s $@.log ]; then \
  printf "%-60b%b" "$(COM_COLOR)$(COM_STRING)$(OBJ_COLOR) $@" "$(WARN_COLOR)$(WARN_STRING)$(NO_COLOR)\n"   ; \
else  \
  printf "%-60b%b" "$(COM_COLOR)$(COM_STRING)$(OBJ_COLOR) $(@F)" "$(OK_COLOR)$(OK_STRING)$(NO_COLOR)\n"   ; \
fi; \
cat $@.log; \
rm -f $@.log; \
exit $$RESULT
endef

INC 	:= 	$(sort -I. $(addprefix -I./,$(dir  $(wildcard *.h */*.h */*/*.h */*/*/*.h)   )) )
SRC 	:= 	$(wildcard src/**/*.c)
OBJ 	:= 	$(addprefix $(OBJ_DIR)/,$(SRC:.c=$(OBJ_EXT)))
OUT 	= 	$(BIN_DIR)/$(notdir $(CURDIR))

.SUFFIXES:
.PHONY: all clean show rebuild

$(OUT): $(OBJ)
	@mkdir -p $(dir $@)
	@printf "%b" "$(COM_COLOR)$(LINK_STRING)$(NO_COLOR)\n" ; 
	$(LD) $^ $(LFLAGS) -o $@
	@echo "-------------------------------"
	@printf "%b" "$(COM_COLOR)$(SUCCESS_STRING)$(NO_COLOR)\n"  ; 

$(OBJ_DIR)/%$(OBJ_EXT): %.c
	@mkdir -p $(dir $@)
	@$(call run_and_test, $(CC) $(CFLAGS) $(INC)  -c $< -o $@ )
	
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