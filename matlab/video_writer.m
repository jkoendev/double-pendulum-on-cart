framerate = 25;

u_fh = @(t,x) 10*cos(t);

data = dpc_simulate(1/framerate, false, u_fh);
x0 = data.X(1,:)';

[fig, h] = dpc_draw_prepare(x0, data.x_min, data.x_max, data.p);

filename = ['data/sim_', datestr(now,'yyyy-mm-dd_HHMMSS')];
v = VideoWriter(filename);
v.FrameRate = framerate;
open(v);

for k=1:size(data.X,1)
  t = data.t(k);
  x = data.X(k,:)';
  u = u_fh(t,x);
  dpc_draw_frame(h, t, x, u, data.p)
  
  frame = getframe(fig);
  writeVideo(v, frame);
end
save([filename,'.txt'], 'data')
close(v)