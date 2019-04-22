from matplotlib import pyplot as plt

def dpc_draw(times, X, x_min, x_max, p):

  x0 = X[1,:];

  # this function is defined below
  [p_c, p_1, p_2] = dpc_endpositions(x0[1], x0[2], x0[3], p)

  fig, ax = plt.subplots(1, 1)
  ax.set_aspect('equal')
  ax.set_xlim([x_min[1] - p["r_1"] - p["r_2"], x_max[1] + p["r_1"] + p["r_2"])
  ax.set_ylim([x_min[1] - p["r_1"] - p["r_2"], x_max[1] + p["r_1"] + p["r_2"])
  ax.hold(True)
  plt.show(False)
  plt.draw()

  timer_handle = plt.text(-0.3, x_max[1], '0.00 s', fontsize=15);
  cart_handle = plt.plot(p_c[1], p_c[2], 'ks', markersize=20, linewidth=3);
  pole_one_handle = plt.plot([p_c[1], p_1[1]], [p_c[2], p_1[2]], color=np.array([38,124,185])/255, linewidth=8);
  pole_two_handle = plt.plot([p_1[1], p_2[1]], [p_1[2], p_2[2]], color=np.array([38,124,185])/255, linewidth=8);

  joint_zero_handle = plt.plot(p_c(1), p_c(2), 'ko', markersize=5);
  joint_one_handle = plt.plot(p_1(1), p_1(2), 'ko', markersize=5);
  joint_two_handle = plt.plot(p_2(1), p_2(2), 'ko', markersize=5);

  ax.hold(False)
  pause(0.5)

  for k in range(0, X.shape[0])
    time.tic()

    x = X[k,:]

    [p_c, p_1, p_2] = dpc_endpositions(x[1], x[2], x[3], p)

    timer_handle.set_data(, 'String', sprintf('%.2f s', times(k)))

    cart_handle.set_data(x[1], 0)

    pole_one_handle.set_data([p_c[1], p_1[1]], [p_c[2], p_1[2]])
    pole_two_handle.set_data([p_1[1], p_2[1]], [p_1[2], p_2[2]])

    joint_zero_handle.set_data(p_c[1], p_c[2]);
    joint_one_handle.set_data(p_1[1], p_1[2]);
    joint_one_handle.set_data(p_2[1], p_2[2]);

    pause(times(k)-times(k-1)-toc);
  end

end

def [p_c, p_1, p_2] = dpc_endpositions(q_0, q_1, q_2, p)
  # Returns the positions of cart, first joint, and second joint
  # to draw the black circles
  p_c = np.array([q_0; 0]);
  p_1 = p_c + p.r_1 * np.array([cos(q_1), sin(q_1)]);
  p_2 = p_c + p.r_1 * np.array([cos(q_1), sin(q_1)]) + p.r_2 * np.array([cos(q_1+q_2), sin(q_1+q_2)]);
  return p_c, p_1, p_2
