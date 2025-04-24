function [Pcirc, thetas] = CalcFlow(DBARoptimal, DCIR, Bbus)
    %% Follow me on GitHub: www.github.com/CayoRw/Optimal_Flow_DC_Cayo
    % CalcFlow - Calculates power flows in the lines and bus voltage angles.
    %
    % Syntax:
    %   [Pcirc, thetas] = CalcFlow(DBARoptimal, DCIR, BBus)
    %
    % Inputs:
    %   DBARoptimal - Matrix of bus data with optimal voltage angles (column 7).
    %   DCIR        - Matrix defining the connections between buses (rows as [from, to]).
    %   BBus        - Susceptance matrix of the system.
    %
    % Outputs:
    %   Pcirc       - Vector of power flows in the transmission lines.
    %   thetas      - Vector of bus voltage angles.

    [NLin, ~] = size(DCIR);
    Pcirc = zeros(NLin, 1);

    % Extract the voltage angles from the DBARoptimal matrix
    thetas = DBARoptimal(:, 7);

    % Calculate power flows in the lines
    for il = 1:NLin
        k = DCIR(il, 1); % Sending bus of the line
        m = DCIR(il, 2); % Receiving bus of the line
        Pcirc(il) = Bbus(k, m) * (thetas(k) - thetas(m));
    end
end
