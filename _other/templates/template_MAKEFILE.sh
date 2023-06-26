#!/bin/bash


echo $"\
BIN_DIR := bin
BUILD_DIR := build
DATA_DIR := data
INCLUDE_DIR := include
OUTPUT_DIR := output
SCRIPTS_DIR := scripts
SRC_DIR := src
TEST_DIR := test

CC := gcc
CFLAGS = -g -I \$(INCLUDE_DIR)/ -Wno-unused-result
CLIBS = -lpthread -lm

SRCS := \$(wildcard \$(SRC_DIR)/*.c)
OBJS := \$(patsubst \$(SRC_DIR)/%.c, \$(BUILD_DIR)/%.o, \$(SRCS))
MAIN := main
EXEC := bin/\$(MAIN).out


# Default target: create main executable.
\$(EXEC): dirs \$(OBJS)
	\$(CC) \$(CFLAGS) \$(OBJS) \$(CLIBS) -o \$@


# Create object files.
\$(BUILD_DIR)/%.o: \$(SRC_DIR)/%.c
	\$(CC) \$(CFLAGS) -c $< -o \$@


.PHONY: all debug test dirs clean


# Compile all, same as default target.
all: \$(EXEC)


# Compile with all warnings activated and declare _DEBUG flag.
debug: CFLAGS += -D_DEBUG -Wall -Wextra -Wshadow -Wvla
debug: clean \$(EXEC)


# Compile test file(s).
test: dirs \$(OBJS)
	\$(CC) \$(CFLAGS) -c test/test.c \$(CLIBS) -o build/test.o
	rm \$(BUILD_DIR)/\$(MAIN).o
	\$(CC) \$(CFLAGS) build/*.o \$(CLIBS) -o bin/test.out


# Create needed directories if they do not already exist.
dirs:
	\$(shell if [ ! -d \$(BIN_DIR) ]; then mkdir -p \$(BIN_DIR); fi)
	\$(shell if [ ! -d \$(BUILD_DIR) ]; then mkdir -p \$(BUILD_DIR); fi)


# Delete object files and executables.
clean:
	-rm \$(BUILD_DIR)/* \$(BIN_DIR)/*
" > makefile
