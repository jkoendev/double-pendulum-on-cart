function [X,U,H,data] = dpc_swingup(X,U,H)

  N = 50;
  T = 5;
  if nargin >= 3
    T = sum(H);
    N = length(H);
  end

  END_TIME = T;                      % horizon length (seconds)
  CONTROL_INTERVALS = N;     % control discretization

  % Get and set solver options
  options = OclOptions();
  options.nlp.controlIntervals = CONTROL_INTERVALS;
  options.nlp.collocationOrder = 3;
  options.nlp.ipopt.linear_solver = 'mumps';
  options.nlp.solver = 'ipopt';
  
  conf = dpc_conf();

  system = OclSystem(@varsfun,@(eq,x,z,u,p)eqfun(eq,x,u,conf));
  ocp = OclOCP('pathcosts', @(c,x,z,u,p)pathcosts(c,x,u,conf), 'arrivalcosts', @arrivalcosts);
  
  ocl = OclSolver(END_TIME,system,ocp,options);
  
  x0 = [0; -pi; 0.1; 0; 0; 0];
  
  % intial state bounds
  ocl.setInitialBounds('q',  x0(1:3));
  ocl.setInitialBounds('qdot', x0(4:6) );
  
  Tmin = 5; 
  Tmax = 10;
  ocl.setBounds('h', Tmin/N, Tmax/N);
  
  eps = 1e-2; 
  
%   ocl.setEndBounds('q',  [0,-eps,-eps], [0,eps,eps]);
%   ocl.setEndBounds('qdot', [0,-eps,-eps], [0,eps,eps]);

  % Get and set initial guess
  initialGuess = ocl.getInitialGuess();
  
  if nargin >= 1
    initialGuess.states.set(X);
  end
  if nargin >= 2
    initialGuess.controls.set(U);
  end
  if nargin >= 3
    initialGuess.h.set(H);
  else
    initialGuess.h.set(T/N);
  end
  
  
  % Run solver to obtain solution
  [solution,times] = ocl.solve(initialGuess);
  
  t = times.states.value;
  X = [solution.states.q.value;solution.states.qdot.value];
  U = [solution.controls.value];
  H = solution.h.value;
  
  dpc_draw(t, X', [0;U], x0, x0, conf);
  
  data.t = t;
  data.X = X;
  data.x_min = x0;
  data.x_max = x0;
  data.p = conf;
  
end

function varsfun(vars)
  vars.addState('q', 3);
  vars.addState('qdot', 3);

  vars.addControl('F', 'lb', -1000, 'ub', 1000);
end

function eqfun(eq,x,u,conf)
  
  f = u;
  
  xdot = dpc_dynamics_generated(x(1), x(2), x(3), x(4), x(5), x(6), f, conf.r_1, conf.r_2, conf.m_c, conf.m_1, conf.m_2, conf.g, conf.d_1, conf.d_2);

  eq.setODE('q', xdot(1:3));
  eq.setODE('qdot', xdot(4:6));
end

function arrivalcosts(c, x, p)
end

function pathcosts(c,x,u,conf)
  c.add( 1e-4*(u.'*u) );
  c.add( 10*(x.'*x) );
end