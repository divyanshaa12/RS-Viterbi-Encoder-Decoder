clear; clc; close all;

m_cc=[1 1 0 0 1 0 1 0];
% for i=1:63
%     for j=1:24
%         m_rs(i,j)= round(rand);
%     end
% end
% 
% %reading in interleaved order
% m_cc=0;
% for i=1:6:24
%     for j=1:63
%         m_cc=[m_cc m_rs(j,i:5+i)];
%     end
% end
% m_cc=m_cc(2:length(m_cc));

%Encoding
[c1,c2,trellis] = my_ConvEnc1(m_cc);

%Noise addition
snr=10;
sd= (2*(10^(snr/10)))^-0.5;
for i=1:length(c1)
    c1_n(i)=c1(i) + normrnd(0,sd);
    c2_n(i)=c2(i) + normrnd(0,sd);
end

c1_n=[1 1 -1 1 1 -1 -1 -1];
c2_n=[1 -1 -1 -1 1 1 -1 1];
%padding zeros at punctured bits.
% for i=1:length(c2_n)
%     if mod(i,3)==0
%         c2_n(i)=0;
%     end
% end

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