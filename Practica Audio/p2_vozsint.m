m1 = y(14200:14419); % SONORO  --> mas energia menos TCC
m2 = y(15500:15719); % SORDO --> menos energía mas TCC

[E1,TCC1] = energy_TCC(m1)
[E2,TCC2] = energy_TCC(m2)

[cm1,lags1] = xcorr(m1);
[cm2,lags2] = xcorr(m2);

figure(1)
plot(lags1,cm1)
hold
plot(lags2,cm2)

myspectra(m1,fs);
myspectra(m2,fs);
