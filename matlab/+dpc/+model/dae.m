function dae(daeh,x,~,u,~)

  conf = dpc.model.conf();
  f = u;
  
  xdot = dpc.model.dynamics_generated(x(1), x(2), x(3), x(4), x(5), x(6), f, conf.r_1, conf.r_2, conf.m_c, conf.m_1, conf.m_2, conf.g, conf.d_1, conf.d_2);

  daeh.setODE('q', xdot(1:3));
  daeh.setODE('qdot', xdot(4:6));
end