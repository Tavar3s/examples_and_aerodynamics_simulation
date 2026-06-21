function res = gaussianaRBF(centro,raio,pontos)
    vec_norm_sqr = sum((pontos-centro).^2,2);    
    res = exp(-raio*(vec_norm_sqr));
end