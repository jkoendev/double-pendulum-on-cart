
function vars(vh)
  vh.addState('q', 3, 'lb', [-1,-inf,-inf], 'ub', [1,inf,inf]);
  vh.addState('qdot', 3, 'lb', [-6,-100,-100], 'ub', [6,100,100]);

  vh.addControl('F', 'lb', -100, 'ub', 100);
end