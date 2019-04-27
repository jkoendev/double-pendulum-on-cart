% You are free to use, modify, copy, distribute the code.
% Please give a clap on medium, star on github, or share the article if you
% like.
%
% Created by github.com/jkoendev

function [X,U,T,H] = dpc_mouse_control()
  % Runs the simulation for double pendulum on a cart

  p = struct;
  p.r_1 = 1;
  p.r_2 = 1;
  p.m_c = 5;
  p.m_1 = 1;
  p.m_2 = 1;
  p.g = 9.81;
  p.xi_1 = 1e-1;
  p.xi_2 = 1e-1;

  x0 = [0; -pi; 0; 0; 0; 0];

  ts = 0.01;
  [fig, h] = dpc_draw_prepare(x0, x0, x0, p);
  
  global U_STORAGE
  U_STORAGE = 0;
  
  global EXIT_STORAGE
  EXIT_STORAGE = false;
  
  set(fig, 'KeyPressFcn', @(src,event) keydown(event, U_STORAGE));
  set(fig, 'KeyReleaseFcn', @(src,event) keyup(event, U_STORAGE));
  
 
  x = x0;
  t = 0;
  X = x0;
  U = [];
  T = 0;
  waitforbuttonpress
  while(1)
    tic;
    u = U_STORAGE;
    x = x + ts * dpc_ode(t, x, u, p);
    t = t + ts;
    u
    X = [X,x];
    U = [U,u];
    T = [T,t];
    dpc_draw_frame(h,t,x,u,p);
    pause(ts-toc)
    if EXIT_STORAGE
      break;
    end
  end
  H = T(2:end)-T(1:end-1);
end

function keydown(event, u)
  global U_STORAGE
  
  if event.Key == 'h'
    U_STORAGE = -40;
  elseif event.Key == 'j'
    U_STORAGE = 40;
  elseif event.Key = 'x'
    U_STORAGE = 0;
    global EXIT_STORAGE
    EXIT_STORAGE = true;
  else
    u = 0;
  end
end

function keyup(src,event)
  global U_STORAGE
  U_STORAGE = 0;
end

function xdot = dpc_ode(t, x, u, p)

  f = u;
  xdot = dpc_dynamics_generated(x(1), x(2), x(3), x(4), x(5), x(6), f, p.r_1, p.r_2, p.m_c, p.m_1, p.m_2, p.g, p.xi_1, p.xi_2);

end
