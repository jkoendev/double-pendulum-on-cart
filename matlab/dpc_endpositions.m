function [p_c, p_1, p_2] = dpc_endpositions(q_0, q_1, q_2, p)
  % Returns the positions of cart, first joint, and second joint
  % to draw the black circles
  p_c = [q_0; 0];
  p_1 = p_c + p.r_1 * [cos(q_1); sin(q_1)];
  p_2 = p_c + p.r_1 * [cos(q_1); sin(q_1)] + p.r_2 * [cos(q_1+q_2); sin(q_1+q_2)];
end