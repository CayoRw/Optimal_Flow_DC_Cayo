function [f,A,b,Aeq,beq,lb,ub] = LinProgDatas(Pg,Pl,Pgmax,Pgmin,Cost,Smax,DBAR,DCIR,NGer,NCar,Bbus,sw)
    %% Follow me on github: www.github.com/CayoRw/Optimal_Flow_DC_Cayo
    % Inicialização das variáveis
    [NBus, ~] = size(DBAR);
    [NLin, ~] = size(DCIR);
    NVar = NGer + NCar + NBus -1;
    NDes = NLin*2;
    f = zeros(NVar, 1);
    A = zeros(NDes, NVar+1);
    b = zeros(1, NDes);
    Aeq = zeros(NBus, NVar);
    beq = zeros(1, NGer);
    lb = zeros(1, NVar);
    ub = zeros(1, NVar);

    Bbusl = Bbus;
    Bbusl(:, sw) = []; 

    Cost = nonzeros(Cost)'; % Remove os custos 0 do vetor custo
    f(NBus:end) = Cost; % Últimos lugares de f recebem os valores de Cost, que tem NGer valores

    % Eq de igualdade
    for i = 1:NBus
        for j = 1:NBus-1
            Aeq(i, j) = Bbusl(i, j);
        end
        if Pg(i) == 1
            % Se a barra i tem um gerador, adiciona o coeficiente 1 para PG
            idx_gerador = sum(Pg(1:i)); % Índice do gerador na lista
            Aeq(i, NBus-1 + idx_gerador) = 1; % Coeficiente para PG
        end
        if Pg(i+NBus) == 1
            % Se a barra i tem um gerador, adiciona o coeficiente 1 para PG
            idx_gerador = sum(Pg(1:i+NBus)); % Índice do gerador na lista
            Aeq(i, NBus-1 + idx_gerador) = 1; % Coeficiente para PG
        end
    end

    beq = Pl; % Depois confira que será várias linhas e 1 coluna
    
    Bbusl = Bbus;
    Bbusl(:, sw) = 0; 

    % Montagem das restrições
    for i = 1:NLin
        k = DCIR(i, 1); % Barramento de origem da linha i
        m = DCIR(i, 2); % Barramento de destino da linha i
        Bij = Bbusl(k, m); % Susceptância da linha i

        % Restrição 1: P_ij = Bij*(θ_k - θ_m) <= Smax(i)
        A(2*i - 1, k) = Bij;   % Coeficiente para θ_k
        A(2*i - 1, m) = -Bij;  % Coeficiente para θ_m
        b(2*i - 1) = Smax(i,1);  % Limite superior
        
        % Restrição 2: -P_ij = Bij*(θ_m - θ_k) <= Smax(i)
        A(2*i, k) = -Bij;      % Coeficiente para θ_k
        A(2*i, m) = Bij;       % Coeficiente para θ_m
        b(2*i) = Smax(i,1);      % Limite superior
    end
    A(:, sw) = []; % Excluindo a barra de referência

    % Lower bounds e Upper bounds

    lb(1:NBus-1) = -pi;
    ub(1:NBus-1) = pi;
    lb(NBus:end) = Pgmin;
    ub(NBus:end) = Pgmax;

end
