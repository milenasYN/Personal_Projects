function [prob,X] = Question4(P,n,N,i0,in)
%% Arguments:
% prob = la matrice des probabilités, chaque ligne represente une
% trajectoire;
% X = la matrice des etats, chaque ligne represente une trajectoire; 
% P = matrice de transition;
% n = nombre de pas a simuler;
% N = nombre de trajectoires;
% i0,in = etat initial et final;
%% CODES:
S = 1:size(P,1); % par defaut, le vecteur des valeurs des etats est [1 2 3 ... k].
CDF = cumsum(P,2); % fonction de distribution cumulative(la somme cumulative a chaque ligne de P).
ind = zeros(N,n); % le vecteur des indices d'etats pour chaque pas, dans cet exercice l'indice d'un etat est equivalent a sa valeur.
ind(1,1) = i0; % fixer l'etat initial pour chaque trajectoire.
i = i0; % initialiser l'etat du premier pas.
prob = zeros(N,n); % initialiser la matrice des probabilites de dimension Nxn.
for j = 1:N % N trajectoires
    for t = 1:(n-1) % simuler jusqu'a X(n-1).
        prob(j,t) = rand(1); % generer la probabilite a chaque pas(un nombre aleatoire de la distribution uniforme).
        ind(j,t) = find(CDF(i,:)>=prob(j,t),1);% methode d'inversion pour generer les etats, il retourne l'indice d'un etat qui est equivalent a la valeur de cet etat.
        i = ind(j,t); % mettre a jour l'etat (son indice) present.
    end
    % simuler la derniere probabilite permettant de passe de l'etape X(n-1)
    % a X(n) fixe.
    if in > 1  % si l'etat du n pas n'est pas egale a 1.
        a = CDF(i,in-1); % trouver la probabilite pour passer de l'etat i_n-1 a l'etat i_n-1 ou plus petit.
        b = CDF(i,in); % trouver la probabilite pour passer de l'etat i_n-1 a l'etat i_n ou plus petit.
    else       % si l'etat du n pas est 1.
        a = 0;
        b = CDF(i,in);
    end
    prob(j,n) = a + (b-a).*rand(1); % generer la derniere probabilite pour passer du n-1 pas à n pas, c'est-a-dire, une v.a. d'uniforme(a,b).
    ind(j,n)=in; % fixer l'etat?son indice? du dernier pas X(n).
end
 X = S(ind); % trouver les valeurs a chaque pas correspondants, dans cet exercice x = ind aussi.
end