function simulate_doublecartpole
  
  % parameters
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
  x0 = rand(6,1) .* (x_max-x_min) + x_min;
  
  % simulate
  tspan = [0:0.01:5];
  [times, X] = ode45(@ode_function, tspan, x0);
  
  draw_doublecartpole(times, X, x_min, x_max, p);
 
end

function r = ode_function(t, x)
  r_1 = 1;
  r_2 = 1;
  m_c = 5;
  m_1 = 1;
  m_2 = 1; 
  g = 9.81;
  
  r = dynamics_generated(x(1), x(2), x(3), x(4), x(5), x(6), 0, r_1, r_2, m_c, m_1, m_2, g);
  
end
