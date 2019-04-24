# Double pendulum on a cart (dpc) simulation model

The blog post can be viewed at the [OpenOCL blog](https://openocl.org/tutorials/tutorial-01-modeling-double-cartpole/) and at [Medium]().

## Prerequisites

### Python

```python
pip install scipy
pip install numpy
pip install sympy
pip install matplotlib
```

### Matlab

* Matlab symbolic toolbox

### Octave

* Python
* Symbolic package

Load symbolic package before running the code
```m
pkg load symbolic
```

## Executing the simulation

First run `dpc_lagrange` to generate the system dynamics function. The generated function will be created under the name `dpc_dynamics_generated`.

Then you can run `dpc_simulate` to simulate and draw the animation.

You can also modify the parameters at the top of the simulation file.

## Simplified version

In the subdirectory is a simplified version of the program where the parameters are hardcoded into the system equations. In this way the equations fit on a single page (for the web). This version is presented in the blog post. However, here we can not change the parameters easily in the simulation but have solve the Euler-Lagrange equations again with the modified parameters.

This version can be run using the `dpc_simple_simulate` script (no code generation for the dynamics required).

## License

You are free to use, modify, copy, distribute the code. Please give a clap on medium, star on github, or share the article if you like. Created by: [https://github.com/jkoendev/](https://github.com/jkoendev/)
