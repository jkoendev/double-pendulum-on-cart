# You are free to use, modify, copy, distribute the code.
# Please give a clap on medium, star on github, or share the article if you
# like.
# Created by Jonas, github.com/jkoendev

# Double pendulum on a cart (dpc) simulation code
#
# This file runs the simulation using python initial value problem solver.
# You need to generate the dynamics before running this file!
#
# run `dpc_lagrange.py` first!

import numpy as np
from scipy.integrate import solve_ivp


# this module must be generated by running `dpc_lagrange.py`
from dpc_dynamics_generated import dpc_dynamics_generated
from dpc_draw import dpc_draw

def main():
  # parameters
  # you can modify the parameters to get a different behaviour
  p = {
    "r_1" : 1,
    "r_2" : 1,
    "m_c" : 5,
    "m_1" : 1,
    "m_2" : 1,
    "g" : 9.81
  }

  def dpc_ode(t, x):
    f = 0;
    return dpc_dynamics_generated(x[0], x[1], x[2], x[3], x[4], x[5], f, p["r_1"], p["r_2"], p["m_c"], p["m_1"], p["m_2"], p["g"]);

  # get a random starting state between min state and max state
  x_min = np.array([-1, -np.pi, -np.pi, -.05, -1, -1]);
  x_max = -x_min;
  x0 = np.random.uniform(low=0.0, high=1.0, size=6) * (x_max-x_min)+x_min;

  # simulate
  t_eval = np.arange(0, 8, 0.025);
  sol = solve_ivp(dpc_ode, [0,8], x0, method="RK45", t_eval=t_eval);

  t_span = sol.t
  X = sol.y

  dpc_draw(t_span, X, x_min, x_max, p);

if __name__ == '__main__':
  main()
