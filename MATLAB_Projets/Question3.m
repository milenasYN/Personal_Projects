function [gamma_hat1,gamma_hat2] = Question3(N)
%% Arguments:
% gamma_hat1 = L'estimateur de gamma par Y = U;
% gamma_hat2 = L'estimateur de gamma par Y = ln(U);
%% CODES:
gamma_hat1 = zeros;
gamma_hat2 = zeros;
% calculer la valeur estimee avec la variable de controle Y1 = U
y1 = rand(1,N); 
gamma_hat1 = mean(-log(-log(y1)));
% calculer la valeur estimee avec la variable de controle Y2 = log(U)
y2 = -exprnd(1,1,N);
gamma_hat2 = mean(-log(-y2));
end