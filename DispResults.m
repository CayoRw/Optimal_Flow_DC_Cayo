function DispResults(DBARoptimal, DCIR, Pcirc, Sbase,fval,x,NGer,NCar)
    % DispResults - Exibe os resultados das barras e linhas do sistema.
    %
    % Sintaxe:
    %   DispResults(DBARoptimal, DCIR, Pcirc, Sbase)
    %
    % Entradas:
    %   DBARoptimal - Matriz de dados das barras com os ângulos ótimos (coluna 7).
    %   DCIR        - Matriz que define as conexões entre as barras (linhas x [origem, destino]).
    %   Pcirc       - Vetor de fluxos de potência nas linhas.
    %   Sbase       - Potência base do sistema (em MVA).
    %
    % Saídas:
    %   Nenhuma. A função exibe os resultados diretamente no console.

    [NBus, ~] = size(DBARoptimal);
    [NLin, ~] = size(DCIR);
    NVar = NGer + NCar + NBus -1;
    count = 1;
    tipo = strings(NBus, 1);
    count2 = 1;
    Pltotal = 0;
    Pgtotal = 0;
    % Exibe os resultados das barras
    disp('Resultados das Barras');
    disp('=====================');
    disp(' ');
    disp(sprintf('Tabela %1d: Fluxo DC sem perdas', count));
    disp('Barra Tipo Tensão(pu)  Ângulo(°)  PL(MW) Corte(MW) PG(MW)  CGmax(MW) Cus($/MW) Cus($)');
    disp('+---+ +--+ +--------+ +--------+ +-----+ +-------+ +-----+ +-------+ +-------+ +-----+');
    corte = 0;
    for ib = 1:NBus
        ang = DBARoptimal(ib, 7) * 180 / pi; % Converte ângulo para graus
        if DBARoptimal(ib, 5) == 0
            tipo(ib, 1) = 'SW'; % Barramento de referência (Swing)
        elseif DBARoptimal(ib, 5) == 1
            tipo(ib, 1) = 'PV'; % Barramento de geração (PV)
        elseif DBARoptimal(ib, 5) == 2
            tipo(ib, 1) = 'PQ'; % Barramento de carga (PQ)
        end
        Pg = DBARoptimal(ib, 8) * Sbase; % Potência gerada em MW
        Pl = DBARoptimal(ib, 2) * Sbase; % Potência demandada em MW
        Cus = DBARoptimal(ib,9);
        Cmax = DBARoptimal(ib,11)*Sbase;
        CustB = Cus * Pg * Sbase;
        if (DBARoptimal(ib,2)~=0)
            corte = x(NBus+NGer-1)*Sbase;
            count2 = count2+1;
        else
            corte = 0;
        end
        Pltotal = Pl + Pltotal;
        Pgtotal = Pg + Pgtotal;
        disp(sprintf('%5d %4s %10.4f %10.4f %7.2f %9.2f %7.2f %9.2f %9.2f %7.2f', ib, tipo(ib, 1), DBARoptimal(ib, 6), ang, Pl, corte, Pg, Cmax, Cus, CustB));
    end
            disp('+---+ +--+ +--------+ +--------+ +-----+ +-------+ +-----+ +-------+ +-------+ +-----+')
    disp(sprintf('Total: ................................. %9.2f ......... %7.2f ......... %7.2f',Pltotal,fval*Sbase))
    disp(' ');
    count = count + 1;
    % Exibe os resultados das linhas
    disp('Resultados das Linhas');
    disp('=====================');
    disp(' ');
    disp(sprintf('Tabela %1d: Fluxo DC sem perdas', count));
    disp(' De  Para  Pkm(MW)  Perda (MW)   CapMax (MW)  Lim(%)');
    disp('+--+ +--+ +------+ +----------+ +----------+ +------+');
    for il = 1:NLin
        Pkm = Pcirc(il, 1) * Sbase; % Fluxo de potência na linha em MW
        Perda = 0; % Perdas são zero em fluxo DC sem perdas
        Capmax = DCIR(il, 10) * Sbase; % Capacidade máxima da linha em MW
        lim = (abs(Pkm) * 100) / Capmax; % Limite de carga da linha em %
        disp(sprintf('%4d %4d %8.2f %12.2f %12.4f %8.2f', DCIR(il, 1), DCIR(il, 2), Pkm, Perda, Capmax, lim));
    end
    disp('+--+ +--+ +------+ +----------+ +----------+ +------+');
    disp(' ');
    disp(sprintf('Custo total: $ %f',fval*Sbase))
end