function [Pg,Pl,Pgmax,Pgmin,Cost,Smax,NGer,NCar] = GetMainDatas(DBAR,DCIR)
    % Inicialização das variáveis
    [NBus, ~] = size(DBAR);
    [NLin, ~] = size(DCIR);
    NGer = 0;
    NCar = 0;
    for il = 1:NBus
        if(DBAR(il,5)==0) || (DBAR(il,5)==1)
            NGer = NGer + 1;
        end
        if(DBAR(il,2)~=0)
            NCar = NCar + 1;
        end
    end
    Pg = zeros(2*NBus, 1);
    Pl = zeros(NBus, 1);
    Cost = zeros(NBus+NCar, 1);
    Smax = zeros(NLin, 1);
    count = 0;
    % Cálculo do vetor Pesp e da soma das potências
    for il = 1:NBus
        Pl(il,1) = DBAR(il,2);
        Cost(il,1) = DBAR(il,9);
        if(DBAR(il,5)==0) || (DBAR(il,5)==1)
            Pg(il,1) = 1;
        end
        if(DBAR(il,2)~=0)
            count = count +1;
            Pg(il+NBus) = 1;
            Cost(count+NBus,1) = 1000;
        end
    end
    Pgmax = zeros(NGer + NCar, 1);
    Pgmin = zeros(NGer + NCar, 1);
    count =  1;
    for il = 1:NBus
        if(DBAR(il,5)==0) || (DBAR(il,5)==1)
            Pgmin(count,1) = DBAR(il,10);
            Pgmax(count,1) = DBAR(il,11);
            count = count + 1;
        end
    end
    count = 1;
    for il = 1:NBus
        if(DBAR(il,2)~=0)
            Pgmax(NGer+count,1) = DBAR(il,2);
            count = count + 1;
        end
    end

    for i = 1:NLin
        Smax(i,1) = DCIR(i, 10);
    end
end