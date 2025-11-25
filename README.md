# Deriva-Lax

A numerical PDE solver implementing the Lax-Wendroff method for simulating wave propagation with periodic boundary conditions.

> **Note**: This is a college project created for educational purposes. While functional, it's not intended for production use or serious research applications. The code serves as a learning exercise in numerical methods and computational physics.

## Overview

`deriva-lax` is a C-based numerical simulation program that solves partial differential equations (PDEs) using a finite difference scheme. The program simulates wave propagation or advection phenomena over time, starting from a Gaussian initial condition.

The implementation uses a modified Lax-Wendroff scheme with periodic boundary conditions, making it suitable for studying wave dynamics in closed systems.

## Mathematical Background

### Initial Condition

The program starts with a Gaussian distribution centered at x = 50:

```
f(x) = 10 * exp(-(x-50)² / (2*σ²))
```

where σ = 10 (standard deviation).

### Numerical Scheme

The evolution equation implemented is:

```
u_j^(n+1) = (1/2)(u_(j-1)^n + u_(j+1)^n) - k(u_(j+1)^n - u_(j-1)^n)
```

where:
- `u_j^n` represents the state at spatial position j and time step n
- `k = 0.49` is the Courant-Friedrichs-Lewy (CFL) parameter
- Periodic boundary conditions are applied at j=0 and j=100

### Parameters

- **Grid points (jmax)**: 101
- **Time steps (tmax)**: 10,000
- **CFL parameter (k)**: 0.49
- **Boundary conditions**: Periodic

## Installation

### Prerequisites

- GCC compiler (or any standard C compiler)
- Standard C libraries (stdio, math, string, stdlib)

### Compilation

#### Using GCC (Linux/macOS):

```bash
gcc deriva_lax.c -o deriva_lax -lm
```

#### Using GCC (Windows with MinGW):

```bash
gcc deriva_lax.c -o deriva_lax.exe -lm
```

The `-lm` flag links the math library required for the `exp()` and `pow()` functions.

## Usage

### Running the Program

Simply execute the compiled binary:

```bash
./deriva_lax
```

On Windows:

```cmd
deriva_lax.exe
```

The program will run the simulation and generate an output file.

### Output

The program generates a file named `deriva_lax.txt` containing the simulation results.

#### Output Format

The output file contains space-separated data:

```
j  u(j)
0  0.123456
1  0.234567
...

```

- Each time step is separated by two blank lines
- First column: spatial grid index (j = 0 to 100)
- Second column: state value at that position
- Total entries: 101 points × 10,000 time steps

## Code Structure

### Main Components

1. **Function `f(double x)`** (lines 6-10)
   - Defines the Gaussian initial condition
   - Returns the value at position x

2. **Main Function** (lines 13-93)
   - File I/O setup
   - Variable initialization
   - Initial condition setup (lines 29-33)
   - Main time evolution loop (lines 36-83)
   - Boundary condition handling (lines 56, 69)

### Algorithm Flow

```
1. Initialize arrays (estado_antigo, estado_novo)
2. Set initial Gaussian distribution
3. For each time step:
   a. Write current state to file
   b. Apply finite difference scheme to interior points
   c. Apply periodic boundary conditions at edges
   d. Update state (estado_antigo ← estado_novo)
4. Close output file
```

## Visualization

The output data can be visualized using various tools:

### Using Python (matplotlib)

```python
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# Read data
data = []
with open('deriva_lax.txt', 'r') as f:
    current_time = []
    for line in f:
        if line.strip():
            j, u = map(float, line.split())
            current_time.append(u)
        elif current_time:
            data.append(current_time)
            current_time = []

# Create 3D plot
data = np.array(data)
X, Y = np.meshgrid(range(101), range(len(data)))

fig = plt.figure(figsize=(12, 8))
ax = fig.add_subplot(111, projection='3d')
ax.plot_surface(X, Y, data, cmap='viridis')
ax.set_xlabel('Spatial Position (j)')
ax.set_ylabel('Time Step')
ax.set_zlabel('Amplitude')
ax.set_title('Wave Evolution - Lax-Wendroff Method')
plt.show()
```

### Using MATLAB/Octave

```matlab
% Read and reshape data
data = load('deriva_lax.txt');
% Process and plot as needed
```

### Using gnuplot

```gnuplot
splot 'deriva_lax.txt' with lines
```

## Numerical Stability

The CFL condition for stability in this scheme is:

```
k ≤ 0.5
```

The current value `k = 0.49` ensures numerical stability throughout the simulation.

## Potential Modifications

### Adjusting Parameters

To modify simulation parameters, edit the values in `deriva_lax.c`:

- **Time steps**: Change `tmax` value (line 23)
- **Spatial resolution**: Change `jmax` value (line 25)
- **CFL parameter**: Change `k` value (line 24)
- **Initial condition**: Modify the `f(x)` function (lines 6-10)

### Example: Different Initial Condition

Replace the Gaussian with a rectangular pulse:

```c
double f(double x)
{
    return (x >= 40 && x <= 60) ? 1.0 : 0.0;
}
```

## Contributing

Contributions are welcome! Here are some ways you can contribute:

1. **Optimization**: Improve computational efficiency
2. **Features**: Add command-line arguments for parameter control
3. **Documentation**: Improve comments in code
4. **Visualization**: Add built-in plotting capabilities
5. **Schemes**: Implement alternative numerical methods
6. **Analysis**: Add stability and convergence analysis tools

Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## Known Issues

1. **Character encoding**: Line 28 comment contains non-ASCII characters (likely "condição inicial")
2. **Return type**: `main()` should return `int` instead of `void` for standard compliance
3. **Output file size**: With 10,000 time steps, the output file can be large (~10 MB)

## Performance

- **Typical runtime**: < 1 second for default parameters (10,000 steps, 101 points)
- **Memory usage**: Minimal (~2 KB for arrays)
- **Output file size**: ~10 MB for default parameters

## References

1. Lax, P. D., & Wendroff, B. (1960). "Systems of conservation laws". Communications on Pure and Applied Mathematics, 13(2), 217-237.
2. LeVeque, R. J. (2002). "Finite Volume Methods for Hyperbolic Problems". Cambridge University Press.
3. Strikwerda, J. C. (2004). "Finite Difference Schemes and Partial Differential Equations". SIAM.

## License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details.

## Author

This project is maintained on GitHub. Feel free to open issues or submit pull requests.

## Acknowledgments

This implementation demonstrates classic finite difference methods for educational and research purposes in numerical analysis and computational physics.

---

**Note**: This program is provided as-is for educational and research purposes. Always verify numerical results against analytical solutions or established benchmarks when using for serious research.
