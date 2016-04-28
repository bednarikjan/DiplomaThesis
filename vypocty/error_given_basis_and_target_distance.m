%%%
% 3D plot showing the localization estimation error as the function of the
% base length and the target distance. The error exists given the imprecise
% estimation of the position of the target on 2D sensor in pixels. The
% fixed error angle delta (corresponding to X pixels error) is used.
%
% Modeled situation:
%          
%        /\ y
%        |
%     e  | .
% Target X    .  error angle delta
%        |  .  / . 
%     D  |      .   .  
%        |          .  .  
%      --|--------------|-----> x
%        C1      B      C2
%

B = 10:5:100;         % m
D = 10:50:1000;     % m
delta = 0.000750;    % rad

e = bsxfun(@minus, bsxfun(@times, B', (tan(atan(D' * (1.0 ./ B)) + delta))'), D);

surf(D, B, e)
shading faceted
colormap(flipud(gray))
xlabel('target distance [m]');
ylabel('base length [m]');
zlabel('position error [m]');