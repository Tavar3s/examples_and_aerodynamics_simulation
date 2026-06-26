clear all; clc;

%% Configurações da gravação

fs = 16000;          % taxa de amostragem
tempo = 10;           % tempo de gravação

fprintf('A gravacao comecara em 3 segundos...\n');
pause(3)

fprintf('Fale uma frase...\n')

gravador = audiorecorder(fs,16,1);
recordblocking(gravador,tempo);

fprintf('Gravacao finalizada!\n')

% Sinal gravado

y = getaudiodata(gravador);
y = y - mean(y);
N = length(y);

% Vetor de tempo

t = (0:N-1)/fs;

% FFT

F = fft(y);

% Frequência fundamental da FFT

f0 = fs/N;

% Harmônicos correspondentes a 500 Hz e 1000 Hz

Kinicial = ceil(500/f0);
Kfinal = floor(1000/f0);

% Reconstrução do sinal

yFiltrado = zeros(size(t));

% Soma trigonométrica

for k = Kinicial:Kfinal

    alphaCos = 2*real(F(k+1))/N;
    alphaSen = -2*imag(F(k+1))/N;

    yFiltrado = yFiltrado ...
        + alphaCos*cos(2*pi*k*f0*t) ...
        + alphaSen*sin(2*pi*k*f0*t);

end

% Espectro original

magOriginal = abs(2*F/N);

magOriginal(1)=magOriginal(1)/2;

magOriginal = magOriginal(1:N/2);

% FFT do sinal reconstruído

Fnovo = fft(yFiltrado);

magNovo = abs(2*Fnovo/N);

magNovo(1)=magNovo(1)/2;

magNovo = magNovo(1:N/2);

% Vetor de frequências

f = linspace(0,fs/2,N/2);

% Gráfico

figure(1)
plot(f,magOriginal,'.')
hold on
plot(f,magNovo,'.')
grid on
xlabel('Frequência (Hz)')
ylabel('Magnitude')
title('Filtro Passa-Banda')
legend('Original','Filtrado')
xlim([70 1500])

% Reprodução

fprintf('\nReproduzindo audio original...\n')
sound(y,fs)

pause(tempo+1)

fprintf('Reproduzindo audio filtrado...\n')
sound(yFiltrado,fs)