function dpc_simple_draw(times, X, x_min, x_max, p)
  
  x0 = X(1,:)';
  
  % this function is defined below
  [p_c, p_1, p_2] = dpc_endpositions(x0(1), x0(2), x0(3), p);
  
  figure;
  hold on;

  % draw position limits
  line([x_min(1) x_max(1)], [0 0], 'color', 'k', 'Linewidth',1.5); hold on;
  line([x_min(1) x_min(1)], [-0.1 0.1], 'color', 'k', 'Linewidth',1.5); hold on;
  line([x_max(1) x_max(1)], [-0.1 0.1], 'color', 'k', 'Linewidth',1.5); hold on;

  timer_handle = text(-0.3, x_max(1), '0.00 s','FontSize', 15);
  cart_handle = plot(p_c(1), p_c(2), 'ks', 'MarkerSize', 20, 'Linewidth', 3);
  pole_one_handle = line([p_c(1) p_1(1)], [p_c(2) p_1(2)], 'color', [38,124,185]/255, 'Linewidth', 8);
  pole_two_handle = line([p_1(1) p_2(1)], [p_1(2) p_2(2)], 'color', [38,124,185]/255, 'Linewidth', 8);
  
  joint_zero_handle = plot(p_c(1), p_c(2), 'ko', 'MarkerSize', 5);
  joint_one_handle = plot(p_1(1), p_1(2), 'ko', 'MarkerSize', 5);
  joint_two_handle = plot(p_2(1), p_2(2), 'ko', 'MarkerSize', 5);
  
  grid on;
  xlim([x_min(1)-p.r_1-p.r_2 x_max(1)+p.r_1+p.r_2]);
  ylim([x_min(1)-p.r_1-p.r_2 x_max(1)+p.r_1+p.r_2]);

  hold off;
  pause(0.5)

  for k=2:size(X,1)
    tic;
    
    x = X(k,:)';
    
    [p_c, p_1, p_2] = dpc_endpositions(x(1), x(2), x(3), p);

    set(timer_handle, 'String', sprintf('%.2f s', times(k)));

    set(cart_handle, 'Xdata', x(1))

    set(pole_one_handle, 'Xdata', [p_c(1) p_1(1)]);
    set(pole_one_handle, 'Ydata', [p_c(2) p_1(2)]);

    set(pole_two_handle, 'Xdata', [p_1(1) p_2(1)]);
    set(pole_two_handle, 'Ydata', [p_1(2) p_2(2)]); 
    
    set(joint_zero_handle, 'Xdata', p_c(1));
    set(joint_zero_handle, 'Ydata', p_c(2));
    
    set(joint_one_handle, 'Xdata', p_1(1));
    set(joint_one_handle, 'Ydata', p_1(2));
    
    set(joint_two_handle, 'Xdata', p_2(1));
    set(joint_two_handle, 'Ydata', p_2(2));
    
    pause(times(k)-times(k-1)-toc);
  end
  
end

function [p_c, p_1, p_2] = dpc_endpositions(q_0, q_1, q_2, p) 
  % Returns the positions of cart, first joint, and second joint
  % to draw the black circles
  p_c = [q_0; 0];
  p_1 = p_c + p.r_1 * [cos(q_1); sin(q_1)];
  p_2 = p_c + p.r_1 * [cos(q_1); sin(q_1)] + p.r_2 * [cos(q_1+q_2); sin(q_1+q_2)];
end
