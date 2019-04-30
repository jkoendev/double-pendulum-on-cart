function [fig, h] = dpc_draw_prepare(x0, x_min, x_max, p)

  fig = figure;
  hold on;
  
  [p_c, p_1, p_2] = dpc_endpositions(x0(1), x0(2), x0(3), p);

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
  
  control_handle = plot([p_c(1),p_c(1)], [p_c(2),p_c(2)], 'r', 'Linewidth', 8);
  
  grid on;
  xlim([x_min(1)-p.r_1-p.r_2-2 x_max(1)+p.r_1+p.r_2+2]);
  ylim([x_min(1)-p.r_1-p.r_2-2 x_max(1)+p.r_1+p.r_2+2]);
  
  hold off;
  
  % plot handles
  h = struct;
  h.timer_handle = timer_handle;
  h.cart_handle = cart_handle;
  h.pole_one_handle = pole_one_handle;
  h.pole_two_handle = pole_two_handle;
  h.joint_zero_handle = joint_zero_handle;
  h.joint_one_handle = joint_one_handle;
  h.joint_two_handle = joint_two_handle;
  h.control_handle = control_handle;

end

