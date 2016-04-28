% Computes the worst error when estimating the horizontal position
% of the target using two camera units given error angle delta.
% The direction vectors T-C1 and T-C2 are perturbed by the error angle
% delta, which yields 4 different intersections Ii. The worst Euclidean 
% distance between T and Ii (for each Ii) is returned.
%
% T - target positions (2-vector)
% C1, C2 - camera units positions (2-vectors)
% delta - error angle
%

function [err] = worst_error(C1, C2, T, delta)
    % Rotation matrices (clockwise and counter-clockwise) to create perturbed direction vectors.
    Rccw = [cos(delta) -sin(delta); ...
            sin(delta)  cos(delta)];

    Rcw = [cos(-delta) -sin(-delta); ...
           sin(-delta)  cos(-delta)];

    u = T - C1;
    v = T - C2;
    
    % Perturbed direction vectors.
    eu1 = Rcw  * u';
    eu2 = Rccw * u';
    ev1 = Rcw  * v';
    ev2 = Rccw * v';
    
    % intersections
    I1 = lines_intersection(C1, eu1, C2, ev1);
    I2 = lines_intersection(C1, eu1, C2, ev2);
    I3 = lines_intersection(C1, eu2, C2, ev1);
    I4 = lines_intersection(C1, eu2, C2, ev2);

    % distances between perturbed lines intersections and GT target position
    distances = zeros(1, 4);
    distances(1) = norm(T - I1);
    distances(2) = norm(T - I2);
    distances(3) = norm(T - I3);
    distances(4) = norm(T - I4);

    err = max(distances);
end