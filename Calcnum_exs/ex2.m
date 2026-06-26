clear all; clc;

%% Dados do problema

T = 20;          
N = 1000;       

% Malha temporal
x = -10:(T/N):10;
x(end) = [];     % remove o último ponto

% Sinal de exemplo

y = sin(2*pi*2*x) + 0.5*cos(2*pi*5*x);


F = fft(y); %% FFT do sinal

f0 = 1/T; % Frequência fundamental


frequencias = zeros(1,N); % Frequências associadas aos elementos da FFT


for k = 0:N-1
    frequencias(k+1) = k*f0;
end

% primeiras frequências

fprintf('Indice        Frequencia (Hz)\n');
for k = 1:20
    fprintf('%3d          %.2f\n',k-1,frequencias(k));
end

% Mostrar somente a primeira metade 

figure(1)
stem(0:N/2-1,frequencias(1:N/2),'filled')
grid on
xlabel('Indice da FFT')
ylabel('Frequencia (Hz)')
title('Frequencias associadas aos elementos da FFT')

% Frequências 

fs = N/T;
nyquist = fs/2;

fprintf('\n');
fprintf('Frequencia fundamental = %.2f Hz\n',f0);
fprintf('Frequencia de amostragem = %.2f Hz\n',fs);
fprintf('Frequencia de Nyquist = %.2f Hz\n',nyquist);