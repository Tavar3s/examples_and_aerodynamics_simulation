clear all; clc;
%% Configurações da gravação

fs = 16000;          % taxa de amostragem (Hz)
tempo = 5;           % duração da gravação (s)

fprintf('A gravacao comecara em 2 segundos...\n');
pause(2)

fprintf('Gravando...\n')

gravador = audiorecorder(fs,16,1);

recordblocking(gravador,tempo);

fprintf('Gravacao finalizada!\n')

% Obtém o sinal gravado

y = getaudiodata(gravador);

% Remove a componente DC (centraliza o sinal em torno de zero)
y = y - mean(y);

N = length(y);

% FFT

F = fft(y);

% Magnitude

mag = abs(2*F/N);

% Corrige a componente DC
mag(1) = mag(1)/2;

% Primeira metade da FFT

mag = mag(1:N/2);

% Vetor de frequências

f = linspace(0,fs/2,N/2);

% Espectro

figure

plot(f,mag,'.')

grid on

xlabel('Frequência (Hz)')
ylabel('Magnitude')
title('Espectro de Magnitude da Voz')

xlim([0 4000])

% Frequência principal

% Ignora frequências abaixo de 50 Hz
indiceInicial = find(f >= 50,1);

% Procura o maior pico a partir de 50 Hz
[valorMax,posicao] = max(mag(indiceInicial:end));

% Converte para o índice original
indice = posicao + indiceInicial - 1;

frequenciaPrincipal = f(indice);

fprintf('\nFrequencia principal: %.2f Hz\n',frequenciaPrincipal);