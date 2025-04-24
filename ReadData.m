function [DBAR, DCIR] = ReadData(filename)
    % Abrir o arquivo
    fid = fopen(filename, 'r');
    if fid == -1
        error('Não foi possível abrir o arquivo.');
    end
    
    % Inicializando variáveis para armazenar dados
    DBAR = {};
    DCIR = {};
    secao_atual = '';
    
    % Lendo o arquivo linha por linha
    while ~feof(fid)
        linha = strtrim(fgetl(fid)); % Lê a linha e remove espaços em branco nas extremidades
        
        % Identificando as seções
        if strcmp(linha, 'DBAR')
            secao_atual = 'DBAR';
            continue;
        elseif strcmp(linha, 'DCIR')
            secao_atual = 'DCIR';
            continue;
        elseif startsWith(linha, '####')
            secao_atual = ''; % Fim da seção
            continue;
        elseif startsWith(linha, 'OBS')
            break; % Ignora os comentários a partir daqui
        end
        
        % Processa a linha dependendo da seção atual
        if strcmp(secao_atual, 'DBAR')
            DBAR = [DBAR; strsplit(linha)];
        elseif strcmp(secao_atual, 'DCIR')
            DCIR = [DCIR; strsplit(linha)];
        end
    end
    
    % Fechando o arquivo
    fclose(fid);

    % Removendo as duas primeiras linhas de DBAR e DCIR
    if size(DBAR, 1) > 2
        DBAR(1:2, :) = [];
    end
    if size(DCIR, 1) > 2
        DCIR(1:2, :) = [];
    end
    
    % Substituindo os valores na matriz DBAR
    DBAR = strrep(strrep(strrep(DBAR, 'SW', '0'), 'PV', '1'), 'PQ', '2');
    
    % Substituindo os valores na matriz DCIR
    DCIR = strrep(strrep(DCIR, 'L', '1'), 'D', '0');
    
    % Convertendo as matrizes para double
    DBAR = str2double(DBAR);
    DCIR = str2double(DCIR);
end