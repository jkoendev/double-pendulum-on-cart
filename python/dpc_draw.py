import time
import numpy as np
from matplotlib import pyplot as plt


def dpc_draw(tdata, X, x_min, x_max, p):

  x0 = X[:,1];

  # this function is defined below
  [p_c, p_1, p_2] = dpc_endpositions(x0[1], x0[2], x0[3], p)

  fig, ax = plt.subplots(1, 1)
  ax.set_aspect('equal')
  print(p)
  ax.set_xlim(x_min[1] - p["r_1"] - p["r_2"], x_max[1] + p["r_1"] + p["r_2"])
  ax.set_ylim(x_min[1] - p["r_1"] - p["r_2"], x_max[1] + p["r_1"] + p["r_2"])
  plt.show(False)
  plt.draw()
  plt.pause(0.5)

  timer_handle = plt.text(-0.3, x_max[0], '0.00 s', fontsize=15);
  cart_handle, = plt.plot(p_c[0], p_c[1], 'ks', markersize=20, linewidth=3);
  pole_one_handle, = plt.plot([p_c[0], p_1[0]], [p_c[1], p_1[1]], color=np.array([38,124,185])/255, linewidth=8);
  pole_two_handle, = plt.plot([p_1[0], p_2[0]], [p_1[1], p_2[1]], color=np.array([38,124,185])/255, linewidth=8);

  joint_zero_handle, = plt.plot(p_c[0], p_c[1], 'ko', markersize=5);
  joint_one_handle, = plt.plot(p_1[0], p_1[1], 'ko', markersize=5);
  joint_two_handle, = plt.plot(p_2[0], p_2[1], 'ko', markersize=5);

  for k in range(0, X.shape[1]):
    tic = time.time()

    x = X[:,k]

    [p_c, p_1, p_2] = dpc_endpositions(x[0], x[1], x[2], p)

    timer_handle.set_text('{:.2f} s'.format(tdata[k]))

    cart_handle.set_data(x[0], 0)

    pole_one_handle.set_data([p_c[0], p_1[0]], [p_c[1], p_1[1]])
    pole_two_handle.set_data([p_1[0], p_2[0]], [p_1[1], p_2[1]])

    joint_zero_handle.set_data(p_c[0], p_c[1]);
    joint_one_handle.set_data(p_1[0], p_1[1]);
    joint_two_handle.set_data(p_2[0], p_2[1]);

    time.sleep(np.max([tdata[k] - tdata[k-1] + time.time() - tic, 0]))
    plt.pause(0.0001)

  plt.close(fig)

def dpc_endpositions(q_0, q_1, q_2, p):
  # Returns the positions of cart, first joint, and second joint
  # to draw the black circles
  p_c = np.array([q_0, 0]);
  p_1 = p_c + p["r_1"] * np.array([np.cos(q_1), np.sin(q_1)]);
  p_2 = p_c + p["r_1"] * np.array([np.cos(q_1), np.sin(q_1)]) + p["r_2"] * np.array([np.cos(q_1+q_2), np.sin(q_1+q_2)]);
  return p_c, p_1, p_2
