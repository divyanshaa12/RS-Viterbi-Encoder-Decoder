function [c1,c2,trellis] = my_ConvEnc1(m)

for i=1:length(m)
    
    if i==1
        in_mem = [0 0]; %initializing conv encoder's SR's to zero.
    end
    
    c1(i) = mod(m(i) + in_mem(2),2);
    c2(i) = mod(mod(m(i) + in_mem(1),2) + in_mem(2),2);
    
    in_mem = [m(i) in_mem(1)]; % update your encoder's memory
    
%BPSK Modulation Ec=1 

    if c1(i)==0
        c1(i)=-1;
    end
    if c2(i)==0
        c2(i)=-1;
    end
end
trellis = poly2trellis(3,[5 7]);
