function DispLambda(LAMBDA, NGer, NCar, NBus, DBARoptimal)
    %% Follow me on github: www.github.com/CayoRw/Optimal_Flow_DC_Cayo
    % Função para exibir apenas os multiplicadores de Lagrange ativos associados a:
    % - Limites de fluxo nas linhas (desigualdades)
    % - Limites de geração (superiores)
    % Entradas:
    %   LAMBDA: Estrutura com multiplicadores de Lagrange.
    %   NGer: Número de geradores.
    %   NCar: Número de barras com corte de carga.
    %   NBus: Número de barras.
    %   NLin: Número de linhas (para restrições de fluxo).

    % Tolerância para considerar um multiplicador como ativo
    tol = 1e-6;

    % Exibir lambdas associados a limites de fluxo nas linhas (desigualdades)
    disp('Lambdas associados a limites de circuitos:');
    

end