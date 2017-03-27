%%

I = imread('Board_Recorte.tif');

R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);

RGB = [R, G, B];
imtool(RGB);

[h,s,i] = rgb2hsi(I);

HSI = [h, s, i];
imtool(HSI);
%%
% Elegimos la componente "s" debido a que los chips aparecen en negro por
% lo que será sencillo extraerlo.

level = graythresh(s);
BW = im2bw(s, level);
imtool(BW);
BW_8 = uint8(BW)*255;
imtool(BW_8);

mask = [5,5];
I_FILT = medfilt2(BW_8, mask);
imtool(I_FILT);

%%

EE_circulo = strel('square', 35);
I_ERODE = imerode(I_FILT, EE_circulo);
imtool(I_ERODE);
I_DILATE = imdilate(I_FILT, EE_circulo);
imtool(I_DILATE);
I_OPEN = imopen(I_FILT, EE_circulo);
imtool(I_OPEN);
I_CLOSE = imclose(I_FILT, EE_circulo);
imtool(I_CLOSE);

Im_Res_Morf = I_CLOSE;
Im_Res_Morf_Neg = 255 - Im_Res_Morf;

%%

[IM_Seg, Num_objetos]= bwlabel(Im_Res_Morf_Neg);
imtool(IM_Seg);

RGB_Segment = label2rgb(IM_Seg);
imtool(RGB_Segment);

imtool(IM_Seg, []);

Props = regionprops(IM_Seg, 'Eccentricity')

for i=1:7
    if(Props(i).Eccentricity < 0.5)
        %Es un cuadrado.
    else
        %Es un rectángulo.
    end 
end

%%

EE_circulo = strel('disk', 1);
I_ERODE = imerode(Im_Res_Morf_Neg, EE_circulo);
imtool(I_ERODE);
I_DILATE = imdilate(Im_Res_Morf_Neg, EE_circulo);
imtool(I_DILATE);

Im_Res_Morf_N = I_DILATE - I_ERODE;
imtool(Im_Res_Morf_N);
