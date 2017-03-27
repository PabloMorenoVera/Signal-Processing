function [exc,E] = sonoro_sordo(sw,fs,w)

%energia
E= sum(sw.^2);
%tasa de cruces por cero
Zcr= sum(0.5/length(w)*abs(sign(sw(2:end))-sign(sw(1:end-1))));

if (E>2 && Zcr<0.2)
    %sonoro
    [ffund] =  ffundVoc(sw,fs);
    exc = zeros(1,length(w));
    exc(1:round(fs/ffund):end)=1;
    
else
    %sordo
    exc = randn(1,length(w));
    
end
