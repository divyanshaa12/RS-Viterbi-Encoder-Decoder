clear; clc; close all;

m_cc=[1 0 1 1 1];
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
[c1,c2,trellis] = my_ConvEnc(m_cc);

%Noise addition
snr=10;
sd= (2*(10^(snr/10)))^-0.5;
for i=1:length(c1)
    c1_n(i)=c1(i) + normrnd(0,sd);
    c2_n(i)=c2(i) + normrnd(0,sd);
end

%padding zeros at punctured bits.
for i=1:length(c2_n)
    if mod(i,3)==0
        c2_n(i)=0;
    end
end

%%Viterbi Decoder
%initialize the path metric
M(1)=0;
for i=2:trellis.numStates
    M(i)=Inf;
end
 
[r,c]=find(trellis.nextStates==0);
pre_in_0 = [r,c]-1;
pre_in_out_0 = [pre_in_0 [trellis.outputs(pre_in_0(1,1)+1,pre_in_0(1,2)+1) trellis.outputs(pre_in_0(2,1)+1,pre_in_0(2,2)+1)]']
 
[r,c]=find(trellis.nextStates==1);
pre_in_1 = [r,c]-1;
pre_in_out_1 = [pre_in_1 [trellis.outputs(pre_in_1(1,1)+1,pre_in_1(1,2)+1) trellis.outputs(pre_in_1(2,1)+1,pre_in_1(2,2)+1)]']
 
[r,c]=find(trellis.nextStates==2);
pre_in_2 = [r,c]-1;
pre_in_out_2 = [pre_in_2 [trellis.outputs(pre_in_2(1,1)+1,pre_in_2(1,2)+1) trellis.outputs(pre_in_2(2,1)+1,pre_in_2(2,2)+1)]']
 
[r,c]=find(trellis.nextStates==3);
pre_in_3 = [r,c]-1;
pre_in_out_3 = [pre_in_3 [trellis.outputs(pre_in_3(1,1)+1,pre_in_3(1,2)+1) trellis.outputs(pre_in_3(2,1)+1,pre_in_3(2,2)+1)]']
 
[r,c]=find(trellis.nextStates==4);
pre_in_4 = [r,c]-1;
pre_in_out_4 = [pre_in_4 [trellis.outputs(pre_in_4(1,1)+1,pre_in_4(1,2)+1) trellis.outputs(pre_in_4(2,1)+1,pre_in_4(2,2)+1)]']
 
[r,c]=find(trellis.nextStates==5);
pre_in_5 = [r,c]-1;
pre_in_out_5 = [pre_in_5 [trellis.outputs(pre_in_5(1,1)+1,pre_in_5(1,2)+1) trellis.outputs(pre_in_5(2,1)+1,pre_in_5(2,2)+1)]']
 
[r,c]=find(trellis.nextStates==6);
pre_in_6 = [r,c]-1;
pre_in_out_6 = [pre_in_6 [trellis.outputs(pre_in_6(1,1)+1,pre_in_6(1,2)+1) trellis.outputs(pre_in_6(2,1)+1,pre_in_6(2,2)+1)]']
 
[r,c]=find(trellis.nextStates==7);
pre_in_7 = [r,c]-1;
pre_in_out_7 = [pre_in_7 [trellis.outputs(pre_in_7(1,1)+1,pre_in_7(1,2)+1) trellis.outputs(pre_in_7(2,1)+1,pre_in_7(2,2)+1)]']
 
[r,c]=find(trellis.nextStates==8);
pre_in_8 = [r,c]-1;
pre_in_out_8 = [pre_in_8 [trellis.outputs(pre_in_8(1,1)+1,pre_in_8(1,2)+1) trellis.outputs(pre_in_8(2,1)+1,pre_in_8(2,2)+1)]']
 
[r,c]=find(trellis.nextStates==9);
pre_in_9 = [r,c]-1;
pre_in_out_9 = [pre_in_9 [trellis.outputs(pre_in_9(1,1)+1,pre_in_9(1,2)+1) trellis.outputs(pre_in_9(2,1)+1,pre_in_9(2,2)+1)]']
 
[r,c]=find(trellis.nextStates==10);
pre_in_10 = [r,c]-1;
pre_in_out_10 = [pre_in_10 [trellis.outputs(pre_in_10(1,1)+1,pre_in_10(1,2)+1) trellis.outputs(pre_in_10(2,1)+1,pre_in_10(2,2)+1)]']
 
[r,c]=find(trellis.nextStates==11);
pre_in_11 = [r,c]-1;
pre_in_out_11 = [pre_in_11 [trellis.outputs(pre_in_11(1,1)+1,pre_in_11(1,2)+1) trellis.outputs(pre_in_11(2,1)+1,pre_in_11(2,2)+1)]']
 
[r,c]=find(trellis.nextStates==12);
pre_in_12 = [r,c]-1;
pre_in_out_12 = [pre_in_12 [trellis.outputs(pre_in_12(1,1)+1,pre_in_12(1,2)+1) trellis.outputs(pre_in_12(2,1)+1,pre_in_12(2,2)+1)]']
 
[r,c]=find(trellis.nextStates==13);
pre_in_13 = [r,c]-1;
pre_in_out_13 = [pre_in_13 [trellis.outputs(pre_in_13(1,1)+1,pre_in_13(1,2)+1) trellis.outputs(pre_in_13(2,1)+1,pre_in_13(2,2)+1)]']
 
[r,c]=find(trellis.nextStates==14);
pre_in_14 = [r,c]-1;
pre_in_out_14 = [pre_in_14 [trellis.outputs(pre_in_14(1,1)+1,pre_in_14(1,2)+1) trellis.outputs(pre_in_14(2,1)+1,pre_in_14(2,2)+1)]']
 
[r,c]=find(trellis.nextStates==15);
pre_in_15 = [r,c]-1;
pre_in_out_15 = [pre_in_15 [trellis.outputs(pre_in_15(1,1)+1,pre_in_15(1,2)+1) trellis.outputs(pre_in_15(2,1)+1,pre_in_15(2,2)+1)]']
