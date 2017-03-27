%% Cargamos el archivo de audio
confront.mat;
%% Reproducimos el audio
soundsc(y,fs);
% Generamos un vector temporal para representar la se�al de audio
t = 1/fs * (1:1:length(y));
% Mostramos en gr�fica la se�al de audio
plot(t,y);
% Enventanamos la se�al
s = y(4180:4400);
% Calculamos la autocorrelacion de la se�al enventanada, con sus
% desplazamientos, lags
[c,lags] = xcorr(s)
plot(lags,c);

p = 12;
toe = c(find(lags==0):find(lags==p-1));
R = toeplitz(toe);
a = inv(R)*r;

e = filter([1 -a],1,s);
s_filter = filter(1,[1 -a],e)