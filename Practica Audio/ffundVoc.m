function [ffund] =  ffundVoc(s,fs)

L = length(s);
NFFT = length(s);
fft_s = fft(s,NFFT)/L;
f = fs/2*linspace(0,1,NFFT/2+1);

%figure,
%plot(f,2*abs(fft_s(1:NFFT/2+1))) 
%xlabel('Hz')
%ylabel('|FFT|')

fre = f(f>20&f<450);
p = fft_s(f>20&f<450);
ffund = fre(find(p==max(p)));