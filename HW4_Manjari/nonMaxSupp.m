function [ supressedIm ] = nonMaxSupp( magIm,d_degIm )
%NONMAXSUPP Summary of this function goes here
%   Detailed explanation goes here
    supressedIm = magIm;
    for i=2:(size(magIm,1)-1)
        for j=2:(size(magIm,2)-1)
            if (d_degIm(i,j)==0)
                if ((magIm(i,j)>=magIm(i,j-1))&&(magIm(i,j)>=magIm(i,j+1)))
                    supressedIm(i,j)=magIm(i,j);
                else
                    supressedIm(i,j)=0;
                end
            end
            
            if (d_degIm(i,j)==45)
                if ((magIm(i,j)>=magIm(i-1,j+1))&&(magIm(i,j)>=magIm(i+1,j-1)))
                    supressedIm(i,j)=magIm(i,j);
                else
                    supressedIm(i,j)=0;
                end
            end
            
            if (d_degIm(i,j)==90)
                if ((magIm(i,j)>=magIm(i-1,j))&&(magIm(i,j)>=magIm(i+1,j)))
                    supressedIm(i,j)=magIm(i,j);
                else
                    supressedIm(i,j)=0;
                end
            end
            
            if (d_degIm(i,j)==135)
                if ((magIm(i,j)>=magIm(i-1,j-1))&&(magIm(i,j)>=magIm(i+1,j+1)))
                    supressedIm(i,j)=magIm(i,j);
                else
                    supressedIm(i,j)=0;
                end
            end
        end
    end
end

