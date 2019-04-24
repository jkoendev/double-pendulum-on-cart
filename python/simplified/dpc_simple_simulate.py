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
import math
from scipy.integrate import solve_ivp

from dpc_simple_draw import dpc_simple_draw

def main():

  # parameters
  p = {
    "r_1" : 1,
    "r_2" : 1,
    "m_c" : 5,
    "m_1" : 1,
    "m_2" : 1,
    "g" : 0.81
  }

  # get a random starting state between min state and max state
  x_min = np.array([-1, -np.pi, -np.pi, -.05, -1, -1]);
  x_max = -x_min;
  x0 = np.random.uniform(low=0.0, high=1.0, size=6) * \
       (x_max-x_min)+x_min;

  # simulate
  t_eval = np.arange(0, 8, 0.025);
  sol = solve_ivp(dpc_ode, [0,8], x0, method="RK45", t_eval=t_eval);

  dpc_simple_draw(sol.t, sol.y, x_min, x_max, p);

def dpc_ode(t, x):
  q_0 = x[0];
  q_1 = x[1];
  q_2 = x[2];

  qdot_0 = x[3];
  qdot_1 = x[4];
  qdot_2 = x[5];
  f = 0;

  qddot_0 = (4.0*f*math.cos(2.0*q_2)-6.0*f+
             4.0*qdot_1**2*math.cos(q_1)+
             qdot_1**2*math.cos(q_1-q_2)-
             qdot_1**2*math.cos(q_1+2.0*q_2)+
             2.0*qdot_1*qdot_2*math.cos(q_1-q_2)+
             qdot_2**2*math.cos(q_1-q_2)-
             29.43*math.sin(2.0*q_1)+
             9.81*math.sin(2.0*q_1+2.0*q_2)) / \
            (3.0*math.cos(2.0*q_1)-22.0*math.cos(2.0*q_2)-
             math.cos(2.0*q_1+2.0*q_2)+34.0)
  qddot_1 = (-8.0*f*math.sin(q_1)+4.0*f*math.sin(q_1+2.0*q_2)+
             3.0*qdot_1**2*math.sin(2.0*q_1)+
             23.0*qdot_1**2*math.sin(q_2)+
             22.0*qdot_1**2*math.sin(2.0*q_2)+
             qdot_1**2*math.sin(2.0*q_1+q_2)+
             46.0*qdot_1*qdot_2*math.sin(q_2)+
             2.0*qdot_1*qdot_2*math.sin(2.0*q_1+q_2)+
             23.0*qdot_2**2*math.sin(q_2)+
             qdot_2**2*math.sin(2.0*q_1+q_2)-
             490.5*math.cos(q_1)+
             215.82*math.cos(q_1+2.0*q_2)) / \
            (3.0*math.cos(2.0*q_1)-
             22.0*math.cos(2.0*q_2)-
             math.cos(2.0*q_1+2.0*q_2)+34.0)
  qddot_2 = -((100.0*qdot_1**2*math.sin(q_2)+
               981.0*math.cos(q_1+q_2)) *
              (-(3.0*math.sin(q_1)+
                 math.sin(q_1+q_2))**2+
               28.0*math.cos(q_2)+42.0)+
              0.5*(200.0*qdot_1*qdot_2*math.sin(q_2)+
                   100.0*qdot_2**2*math.sin(q_2)-
                   2943.0*math.cos(q_1)-
                   981.0*math.cos(q_1+q_2))*
              (25.0*math.cos(q_2)+3.0*math.cos(2.0*q_1+q_2)+
               math.cos(2.0*q_1+2.0*q_2)+13.0)+
               50.0*(2.0*math.sin(q_1)+3.0*math.sin(q_1-q_2)-
               2.0*math.sin(q_1+q_2)-math.sin(q_1+2.0*q_2))*
              (-2.0*f+3.0*qdot_1**2*math.cos(q_1)+
               qdot_1**2*math.cos(q_1+q_2)+
               2.0*qdot_1*qdot_2*math.cos(q_1+q_2)+
               qdot_2**2*math.cos(q_1+q_2))) / \
             (75.0*math.cos(2.0*q_1)-550.0*math.cos(2.0*q_2)-
              25.0*math.cos(2.0*q_1+2.0*q_2)+850.0)

  return [qdot_0, qdot_1, qdot_2, qddot_0, qddot_1, qddot_2]

if __name__ == '__main__':
  main()
