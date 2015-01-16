function [ Ps ] = Ps_uav( M, h, TW, WS, tfrac, beta, n, offsetT)
%UNTITLED Summary of this function goes here
%   TW = Tsls/Wto
%   WS = Wto/Sref
%   offsetT = temp. offset -- help stdatmo for more info
%   sweep = sweep angle [degree]

% Han Tran || h.tran.ly@gmail.com
% Last Update: 01.15.2015


CD0 = 0.02;
AR = 8;
taper = 0;
sweep = 0;

[rho, a, ~, ~, ~, ~] = stdatmo(h, offsetT, 'US', false);
q = 0.5*rho*(M*a)^2;
CL = n*beta*WS/q;
alfa = 1;         % Need Thrust lapse
[CD,~] = dpolar_AR(CL,CD0,AR,taper,sweep);
% CD = CD + CDadd;
Ps = (tfrac*alfa*M*a/beta)*TW - (q*CD*M*a/beta)/WS;

end

