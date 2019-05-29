function output=MedianFilter(MaxSizeFilter)% x: row number and y: col number
global imag;
global imageTemp;
    
[xb,yb]=size(imag);
 
imageTemp=zeros(xb,yb);
imag=Padding(MaxSizeFilter);
 
StartPoint=MaxSizeFilter-floor(MaxSizeFilter/2);%chon tasvir pad shode bayad noqte shoroe tasvire asli
                                                 % baraye mohasebat peyda
                                                 % shavad (be tedade size
                                                 % tasvire asli bayad
                                                 % mohasebat anjam bedim)
                                                %ke markaze panjere filter ast 
for i=StartPoint:StartPoint+(xb-1)
    for j=StartPoint:StartPoint+(yb-1)
               
        Computation(3,MaxSizeFilter,i,j);
               
    end
end
output=imageTemp;
end