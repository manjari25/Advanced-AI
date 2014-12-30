function [ a,b ] = min_max_data( D )
%Compute minimun and maximum of the data
a = [99999999,99999999];
b = [0,0];

for i=1:size(D,1)
    if(D(i,1)<a(1,1))
        a(1,1) = D(i,1);
    end
    if(D(i,2)<a(1,2))
        a(1,2) = D(i,2);
    end
    if(D(i,1)>b(1,1))
        b(1,1) = D(i,1);
    end
    if(D(i,2)>b(1,2))
        b(1,2) = D(i,2);
    end
end

end

