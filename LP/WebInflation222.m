% Code for
% Post-quantum nonlocality in the minimal triangle scenario
% arXiv:2304.xxxxx
% 
% Authors: Alejandro Pozas-Kerstjens
%
% Last modified: Apr, 2023

function [lambda,prob] = WebInflation222(orig)

[oA, oB, oC] = size(orig);

cvx_begin
    variable prob(oA,oA,oA,oA,oB,oB,oB,oB,oC,oC,oC,oC)
    variable lambda
    maximize lambda
    subject to
        % Positivity
        prob(:) - lambda >= 0;

        % Normalization
        sum(prob(:))==1;
%        disp("Normalization done")

        % Inflation
        % Order: a11a12a21a22b11b12b21b22c11c12c21c22
        permute(prob,[2,1,4,3,7,8,5,6,9,10,11,12]) == prob;
        permute(prob,[1,2,3,4,6,5,8,7,11,12,9,10]) == prob;
        permute(prob,[3,4,1,2,5,6,7,8,10,9,12,11]) == prob;
%        disp("Inflation done")

        % Marginals
        marginal = zeros(oA,oA,oB,oB,oC,oC);
        for a22=1:oA
            for b22=1:oB
                for c22=1:oC
                    marginal(:,a22,:,b22,:,c22) = orig*orig(a22,b22,c22);
                end
            end
        end
        squeeze(sum(sum(sum(sum(sum(sum(prob,2),3),6),7),10),11)) == marginal;
%        disp('marginal1 done')
        marginal2 = zeros(oA,oB,oC);
        for a12=1:oA
            for b12=1:oB
                for c12=1:oC
                    marginal2(a12,b12,c12) = sum(sum(orig(a12,:,:)))*sum(sum(orig(:,b12,:)))*sum(sum(orig(:,:,c12)));
                end
            end
        end
        squeeze(sum(sum(sum(sum(sum(sum(sum(sum(sum(prob,1),3),4),5),7),8),9),11),12)) == marginal2;
%        disp('marginal2 done')

        % LPI constraints
        for a11=1:oA
            for a22=1:oA
                for b11=1:oB
                    for b12=1:oB
                        for c11=1:oC
                            for c21=1:oC
                                sum(sum(sum(sum(sum(sum(prob(a11,:,:,a22,b11,b12,:,:,c11,:,c21,:))))))) == sum(sum(orig(a22,:,:)))*sum(sum(sum(sum(sum(sum(sum(prob(a11,:,:,:,b11,b12,:,:,c11,:,c21,:))))))));
                                sum(sum(sum(sum(sum(sum(prob(c11,:,c21,:,a11,:,:,a22,b11,b12,:,:))))))) == sum(sum(orig(:,a22,:)))*sum(sum(sum(sum(sum(sum(sum(prob(c11,:,c21,:,a11,:,:,:,b11,b12,:,:))))))));
                                sum(sum(sum(sum(sum(sum(prob(b11,b12,:,:,c11,:,c21,:,a11,:,:,a22))))))) == sum(sum(orig(:,:,a22)))*sum(sum(sum(sum(sum(sum(sum(prob(b11,b12,:,:,c11,:,c21,:,a11,:,:,:))))))));
                            end
                        end
                    end
                end
            end
        end
%        disp('LPI constraints done')
cvx_end