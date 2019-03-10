
% forward pass
% calculate positions, velcoties, accelerations
% at po, p1, p2

% parameters
p0y = 0;
v0y = 0;
a0y = 0;
syms l1 l2

% known variables 
syms p0x v0x theta dtheta phi dphi ddtheta ddphi

% unknown variables 
syms a0x troque1 torque2 


p0 = [p0x; p0y];
v0 = [v0x; v0y];
a0 = [a0x; a0y];

p01 = [cos(theta);sin(theta)] * l1;
p1 = p0 + p01;

v01 = jacobian(p01,theta) * dtheta;
v1 = v0 + v01;

a01 = jacobian(v01, [theta,dtheta]) * [dtheta; ddtheta];
a1 = a0 + a01;

p12 = [cos(theta+phi);sin(theta+phi)] * l2;
p2 = p1 + p12;

v12 = jacobian(p12,[theta,phi]) * [dtheta; dphi];
v1 = v0 + v12;

a12 = jacobian(v12,[theta,phi,dtheta,dphi]) * [dtheta; dphi; ddtheta; ddphi];
a2 = a1 + a12;



