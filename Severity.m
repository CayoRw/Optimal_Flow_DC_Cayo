classdef Severity
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Sum
        Qtd
    end
    
    methods
        function obj = Severity(DBAR, DCIR, FlowP, Sbase)
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here
            [NBus, ~] = size(DBAR);
            [NLin, ~] = size(DCIR);
            obj.Qtd = 0;
            obj.Sum = 0;
            for il = 1:NLin
                flows =  abs(FlowP(il,1));
                %limflow = abs(DCIR(il,10)*1.15);
                limflow = abs(DCIR(il,10));
                Value = obj.Verify(flows,limflow);
                if Value ~= 0
                    disp(sprintf('O circuito %2d para %2d tem capacidade de %4f. Passou com %4f com uma severidade de %4f',DCIR(il,1),DCIR(il,2),limflow,FlowP(il,1),Value));
                    obj.Qtd = obj.Qtd  + 1;
                end
                obj.Sum = obj.Sum + Value;
            end
        end
        
        function OverL = Verify(obj,Sij,SijMax)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            if (Sij<=SijMax)
                OverL = 0;
            else
                %OverL = (Sij - (SijMax*0.85))/(SijMax*0.85);
                OverL = (Sij - (SijMax))/(SijMax);
            end
        end
        function [Sum,Qtd] = getSum(obj)
            Sum = obj.Sum;
            Qtd = obj.Qtd;
        end
    end
end


