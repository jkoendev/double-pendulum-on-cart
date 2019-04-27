function dpc_swingup(X,U,H)

  END_TIME = sum(H);              % horizon length (seconds)
  CONTROL_INTERVALS = length(H);     % control discretization

  % Get and set solver options
  options = OclOptions();
  options.nlp.controlIntervals = CONTROL_INTERVALS;
  options.nlp.collocationOrder = 2;
  options.nlp.ipopt.linear_solver = 'mumps';
  options.nlp.solver = 'ipopt';
  
  conf = struct;
  conf.r_1 = 1;
  conf.r_2 = 1;
  conf.m_c = 5;
  conf.m_1 = 1;
  conf.m_2 = 1;
  conf.g = 9.81;
  conf.xi_1 = 1;
  conf.xi_2 = 1;

  system = OclSystem(@varsfun,@(eq,x,z,u,p)eqfun(eq,x,u,conf));
  ocp = OclOCP(@(c,x,z,u,p)pathcosts(c,x,u,conf));
  
  ocl = OclSolver(END_TIME,system,ocp,options);
  
  % get a random starting state between min state and max state
  x_min = [0; -pi; 0; 0; 0; 0];
  x_max = [0; -pi; 0; 0; 0; 0];
  x0 = rand(6,1) .* (x_max-x_min)+x_min ;
  
  % intial state bounds
  ocl.setInitialBounds('q',  x0(1:3));
  ocl.setInitialBounds('qdot', x0(4:6) );
  
  %ocl.setEndBounds('q',  [-eps,-eps,-eps], [eps,eps,eps]);
  %ocl.setEndBounds('qdot', [-eps,-eps,-eps], [eps,eps,eps]);

  % Get and set initial guess
  initialGuess = ocl.getInitialGuess();
  initialGuess.states.set(X);
  initialGuess.controls.set(U);
  initialGuess.h.set(H);

  % Run solver to obtain solution
  [solution,times] = ocl.solve(initialGuess);
  
  t = times.states.value;
  X = [solution.states.q.value',solution.states.qdot.value'];
  U = [0;solution.controls.value];
  
  dpc_draw(t, X, U, x_min, x_max, conf);
  
end

function varsfun(vars)
  vars.addState('q', 3, 'lb', [-3, -inf, -inf], 'ub', [3, inf, inf]);
  vars.addState('qdot', 3 ,'lb', [-5, -5, -5], 'ub', [5, 5, 5]);

  vars.addControl('F', 'lb', -60, 'ub', 60);
end

function eqfun(eq,x,u,conf)
  
  f = u;
  
  xdot = dpc_dynamics_generated(x(1), x(2), x(3), x(4), x(5), x(6), f, conf.r_1, conf.r_2, conf.m_c, conf.m_1, conf.m_2, conf.g, conf.xi_1, conf.xi_2);

  eq.setODE('q', xdot(1:3));
  eq.setODE('qdot', xdot(4:6));
end

function pathcosts(c,x,u,conf)
  
  [p_c, p_1, p_2] = dpc_endpositions(x.q(1), x.q(1), x.q(2), conf);
  c.add( 1e-3*(u.'*u) );
  c.add( -p_1(2) )
end