function [p_c, p_1, p_2] = doublecartpole_endpositions(q_0, q_1, q_2, p)

  p_c = [q_0; 0];
  p_1 = p_c + p.r_1 * [cos(q_1); sin(q_1)];
  p_2 = p_c + p.r_1 * [cos(q_1); sin(q_1)] + p.r_2 * [cos(q_1+q_2); sin(q_1+q_2)];
  
end