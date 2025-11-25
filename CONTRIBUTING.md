# Contributing to Deriva-Lax

Thank you for your interest in contributing to Deriva-Lax! This document provides guidelines and instructions for contributing to the project.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
- [Development Setup](#development-setup)
- [Coding Standards](#coding-standards)
- [Submitting Changes](#submitting-changes)
- [Testing](#testing)
- [Documentation](#documentation)

## Code of Conduct

This project aims to foster an open and welcoming environment. Please be respectful and constructive in all interactions.

### Our Standards

- Be respectful and inclusive
- Focus on constructive feedback
- Accept criticism gracefully
- Prioritize the community's best interests

## How Can I Contribute?

### Reporting Bugs

Before submitting a bug report, please:

1. Check existing issues to avoid duplicates
2. Use the latest version of the code
3. Verify the bug is reproducible

**When reporting bugs, include:**
- Operating system and compiler version
- Steps to reproduce the issue
- Expected vs. actual behavior
- Relevant code snippets or error messages
- Output file samples if applicable

### Suggesting Enhancements

Enhancement suggestions are welcome! Please include:

- Clear description of the feature
- Use cases and benefits
- Potential implementation approach
- Any relevant examples or references

### Pull Requests

We actively welcome pull requests for:

1. **Bug fixes**
2. **Performance improvements**
3. **New features**
4. **Documentation improvements**
5. **Code cleanup and refactoring**

## Development Setup

### Prerequisites

- GCC compiler (or compatible C compiler)
- Git for version control
- Text editor or IDE
- (Optional) Python/MATLAB for visualization

### Setting Up Your Development Environment

1. **Fork the repository** on GitHub

2. **Clone your fork:**
   ```bash
   git clone https://github.com/YOUR-USERNAME/deriva-lax.git
   cd deriva-lax
   ```

3. **Create a branch for your changes:**
   ```bash
   git checkout -b feature/your-feature-name
   ```

4. **Compile and test:**
   ```bash
   gcc deriva_lax.c -o deriva_lax -lm
   ./deriva_lax
   ```

## Coding Standards

### C Code Style

Follow these guidelines for consistency:

#### Formatting
- **Indentation**: 4 spaces (no tabs)
- **Braces**: K&R style
  ```c
  if (condition) {
      // code
  }
  ```
- **Line length**: Maximum 80 characters when practical

#### Naming Conventions
- **Functions**: lowercase with underscores: `calculate_derivative()`
- **Variables**: descriptive names: `spatial_index`, `time_step`
- **Constants**: uppercase with underscores: `MAX_ITERATIONS`

#### Comments
- Use clear, concise comments
- Explain **why**, not **what** (code should be self-explanatory)
- Document complex algorithms with references

**Example:**
```c
// Apply Lax-Wendroff scheme at interior points
// Reference: Lax & Wendroff (1960), equation (12)
for (j = 1; j < jmax - 1; j++) {
    estado_novo[j] = 0.5 * (estado_antigo[j-1] + estado_antigo[j+1])
                     - k * (estado_antigo[j+1] - estado_antigo[j-1]);
}
```

### Code Quality

- **No warnings**: Code should compile without warnings
- **Standard compliance**: Follow C99 or later standards
- **Error handling**: Check file operations and memory allocations
- **Memory management**: Free allocated memory; avoid leaks

### Specific Improvements Welcome

#### Code Standards Issues
The current code has areas for improvement:

1. **Main return type**: Change `void main()` to `int main()`
2. **Character encoding**: Fix non-ASCII characters in comments
3. **Variable naming**: Consider English names for broader accessibility
4. **Error handling**: Add checks for file operations
5. **Memory safety**: Add bounds checking

**Example fix:**
```c
// Current
void main() {
    FILE *arq;
    arq = fopen("deriva_lax.txt", "w+");
    // ...
}

// Improved
int main(void) {
    FILE *output_file;
    output_file = fopen("deriva_lax.txt", "w");
    if (output_file == NULL) {
        fprintf(stderr, "Error: Cannot open output file\n");
        return 1;
    }
    // ...
    fclose(output_file);
    return 0;
}
```

## Submitting Changes

### Before Submitting

1. **Test your changes** thoroughly
2. **Compile without warnings:**
   ```bash
   gcc -Wall -Wextra -pedantic deriva_lax.c -o deriva_lax -lm
   ```
3. **Update documentation** if needed
4. **Verify output** matches expected results

### Pull Request Process

1. **Commit your changes:**
   ```bash
   git add .
   git commit -m "Brief description of changes"
   ```

2. **Push to your fork:**
   ```bash
   git push origin feature/your-feature-name
   ```

3. **Create a Pull Request** on GitHub with:
   - Clear title describing the change
   - Detailed description of what and why
   - Reference to related issues (if any)
   - Screenshots or output samples (if applicable)

### Commit Message Guidelines

Follow these conventions:

```
type: Short summary (50 chars or less)

Detailed explanation if needed. Wrap at 72 characters.
Explain the problem and why this change is needed.

Reference issues: Fixes #123
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code formatting (no functional changes)
- `refactor`: Code restructuring
- `perf`: Performance improvements
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

**Examples:**
```
feat: Add command-line parameter support

Allow users to specify tmax, jmax, and k via command-line
arguments instead of modifying source code.

Fixes #42
```

```
fix: Correct boundary condition calculation

The periodic boundary at j=0 was using incorrect indices.
Now properly wraps to jmax-1.

Fixes #15
```

## Testing

### Manual Testing

After changes, verify:

1. **Compilation succeeds:**
   ```bash
   gcc deriva_lax.c -o deriva_lax -lm
   ```

2. **Program runs without errors:**
   ```bash
   ./deriva_lax
   ```

3. **Output file is generated:**
   ```bash
   ls -lh deriva_lax.txt
   ```

4. **Output format is correct:**
   ```bash
   head -n 20 deriva_lax.txt
   ```

### Validation Tests

For numerical changes, validate:

1. **Energy conservation** (if applicable)
2. **Symmetry preservation**
3. **Stability** (no exponential growth)
4. **Convergence** (results improve with resolution)

### Benchmark Results

If modifying the algorithm, provide benchmark comparisons:

```
Before: Runtime 0.85s, Max value 9.87
After:  Runtime 0.45s, Max value 9.87 (47% faster, same accuracy)
```

## Documentation

### Code Documentation

- Add inline comments for complex logic
- Use meaningful variable and function names
- Document assumptions and limitations

### README Updates

If your changes affect usage:
- Update relevant sections in README.md
- Add examples for new features
- Update parameter descriptions

### API Documentation

For new functions:

```c
/**
 * Calculate the wave speed at a given position
 *
 * @param position   Spatial coordinate (0 to jmax-1)
 * @param amplitude  Current amplitude value
 * @return Wave speed at the specified position
 */
double calculate_wave_speed(int position, double amplitude);
```

## Feature Ideas

Looking for ideas? Consider these enhancements:

### High Priority
- [ ] Command-line argument parsing
- [ ] Multiple output format support (CSV, binary)
- [ ] Progress indicator for long simulations
- [ ] Configuration file support

### Medium Priority
- [ ] Built-in visualization (gnuplot integration)
- [ ] Multiple initial condition presets
- [ ] Adaptive time stepping
- [ ] Parallel processing (OpenMP)

### Low Priority
- [ ] 2D simulation support
- [ ] Interactive parameter tuning
- [ ] Real-time plotting
- [ ] Checkpoint/restart capability

## Questions?

If you have questions:
1. Check existing issues and documentation
2. Open a new issue with the "question" label
3. Provide context and what you've already tried

## License

By contributing, you agree that your contributions will be licensed under the GNU General Public License v3.0.

## Recognition

Contributors will be acknowledged in the project. Significant contributions may be recognized with co-authorship on research outputs using this code.

---

Thank you for contributing to Deriva-Lax!
