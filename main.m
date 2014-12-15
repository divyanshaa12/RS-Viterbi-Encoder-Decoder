clear; clc; close all;

% m_cc=[1 1 0 1 0 0 1 0 0];
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
[c1,c2,trellis] = my_ConvEnc(m_cc);

%Noise addition
R=0.5*(6/5)*(53/63);
snr=2.5;
sd= (2*R*(10^(snr/10)))^-0.5;
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

m_vit_out = my_VitDec(c1_n,c2_n,trellis);

%Deinterleaving
for i=1:6:24
    for j=1:63
        rx_m_rs(j,i:i+5)=m_vit_out(63*(i-1)+6*(j-1)+1:63*(i-1)+6*j);
    end
end

%calculating # of symbol errors for each code
num_symb_err=[0 0 0 0]; %initialize
for i=1:63
    for j=1:4
        num_symb_err(j) = num_symb_err(j) + (1 - isequal(m_rs(i,6*(j-1)+1:6*j) , rx_m_rs(i,6*(j-1)+1:6*j)));
    end
end

%RS decoding
rs_out=rx_m_rs;
for i=1:4
    if num_symb_err(i) <= 5
        for j=1:63
            rs_out(j,6*(i-1)+1:6*i)=m_rs(j,6*(i-1)+1:6*i);
        end
    end
end

%Calculating PER and Frame errors
frame_error= 1 - isequal(m_rs,rs_out)
ber=nnz(xor(m_rs,rs_out))/(length(m_cc))