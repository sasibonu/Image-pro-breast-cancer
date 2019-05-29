function Computation(FilterSize,MaxFilterSize,i,j)
global imageTemp;
global imag;
 
            Zxy=0;
            
            justification=ceil((FilterSize-1)/2);
            AreaNeighberhood=imag(i-justification:i+justification,j-justification:j+justification);
            sortedArea=sort(AreaNeighberhood(:));
            % obtain variables for computation
            Zmin=sortedArea(1);
            Zmax=sortedArea(end);
            Zmed=median(sortedArea);
            Zxy=imag(i,j);
            
            B1=Zxy-Zmin;
            B2=Zxy-Zmax;
            if(B1>0 && B2<0)
                imageTemp(i,j)=Zxy;
                return;
            else
                A1=Zmed-Zmin;
                A2=Zmed-Zmax;
                if(A1>0 && A2<0)
                    imageTemp(i,j)=Zmed;
                    return;
                else
                    if(FilterSize<MaxFilterSize)
                        FilterSize=FilterSize+2;
                        Computation(FilterSize,MaxFilterSize,i,j);
                        return;
                    else
                        imageTemp(i,j)=Zmed;
                    end
                end
            end
end
 