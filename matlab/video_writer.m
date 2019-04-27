framerate = 1/(data.t(2)-data.t(1));
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