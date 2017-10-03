% Inclass11

% You can find a multilayered .tif file with some data on stem cells here:
% https://www.dropbox.com/s/83vjkkj3np4ehu3/011917-wntDose-esi017-RI_f0016.tif?dl=0

% 1. Find out (without reading  the entire file) -  (a) the size of the image in
% x and y, (b) the number of z-slices, (c) the number of time points, and (d) the number of
% channels. 

%by reading:
file='011917-wntDose-esi017-RI_f0016.tif';
reader=bfGetReader(file); %this generates a Warning

x=reader.getSizeX;
y=reader.getSizeY;
zplane=reader.getSizeZ;
chan=reader.getSizeC;
time=reader.getSizeT;

% 2. Write code which reads in all the channels from the 30th time point
% and displays them as a multicolor image.

plane1=reader.getIndex(zplane-1,chan-2,29)+1;
img1=bfGetPlane(reader,plane1); %esta es la membrana !!!!! 
imshow(img1,[]) %tiene que haber los corchetes pq si no, daña la img.

plane2=reader.getIndex(zplane-1,chan-1,29)+1;
img2=bfGetPlane(reader,plane2); 
imshow(img2,[]) %tiene que haber los corchetes pq si no, daña la img.

img2show=cat(3,imadjust(img1),imadjust(img2),zeros(size(img1)));
q2=imshow(img2show)
 
% 3. Use the images from part (2). In one of the channels, the membrane is
% prominently marked. Determine the best threshold and make a binary
% mask which marks the membranes and displays this mask. 

dimg1=im2double(img1);
imgbright=uint16((2^16-1)*(dimg1/max(max(dimg1))));

imgbw=img1>1000; %default example in lecture
imshow(imgbw)

imgbw=img1>500; %nope 
imshow(imgbw)

imgbw=img1>2000; %nope
imshow(imgbw)

imgbw=img1>1500; % too much fade
imshow(imgbw)

imgbw=img1>1200; %mmmm
imshow(imgbw)

imgbw=img1>900; % a bit better
imshow(imgbw)

% 4. Run and display both an erosion and a dilation on your mask from part
% (3) with a structuring element which is a disk of radius 3. Explain the
% results.

imshow(imerode(imgbw,strel('disk',3)))
imshow(imdilate(imgbw,strel('disk',3)))

%Miguel Angel: Erosion is doing it too drasticly, because there is
%practically no membrane now. So my image has a lot of "cracks" and with
%erosion is expanding those, but greatly that is why there's a low signal now.

%in the case for dilation, it's also doing it drastically because there is
%a very thick signal for the membrane now, and we can even see white
%squares acrooss the image as well, which means that this settings are too
%far and its doing more damage than optimizing. 

