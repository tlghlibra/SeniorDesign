% Aero 444
% UAV Design Preliminary Sizing

% Sarthak Patel
% Last Update: 1/12/2015

% Notes:
%
% Empty weight fraction equation is based on Purdue paper.
% https://engineering.purdue.edu/AAE/Academics/Courses/aae451/2007/Spring/Team3/SRR%20Final%20Team%203.doc

%% Clean Up
clear all; close all; clc; format compact;

%% Sizing Inputs

Wto_guess = 9.8;    % [lb]
Wp = 2;             % [lb]
endurance = 4;      % [hr]
vcruise = 39.2;     % [knots]
hcruise = 7000;     % [ft]

TSFC = 4;         % [1/hr]
LoD = 10;            % [-]

WeFracEqn = 'fancy';    % 'standard' or 'fancy'
plots = 'yes';          % 'yes' or 'no'
A = 1.02;
B = -0.06;

tol = .001;            % lb
err = tol+1;
n = 1;
Wto(n) = Wto_guess;

% Wto = guess;
% Wp = Wp;

%% Sizing Code

while err > tol
    
    disp(['Wto = ',num2str(Wto(n))])
    
    if strcmp(WeFracEqn,'fancy')
        Wefrac = 1.243*(Wto(n)^0.1566)*(Wp^-0.0806)*(endurance^0.0975)*(vcruise^-0.3014)*(hcruise^-0.0174);
    elseif strcmp(WeFracEqn,'standard')
        Wefrac = A*Wto^B;
    else
        error('WeFracEqn must be specified as a string: "standard" or "fancy"')
    end
    
    % one cruise leg
    Wffrac = exp(-TSFC/LoD*endurance);
%     Wffrac = exp(-endurance);

    n = n+1;
    Wto(n) = Wp/(1-Wefrac-Wffrac);
    err = abs(Wto(n)-Wto(n-1));
end

%% Display Results

disp(' ')
disp(['Final Wto = ',num2str(Wto(n)),' lb'])
disp(['Tolerance = ',num2str(tol),' lb'])
disp(['Empty Weight = ',num2str(Wefrac*Wto(end)),' lb (',num2str(Wefrac(end)*100),' %)'])
disp(['Payload Weight = ',num2str(Wp),' lb (',num2str(Wp/Wto(end)*100),' %)'])
disp(['Fuel Weight = ',num2str(Wffrac*Wto(end)),' lb (',num2str(Wffrac(end)*100),' %)'])

if strcmp(plots,'yes')
    plot(0:n-1,Wto);
    title('Wto Convergence')
    xlabel('Iteration (0 = guess)')
    ylabel('Wto')
    grid on
end


