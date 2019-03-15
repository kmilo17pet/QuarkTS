####
#### Generic Makefile for C 
####
#### This file is public domain.
#### Author: Eng. J. Camilo Gomez Cadavid
####

###################################
### User configurable variables ###
###################################
TARGET   = $(shell basename $$(pwd))
CC       = gcc
LIBS     = 
INCS 	 = -I.
CFLAGS   = -pedantic $(INCS) -std=c99 -O0
LINKER   = gcc
LFLAGS   = -Wall $(LIBS) -lm -lpthread
SRCDIR   = src
OBJDIR   = obj
BINDIR   = bin
##############################################
### Do not modify anything below this line ###
##############################################
SUBDIRS = $(OBJDIR) $(BINDIR) 
SOURCES := $(wildcard *.c */*.c */*/*.c */*/*/*.c)
INCLUDES := $(dir $(wildcard *.h */*.h */*/*.h */*/*/*.h))
OBJECTS  := $(SOURCES:$(SRCDIR)/%.c=$(OBJDIR)/%.o)
OBJS_FILENAME := $(notdir $(OBJECTS))
OBJS_OUTPATH := $(OBJS_FILENAME:%=$(OBJDIR)/%)
INC_PATHS = $(INCLUDES:%=-I./%)
rm       = rm -f

all: $(BINDIR)/$(TARGET)
	@echo "======================="
	@echo "||   BUILD SUCCESS   ||"
	@echo "======================="

$(BINDIR)/$(TARGET): $(OBJECTS)
	$(LINKER) $(CFLAGS) $(OBJS_OUTPATH) $(LFLAGS) -o $@
	@echo "(*) LINKING COMPLETE!"

$(OBJECTS): $(OBJDIR)/%.o : $(SRCDIR)/%.c | subdirs
	$(CC) $(CFLAGS) $(INC_PATHS) -c $< -o $(OBJDIR)/$(notdir $@) 
	@echo "(*) COMPILED "$<" SUCCESSFULLY"

.PHONY: subdirs $(SUBDIRS)
subdirs: $(SUBDIRS)
$(SUBDIRS):
	@mkdir -p $@

.PHONY: clean
clean: remove
	@$(rm) $(OBJS_OUTPATH)
	@echo "Cleanup complete!"

.PHONY: remove
remove: 
	@$(rm) $(BINDIR)/$(TARGET)
	@echo "Executable removed!"