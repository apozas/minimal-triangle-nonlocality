% Code for
% Post-quantum nonlocality in the minimal triangle scenario
% New J. Phys. 25, 113037 (2023)
% arXiv:2305.03745
% 
% Authors: Alejandro Pozas-Kerstjens
%
% Last modified: May, 2023

function [lambda,prob] = HexagonInflation(orig)

[oA, oB, oC] = size(orig);
o = oA;
cvx_begin
    variable prob(o,o,o,o,o,o)
    variable lambda
    maximize lambda
    subject to
        % Positivity
        prob(:) - lambda >= 0;

        % Normalization
        sum(prob(:))==1;
        % disp("Normalization done")

        % Inflation
        % Order: a11b11c12a22b22c21
        permute(prob,[4,5,6,1,2,3]) == prob;
        %   disp("Inflation done")

        % Marginals
        abab = zeros(o,o,o,o);
        acac = zeros(o,o,o,o);
        bcbc = zeros(o,o,o,o);
        for a11=1:o
            for b11=1:o
                abab(:,:,a11,b11) = squeeze(sum(orig,3))*sum(orig(a11,b11,:));
                bcbc(:,:,a11,b11) = squeeze(sum(orig,1))*sum(orig(:,a11,b11));
                acac(:,:,a11,b11) = squeeze(sum(orig,2))*sum(orig(a11,:,b11));
            end
        end
        acac = permute(acac,[1,4,3,2]);
        %   disp('marginal1 and marginal2 generated')
        squeeze(sum(sum(prob,3),6)) == abab;
        squeeze(sum(sum(prob,1),4)) == bcbc;
        squeeze(sum(sum(prob,2),5)) == acac;

        % LPI constraints
        for a11=1:o
            squeeze(sum(sum(prob(a11,:,:,:,:,:),2),6)) == sum(sum(orig(a11,:,:)))*squeeze(sum(sum(sum(prob,1),2),6));
            squeeze(sum(sum(prob(:,a11,:,:,:,:),1),3)) == sum(sum(orig(:,a11,:)))*squeeze(sum(sum(sum(prob,1),2),3));
            squeeze(sum(sum(prob(:,:,a11,:,:,:),2),4)) == sum(sum(orig(:,:,a11)))*squeeze(sum(sum(sum(prob,2),3),4));
            squeeze(sum(sum(prob(:,:,:,a11,:,:),3),5)) == sum(sum(orig(a11,:,:)))*squeeze(sum(sum(sum(prob,3),4),5));
            squeeze(sum(sum(prob(:,:,:,:,a11,:),4),6)) == sum(sum(orig(:,a11,:)))*squeeze(sum(sum(sum(prob,4),5),6));
            squeeze(sum(sum(prob(:,:,:,:,:,a11),5),1)) == sum(sum(orig(:,:,a11)))*squeeze(sum(sum(sum(prob,1),5),6));
        end
    %    disp('LPI constraints done')
cvx_end