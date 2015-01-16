function [ alfa ] = piston_thrustlapse( Palt, Psea )
%piston_thrustlapse solves for the thrust ratio of a certain altitude to
%power at sea level. 

%Synthesis of Subsonic  Airplane Design by Egbert Torenbeck [pg. 165]

%   n = 0.7~0.8
%   Palt = Power at altitude
%   Psea = Power at sea level

% Han Tran || h.tran.ly@gmail.com
% Last Update: 01.15.2015

n = 0.7;
sigma_pis = (Palt/Psea)^(1/n);
alfa = 1.132*sigma_pis - 0.132;


end

