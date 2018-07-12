function [W,p] = Question5(N,T,delta,L)
%% Arguments:
% N = le nombre de trajectoires;
% T = la longueur du temps;
% delta = la valeur d'unite des instants;
%% CODES:
m = T./delta; % nombre des instants.
W = [zeros(N,1) cumsum(sqrt(delta).*normrnd(0,1,N,m),2)];
p = length(find(any(W(:,1:1/delta+1)>=L,2)))./N;
end