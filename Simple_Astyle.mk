# MIT License
# 
# Copyright (c) 2024 AverageMensch
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Filenames
MAKEFILE = Makefile
EXECUTABLE = my_program

# Compiler and linker
CC = gcc
CFLAGS = -Wall -Wextra -Os -MMD -MP -c
LD = gcc
LDFLAGS = -s

# Code formatter
FMT = astyle
FMT_FLAGS = --style=allman --max-code-length=100 --suffix=none

# Define direcories
INC_DIR = include/
SRC_DIR = source/
OBJ_DIR = .build/

# Add get source files and include flag
INC_FILES = $(wildcard $(INC_DIR)*.h)
SRC_FILES = $(wildcard $(SRC_DIR)*.c)
OBJ_FILES = $(patsubst $(SRC_DIR)%.c,$(OBJ_DIR)%.o,$(SRC_FILES))
CFLAGS += -I$(INC_DIR)

# Compile executable
bin: $(EXECUTABLE)

$(EXECUTABLE): $(OBJ_FILES)
	$(LD) $(LDFLAGS) -o $@ $^

-include $(wildcard $(OBJ_DIR)*.d)

$(OBJ_DIR)%.o: $(SRC_DIR)%.c $(MAKEFILE) | $(OBJ_DIR)
	$(CC) $(CFLAGS) -o $@ $<

$(OBJ_DIR):
	mkdir -p $@

# Phony rules
run: $(EXECUTABLE)
	@./$<

format:
	$(FMT) $(FMT_FLAGS) $(INC_FILES) $(SRC_FILES)

clean:
	rm -vrf $(OBJ_DIR)

.PHONY: run format clean