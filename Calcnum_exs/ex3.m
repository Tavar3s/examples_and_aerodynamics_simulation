clear all; clc;
%% Dados do problema

T = 20;          
m = 999;         
N = m + 1;

% Malha temporal

x = -10:(T/N):10;
x(end) = [];     % intervalo semi-aberto [-10,10)

% Função degrau

y = zeros(size(x));

for i = 1:length(x)
    if x(i) >= 0
        y(i) = 1;
    end
end

F = fft(y); %FFT

mag = abs(2*F/(m+1)); % Magnitude

% Corrige o primeiro coeficiente (DC)
mag(1) = mag(1)/2;

% Elimina a parte redundante

mag = mag(1:N/2);

% Vetor de frequências

fmax = N/T;              % frequência de amostragem

frequencias = linspace(0,fmax/2,N/2);

% Gráfico

figure

stem(frequencias,mag,'filled')

grid on

xlabel('Frequência (Hz)')
ylabel('Magnitude')
title('Espectro de Magnitude do Sinal Degrau')