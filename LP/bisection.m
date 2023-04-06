% Code for
% Post-quantum nonlocality in the minimal triangle scenario
% arXiv:2304.xxxxx
% 
% Authors: Alejandro Pozas-Kerstjens
%
% Last modified: Apr, 2023

clear all

o = 2;

E1 = 0;
E3 = 0;

left = 0;
right = 1;

while abs(left-right) > 1e-4
  v = (right+left)/2;
  orig = zeros(o,o,o);
  for a=-1:2:1
      for b=-1:2:1
          for c=-1:2:1
              orig(1+(a+1)/2,1+(b+1)/2,1+(c+1)/2) = ...
                  1/8*(1+(a+b+c)*E1+(a*b+b*c+c*a)*v+a*b*c*E3);
          end
      end
  end
  % Implemented: HexagonInflation, WebInflation222, WebInflation322, WebInflation332
  lambda = WebInflation222(orig);    % CHANGE for other inflations
  disp([v, lambda])
  if lambda > 0
    left = v;
  else
    right = v;
  end
end
