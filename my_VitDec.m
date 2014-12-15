function [m_vit_out] = my_VitDec(c1_n,c2_n,trellis)

%%Viterbi Decoder
 
%constructing tables for each state to find out the previous state, input
%and the output message.

for i=1:trellis.numStates
    [r,c]=find(trellis.nextStates==(i-1));
    pre_in(:,:,i) = [r,c]-1;
    pre_in_out(:,:,i) = [pre_in(:,:,i) [trellis.outputs(pre_in(1,1,i)+1,pre_in(1,2,i)+1) trellis.outputs(pre_in(2,1,i)+1,pre_in(2,2,i)+1)]'];
end

%initialize the path metric and paths
PM(1)=0;
for i=2:trellis.numStates
    PM(i)=Inf;
end

path=zeros(trellis.numStates,length(c1_n));

for j=1:length(c1_n)
    for i=1:trellis.numStates
        if pre_in_out(1,3,i)==0
            BM1= (c1_n(j)+1)^2 + (c2_n(j)+1)^2;
        elseif pre_in_out(1,3,i)==1
            BM1= (c1_n(j)+1)^2 + (c2_n(j)-1)^2;
        elseif pre_in_out(1,3,i)==2
            BM1= (c1_n(j)-1)^2 + (c2_n(j)+1)^2;
        elseif pre_in_out(1,3,i)==3
            BM1= (c1_n(j)-1)^2 + (c2_n(j)-1)^2;
        end
        if pre_in_out(2,3,i)==0
            BM2= (c1_n(j)+1)^2 + (c2_n(j)+1)^2;
        elseif pre_in_out(2,3,i)==1
            BM2= (c1_n(j)+1)^2 + (c2_n(j)-1)^2;
        elseif pre_in_out(2,3,i)==2
            BM2= (c1_n(j)-1)^2 + (c2_n(j)+1)^2;
        elseif pre_in_out(2,3,i)==3
            BM2= (c1_n(j)-1)^2 + (c2_n(j)-1)^2;
        end
        PM1=PM(pre_in_out(1,1,i)+1) + BM1;
        PM2=PM(pre_in_out(2,1,i)+1) + BM2;
        PM_next(i)= min(PM1,PM2);
        if PM1 <= PM2
            from_path = 1;
        else
            from_path = 2;
        end
        path(i,:)=[pre_in_out(from_path,1,i) path(i,1:(length(c1_n)-1))];
    end
    PM=PM_next;
end
path=fliplr(path);

%trace back from path 0

curr_state = 0; %Start from 0 since we made sure that the encoder ends in state 0.
[a b] = size(path);
for i=b:-1:1
    pre_state = path(curr_state+1,i);
    [r c]=find(pre_in_out(:,1,curr_state+1)==pre_state);
    m_vit_out(i) = pre_in_out(r,2,curr_state+1);
    curr_state=pre_state;
end