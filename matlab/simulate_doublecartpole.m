function simulate_doublecartpole
  
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
  tspan = [0:0.01:5];
  [tspan, X] = ode45(@(t,x)ode_function(t,x,p), tspan, x0);
  
  draw_doublecartpole(tspan, X, x_min, x_max, p);
 
end

function xdot = ode_function(t, x, p)
  
  f = 0;
  xdot = doublecartpole_dynamics_generated(x(1), x(2), x(3), x(4), x(5), x(6), f, p.r_1, p.r_2, p.m_c, p.m_1, p.m_2, p.g);
  
end
