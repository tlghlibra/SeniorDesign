function [CD,e] = dpolar_AR(CL,CD0,AR,taper,sweep)
%
% [CD,e] = dpolar_AR(CL,AR,taper,sweep)
%
% sweep in degrees

% Oswald Eff. based on modified Horner approximation and NASA paper 921.
% http://www.fzt.haw-hamburg.de/pers/Scholz/OPerA/...
% OPerA_PRE_DLRK_12-09-10_MethodOnly.pdf

% CD0 = dpolar(CL,M,h);
% CD0 = .03;

lam =  taper;
dlam = 0.45*exp(-0.0375*sweep);
x = lam-dlam;
f = 0.0524*x^4 - 0.15*x^3 + 0.1659*x^2 - 0.0706*x +0.0119;
e = 1/(1+f*AR);

% e = 0.83;

CDi = CL^2/(pi*e*AR);
CD = CD0 + CDi;

end