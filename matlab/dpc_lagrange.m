% You are free to use, modify, copy, distribute the code.
% Please give a clap on medium, star on github, or share the article if you
% like.
%
% Created by github.com/jkoendev

syms q_0 q_1 q_2 qdot_0 qdot_1 qdot_2 qddot_0 qddot_1 qddot_2 f
syms r_1 r_2 m_c m_1 m_2 g xi_1 xi_2 % parameters

p = [r_1; r_2; m_c; m_1; m_2; g; xi_1; xi_2]; % parameter vector

q = [q_0; q_1; q_2];                  % generalized positions
qdot = [qdot_0; qdot_1; qdot_2];      % time derivative of q
qddot = [qddot_0; qddot_1; qddot_2];  % time derivative of qdot

% To calculate time derivatives of a function f(q), we use:
% df(q)/dt = df(q)/dq * dq/dt = df(q)/dq * qdot

% kinematics:
p_c = [q_0; 0];
p_1 = p_c + r_1/2 * [-sin(q_1); cos(q_1)];
p_2 = p_c + r_1 * [-sin(q_1); cos(q_1)] + r_2/2 * [-sin(q_1+q_2); cos(q_1+q_2)];

v_c = jacobian(p_c, q_0) * qdot_0;
v_1 = jacobian(p_1, [q_0; q_1]) * [qdot_0; qdot_1];
v_2 = jacobian(p_2, [q_0; q_1; q_2]) * [qdot_0; qdot_1; qdot_2];


K_c = m_c * (v_c.'*v_c) / 2;
K_1 = m_1 * (v_1.'*v_1) / 2;
K_2 = m_2 * (v_2.'*v_2) / 2;

P_1 = m_1 * g * p_1(2);
P_2 = m_2 * g * p_2(2);

% dynamics:

% Lagrangian L=sum(K)-sum(P)
L = K_c + K_1 + K_2 - P_1 - P_2;

% first term in the Euler-Lagrange equation
partial_L_by_partial_q = jacobian(L, q).';

% inner term of the second part of the Euler-Lagrange equation
partial_L_by_partial_qdot = jacobian(L, qdot).';

% second term (overall, time derivative) in the Euler-Lagrange equation
% applies the chain rule
d_inner_by_dt = jacobian(partial_L_by_partial_qdot, q) * qdot + jacobian(partial_L_by_partial_qdot, qdot) * qddot;

% Euler-Lagrange equation
lagrange_eq = partial_L_by_partial_q - d_inner_by_dt + [f;-xi_1*qdot_1;-xi_2*qdot_2];

% solve the lagrange equation for qddot and simplify (takes a while)
r = solve(simplify(lagrange_eq), qddot);

qddot_0 = simplify(r.qddot_0);
qddot_1 = simplify(r.qddot_1);
qddot_2 = simplify(r.qddot_2);

disp('qddot_0 = '); disp(qddot_0);
disp('qddot_1 = '); disp(qddot_1);
disp('qddot_2 = '); disp(qddot_2);

% generate Matlab function
matlabFunction([qdot_0; qdot_1; qdot_2; r.qddot_0; r.qddot_1; r.qddot_2], 'file', 'dpc_dynamics_generated', 'Vars', [q;qdot;f;p]);
