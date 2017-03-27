function myspectra(s,fs)

L = length(s);
%NFFT = length(s);
NFFT=512;
fft_s = fft(s,NFFT)/L;
f = fs/2*linspace(0,1,NFFT/2+1);

figure,
plot(f,2*abs(fft_s(1:NFFT/2+1))) 
xlabel('Hz')
ylabel('|FFT|')
