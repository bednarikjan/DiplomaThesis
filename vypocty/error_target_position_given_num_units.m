%%%
% 3D plot of the position estimation error given the 2D position of the
% target (only azimuth error is considered).  The error exists due to 
% the imprecise estimation of the position of the target on 2D sensor 
% in pixels. The fixed error angle delta (corresponding to X pixels 
% error) is used. 
% 
% Error can be plotted for two or three camera units. To change this set
% 'cameraUnitsCount' to 2 or 3. Two CUs form line, three CUs form rgular
% triangle.
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CONSTANTS - only change these

% system setup
B   = 20.0;                     % basis [m]
ePX = 10;                    % error of 2D target position estimation [px]

xMin    = -500.0;
xMax    =  500.0;
xStep   =  30.0;
yMin    =  -500.0;
yMax    =  500.0;
yStep   =  30.0;
zMax    =  75.0;

cameraUnitsCount = 2;

% camera properties
f               = 50e-3;    % focus [m]
sensorWidth     = 4.8e-3;   % image sensor width [m]
sensorHeight    = 3.6e-3;   % image sensor height [m]
resHor          = 1280;     % horizontal resolution [px]
resVer          = 960;      % vertical resoltuion [px]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

csHor           = sensorWidth  / resHor;    % pixel horizontal size [m]
csVer           = sensorHeight / resVer;    % pixel vertical size [m]

delta = atan(ePX * csHor / f);              % Error angle delta [rad]

% Camera units positions
C1 = [-B / 2.0, 0.0];
C2 = [ B / 2.0, 0.0];

if cameraUnitsCount == 2
    C = [C1; C2];
elseif cameraUnitsCount == 3
    C3 = [0.0, -B * 0.5 * tan(pi / 3.0)];
    C = [C1; C2; C3];
end

% Bases direction vectors
if(size(C, 1) < 3)
    bd = zeros(1, 2);
else
    bd = zeros(size(C));
end

for ii = 1:size(bd, 1)
    tmp = C(mod(ii, size(C, 1)) + 1, :) - C(mod(ii - 1, size(C, 1)) + 1, :);
    bd(ii, :) = [-tmp(2), tmp(1)] ./ norm(tmp);    
end

% Resulting error map
errorMap = zeros(floor((yMax - yMin) / yStep), floor((xMax - xMin) / xStep));

% Rotation matrices (clockwise and counter-clockwise) to create perturbed direction vectors.
Rccw = [cos(delta) -sin(delta); ...
        sin(delta)  cos(delta)];

Rcw = [cos(-delta) -sin(-delta); ...
       sin(-delta)  cos(-delta)];

x = xMin:xStep:xMax;
y = yMin:yStep:yMax;
   
for i = 1:length(y)
    for j = 1:length(x)
    
        % target positions
        T = [x(j), y(i)];
        
        % Select the base to compute target position                             
        [~, idx] =  max(T * bd');
        
        % direction and corresponding normal vectors to GT target
        c1 = C(idx, :);
        c2 = C(mod(idx, length(C)) + 1, :);
        
        u = T - c1;
        v = T - c2;              

        % Perturbed direction vectors.
        eu1 = Rcw  * u';
        eu2 = Rccw * u';
        ev1 = Rcw  * v';
        ev2 = Rccw * v';

        % intersections
        I1 = lines_intersection(c1, eu1, c2, ev1);
        I2 = lines_intersection(c1, eu1, c2, ev2);
        I3 = lines_intersection(c1, eu2, c2, ev1);
        I4 = lines_intersection(c1, eu2, c2, ev2);

        % distances between perturbed lines intersections and GT target position
        distances = zeros(1, 4);
        distances(1) = norm(T - I1);
        distances(2) = norm(T - I2);
        distances(3) = norm(T - I3);
        distances(4) = norm(T - I4);

        errorMap(i, j) = min(zMax, max(distances));       
    end
end

figure(1);
hold on;
surf(x, y, errorMap);
axis([xMin xMax min(0.0, yMin) yMax 0 min(zMax, max(max(errorMap)))])
shading faceted
colormap(flipud(gray))
xlabel('x [m]');
ylabel('y [m]');
zlabel('position error [m]');

% draw camera units stations positions
for ii = 1:length(C)
    cSurfPoint = scatter3(C(ii, 1), C(ii, 2), 1, 'filled');
%     cSurfPoint.SizeData = 150;
end

hold off;
clear;
