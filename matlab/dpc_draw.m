% You are free to use, modify, copy, distribute the code.
% Please give a clap on medium, star on github, or share the article if you
% like.
%
% Created by github.com/jkoendev

function dpc_draw(times, X, x_min, x_max, p)

  x0 = X(1,:)';
  [~, h] = dpc_draw_prepare(x0, x_min, x_max, p);
  pause(0.5)

  for k=2:size(X,1)
    tic;

    x = X(k,:)';
    t = times(k);
    
    dpc_draw_frame(h, t, x, p);
    pause(times(k)-times(k-1)-toc);
  end
end


