%practica TIM vocodificador
load confront
y = y-mean(y);
t = 1/fs*(1:1:length(y));
%numero de coeficiente de prediccion lineal
p=12;
%tamaño de las ventanas
sg =0.020;%20 ms

N=fs*sg;

sal =0;
%%Enventanado de la señal en tramas

w = rectwin(N);
sw = zeros(floor(length(y)/length(w)),length(w));
%condiciones iniciales del filtro
zi=[];
i=1;
Lt = length(y)-length(w);
figure
for n = 1:length(w):Lt
    %senhal enventanada
    sw(i,:) = y(n:n+length(w)-1).*w;
    
    %calculo de la respuesta del tracto vocal para cada trama
    ak = tractovocal(sw(i,:)',p);
    %Determinar tramo sonoro/sordo
    
    [exc,E] = sonoro_sordo(sw(i,:),fs,w);
    
    %voz sintetica
    [scod,zi] = filter(E,[1 -ak'],exc,zi);
    
    %concatenamos la voz sintetica de cada trama
    sal = [sal scod];
        
    i=i+1;
end
%fitrado sal
%FPA fc = 150Hz para eliminar el ruido de baja frec.
%La frecuencia de corte del filtro hay que pasarsela normalizada.
B = fir1(128,150/(fs/2),'high');
sal_1 = filtfilt(B,1,sal);

%FPB fc=4000 Hz para eliminar el ruido de alta frec.
A = fir1(128,4000/(fs/2));
sal_2 = filtfilt(A,1,sal_1);

soundsc(sal_2,fs)


