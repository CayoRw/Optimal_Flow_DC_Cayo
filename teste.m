% Dados de exemplo
NGer = 3; % Número de geradores (tamanho x)
NBus = 5; % Número de barramentos (tamanho y)
NVar = NGer + NBus - 1; % Número de variáveis

% Vetor Cost de exemplo (alternando entre 0 e números positivos)
Cost = [0.0, 10, 00.0, 20, 30]; % Exemplo: tamanho NBus

% Passo 1: Remover os zeros do vetor Cost
Cost = nonzeros(Cost)'; % Remove zeros e transposta para vetor linha

% Passo 2: Preencher o vetor f
f = zeros(NVar, 1); % Inicializa f com zeros

% Preenche as primeiras NBus-1 posições de f com 0
f(1:NBus-1) = 0; % Primeiras NBus-1 posições são 0

% Preenche as últimas posições de f com os valores de Cost
f(NBus:end) = Cost; % Últimas NGer posições recebem os valores de Cost

% Exibindo os resultados
disp('Vetor Cost sem zeros:');
disp(Cost);

disp('Vetor f preenchido:');
disp(f);