clear; clc; close all;

%m=[1 0 1 1 1 0 0 0 0 1 1 0 0 1 0 0 0 0 1 0 0 0 0 0];
for i=1:63
    for j=1:24
        m_rs(i,j)= round(rand);
    end
end

%reading in interleaved order
m_cc=0;
for i=1:6:24
    for j=1:63
        m_cc=[m_cc m_rs(j,i:5+i)];
    end
end
m_cc=m_cc(2:length(m_cc));

%Encoding
[c1,c2,tail] = my_ConvEnc(m_cc);

%Noise addition
snr=1;
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

