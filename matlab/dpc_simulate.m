% You are free to use, modify, copy, distribute the code.
% Please give a clap on medium, star on github, or share the article if you
% like.
%
% Created by github.com/jkoendev

function dpc_simulate
  % Runs the simulation for double pendulum on a cart

  % parameters
  % you can modify the parameters to get a different behaviour
  p = struct;
  p.r_1 = 1;
  p.r_2 = 1;
  p.m_c = 5;
  p.m_1 = 1;
  p.m_2 = 1;
  p.g = 9.81;

  % get a random starting state between min state and max state
  x_min = [-1; -pi; -pi; -.05; -1; -1];
  x_max = -x_min;
  x0 = rand(6,1) .* (x_max-x_min)+x_min;

  % simulate
  tspan = [0:0.01:8];
  [tspan, X] = ode45(@(t,x)dpc_ode(t,x,p), tspan, x0);

  dpc_draw(tspan, X, x_min, x_max, p);
end

function xdot = dpc_ode(t, x, p)

  f = 0;
  xdot = dpc_dynamics_generated(x(1), x(2), x(3), x(4), x(5), x(6), f, p.r_1, p.r_2, p.m_c, p.m_1, p.m_2, p.g);

end
