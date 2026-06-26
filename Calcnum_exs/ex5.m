clear all; clc;

%% Configurações da gravação

fs = 16000;      % taxa de amostragem (Hz)
tempo = 15;       % duração da gravação (s)

fprintf('A gravacao comecara em 2 segundos...\n');
pause(2)

fprintf('Fale uma frase...\n');

gravador = audiorecorder(fs,16,1);

recordblocking(gravador,tempo);

fprintf('Gravacao finalizada!\n');

% Obtém o sinal gravado

y = getaudiodata(gravador);

% Remove a componente DC
y = y - mean(y);

N = length(y);

% FFT

F = fft(y);

% Cálculo da magnitude

mag = abs(2*F/N);

% Corrige a componente DC
mag(1) = mag(1)/2;

% Mantém apenas a primeira metade da FFT

mag = mag(1:N/2);

% Vetor de frequências

f = linspace(0,fs/2,N/2);

% Gráfico

figure(1)
plot(f,mag,'.')
grid on
xlabel('Frequência (Hz)')
ylabel('Magnitude')
title('Espectro de Magnitude da Fala')

% Limita o gráfico para visualizar melhor a região útil
xlim([70 500])