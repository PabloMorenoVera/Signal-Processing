clear all
close all
clc
I_peppers = imread('peppers.png');
Res_peppers = size(I_peppers)
P = whos('coins.png')
G = whos('coins.png')
%Extraigo la capa R
I_r_peppers = I_peppers(:,:,1);
%Negativizar la capa roja
I_neg = 255 - I_r_peppers;
%Sustituir la capa R por la capa negativa
I_peppers(:,:,1) = I_neg;
%Representar
imshow(I_peppers)
%% Punto 2
I_coins = imread('coins.png');
figure
imshow(I_coins)
figure
imhist(I_coins)
figure
im2bw(I_coins,graythresh(I_coins));
figure
im2bw(I_coins,80/255);
%% Punto 3
Igris = zeros(256,256) + 128;
Igris = uint8(Igris);
Ruido1 = imnoise(Igris,'gaussian',0.02);
Ruido2 = imnoise(Igris,'speckle',0.02);
Ruido3 = imnoise(Igris,'salt & pepper',0.02);
%% Filtrado lineal
Mascara = zeros(5,5) + 1/25
%Filtrado_z = imfilter(Ruido, Mascara,'same');
Filtrado_m1 = imfilter(Ruido1, Mascara,'symmetric');
Filtrado_m2 = imfilter(Ruido2, Mascara,'symmetric');
Filtrado_m3 = imfilter(Ruido3, Mascara,'symmetric');
figure
imhist(Ruido3)
figure
imhist(Filtrado_m3)
%%
imshow(medfilt2(Ruido2, [5,5], 'symmetric'))
%% Punto 4
%1 Filtro paso bajo
figure
Bloque_1 = imfilter(I_coins, Mascara,'symmetric');
imshow(Bloque_1)
% Binarizacion
figure
Mascara = zeros(5,5) + 1/25
Bloque_2 = im2bw(Bloque_1,80/255);
imshow(Bloque_2)
% Filtro paso alto 5x5
figure
Mascara2 = zeros(5,5) - 1;
Mascara2(3,3) = 24;
Bloque_3 = imfilter(Bloque_2, Mascara2,'symmetric');
imshow(Bloque_3)
% Filtro paso alto 3x3
figure
Mascara2 = zeros(3,3) - 1;
Mascara2(2,2) = 8;
Bloque_3 = imfilter(Bloque_2, Mascara2,'symmetric');
imshow(Bloque_3)

