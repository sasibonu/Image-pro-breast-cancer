function[I] = amf(image,MaxSizeFilter)
%         AdaptiveFilter(image,MaxSizeFilter)
%                 remove noise by changing the size of filter
%                 image : tasvir noisy
%                 MaxSizeFilter : maximum size of filter 
%
%                   AdaptiveFilter start from 3*3 filter
%                   and if noise don't remove,greats size of filter
%                   until MaxSizeFilter and repeat removing noise
global imag;
global imageTemp;
[x,y]=size(image);
imag=double(image);
imag=MedianFilter(MaxSizeFilter);
 
Q=MaxSizeFilter-ceil(MaxSizeFilter/2);%cut image
I=imag(Q:Q+x-1,Q:Q+y-1);
% figure();
% imshow(uint8(imag),[]);
end