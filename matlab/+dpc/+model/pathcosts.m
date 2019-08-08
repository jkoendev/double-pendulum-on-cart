function pathcosts(c,x,~,u,~)
  c.add( 1e-4*(u.'*u) );
  c.add( 1e-2*(x.q.'*x.q) );
  c.add( 1e-4*(x.qdot.'*x.qdot) );
end