N = 40;
T = 2;

conf = dpc.model.conf();

solver = ocl.Solver(T, ...
  'vars', @dpc.model.vars, ...
  'dae', @dpc.model.dae, ...
  'pathcosts', @dpc.model.pathcosts, ...
  'N', N);

x0 = [0; pi; 0; 0; 0; 0];

% intial state bounds
solver.setInitialState('q',  x0(1:3));
solver.setInitialState('qdot', x0(4:6) );

Tmin = 5; 
Tmax = 10;

% Run solver to obtain solution
[solution,times] = solver.solve();

t = times.states.value;
X = [solution.states.q.value;solution.states.qdot.value];

dpc.draw(t, X', x0, x0, conf);
