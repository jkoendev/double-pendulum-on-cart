% You are free to use, modify, copy, distribute the code.
% Please give a clap on medium, star on github, or share the article if you
% like.
%
% Created by github.com/jkoendev

function r = dpc_mouse_control()
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
  p.xi_1 = 1e-4;
  p.xi_2 = 1e-4;

  % get a random starting state between min state and max state
  x_min = [-1; -pi; -pi; -.05; -1; -1];
  x_max = -x_min;
  x0 = rand(6,1) .* (x_max-x_min)+x_min;

  ts = 0.01;
  [fig, h] = dpc_draw_prepare(x0, x_min, x_max, p);
  
  control = @(t,x) process_keyboard(fig,h,ts,t,x,p);
  
  tspan = 0:ts:8;
  x = x0;
  for k=1:length(tspan)
    t = tspan(k);
    x = x + ts * dpc_ode(t, x, control, p);
  end
end

function u = process_keyboard(fig,h,ts,t,x,p)
  % 28 leftarrow
  % 29 rightarrow
  % 30 uparrow
  % 31 downarrow
  value = double(get(gcf,'CurrentCharacter'))
  
  if value == 28
    u = -50;  
  elseif value == 29
    u = 50;
  else
    u = 0;
  end
 
  dpc_draw_frame(h,t,x,u,p);
  pause(ts)
end

function xdot = dpc_ode(t, x, u_fh, p)

  f = u_fh(t,x);
  xdot = dpc_dynamics_generated(x(1), x(2), x(3), x(4), x(5), x(6), f, p.r_1, p.r_2, p.m_c, p.m_1, p.m_2, p.g, p.xi_1, p.xi_2);

end
