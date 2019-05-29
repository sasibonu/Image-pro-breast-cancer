function output=Padding(maxPadd)
global imag;
 
 counterPadding=floor((maxPadd-1)/2);
 while(counterPadding)
     imag=[imag(:,1) imag imag(:,end)]; % or imag=[imag(:,1,:) imag imag(:,end,:)];
     imag=[imag(1,:);imag;imag(end,:)]; % or imag=[imag(1,:,:);imag;imag(end,:,:)];
     counterPadding=counterPadding-1;
 end
 output=imag;
end