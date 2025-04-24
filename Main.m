clc
clear all

% File name
filename = 'dados_sistema13B_EC4.txt';
%filename = 'Data_Example_Slide.txt';

% Inicializating
Sbase = 100;  % MVA
tol = 0.00001;

% Getting the datas 
[DBAR, DCIR] = ReadData(filename);

DBAR(:,2) = DBAR(:,2)*1.2;
DBAR(:,3) = DBAR(:,3)*1.2;

% Getting the YBus
[BBus,Bbus,sw] = GetBBus(DBAR,DCIR);       

% Getting the Pesp and Qesp
[Pg,Pl,Pgmax,Pgmin,Cost,Smax,NGer,NCar] = GetMainDatas(DBAR,DCIR);     

% Datas to road lin prog
[f,A,b,Aeq,beq,lb,ub] = LinProgDatas(Pg,Pl,Pgmax,Pgmin,Cost,Smax,DBAR,DCIR,NGer,NCar,Bbus,sw);

% Roading linprog
[x,fval,exitflag,output,lambda] = linprog(f,A,b,Aeq,beq,lb,ub);

% Creating a new DBAR with optmal values
[DBARoptimal] = Get_new_DBAR(DBAR,x,NGer,sw);

% Roading the system on a flow dc function
[Pcirc] = CalcFlow(DBARoptimal,DCIR,Bbus);

% Print the results
DispResults(DBARoptimal, DCIR, Pcirc, Sbase,fval,x,NGer,NCar);