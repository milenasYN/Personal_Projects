function [W,prob] = Question5c(N,T,delta,t1,t2)
%% Arguments:
% N = le nombre de trajectoires;
% T = la longueur du temps;
% delta = la valeur d'unite des instants;
%% CODES:
m = T./delta; % nombre de temps.
W = [zeros(N,1) cumsum(sqrt(delta).*normrnd(0,1,N,m),2)];

% pour les mouvements qui ont y2 < 1
lignes2 = find(W(:,t2./delta + 1)<1); % trouver les lignes ou y2 < 1.
W2 = W(lignes2,:); % retrouver tous les mouventment avec y2 >= 1.
y1 = W2(:,t1./delta + 1);
y2 = W2(:,t2./delta + 1);
p = exp(-(1-y1).*(1-y2)./(2.*(t2-t1))); % calculer la probabilite conditionnelle pour chaque mouvement.
n = length(lignes2);
cpt2 = 0;
for i = 1:n
    u = rand();
    if u < p(i)
        cpt2 = cpt2 + 1;
    end
end
prob = cpt2./N;
end