% You are free to use, modify, copy, distribute the code.
% Please give a clap on medium, star on github, or share the article if you
% like.
%
% Created by github.com/jkoendev

function r = dpc_simulate(ts, animate, control_fh)
  % Runs the simulation for double pendulum on a cart
  
  if nargin < 1
    ts = 0.01;
  end
  if nargin < 2
    animate = true;
  end
  if nargin < 3
    control_fh = @(t,x) 0;
  end

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
  tspan = 0:ts:8;
  [t, X] = ode45(@(t,x)dpc_ode(t,x,control_fh,p), tspan, x0);
  
  U = arrayfun(control_fh,t);

  if animate
    dpc_draw(t, X, U, x_min, x_max, p);
  end
  
  r = struct;
  r.t = tspan;
  r.X = X;
  r.x_min = x_min;
  r.x_max = x_max;
  r.p = p;
end

function xdot = dpc_ode(t, x, u_fh, p)

  f = u_fh(t,x);
  xdot = dpc_dynamics_generated(x(1), x(2), x(3), x(4), x(5), x(6), f, p.r_1, p.r_2, p.m_c, p.m_1, p.m_2, p.g);

end
