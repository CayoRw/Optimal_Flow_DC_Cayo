%% Follow me on github: www.github.com/CayoRw/Optimal_Flow_DC_Cayo
clc
clear all

% File name
filename = 'dados_sistema13B_EC4.txt';

% Inicializating
Sbase = 100;  % MVA
tol = 0.00001; %tolerance

% Getting the datas 
[DBAR, DCIR] = ReadData(filename);

%DBAR(:,2) = DBAR(:,2)*1.2;       % Use this if you want to multiply this load 120%

% Getting the YBus
[BBus,Bbus,sw] = GetBBus(DBAR,DCIR);       

% Getting the Pesp and Qesp
[Pg,Pl,Pgmax,Pgmin,Cost,Smax,NGer,NCar,NBus,NLin] = GetMainDatas(DBAR,DCIR);     

% Datas to road lin prog
[f,A,b,Aeq,beq,lb,ub] = LinProgDatas(Pg,Pl,Pgmax,Pgmin,Cost,Smax,DBAR,DCIR,NGer,NCar,Bbus,sw);

% Roading linprog
[x,fval,exitflag,output,LAMBDA] = linprog(f,A,b,Aeq,beq,lb,ub);

% Creating a new DBAR with optmal values
[DBARoptimal] = Get_new_DBAR(DBAR,x,NGer,sw);

% Roading the system on a flow dc function
[Pcirc] = CalcFlow(DBARoptimal,DCIR,Bbus);

% Print the results
DispResults(DBARoptimal, DCIR, Pcirc, Sbase,fval,x,NGer,NCar);

disp('Lambdas associados a limites de circuitos:');
for i = 1:2*NLin 
    lambda = LAMBDA.ineqlin(i);
    if abs(lambda) > tol
        circuito = ceil(i / 2);  
        fprintf('Circuito %d: %.4f\n', circuito, lambda);
    end
end
disp(' ');
disp('Lambdas associados a limites de geração:');
var = 1;
for i = NBus:NBus+NGer-1  
    lambda = LAMBDA.upper(i);
    if abs(lambda) > tol
        var = i - NBus +1;  
        fprintf('Gerador %d (limite superior): %.4f\n', var, lambda);
    end
end
disp(' ');
disp('Lambdas associados ao custo marginal de operação (restrições de igualdade):');
for i = 1:NBus
    lambda = LAMBDA.eqlin(i);
    if abs(lambda) > tol 
        fprintf('Barra %d: %.4f $/MW\n', i, abs(lambda));
    end
end

% You can acess and favorite the code on: www.github.com/CayoRw/Optimal_Flow_DC_Cayo