% Parâmetros da senoide
amplitude = 2047;  % Amplitude máxima para 12 bits (0 a 4095)
offset = 2048;     % Offset para centrar a senoide (valor DC)
num_points = 360;  % Número de pontos na senoide

% Geração dos valores da senoide
x = linspace(0, 2*pi, num_points);
sine_wave = round(amplitude * sin(x) + offset);

% Conversão para binário de 12 bits
sine_wave_bin = dec2bin(sine_wave, 12);

% Exibição dos valores binários
disp(sine_wave_bin);

% Salvando os valores binários em um arquivo (opcional)
fid = fopen('sine_wave_values_bin.txt', 'w');
for i = 1:length(sine_wave_bin)
    fprintf(fid, '"%s", ', sine_wave_bin(i, :));
    if mod(i, 8) == 0
        fprintf(fid, '\n'); % Nova linha a cada 8 valores para melhor formatação
    end
end
fclose(fid);
