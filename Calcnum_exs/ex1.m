clear all; clc;

%% Dados do exercício
T = 10;          
m = 1000;       
N = m;           
%% Letra a

% Malha temporal
x = -5:(T/m):5;
x(end) = [];     % remove o último ponto

% Função degrau unitário
y = zeros(size(x));

for i = 1:length(x)
    if x(i) >= 0
        y(i) = 1;
    else
        y(i) = 0;
    end
end

figure;
plot(x,y,'LineWidth',1.5);
grid on;
xlabel('t');
ylabel('f(t)');
title('Função degrau');

%% Letra b
% Produto interno <phi_j,phi_j>

dx = T/N;

fprintf('Produtos internos:\n\n');

for j = 1:10

    if j == 1
        phi = ones(size(x));
    elseif mod(j,2)==0  %identifica se j é par ou ímpar
        k = j/2;
        phi = cos(2*pi*k*x/T);
    else
        k = (j-1)/2;
        phi = sin(2*pi*k*x/T);
    end

    produto = sum(phi.*phi)*dx; %produto interno

    fprintf('<phi_%d,phi_%d> = %.4f\n',j,j,produto);

end

%% Letra c
% Cálculo dos coeficientes alpha

alpha = zeros(10,1);

for j = 1:10

    if j == 1
        phi = ones(size(x));
    elseif mod(j,2)==0
        k = j/2;
        phi = cos(2*pi*k*x/T);
    else
        k = (j-1)/2;
        phi = sin(2*pi*k*x/T);
    end

    numerador = sum(y.*phi)*dx;
    denominador = sum(phi.*phi)*dx;

    alpha(j) = numerador/denominador;

end

fprintf('\nCoeficientes alpha:\n\n');
disp(alpha)

%% FFT

F = fft(y);

% descarta a metade redundante
F = F(1:N/2);

% normalização sugerida no enunciado
F = F/((m+1)/2);

fprintf('Primeiros coeficientes da FFT:\n\n');
disp(F(1:10))