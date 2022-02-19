
%Convolutional Coded QPSK using Viterbi Decoder 
%Author: Sidong Guo
clear;clc;close all;
tb=2;
n=4;
Block_Num=500;
Bits=randi(0:1,[1,n,Block_Num]);
Trellis=poly2trellis(3,[7,5]);
Coded_bits=zeros(1,n/0.5,Block_Num);

for i=1:Block_Num
    Coded_bits(:,:,i)=convenc(Bits(:,:,i),Trellis);
end
Premod_bits=zeros(1,n,Block_Num);
for i=1:Block_Num
    b=1;
    while b<length(Coded_bits(:,:,i))
        Premod_bits(:,(b+1)/2,i)=bin2dec(num2str(Coded_bits(:,b:b+1,i)));
        b=b+2;
    end
end
Coded_Symbols=qammod(Premod_bits,4)*sqrt(0.5);

nr=randn(1,n,Block_Num);
ni=randn(1,n,Block_Num);
Noise_coded=(sqrt(2)/2)*(nr+1i*ni);

Coded_ratio=zeros(1,6);
Precorrect_bits=zeros(1,2*n,Block_Num);
Corrected_bits=zeros(1,n,Block_Num);
for SNRdb=0:2:10
    Coded_error=0;
    SNR=10^(SNRdb/10);
    Coded_Symbols2=Coded_Symbols+(1/sqrt(SNR))*Noise_coded;
    Decoded_Symbol=qamdemod(Coded_Symbols2,4);
    for i=1:Block_Num
        for b=1:length(Decoded_Symbol(:,:,i))
            a=dec2bin(Decoded_Symbol(:,b,i),2);
            Precorrect_bits(:,(2*b-1):(2*b),i)=[str2double(a(1)),str2double(a(2))];
        end
    end
    for i=1:Block_Num
        Corrected_bits(:,:,i)=vitdec(Precorrect_bits(:,:,i),Trellis,tb,'trunc','hard');
    end
    for count=1:Block_Num*n 
        if Corrected_bits(count)~=Bits(count)
            Coded_error=Coded_error+1;
        end
    end
    Coded_ratio(SNRdb/2+1)=Coded_error/(Block_Num*n);
end

figure()  
semilogy(0:2:10,Coded_ratio)
legend('Coded-QPSK')
