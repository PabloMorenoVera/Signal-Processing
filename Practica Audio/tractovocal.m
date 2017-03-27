function [ak] = tractovocal(s,p)
% Calculamos la autocorrelacion de la señal enventanada, con sus
% desplazamientos, lags
[c,lags] = xcorr(s)
plot(lags,c);
r = c(find(lags==1):find(lags==p));
toe = c(find(lags==0):find(lags==p-1));
R = toeplitz(toe);
ak = inv(R)*r;

e = filter([1 -ak'],1,s);
s_filter = filter(1,[1 -ak'],e);
plot(s)
hold
plot(s_filter)

