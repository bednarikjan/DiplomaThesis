% This script reads an input file 'targets.txt' with info about targets 
% (names and UTM coordinates - ground truth and estimation),
% each target per one line, with following format:
%
% obj.name      x           y           estim.x     estim.y   % this is header
% [string]      [float]     [float]     [float]     [float]
%
% It computes the distance of each target (target-CU1), the angle alpha
%  between the base and the direction from base center to target, the
% estimated error and the real error in meters.
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% change following constants

% UTM positions of camera units

% Zebetin
% CU1 = [608708.55, 5453089.09];
% CU2 = [608680.49, 5453099.64];

% VUT
CU1 = [614440.62, 5453734.49];
CU2 = [614445.04, 5453725.49];

% Error of 2D target position estimation [px]
ePX = 4;                    

% Input file name
inFileName = 'targets.txt';

% camera properties
f               = 50e-3;    % focus [m]
sensorWidth     = 4.8e-3;   % image sensor width [m]
sensorHeight    = 3.6e-3;   % image sensor height [m]
resHor          = 1280;     % horizontal resolution [px]
resVer          = 960;      % vertical resoltuion [px]
csHor           = sensorWidth  / resHor;    % pixel horizontal size [m]
csVer           = sensorHeight / resVer;    % pixel vertical size [m]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Computing constants from the constants given by the user.

CM = CU1 + 0.5 * (CU2 - CU1);
b  = CU2 - CU1; 
n = [-b(2), b(1)];
n = n ./ norm(n);

delta = atan(ePX * csHor / f);          % Error angle delta [rad]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% main program

% read data from file
fid       = fopen(inFileName);
fgetl(fid); % disregard header
targets   = textscan(fid, '%s %f %f %f %f');
fclose(fid);

numTgts = length(targets{1});

distances   = zeros(numTgts, 1);
alphas      = zeros(numTgts, 1);
errors      = zeros(numTgts, 1);
estimErrors = zeros(numTgts, 1);

disp(sprintf('name distance alpha estim_error error'))
for ii = 1:numTgts
    tgt      = [targets{2}(ii) targets{3}(ii)];    
    tgtEstim = [targets{4}(ii) targets{5}(ii)];    
    t = tgt - CM;        
    
    distances(ii)  = norm(tgt - CU1);
    alphas(ii) = acos(abs(dot(b, t)) / (norm(t) * norm(b))) / pi * 180;
    errors(ii) = norm(tgt - tgtEstim);
    estimErrors(ii) = worst_error(CU1, CU2, tgt, delta);
    
%     disp(sprintf('%s %f m %f rad %f m %f m', targets{1}{ii}, distances(ii), alphas(ii), estimErrors(ii), errors(ii)));	
%     disp(sprintf('%s %f %f %f %f', targets{1}{ii}, distances(ii), alphas(ii), estimErrors(ii), errors(ii)));
end

% Find indices for sorting the records according to the distance in ascending order
[~, si] = sort(distances);

for ii = 1:numTgts
    disp(sprintf('%s %f %f %f %f', targets{1}{si(ii)}, distances(si(ii)), alphas(si(ii)), estimErrors(si(ii)), errors(si(ii))));
end

disp(sprintf('\n'));

% plot expected and measured error
plot(1:numTgts, errors, '-r');
hold on;
plot(1:numTgts, estimErrors, '-b');
set(gca,'XTick',1:numTgts,'XTickLabel',targets{1})
hold off;