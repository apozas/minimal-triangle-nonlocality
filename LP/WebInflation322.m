% Code for
% Post-quantum nonlocality in the minimal triangle scenario
% arXiv:2304.xxxxx
% 
% Authors: Alejandro Pozas-Kerstjens
%
% Last modified: Apr, 2023

function lambda = WebInflation322(orig)

[oA, oB, oC] = size(orig);
o = oA;

cvx_begin quiet
    cvx_solver mosek
    variable prob(o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o)
    variable lambda
    maximize lambda
    subject to
        % Positivity
        prob(:) - lambda >= 0;

        % Normalization
        sum(prob(:))==1;
        % disp("Normalization done")

        % Inflation
        % Order: a11a12a21a22b11b12b13b21b22b23c11c12c21c22c31c32
        % Swap rhoABs
        permute(prob,[2,1,4,3,8,9,10,5,6,7,11,12,13,14,15,16]) == prob;
        % Swap rhoACs
        permute(prob,[3,4,1,2,5,6,7,8,9,10,12,11,14,13,16,15]) == prob;
        % rhoBC 1<->2
        permute(prob,[1,2,3,4,6,5,7,9,8,10,13,14,11,12,15,16]) == prob;
        % rhoBC 1<->3
        permute(prob,[1,2,3,4,7,6,5,10,9,8,15,16,13,14,11,12]) == prob;
        % rhoBC 2<->3
        permute(prob,[1,2,3,4,5,7,6,8,10,9,11,12,15,16,13,14]) == prob;
        % rhoBC 1->2->3->1
        permute(prob,[1,2,3,4,6,7,5,9,10,8,13,14,15,16,11,12]) == prob;
        % rhoBC 1->3->2->1
        permute(prob,[1,2,3,4,7,5,6,10,8,9,15,16,11,12,13,14]) == prob;
        % disp("Inflation done")

        % Marginals
        marginal1 = zeros(o,o,o,o,o,o); %a11a22b11b22c11c22
        marginal2 = zeros(o,o,o,o,o);   %a11b11b22c11c32
        for a11=1:o
            for b11=1:o
                marginal2(:,:,a11,:,b11) = orig*sum(sum(orig(:,a11,:)))*sum(sum(orig(:,:,b11)));
                for c11=1:o
                    marginal1(a11,:,b11,:,c11,:) = orig(a11,b11,c11)*orig;
                end
            end
        end
        % a11,a12,a21,a22,b11,b12,b13,b21,b22,b23,c11,c12,c21,c22,c31,c32
        squeeze(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(prob,2),3),6),7),8),10),12),13),15),16)) == marginal1;
        % disp('marginal1 done')
        squeeze(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(prob,2),3),4),6),7),8),10),12),13),14),15)) == marginal2;
        % disp('marginal2 done')

        % LPI constraints
        for a11=1:o
            for b11=1:o
                for c11=1:o
                    % a11a22b11b22b23c11c22c32 = a11b11c11 a22b22b23c22c32
                    squeeze(sum(sum(sum(sum(sum(sum(sum(sum(prob(a11,:,:,:,b11,:,:,:,:,:,c11,:,:,:,:,:),2),3),6),7),8),12),13),15)) == ...
                    orig(a11,b11,c11)*squeeze(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(sum(prob,1),2),3),5),6),7),8),11),12),13),15));
                end
            end
        end
        % disp('LPI constraints 1 done')
    
        for a22=1:o
            % a11a22b11b12b13c11c21c31 = a22 a11b11b12b13c11c21c31
            squeeze(sum(sum(sum(sum(sum(sum(sum(sum(prob(:,:,:,a22,:,:,:,:,:,:,:,:,:,:,:,:),2),3),8),9),10),12),14),16)) == ...
            sum(sum(orig(a22,:,:)))*squeeze(sum(sum(sum(sum(sum(sum(sum(sum(sum(prob,2),3),4),8),9),10),12),14),16));
            % a11a21b11b12b23c11c12c21c22 = b23 a11a21b11b12c11c12c21c22
            squeeze(sum(sum(sum(sum(sum(sum(sum(prob(:,:,:,:,:,:,:,:,:,a22,:,:,:,:,:,:),2),4),7),8),9),15),16)) == ...
            sum(sum(orig(:,a22,:)))*squeeze(sum(sum(sum(sum(sum(sum(sum(sum(prob,2),4),7),8),9),10),15),16));
            % a11a12b11b12b21b22c11c21c32 = c32 a11a12b11b12b21b22c11c21
            squeeze(sum(sum(sum(sum(sum(sum(sum(prob(:,:,:,:,:,:,:,:,:,:,:,:,:,:,:,a22),3),4),7),10),12),14),15)) == ...
            sum(sum(orig(:,:,a22)))*squeeze(sum(sum(sum(sum(sum(sum(sum(sum(prob,3),4),7),10),12),14),15),16));
        end
        % disp('LPI constraints 2 done')
cvx_end
