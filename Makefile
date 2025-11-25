# Makefile for Deriva-Lax
# A simple numerical PDE solver

# Compiler and flags
CC = gcc
CFLAGS = -Wall -Wextra -O2
LDFLAGS = -lm

# Target executable
TARGET = deriva_lax

# Source files
SOURCES = deriva_lax.c

# Object files
OBJECTS = $(SOURCES:.c=.o)

# Output file
OUTPUT = deriva_lax.txt

# Default target
all: $(TARGET)

# Build the executable
$(TARGET): $(SOURCES)
	$(CC) $(CFLAGS) $(SOURCES) -o $(TARGET) $(LDFLAGS)
	@echo "Build complete! Run with: ./$(TARGET)"

# Compile object files
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Run the program
run: $(TARGET)
	./$(TARGET)
	@echo "Simulation complete! Output saved to $(OUTPUT)"

# Clean build artifacts and output
clean:
	rm -f $(TARGET) $(OBJECTS) $(OUTPUT)
	@echo "Cleaned build artifacts and output files"

# Clean only the output file
clean-output:
	rm -f $(OUTPUT)
	@echo "Cleaned output file"

# Install (copy to /usr/local/bin) - requires sudo
install: $(TARGET)
	install -m 0755 $(TARGET) /usr/local/bin
	@echo "Installed to /usr/local/bin/$(TARGET)"

# Uninstall
uninstall:
	rm -f /usr/local/bin/$(TARGET)
	@echo "Uninstalled $(TARGET)"

# Debug build (with symbols, no optimization)
debug: CFLAGS = -Wall -Wextra -g -O0
debug: clean $(TARGET)
	@echo "Debug build complete"

# Help message
help:
	@echo "Deriva-Lax Makefile"
	@echo ""
	@echo "Usage:"
	@echo "  make           - Build the program"
	@echo "  make run       - Build and run the program"
	@echo "  make clean     - Remove build artifacts and output"
	@echo "  make debug     - Build with debug symbols"
	@echo "  make install   - Install to /usr/local/bin (requires sudo)"
	@echo "  make uninstall - Remove from /usr/local/bin"
	@echo "  make help      - Show this help message"

# Phony targets
.PHONY: all clean clean-output run install uninstall debug help
