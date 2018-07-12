function [X,Y] = Question2(N)
%% Arguments:
% N = le nombre de couple (x, y) a generer;
%% CODES:
X = zeros(1,N);
Y = zeros(1,N);
for i = 1:N
    % Utilisons la methode d'inversion pour generer la variables X selon
    % f(x)
    u1 = rand();
    x = log(u1./(1-u1));
    X(i) = x;
    % Utilisons la methode d'inversion pour generer la variables Y selon
    % f(y|x)
    u2 = rand();
    y = log(sqrt(u2)./((exp(-x)+1).*(1-sqrt(u2))));
    Y(i) = y;
end

end