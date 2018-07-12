%% ****************Question 1****************
clear all;
a = 1; 
b = 2;
n = 1000;
% f = @(x) a.*b.*(1./(a+x).^2+1./(b+x).^2)./(a+b);
% g1 = @(x) a./(a+x).^2;
% g2 = @(x) b./(a+x).^2; 
% si on choisit g1 comme la densite instrumentale
rng(888);
[X1,iter1] = Question1(n,a,b,1);
% si on choisit g2 comme la densite instrumentale
rng(888);
[X2,iter2] = Question1(n,a,b,2);
%% ****************Question 2****************
clear all;
N = 10000;
rng(888);
[X,Y] = Question2(N);
M_cov = cov(X,Y);
covXY = M_cov(1,2);
%% ****************Question 3****************
% calculer la valeur estimee de gamma en utilisant deux differente
% variables de controle.
clear all;
N = 1000;
rng(888);
[gamma_hat1,gamma_hat2] = Question3(N);
% calculer la vraie valeur de gamma
gamma = integral(@(x) -log(-log(x)),0,1)
%% ****************Question 4****************
clear all;
n=5;
N=1000;
P=[0.4 0.3 0.3;0.5 0.2 0.3;0.3 0.1 0.6];
i0=2;
in=2;
rng(888);
[Proba,X]=Question4(P,n,N,i0,in);
p4 = 1 - length(find(any(X(:,1:4)==2,2)))./N;
%% ****************Question 5****************
clear all;
% b)
N = 10000 %le nombre de trajectoires simulees.
T = 1 %la longueur du temps.
delta = 0.01; % la longueur d'une unite de temps.
L = 1;
rng(888);
[W1 p_5b] = Question5(N,T,delta,L);
temps = 0:delta:T;
% c)
t1 = 0;
t2 = 1;
rng(888);
[W2 p_5c] = Question5c(N,T,delta,t1,t2);