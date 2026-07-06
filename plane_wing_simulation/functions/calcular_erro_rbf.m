function erro = calcular_erro_rbf(h_val, pontos, z_real, centros)
    % Evita h negativo ou zero (matematicamente inválido para essa formulação)
    if h_val <= 0
        erro = inf;
        return;
    end
    
    num_centros = size(centros, 1);
    num_pontos = size(pontos, 1);
    Phi = zeros(num_pontos, num_centros);
    
    % Monta a matriz de design
    for j = 1:num_centros
        Phi(:, j) = gaussianaRBF(centros(j, :), h_val, pontos);
    end
    
    % Resolve os coeficientes e prevê
    c = Phi \ z_real; 
    z_pred = Phi * c;
    
    % Calcula o Erro Quadrático Médio (MSE)
    erro = mean((z_real - z_pred).^2);
end
