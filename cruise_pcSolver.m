function [ pc ] = cruise_pcSolver( speed, h, ToW, WoS, tfrac, betac, offsetT)
%cruise_pcSolver solves for the throttle setting at cruise condition
%   ToW = Tsls,slv/Wto
%   WoS = Wto/Sref
%   speed can be pass in as Mach number or Velocity

% Han Tran || h.tran.ly@gmail.com
% Last Update: 01.15.2015

CD0 = 0.02;
AR = 8;
taper = 0;
sweep = 0;
[rho,a,~,~,~,~]=stdatmo(h,offsetT,'US',false);

if speed < 1 || speed == 1
    M = speed;
    V = M*a;
else
    V = speed;
    M = V/a;
end

q = 0.5*rho*V^2;
CL = WoS*betac/q;
% [CD, ~] = DC10polar(CL, M, h);
[CD,~] = dpolar_AR(CL,CD0,AR,taper,sweep);

% pc = fminbnd(@(pc) (1-CD/CL*(betac/cf6deck(M, h, pc)/tfrac)/ToW)^2, 1, 15.9);
Palt = 122; % how to get power at the altitude
Psea = 123; % how to get power at sea level

pc = fminbnd(@(pc) (1-CD/CL*(betac/piston_thrustlapse(Palt, Psea)/tfrac)...
    /ToW)^2, 1, 15.9);

end

