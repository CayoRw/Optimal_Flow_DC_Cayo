function [DBARoptimal] = Get_New_DBAR(DBAR, x, NGer, sw)
    %% Follow me on github: www.github.com/CayoRw/Optimal_Flow_DC_Cayo
    % Get_New_DBAR - Reconstroi a matriz DBAR a partir do resultado de x do linprog.
    %
    % Entradas:
    %   DBAR    - Matriz original de dados das barras.
    %   x       - Vetor de solução do linprog (ângulos e potências dos geradores).
    %   NGer    - Número de geradores no sistema.
    %   sw      - Índice do barramento de referência (swing).
    %
    % Saída:
    %   DBARoptimal - Matriz DBAR atualizada com os ângulos e potências ótimos.
    [NBus, ~] = size(DBAR);
    DBARoptimal = DBAR; % Copia a matriz original
    % Extrai os ângulos das barras (exceto o barramento de referência)
    thetasl = x(1:NBus-1); % Ângulos das barras (exceto swing)
    thetas = [thetasl(1:sw-1); 0; thetasl(sw:end)]; % Adiciona 0 no swing
    % Extrai as potências dos geradores
    Pg = x(NBus:NBus+NGer-1); % Potências dos geradores
    count = 1;
    % Atualiza os ângulos e potências na matriz DBARoptimal
    for il = 1:NBus
        DBARoptimal(il, 7) = thetas(il); % Atualiza o ângulo da barra
        % Se a barra for do tipo 0 (referência) ou 1 (PQ), atualiza a potência
        if DBARoptimal(il, 5) == 0 || DBARoptimal(il, 5) == 1
            % Verifica se a barra possui um gerador
            DBARoptimal(il, 8) = Pg(count); % Atualiza a potência do gerador
            count = count +1;
        end
    end
end