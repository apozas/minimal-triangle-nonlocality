% Code for
% Post-quantum nonlocality in the minimal triangle scenario
% arXiv:2304.xxxxx
% 
% Authors: Alejandro Pozas-Kerstjens
%
% Last modified: Apr, 2023

clear all

o = 2;
orig = zeros(o,o,o);

points = importdata(join('..' filesep 'points_E1E2E3.txt'),' ');

% Remove if textprogressbar is not installed
upd = textprogressbar(length(points), 'barlength', 20, ...
                      'updatestep', 1, ...
                      'startmsg', 'Waiting... ',...
                      'endmsg', ' Yay!', ...
                      'showbar', true, ...
                      'showremtime', false, ...
                      'showactualnum', true, ...
                      'barsymbol', '+', ...
                      'emptybarsymbol', '-');

% Smallest inflation probability
% Therefore, if negative, the distribution is not compatible with the model
smallestPinf = zeros(length(points), 1);
for i=1:length(points)
    E1 = points(i,1);
    E2 = points(i,2);
    E3 = points(i,3);
    for a=-1:2:1
        for b=-1:2:1
            for c=-1:2:1
                orig(1+(a+1)/2,1+(b+1)/2,1+(c+1)/2) = ...
                    (1+(a+b+c)*E1+(a*b+b*c+c*a)*E2+a*b*c*E3)/8;
            end
        end
    end
    % Implemented: HexagonInflation, WebInflation222, WebInflation322, WebInflation332
    lambda = WebInflation222(orig);    % CHANGE for other inflations
    smallestPinf(i) = lambda;
    upd(i);    % Remove if textprogressbar is not installed
end
% CHANGE for other inflations
fid = fopen(join(['..' filesep 'results' filesep 'smallestPinf_222inflation.txt']), 'wt');
fprintf(fid,'%.16f\n', smallestPinf');
fclose(fid);
