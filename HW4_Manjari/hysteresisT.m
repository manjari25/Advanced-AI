function [ linkedIm ] = hysteresisT(nmmagIm)
%Performs Hysteresis  thresholding
    TL=0.1*(max(max(nmmagIm)));
    TH=0.4*TL;
    linkedIm = zeros(size(nmmagIm,1), size(nmmagIm,2));
    for i=2:(size(nmmagIm,1)-1)
        for j=2:(size(nmmagIm,2)-1)
            if(nmmagIm(i,j)<TL)
                linkedIm(i,j)=0;
            elseif(nmmagIm>TH)
                linkedIm(i,j) = 1;
            else
                if((nmmagIm(i+1,j)>TH)||(nmmagIm(i-1,j)>TH)||(nmmagIm(i,j+1)>TH)||(nmmagIm(i,j-1)>TH)||(nmmagIm(i-1,j-1)>TH)||(nmmagIm(i+1,j-1)>TH)||(nmmagIm(i-1,j+1)>TH)||(nmmagIm(i+1,j+1)>TH))
                    linkedIm(i,j) = 1; 
                else
                    linkedIm(i,j) = 0;
                end
            end
        end
    end
end

