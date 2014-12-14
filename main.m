clear; clc; close all;

m=[1 0 1 1 1 0 0 0 0 1 1 0 0 1 0 0 0 0 1 0 0 0 0 0];

%Encoding
[c1,c2,tail] = ConvEnc(m);

%Noise SD calculation
R=0.5*(53/63)*(6/5);
snr=1;
sd= (2*(10^(snr/10)))^-0.5;
noise=normrnd(0,sd);

