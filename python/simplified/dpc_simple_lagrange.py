# You are free to use, modify, copy, distribute the code.
# Please give a clap on medium, star on github, or share the article if you
# like.
# Created by Jonas, github.com/jkoendev

# Double pendulum on a cart (dpc) simulation code
#
# This file generates the model from symbolic expressions and generates a
# file with the name `dpc_dynamics_generated.py`

import sympy
from sympy import sin, cos, simplify
from sympy import symbols as syms
from sympy.matrices import Matrix
from sympy.utilities.lambdify import lambdastr


# state, state derivative, and control variables
q_0, q_1, q_2, qdot_0, qdot_1, qdot_2, qddot_0, qddot_1, qddot_2, f = syms('q_0 q_1 q_2 qdot_0 qdot_1 qdot_2 qddot_0 qddot_1 qddot_2 f')

# parameters
r_1, r_2, m_c, m_1, m_2, g = syms('r_1 r_2 m_c m_1 m_2 g')

p = Matrix([r_1, r_2, m_c, m_1, m_2, g])      # parameter vector

q = Matrix([q_0, q_1, q_2])                   # generalized positions
qdot = Matrix([qdot_0, qdot_1, qdot_2])       # time derivative of q
qddot = Matrix([qddot_0, qddot_1, qddot_2])   # time derivative of qdot

# To calculate time derivatives of a function f(q), we use:
# df(q)/dt = df(q)/dq * dq/dt = df(q)/dq * qdot

# kinematics:
p_c = Matrix([q_0, 0])
p_1 = p_c + r_1/2 * Matrix([cos(q_1), sin(q_1)])
p_2 = p_c + r_1 * Matrix([cos(q_1), sin(q_1)]) + r_2/2 * Matrix([cos(q_1+q_2), sin(q_1+q_2)])

v_c = p_c.jacobian(Matrix([q_0])) * Matrix([qdot_0])
v_1 = p_1.jacobian(Matrix([q_0, q_1])) * Matrix([qdot_0, qdot_1])
v_2 = p_2.jacobian(Matrix([q_0, q_1, q_2])) * Matrix([qdot_0, qdot_1, qdot_2])

K_c = m_c * v_c.T*v_c / 2
K_1 = m_1 * v_1.T*v_1 / 2
K_2 = m_2 * v_2.T*v_2 / 2

P_1 = Matrix([m_1 * g * p_1[1]])
P_2 = Matrix([m_2 * g * p_2[1]])

# dynamics:

# Lagrangian L=sum(K)-sum(P)
L = K_c + K_1 + K_2 - P_1 - P_2

# first term in the Euler-Lagrange equation
partial_L_by_partial_q = L.jacobian(Matrix([q])).T

# inner term of the second part of the Euler-Lagrange equation
partial_L_by_partial_qdot = L.jacobian(Matrix([qdot]))

# second term (overall, time derivative) in the Euler-Lagrange equation
# applies the chain rule
d_inner_by_dt = partial_L_by_partial_qdot.jacobian(Matrix([q])) * qdot + partial_L_by_partial_qdot.jacobian(Matrix([qdot])) * qddot

# Euler-Lagrange equation
lagrange_eq =  partial_L_by_partial_q - d_inner_by_dt - Matrix([f,0,0])

# substitude parameters with numerical values to get simpler equations
lagrange_eq = lagrange_eq.subs({r_1:1, r_2:1, m_c:5, m_1:1, m_2:1, g:9.81});

# solve the lagrange equation for qddot and simplify
print("Calculations take a while...")
r = sympy.solvers.solve(simplify(lagrange_eq), Matrix([qddot]))

qddot_0 = r[qddot_0];
qddot_1 = r[qddot_1];
qddot_2 = r[qddot_2];

print('qddot_0 = {}\n'.format(qddot_0));
print('qddot_1 = {}\n'.format(qddot_1));
print('qddot_2 = {}\n'.format(qddot_2));
#
# # generate python function
s = lambdastr((q_0, q_1, q_2, qdot_0, qdot_1, qdot_2, f, r_1, r_2, m_c, m_1, m_2, g),
               [qdot_0, qdot_1, qdot_2, qddot_0, qddot_1, qddot_2])
