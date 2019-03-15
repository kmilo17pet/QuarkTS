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
CFLAGS   = -pedantic -std=c99 -O0
LINKER   = gcc
LFLAGS   = -Wall -I. -lm -lpthread
SRCDIR   = src
OBJDIR   = obj
BINDIR   = bin
TMPDIR   = tmp

##############################################
### Do not modify anything below this line ###
##############################################
SUBDIRS = $(OBJDIR) $(BINDIR) $(TMPDIR)
SOURCES  := $(wildcard $(SRCDIR)/*.c)
INCLUDES := $(wildcard $(SRCDIR)/*.h)
OBJECTS  := $(SOURCES:$(SRCDIR)/%.c=$(OBJDIR)/%.o)
rm       = rm -f

all: $(BINDIR)/$(TARGET)
	@echo "======================="
	@echo "||   BUILD SUCCESS   ||"
	@echo "======================="

$(BINDIR)/$(TARGET): $(OBJECTS)
	$(LINKER) $(CFLAGS) $(OBJECTS) $(LFLAGS) -o $@
	@echo "(*) LINKING COMPLETE!"

$(OBJECTS): $(OBJDIR)/%.o : $(SRCDIR)/%.c | subdirs
	$(CC) $(CFLAGS) -c $< -o $@
	@echo "(*) COMPILED "$<" SUCCESSFULLY"

.PHONY: subdirs $(SUBDIRS)
subdirs: $(SUBDIRS)
$(SUBDIRS):
	@mkdir -p $@

.PHONY: clean
clean: remove
	@$(rm) $(OBJECTS)
	@echo "Cleanup complete!"

.PHONY: remove
remove: 
	@$(rm) $(BINDIR)/$(TARGET)
	@echo "Executable removed!"