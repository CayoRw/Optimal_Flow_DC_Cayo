function [Pcirc, thetas] = CalcFlow(DBARoptimal, DCIR, Bbus)
    % CalcFlow - Calcula os fluxos de potência nas linhas e os ângulos das barras.
    %
    % Sintaxe:
    %   [Pcirc, thetas] = CalcFlow(DBARoptimal, DCIR, BBus, Bbusl, sw)
    %
    % Entradas:
    %   DBARoptimal - Matriz de dados das barras com os ângulos ótimos (coluna 7).
    %   DCIR        - Matriz que define as conexões entre as barras (linhas x [origem, destino]).
    %   BBus        - Matriz de susceptâncias do sistema.
    %   Bbusl       - Matriz de susceptâncias modificada (sem o barramento de referência).
    %   sw          - Índice do barramento de referência (swing).
    %
    % Saídas:
    %   Pcirc       - Vetor de fluxos de potência nas linhas.
    %   thetas      - Vetor de ângulos das barras.

    [NLin, ~] = size(DCIR);
    Pcirc = zeros(NLin, 1);

    % Extrai os ângulos das barras da matriz DBARoptimal
    thetas = DBARoptimal(:, 7);

    % Calcula os fluxos de potência nas linhas
    for il = 1:NLin
        k = DCIR(il, 1); % Barramento de origem da linha
        m = DCIR(il, 2); % Barramento de destino da linha
        Pcirc(il) = Bbus(k, m) * (thetas(k) - thetas(m));
    end
end