% Code for
% Post-quantum nonlocality in the minimal triangle scenario
% arXiv:2305.xxxxx
% 
% Authors: Alejandro Pozas-Kerstjens
%
% Last modified: May, 2023

function lambda = WebInflation332(orig)

[oA, oB, oC] = size(orig);
o = oA;

cvx_begin
  cvx_solver mosek
  variable prob(o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o)
  variable lambda
  maximize lambda
  subject to
    % Positivity
    prob(:) - lambda >= 0;

    % Normalization
    sum(prob(:))==1;
    % disp("Normalization done")

    % Inflation
    % Order: a11a12a13a21a22a23b11b12b13b21b22b23b31b32b33c11c12c21c22c31c32
    % Swap rhoACs
    permute(prob,[4,5,6,1,2,3,7,8,9,10,11,12,13,14,15,17,16,19,18,21,20]) == prob;
    % rhoAB 1<->2
    permute(prob,[2,1,3,5,4,6,10,11,12,7,8,9,13,14,15,16,17,18,19,20,21]) == prob;
    % rhoAB 1<->3
    permute(prob,[3,2,1,6,5,4,13,14,15,10,11,12,7,8,9,16,17,18,19,20,21]) == prob;
    % rhoAB 2<->3
    permute(prob,[1,3,2,4,6,5,7,8,9,13,14,15,10,11,12,16,17,18,19,20,21]) == prob;
    % rhoAB 1->2->3->1
    permute(prob,[2,3,1,5,6,4,10,11,12,13,14,15,7,8,9,16,17,18,19,20,21]) == prob;
    % rhoAB 1->3->2->1
    permute(prob,[3,1,2,6,4,5,13,14,15,7,8,9,10,11,12,16,17,18,19,20,21]) == prob;
    % rhoBC 1<->2
    permute(prob,[1,2,3,4,5,6,8,7,9,11,10,12,14,13,15,18,19,16,17,20,21]) == prob;
    % rhoBC 1<->3
    permute(prob,[1,2,3,4,5,6,9,8,7,12,11,10,15,14,13,20,21,18,19,16,17]) == prob;
    % rhoBC 2<->3
    permute(prob,[1,2,3,4,5,6,7,9,8,10,12,11,13,15,14,16,17,20,21,18,19]) == prob;
    % rhoBC 1->2->3->1
    permute(prob,[1,2,3,4,5,6,8,9,7,11,12,10,14,15,13,18,19,20,21,16,17]) == prob;
    % rhoBC 1->3->2->1
    permute(prob,[1,2,3,4,5,6,9,7,8,12,10,11,15,13,14,20,21,16,17,18,19]) == prob;
    % disp("Inflation done")

    % Marginals
    marginal1 = zeros(o,o,o,o,o,o,o); %a11b11c11 a22b22c22 b33
    marginal2 = zeros(o,o,o,o); %a12 b12 c12 b33
    for a11=1:o
      for b11=1:o
        for b33=1:o
          for c11=1:o
            % a11a22b11b22b33c11c22 = a11b11c11 a22b22c22 b33
            marginal1(a11,:,b11,:,b33,c11,:) = orig(a11,b11,c11)*orig*sum(sum(orig(:,b33,:)));
            % a12b12b33c12 = a12 b12 b33 c12
            marginal2(a11,b11,b33,c11) = sum(sum(orig(a11,:,:)))*sum(sum(orig(:,b11,:)))*sum(sum(orig(:,b33,:)))*sum(sum(orig(:,:,c11)));
          end
        end
      end
    end
    squeeze(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(prob,2),3),4),6),8),9),10),12),13),14),17),18),20),21)) == marginal1;
    % disp('marginal1 done')
    squeeze(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(prob,1),3),4),5),6),7),9),10),11),12),13),14),16),18),19),20),21)) == marginal2;
    % disp('marginal2 done')

    % LPI constraints
    for o1=1:o
      % Isolate a11
      % a11a22a23b21b22b23b32b33c12c22c32 = a11 a22a23b21b22b23b32b33c12c22c32
      squeeze(sum(sum(sum(sum(sum(sum(sum(sum(sum(prob(o1,:,:,:,:,:,:,:,:,:,:,:,:,:,:,:,:,:,:,:,:),2),3),4),7),8),9),16),18),20)) == ...
      sum(sum(orig(o1,:,:)))*squeeze(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(prob,1),2),3),4),7),8),9),16),18),20));
      % Isolate b33
      % a11a12a21a22b11b12b21b22b33c11c12c21c22 = b33 a11a12a21a22b11b12b21b22c11c12c21c22
      squeeze(sum(sum(sum(sum(sum(sum(sum(sum(prob(:,:,:,:,:,:,:,:,:,:,:,:,:,:,o1,:,:,:,:,:,:),3),6),9),12),13),14),20),21)) == ...
      sum(sum(orig(:,o1,:)))*squeeze(sum(sum(sum(sum(sum(sum(sum(sum(sum(prob,3),6),9),12),13),14),15),20),21));
      % Isolate c11
      % a21a22a23b12b13b22b23b32b33c11c22c32 = c11 a21a22a23b12b13b22b23b32b33c22c32
      squeeze(sum(sum(sum(sum(sum(sum(sum(sum(sum(prob(:,:,:,:,:,:,:,:,:,:,:,:,:,:,:,o1,:,:,:,:,:),1),2),3),7),10),13),17),18),20)) == ...
      sum(sum(orig(:,:,o1)))*squeeze(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(prob,1),2),3),7),10),13),16),17),18),20));
      for o2=1:o
        % Isolate a11 b22
        %a11a23b22b31b33c12c32 = a11 b22 a23b31b33c12c32
        squeeze(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(prob(o1,:,:,:,:,:,:,:,:,:,o2,:,:,:,:,:,:,:,:,:,:),2),3),4),5),7),8),9),10),12),14),16),18),19),20)) == ...
        sum(sum(orig(o1,:,:)))*sum(sum(orig(:,o2,:)))*squeeze(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(prob,1),2),3),4),5),7),8),9),10),11),12),14),16),18),19),20));
        % Isolate a11 c22
        %a11b21b23b31b33c22 = a11 c22 b21b23b31b33
        squeeze(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(prob(o1,:,:,:,:,:,:,:,:,:,:,:,:,:,:,:,:,:,o2,:,:),2),3),4),5),6),7),8),9),11),14),16),17),18),20),21)) == ...
        sum(sum(orig(o1,:,:)))*sum(sum(orig(:,:,o2)))*squeeze(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(prob,1),2),3),4),5),6),7),8),9),11),14),16),17),18),19),20),21));
        % Isolate b11 c22
        %a12a13b11b23b33c22c31 = b11 c22 a12a13b23b33c31
        squeeze(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(prob(:,:,:,:,:,:,o1,:,:,:,:,:,:,:,:,:,:,:,o2,:,:),1),4),5),6),8),9),10),11),13),14),16),17),18),21)) == ...
        sum(sum(orig(:,o1,:)))*sum(sum(orig(:,:,o2)))*squeeze(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(prob,1),4),5),6),7),8),9),10),11),13),14),16),17),18),19),21));
        % Isolate a11 a22
        % a11a22b31b32b33 = a11 a22 b31b32b33
        squeeze(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(prob(o1,:,:,:,o2,:,:,:,:,:,:,:,:,:,:,:,:,:,:,:,:),2),3),4),6),7),8),9),10),11),12),16),17),18),19),20),21)) == ...
        sum(sum(orig(o1,:,:)))*sum(sum(orig(o2,:,:)))*squeeze(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(prob,1),2),3),4),5),6),7),8),9),10),11),12),16),17),18),19),20),21));
        % Isolate c11 c22
        % b13b23b33c11c22 = c11 c22 b13b23b33
        squeeze(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(prob(:,:,:,:,:,:,:,:,:,:,:,:,:,:,:,o1,:,:,o2,:,:),1),2),3),4),5),6),7),8),10),11),13),14),17),18),20),21)) == ...
        sum(sum(orig(:,:,o1)))*sum(sum(orig(:,:,o2)))*squeeze(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(prob,1),2),3),4),5),6),7),8),10),11),13),14),16),17),18),19),20),21));
        % Isolate b11 b22
        % a13a23b11b22b33c31c32 = b11 b22 a13a23b33c31c32
        squeeze(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(prob(:,:,:,:,:,:,o1,:,:,:,o2,:,:,:,:,:,:,:,:,:,:),1),2),4),5),8),9),10),12),13),14),16),17),18),19)) == ...
        sum(sum(orig(:,o1,:)))*sum(sum(orig(:,o2,:)))*squeeze(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(prob,1),2),4),5),7),8),9),10),11),12),13),14),16),17),18),19));

        for o3=1:o
          % Isolate a11b11c11 (a11b11, a11c11, b11c11 are included)
          % a11a22a23b11b22b23b32b33c11c22c32 = a11b11c11 a22a23b22b23b32b33c22c32
          squeeze(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(prob(o1,:,:,:,:,:,o2,:,:,:,:,:,:,:,:,o3,:,:,:,:,:),2),3),4),8),9),10),13),17),18),20)) == ...
          orig(o1,o2,o3)*squeeze(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(prob,1),2),3),4),7),8),9),10),13),16),17),18),20));
          % Isolate a11c11 b22 leads to a11b11c11 b22 a23b33c32
          % Isolate a11 b33 c22 leads to a11 b21 b33 c22
          % Isolate b11 b22 b33 leads to abc*abc*b
          % Isolate a11b11 b22 leads to abc*abc*b
          for o4=1:o
            % Isolate a11b11c11 c22 (includes a11b11 c22 and a11b11 a22)
            % a11b11b23b33c11c22 =  a11b11c11 c22 b23b33
            squeeze(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(prob(o1,:,:,:,:,:,o2,:,:,:,:,:,:,:,:,o3,:,:,o4,:,:),2),3),4),5),6),8),9),10),11),13),14),17),18),20),21)) == ...
            orig(o1,o2,o3)*sum(sum(orig(:,:,o4)))*squeeze(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(prob,1),2),3),4),5),6),7),8),9),10),11),13),14),16),17),18),19),20),21));
            % Isolate a11b11c11 b22 leads to a11b11c11 b22 a23b33c32
            % Isolate a11b11c11 a22 (includes a22 b11c11 and a11b11 a22)
            % a11a22b11b32b33c11 = a11b11c11 a22 b32b33
            squeeze(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(prob(o1,:,:,:,o4,:,o2,:,:,:,:,:,:,:,:,o3,:,:,:,:,:),2),3),4),6),8),9),10),11),12),13),17),18),19),20),21)) == ...
            orig(o1,o2,o3)*sum(sum(orig(o4,:,:)))*squeeze(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(prob,1),2),3),4),5),6),7),8),9),10),11),12),13),16),17),18),19),20),21));

            % Isolate a11b11 b22c22 leads to a11b11c11 a22b22c22 b33
            % Isolate a11c11 b22c22 leads to a11b11c11 a22b22c22 b33
            % Isolate a11b11 a22c22 leads to a11b11c11 a22b22c22 b33
            % Isolate a11b11 b22 c32 leads to a11b11c11 b22 a23b33c32
            % Isolate a11 b22 b33c32 leads to a11b11c11 b22 a23b33c32
            % Isolate a11b11 a22c22 leads to a11b11c11 a22b22c22 b33

            % The products of 3 with two As, Bs or Cs have to have the same in
            % different parts, and then for two As or two Cs the probability
            % doesn't exist, and for two Bs we have
            % Isolate a11b11 b22 c32 leads to a11b11c11 a22b22c22 b33

            % The products of 3 with three As or Cs are impossible because there
            % are not enough indices. The products with three Bs exhaust the
            % indices for the fourth part

            % Products of 4 with two As or Cs are not possible because indices
            % are exhausted. Products of 4 with two Bs is one of the all-known
            % marginals. Products of 4 with three As or Cs are impossible for
            % the same reason as above, and with three Bs exhausts the indices.

            % Products of 3-2 reduce to abc*abc*b
            % Products of 3-1-1 reduce also to abc*abc*b
            % Products of 2-2-1
            % AB-AB-B leads to abc*abc*b
            % AB-AB-A/C is not possible because of indices
            % AB-AC-A/C is not possible because of indices
            % AB-AC-B leads to abc*abc*b
            % AB-BC-A/C is not possible, AB-BC-B leads to abc*abc*b
            % Products of 3-1-1-1 are not possible due to indices
          end
        end
      end
    end
    % disp('LPI constraints done')
cvx_end
