function [DBAR, DCIR] = ReadData(filename)
    %% Follow me on github: www.github.com/CayoRw/Optimal_Flow_DC_Cayo
    fid = fopen(filename, 'r');
    if fid == -1
        error('Não foi possível abrir o arquivo.');
    end
    
    DBAR = {};
    DCIR = {};
    secao_atual = '';
    
    while ~feof(fid)
        linha = strtrim(fgetl(fid));
        
        if strcmp(linha, 'DBAR')
            secao_atual = 'DBAR';
            continue;
        elseif strcmp(linha, 'DCIR')
            secao_atual = 'DCIR';
            continue;
        elseif startsWith(linha, '####')
            secao_atual = ''; 
            continue;
        elseif startsWith(linha, 'OBS')
            break; 
        end
        
        if strcmp(secao_atual, 'DBAR')
            DBAR = [DBAR; strsplit(linha)];
        elseif strcmp(secao_atual, 'DCIR')
            DCIR = [DCIR; strsplit(linha)];
        end
    end
    
    fclose(fid);

    if size(DBAR, 1) > 2
        DBAR(1:2, :) = [];
    end
    if size(DCIR, 1) > 2
        DCIR(1:2, :) = [];
    end
    
    DBAR = strrep(strrep(strrep(DBAR, 'SW', '0'), 'PV', '1'), 'PQ', '2');
    
    DCIR = strrep(strrep(DCIR, 'L', '1'), 'D', '0');
    
    DBAR = str2double(DBAR);
    DCIR = str2double(DCIR);
end