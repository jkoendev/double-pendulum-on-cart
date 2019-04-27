function dpc_draw_frame(h,t,x,u,p)

[p_c, p_1, p_2] = dpc_endpositions(x(1), x(2), x(3), p);

set(h.timer_handle, 'String', sprintf('%.2f s', t));

set(h.cart_handle, 'Xdata', x(1))

set(h.pole_one_handle, 'Xdata', [p_c(1) p_1(1)]);
set(h.pole_one_handle, 'Ydata', [p_c(2) p_1(2)]);

set(h.pole_two_handle, 'Xdata', [p_1(1) p_2(1)]);
set(h.pole_two_handle, 'Ydata', [p_1(2) p_2(2)]);

set(h.joint_zero_handle, 'Xdata', p_c(1));
set(h.joint_zero_handle, 'Ydata', p_c(2));

set(h.joint_one_handle, 'Xdata', p_1(1));
set(h.joint_one_handle, 'Ydata', p_1(2));

set(h.joint_two_handle, 'Xdata', p_2(1));
set(h.joint_two_handle, 'Ydata', p_2(2));

set(h.control_handle, 'Xdata', [p_c(1),p_c(1)+u/200]);