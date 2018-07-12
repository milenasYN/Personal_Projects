function [X,iter] = Question1(n,a,b,no_g)
%% Arguments:
% n = nombre de denste de f a generer;
% no_g = 1 si on chisoit g1, 2 si on choisit g2;
%% CODES:
X = zeros(1,n);
iter = 0; % le nombre d'iteration necessaires pour generer n nombre de f.
if no_g == 1 % si on choisit g1 comme la densite instrumentale.
    % g1 = @(x) a./(a+x).^2;
    for i = 1:n
        accept = false;
        while accept == false
            u1 = rand();
            z = a.*u1./(1-u1); % Etape 1: generer Z ~ g1 par u1.
            u2 = rand(); % Etape 2.
            if b <= a % Etape 3.
                if u2 <= b^2*(1+(a+z)^2/(b+z)^2)/(a^2+b^2)
                    X(i) = z;
                    accept = true;
                end
            else
                if u2 <= (1+(a+z)^2/(b+z)^2)/2
                    X(i) = z;
                    accept = true;
                end
            end % Fin d'etape 3
            iter = iter + 1; % Incrementer l'iteration
        end
    end
else
    % g2 = @(x) b./(b+x).^2; % si on choisit g2 comme la densite instrumentale.
    for i = 1:n
        accept = false;
        while accept == false
            u1 = rand();
            z = b.*u1./(1-u1); % Generer Z ~ g2 par u1.
            u2 = rand(); % Etape 2.
            if a <= b % Etape 3.
                if u2 <= a^2*(1+(b+z)^2/(a+z)^2)/(a^2+b^2)
                    X(i) = z;
                    accept = true;
                end
            else
                if u2 <= (1+(b+z)^2/(a+z)^2)/2
                    X(i) = z;
                    accept = true;
                end
            end % Fin d'etape 3.
            iter = iter + 1; % Incrementer l'iteration.
        end
    end
end


end

