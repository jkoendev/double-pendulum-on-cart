# Double pendulum on cart (dpc) simulation

First run `dpc_lagrange.m` to generate the system dynamics function. The generated function will be created under the name `dpc_dynamics_generated.m`.

Then you can run `dpc_simulate.m` to simulate and draw the animation.

You can also modify the parameters at the top of the simulation file.

## Simplified version

In the subdirectory is a simplified version of the program where the parameters are hardcoded into the system equations. In this way the equations fit on a single page. This version is presented in the blog post. However, here we can not change the parameters easily in the simulation but have solve the Euler-Lagrange equations again with the modified parameters.
