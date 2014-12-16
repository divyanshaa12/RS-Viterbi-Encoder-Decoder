clear; clc; close all;

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

%loading trellis structure
load 'trellis.mat';

%Encoding
[c1,c2] = my_ConvEnc(m_cc);


R=0.5*(6/5)*(53/63);

%snr sweep
frame_error=0;
num_of_iter=0;
tmp=1;

for snr=0:0.2:5;
    while (frame_error<=50)
        sd= (2*R*(10^(snr/10)))^-0.5;
        
        %Noise addition
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
        
        %RS Decoding
        rs_out = my_RS_Dec(m_rs,rx_m_rs);
        
        %Calculating PER and Frame errors
        frame_error= frame_error + (1 - isequal(m_rs,rs_out));
        num_of_iter = num_of_iter + 1;
        be(tmp,num_of_iter) = nnz(xor(m_rs,rs_out));
        if num_of_iter > 10000
            break
        end
    end
    ber(tmp) = mean(be(tmp,:))/(length(m_cc));
    frame_error=0;
    num_of_iter=0;
    tmp=tmp+1
end

figure('Name','Eb/N0 vs. PER Plot')
snr=0:0.2:5;
h=semilogy(snr,ber);
title('Eb/N0 vs. PER Plot')
grid on
xlabel('Eb/N0')
ylabel('PER')
saveas(h,'Performance_Plot','eps');
save 'workspace.mat'