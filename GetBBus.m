function [BBus, Bbus,sw] = GetBBus(DBAR, DCIR)
    %%  Follow me on github: www.github.com/CayoRw/Optimal_Flow_DC_Cayo
    % Inicialização das variáveis
    [NBus, ~] = size(DBAR);
    [NLin, ~] = size(DCIR);
    BBus = zeros(NBus, NBus);
    Bbus = zeros(NBus, NBus);
    % Cálculo das matrizes BBus e Bbus
    for il = 1:NLin
        k = DCIR(il, 1);
        m = DCIR(il, 2);
        ykm = -1 / (DCIR(il, 4) + DCIR(il, 5) * 1i); % Admitância série
        bkm = -1 / DCIR(il, 5); % Susceptância shunt

        % Atualização da matriz BBus
        BBus(k, k) = BBus(k, k) + ykm;
        BBus(k, m) = BBus(k, m) - ykm;
        BBus(m, k) = BBus(m, k) - ykm;
        BBus(m, m) = BBus(m, m) + ykm;

        % Atualização da matriz Bbus
        Bbus(k, k) = Bbus(k, k) + bkm;
        Bbus(k, m) = Bbus(k, m) - bkm;
        Bbus(m, k) = Bbus(m, k) - bkm;
        Bbus(m, m) = Bbus(m, m) + bkm;

        for i = 1:NBus
            if DBAR(i, 5) == 0
                sw = i; 
            end
        end
    end
end