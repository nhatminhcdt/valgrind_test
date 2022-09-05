# The default shell is /bin/sh
# Change the default shell
# SHELL=/bin/bash

# ===Error handling===
# Add	-k	when running make to continue running even in the face of errors. Helpful if you want to see all the errors of Make at once.
# Add	-	before a command to suppress the error
# Add	-i	to make to have this happen for every command.

# ===Flag for implicit rules===
# Flags for compiling C++ programs
CXX = g++
# using c++11 standard, turning on debug info
CXXFLAGS = -std=c++11 -g
COVFLAGS = --coverage
# GPROF Flags
# -pg			gprof
# -no-pie		no position independent
# -fno-builtin	don't replace my function with inline
GPROFFLAGS = -pg -no-pie -fno-builtin
# Extra flags to give to compilers when they are supposed to invoke the linker
LDFLAGS= -pthread
# Flags for compiling C++ programs
CCC = gcc
CFLAGS = -I
# ==========# ==========# ==========
I_DIR = ./include
SRC_DIR := ./src
BUILD_DIR := ./build
CHECK_DIR := ./check

TARGET_EXEC := $(BUILD_DIR)/prog.exe

# First target is default target
# Generate executable files
# Delete the target of a rule if the rule fails
.DELETE_ON_ERROR:
all: $(TARGET_EXEC)
	echo "Compilation success!"

# Create list of dependancy files for each object file.
# including .h files and .inl files
DEPS = $(shell find $(I_DIR) -name "*.h" -o -name "*.inl")
_dep:
	@echo $(DEPS)
# String Substitution
# $(patsubst pattern,replacement,text)
# If replacement also contains a Åe%Åf, the Åe%Åf is replaced by the text that matched the Åe%Åf in pattern
#DEPS = $(patsubst %,$(I_DIR)/%,$(_DEPS))
# The substitution reference $(text:pattern=replacement) is a shorthand for this.
#DEPS = $(_DEPS:%=$(I_DIR)/%)

# Find all the C and C++ files we want to compile
SRCS = $(shell find $(SRC_DIR) -name "*.cpp" -o -name "*.c")
_src:
	@echo $(SRCS)
# Object files
# Syntax - targets ...: target-pattern: prereq-patterns ...
# $(OBJS): %o: %.cpp
SRC_FILES = $(notdir $(SRCS))
# $(text:pattern=replacement)
# If replacement also contains a Åe%Åf, the Åe%Åf is replaced by the text that matched the Åe%Åf in pattern
OBJS = $(SRC_FILES:%.cpp=$(BUILD_DIR)/%.o)
#OBJS = $(SRC_FILES:%.c=$(BUILD_DIR)/%.o)
_obj:
	@echo $(OBJS)

# $^ the prerequisites on the right of ":"
$(TARGET_EXEC): $(OBJS)
	$(CXX) -o $@ $^ $(LDFLAGS) $(COVFLAGS) $(GPROFFLAGS)

# Build step for C source
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c $(DEPS)
	mkdir -p $(dir $@)
	$(CC) -c $< -o $@ $(CPPFLAGS) $(CFLAGS)
# Build step for C++ source
# Define a pattern rule that compiles every .c file into a .o file
$(BUILD_DIR)/%.o:$(SRC_DIR)/%.cpp $(DEPS)
#	The -p option to mkdir prevents the error message if the directory exists
	mkdir -p $(dir $@)
# updating a Åe.oÅf file from a correspondingly named Åe.cÅf file using a g++ -cÅf command
# $@ is the name of the target being generated, and $< is the first prerequisite
	$(CXX) -c -o $@ $< $(CXXFLAGS) $(COVFLAGS) $(GPROFFLAGS)

.PHONY: clean
clean:
#	rm -f $(BUILD_DIR)/*
# Posix systems have a feature called core dumps.
# If core dumps are enabled, a file will be created named core that contains information about the program's state when it crashed,
# so you can use a tool like gdb to debug crashes after they occur
# *~ remove these backup copies
	rm -rf $(BUILD_DIR)/*.o $(BUILD_DIR)/*.exe */*.gcno */*.gcda */*.info ./*.out */*.log ./*.gcov *~ core