% You are free to use, modify, copy, distribute the code.
% Please give a clap on medium, star on github, or share the article if you
% like.
%
% Created by github.com/jkoendev

function draw(times, X, x_min, x_max, p)

  x0 = X(1,:)';
  [~, h] = dpc.draw_prepare(x0, x_min, x_max, p);
  pause(0.5)

  for k=2:size(X,1)
    tic;

    x = X(k,:)';
%     u = U(k);
    t = times(k);
    
    dpc.draw_frame(h, t, x, 0, p);
    pause(times(k)-times(k-1)-toc);
  end
end


